import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  /* overview or date or time */
  gPrefStartPage = prefs.getString('startPage') ?? 'overview';
  /* date or time */
  gPrefActionButton = prefs.getString('actionButton') ?? 'date';
  /* dark or light or system */
  gPrefColorScheme = prefs.getString('colorScheme') ?? 'system';
  /* summary lines */
  gPrefSummaryLines = prefs.getInt('summaryLines') ?? 3;
  /* summary newlines */
  gPrefSummaryNewlines = prefs.getBool('summaryNewlines') ?? true;
  gPrefAllowEmpty = prefs.getBool('allowEmpty') ?? true;

  runApp(
    App(
      startPage: gPrefStartPage,
      actionButton: gPrefActionButton,
      colorScheme: gPrefColorScheme,
      summaryLines: gPrefSummaryLines,
      summaryNewlines: gPrefSummaryNewlines,
      allowEmpty: gPrefAllowEmpty,
    ),
  );
}
