import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'globals.dart';
import 'models/archive.dart';
import 'screens/about_screen.dart';
import 'screens/editor_screen.dart';
import 'screens/list_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/utils.dart';

// https://docs.flutter.dev/cookbook/design/themes#creating-unique-themedata

class App extends StatefulWidget {
  final String startPage;
  final String actionButton;
  final String colorScheme;
  final int summaryLines;
  final bool summaryNewlines;
  final bool allowEmpty;

  const App(
      {required this.startPage,
      required this.actionButton,
      required this.colorScheme,
      required this.summaryLines,
      required this.summaryNewlines,
      required this.allowEmpty,
      super.key});

  @override
  State<App> createState() => AppState();

  static AppState of(BuildContext context) =>
      context.findAncestorStateOfType<AppState>()!;
}

class AppState extends State<App> {
  late Archive archive;
  ThemeMode _themeMode = (gPrefColorScheme == "system")
      ? ThemeMode.system
      : (gPrefColorScheme == "dark")
          ? ThemeMode.dark
          : ThemeMode.light;

  @override
  void initState() {
    archive = Archive(id: const Uuid().v4(), name: "archive", entries: []);
    archive.load();

    debugPrint('start $appTitle');
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('close $appTitle');
    archive.store();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: archive,
        ),
      ],
      child: MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        themeMode: _themeMode,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),

        /**
         * Initial route is retrieved from the shared preferences. It can be updated
         * in the app settings screen. Default value is editor screen for the current
         * date (without time)
         */
        /* initialRoute: (widget.startPage == 'overview') ? '/list' : '/editor',*/
        initialRoute: '/list',
        routes: {
          '/': (context) => const ListScreen(),
          '/editor': (context) => EditorScreen(
              entry: Entry(
                  const Uuid().v4(),
                  (widget.startPage == 'time') ? currentDTKey() : currentDKey(),
                  '')),
          '/list': (context) => const ListScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/about': (context) => const AboutScreen(),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) => const ListScreen());
        },
      ),
    );
  }

  /// MyApp.of(context).changeTheme(ThemeMode.dark);
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
