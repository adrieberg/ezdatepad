import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../globals.dart';
import 'utils.dart';

Future<dynamic> popupSelectDate(BuildContext context) async {
  DateTime date = DateTime.now();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pick a date'),
        content: SizedBox(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          width: MediaQuery.of(context).size.width - 50,
          child: CupertinoDatePicker(
            initialDateTime: date,
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              date = newDate;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(textBtnCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(dateTimeToDateKey(date));
            },
            child: const Text(textBtnOK),
          ),
        ],
      );
    },
  );
}

Future popupSelectTime(BuildContext context) {
  DateTime time = DateTime.now();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pick a time'),
        content: SizedBox(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          width: MediaQuery.of(context).size.width - 50,
          child: CupertinoDatePicker(
            initialDateTime: time,
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newTime) {
              time = newTime;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(textBtnCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(dateTimeToDateTimeKey(time));
            },
            child: const Text(textBtnOK),
          ),
        ],
      );
    },
  );
}

Future popupSelectDateTime(BuildContext context) {
  DateTime dateTime = DateTime.now();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pick a date and time'),
        content: SizedBox(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          width: MediaQuery.of(context).size.width - 50,
          child: CupertinoDatePicker(
            initialDateTime: dateTime,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDateTime) {
              dateTime = newDateTime;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(textBtnCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(dateTimeToDateTimeKey(dateTime));
            },
            child: const Text(textBtnOK),
          ),
        ],
      );
    },
  );
}
