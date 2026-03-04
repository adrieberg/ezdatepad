import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import '../models/archive.dart';
import '../screens/editor_screen.dart';

// https://github.com/vandadnp/flutter-tips-and-tricks

Widget workingIndicator() {
  return Container(
    color: Colors.grey[300],
    width: double.infinity,
    height: double.infinity,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [CircularProgressIndicator()],
    ),
  );
}

/// Create a key with the current date and time
///
/// For now: Use date key (and ignore time for now)
String currentDTKey() {
  DateTime now = DateTime.now();
  return DateFormat('yyyyMMddHHmm').format(now);
  //return DateFormat('yyyyMMdd').format(now);
}

/// Create a key with the current date
String currentDKey() {
  DateTime now = DateTime.now();
  return DateFormat('yyyyMMdd').format(now);
}

/// Create a key with the current time
String currentTKey() {
  DateTime now = DateTime.now();
  return DateFormat('HHmm').format(now);
}

String makeKey(int year, int month, int day, [int? hour, int? minute]) =>
    (hour != null)
        ? DateFormat('yyyyMMddHHmm')
            .format(DateTime(year, month, day, hour, minute ?? 0))
        : DateFormat('yyyyMMdd').format(DateTime(year, month, day));

String labelKey(String key) => (key.length == 4)
    ? labelTKey(key)
    : (key.length == 8)
        ? labelDKey(key)
        : (key.length == 12)
            ? labelDTKey(key)
            : 'incorrect key';

String labelTKey(String key) => '${key.substring(0, 2)}:${key.substring(2, 4)}';

String labelDKey(String key) =>
    DateFormat("MMMM d'${labelDaySuffix(key)}', yyyy").format(DateTime(
        int.parse(key.substring(0, 4)),
        int.parse(key.substring(4, 6)),
        int.parse(key.substring(6, 8))));

String labelDayOfWeekKey(String key) => DateFormat('EEEE').format(DateTime(
    int.parse(key.substring(0, 4)),
    int.parse(key.substring(4, 6)),
    int.parse(key.substring(6, 8))));

String labelDaySuffix(String key) {
  if (key.substring(6, 8).endsWith('1')) {
    return 'st';
  } else if (key.substring(6, 8).endsWith('2')) {
    return 'nd';
  } else if (key.substring(6, 8).endsWith('3')) {
    return 'rd';
  } else {
    return 'th';
  }
}

String dateTimeToDateKey(DateTime dt) {
  return '${dt.year.toString().padLeft(4, '0')}${dt.month.toString().padLeft(2, '0')}${dt.day.toString().padLeft(2, '0')}';
}

String dateTimeToDateTimeKey(DateTime dt) {
  return '${dt.year.toString().padLeft(4, '0')}${dt.month.toString().padLeft(2, '0')}${dt.day.toString().padLeft(2, '0')}${dt.hour.toString().padLeft(2, '0')}${dt.minute.toString().padLeft(2, '0')}';
}

String currentYear(String key) => key.substring(0, 4);

String currentMonth(String key) => key.substring(4, 6);

String currentDay(String key) => key.substring(6, 8);

String currentDate(String key) => key.substring(0, 8);

String currentHour(String key) =>
    (key.length >= 10) ? key.substring(8, 10) : '00';

String currentMinute(String key) =>
    (key.length >= 12) ? key.substring(10, 12) : '00';

String currentTime(String key) =>
    (key.length >= 12) ? key.substring(8, 12) : '0000';

DateTime currentDKeyDateTime(String key) {
  return DateTime(int.parse(currentYear(key)), int.parse(currentMonth(key)),
      int.parse(currentDay(key)));
}

DateTime currentDTKeyDateTime(String key) {
  return DateTime(
      int.parse(currentYear(key)),
      int.parse(currentMonth(key)),
      int.parse(currentDay(key)),
      int.parse(currentHour(key)),
      int.parse(currentMinute(key)));
}

String labelDTKey(String key) =>
    DateFormat("MMMM d'${labelDaySuffix(key)}', yyyy (HH:mm)").format(DateTime(
        int.parse(key.substring(0, 4)),
        int.parse(key.substring(4, 6)),
        int.parse(key.substring(6, 8)),
        key.length >= 10 ? int.parse(key.substring(8, 10)) : 0,
        key.length >= 12 ? int.parse(key.substring(10, 12)) : 0));

Widget archiveRow(BuildContext context, Entry e) {
  return Ink(
    child: InkWell(
      onTap: () {
        Provider.of<Archive>(context, listen: false).update(e);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditorScreen(entry: e)),
        );
      },
      /*child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey(e.dtKey),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                Entry backup = e;
                Provider.of<Archive>(context, listen: false).delete(e);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Entry [${labelDKey(e.dtKey)}] deleted'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        Provider.of<Archive>(context, listen: false).add(backup);
                        Provider.of<Archive>(context, listen: false).refresh();
                        Provider.of<Archive>(context, listen: false).store();
                      },
                    ),
                  ),
                );
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Edit',
            ),
          ],
        ),*/

            child: Dismissible(
        key: ValueKey(e.dtKey),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Align(
              alignment: Alignment.centerRight, child: gIconDeleteWhite,
            ),
          ),
        ),
        onDismissed: (direction) {
          Provider.of<Archive>(context, listen: false).delete(e);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:  Text('Entry [${labelKey(e.dtKey)}] deleted'),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  Provider.of<Archive>(context, listen: false).add(e);
                  Provider.of<Archive>(context, listen: false).refresh();
                  Provider.of<Archive>(context, listen: false).store();
                },
              ),
            ),
          );
        },
        child: ListTile(
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
          visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
          title: Ink(
            padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 0.0),
            child: Row(
              key: ValueKey(e.dtKey),
              children: <Widget>[
                Expanded(
                    child: Row(children: [
                  (e.dtKey.length == 12)
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(10, 8, 8, 2.0),
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                          ),
                          child: Text(
                            labelTKey(e.dtKey.substring(8, 12)),
                          ),
                        )
                      : Container(),
                  const Spacer(),
                  Provider.of<Archive>(context, listen: false)
                          .checkIfFirst(e.dtKey)
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(20, 8, 8, 2.0),
                          padding:
                              const EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
                          decoration: (currentDKey() == e.dtKey)
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                          child: Row(
                            children: [
                              Text('${labelDayOfWeekKey(e.dtKey)}, '),
                              Text(
                                labelDKey(e.dtKey),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                      : Container(),
                ]))
              ],
            ),
          ),
          subtitle: Ink(
            padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 2.0),
            // overflow test: TextOverflow.fade
            child: Text(
              (gPrefSummaryNewlines == true)
                  ? e.value.trim().replaceAll("\n", " ")
                  : e.value.trim(),
              maxLines: gPrefSummaryLines,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          // trailing: gIconMoreHoriz,
        ),
      ),
    ),
  );
}
