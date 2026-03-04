// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Archive _$ArchiveFromJson(Map<String, dynamic> json) => Archive(
      id: json['id'] as String,
      name: json['name'] as String,
      entries: (json['entries'] as List<dynamic>)
          .map((e) => Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..searchResults = (json['searchResults'] as List<dynamic>)
        .map((e) => Entry.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ArchiveToJson(Archive instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
      'searchResults': instance.searchResults.map((e) => e.toJson()).toList(),
    };

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      json['id'] as String,
      json['dtKey'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'id': instance.id,
      'dtKey': instance.dtKey,
      'value': instance.value,
    };
