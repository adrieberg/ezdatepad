import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/utils.dart';

part 'archive.g.dart';
// flutter pub run build_runner build

/// Keys that can/should be used:
/// - Default: yyyymmdd
/// - Default including time: yyyymmddHHMM
/// - Time: HHmm

@JsonSerializable(explicitToJson: true)
class Archive extends ChangeNotifier {
  Archive({required this.id, required this.name, required this.entries});

  String id;
  String name;
  List<Entry> entries = [];
  List<Entry> searchResults = [];

  static String lastKey = '';
  Future<void> _pendingStore = Future.value();

  factory Archive.fromJson(Map<String, dynamic> json) =>
      _$ArchiveFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveToJson(this);

  Future<void> readJsonFile() async {
    if (kDebugMode) debugPrint('read JSON file ');

    final file = await _localFile;
    if (await file.exists()) {
      final content = await file.readAsString();

      if (content.trim().isEmpty) {
        id = const Uuid().v4();
        name = 'archive';
        entries = [];
        return;
      }

      try {
        final decoded = json.decode(content) as Map<String, dynamic>;
        Archive temp = _$ArchiveFromJson(decoded);
        id = temp.id;
        name = temp.name;
        entries = temp.entries;
      } on FormatException catch (e) {
        if (kDebugMode) debugPrint('Invalid archive JSON, creating backup: $e');
        await _backupCorruptArchive(file, content);
        id = const Uuid().v4();
        name = 'archive';
        entries = [];
      }
    } else {
      id = const Uuid().v4();
      name = 'archive';
      entries = [];
    }
  }

  Future<File> writeJsonFile() async {
    final file = await _localFile;
    final tempFile = File('${file.path}.tmp');

    if (kDebugMode) debugPrint('write JSON file');
    
/*    if (!await file.exists()) {
      // read the file from assets first and create the local file with its contents
      final initialContent = await rootBundle.loadString(initialAssetFile);
      await file.create();
      await file.writeAsString(initialContent);
    }
*/
    final data = json.encode(_$ArchiveToJson(this));
    await tempFile.writeAsString(data, flush: true);
    if (await file.exists()) {
      await file.delete();
    }
    return tempFile.rename(file.path);
  }

  Future<void> _backupCorruptArchive(File file, String content) async {
    final ts = DateTime.now().toIso8601String().replaceAll(':', '-');
    final backup = File('${file.parent.path}/archive_corrupt_$ts.json');
    await backup.writeAsString(content, flush: true);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/archive.json');
  }

  void load() {
    readJsonFile().then((value) => refresh());
    searchResults = [];
  }

  void store() {
    _pendingStore = _pendingStore
        .catchError((_) {})
        .then((_) async {
      await writeJsonFile();
      refresh();
    });
  }

  Entry createEntry(String? key, String? value) =>
      Entry(const Uuid().v4(), key ?? currentDTKey(), value ?? '');

  void add(Entry entry) {
    if (entries.where((element) => element.dtKey == entry.dtKey).isNotEmpty) {
      entries
          .where((element) => element.dtKey == entry.dtKey)
          .single
          .inject(entry.value);
      refresh();
      return;
    }
    entries.add(entry);
    sort();
    //refresh();
  }

  bool check(String key) =>
      entries.where((element) => element.dtKey == key).isNotEmpty;

  bool checkIfFirst(String key) {
    // return true;
    String firstKey;
    if (searchResults.isNotEmpty) {
      firstKey = searchResults
          .firstWhere(
            (element) => element.dtKey.substring(0, 8) == key.substring(0, 8))
          .dtKey;
    } else {
      firstKey = entries
          .firstWhere(
            (element) => element.dtKey.substring(0, 8) == key.substring(0, 8))
          .dtKey;
    }
    if (firstKey == key) {
      return true;
    }
    return false;
  }

  bool checkIfLast(String key) {
    String lastKey;
    if (searchResults.isNotEmpty) {
      lastKey = searchResults
          .lastWhere(
            (element) => element.dtKey.substring(0, 8) == key.substring(0, 8))
          .dtKey;
    } else {
      lastKey = entries
          .lastWhere(
            (element) => element.dtKey.substring(0, 8) == key.substring(0, 8))
          .dtKey;
    }
    if (lastKey == key) {
      return true;
    }
    return false;
  }

  Entry get(String key) => check(key)
      ? entries.where((element) => element.dtKey == key).single
      : Entry(const Uuid().v4(), currentDTKey(), '');

  void update(Entry entry) {
    if (check(entry.dtKey) == false) {
      add(entry);
    } else {
      entries.where((element) => element.dtKey == entry.dtKey).single.value =
          entry.value;
      refresh();
    }
  }

  /// Insert text the the beginning of an entry
  void inject(String key, String inject) {
    if (check(key) == false) {
      add(createEntry(key, inject));
    } else {
      entries.where((element) => element.dtKey == key).single.inject(inject);
    }
    refresh();
  }

  /// Insert text at the end of an entry
  Entry append(String key, String append) {
    if (check(key) == false) {
      add(createEntry(key, append));
    } else {
      entries.where((element) => element.dtKey == key).single.append(append);
    }
    //refresh();
    return entries.where((element) => element.dtKey == key).single;
  }

  /// Delete an entry from the list
  void delete(Entry entry) {
    entries.removeWhere((element) => element.id == entry.id);
    refresh();
  }

  /// Delete the entire list or entries
  void clear() {
    entries.clear();
    refresh();
  }

  /// Update interface
  void refresh() {
    notifyListeners();
  }

  /// Order the list
  void sort() {
    if (kDebugMode) debugPrint('sort list ');

    /// Only for sorting the list the entry keys are padded on the right
    /// with a 9, so that the entries with a shorter key will get sorted
    /// above entries with a longer key. 197506299999 > 197506290830

    //If sort on date is suficient, thats it, sort descending
    //If dates are the same, then sort on the time part, but sort the time the
    //other way around (ascending)
    entries.sort((a, b) {

    //debugPrint('compare a ${a.dtKey} --  ${a.dtKey.padRight(12, '9').substring(8, 12)}');
    //debugPrint('compare to b ${b.dtKey} --  ${b.dtKey.padRight(12, '9').substring(8, 12)}');

// Compare dates. If date is the same, check the time part, else retunr the date comparison
      return (b.dtKey
                .substring(0, 8)
                .compareTo(a.dtKey.substring(0, 8))) ==
            0
        ? (a.dtKey
            .padRight(12, '-')
            .substring(8, 12)
            .compareTo(b.dtKey.padRight(12, '-').substring(8, 12)))
        : (b.dtKey
            .substring(0, 8)
            .compareTo(a.dtKey.substring(0, 8)));
    });
    //refresh();
  }

/*  /// Order the list
  void sort() {
    if (kDebugMode) debugPrint('sort list ');

    /// Only for sorting the list the entry keys are padded on the right
    /// with a 9, so that the entries with a shorter key will get sorted
    /// above entries with a longer key. 197506299999 > 197506290830

    //If sort on date is suficient, thats it, sort descending
    //If dates are the same, then sort on the time part, but sort the time the
    //other way around (ascending)
    entries.sort((a, b) => (b.dtKey
                .padRight(12, '9')
                .substring(0, 8)
                .compareTo(a.dtKey.substring(0, 8))) ==
            0
        ? (b.dtKey
            .padRight(12, '9')
            .substring(8, 11)
            .compareTo(a.dtKey.substring(8, 11)))
        : (a.dtKey
            .padRight(12, '9')
            .substring(8, 11)
            .compareTo(b.dtKey.substring(8, 11))));
    refresh();
  }
*/


  /// Search the list
  Widget search(BuildContext context, String searchString) {

    searchResults = [];
    if (searchString.isEmpty) {
      return list(context);
    }
    //debugPrint('search for $searchString ');
    searchResults.addAll(entries.where((element) => element.dtKey.contains(searchString) ||
      labelKey(element.dtKey).toLowerCase().contains(searchString.toLowerCase()) ||
      labelDayOfWeekKey(element.dtKey).toLowerCase().contains(searchString.toLowerCase()) ||
      element.value.toLowerCase().contains(searchString.toLowerCase())));

    return (searchResults.isEmpty)
      ? Container()
      : Column(
          children:
            searchResults.map((e) => archiveRow(context, e)).toList(),
        );
  }

  /// Count the number of hits
  int searchCount(String searchString) {
    return (searchResults.isEmpty) ? 0 : searchResults.length;
  }

  /// Print the list
  Widget list(BuildContext context) {
    return Column(
        children: entries.map((e) => archiveRow(context, e)).toList());
  }

  /// Count the number of items in the list
  int listCount() => entries.length;
}

@JsonSerializable(explicitToJson: true)
class Entry {
  final String id;
  final String dtKey;
  String value;

  Entry(this.id, this.dtKey, this.value);

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  Map<String, dynamic> toJson() => _$EntryToJson(this);

  void inject(String newText) => value = '$newText\n$value';

  void append(String newText) => value += '\n$newText';
}
