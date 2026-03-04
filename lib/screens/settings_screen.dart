import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';
import '../globals.dart';
import '../widgets/menu.dart';
//import '../widgets/numeric_step.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _SettingsScreenState();

  //String _selectStartPage = gPrefStartPage;
  String _selectActionButton = gPrefActionButton;
  String _selectColorScheme = gPrefColorScheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title: const Text('Settings'),
        automaticallyImplyLeading: true,
        actions: [mainMenuRight(context, currentItem: menuItemSettings)],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    const ListTile(
                      //  leading: const Icon(Icons.settings),
                      title: Text('App'),
                      //subtitle: Text('Trailing expansion arrow icon'),
                    ),

        /*            ExpansionTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Startup page'),
                      subtitle: const Text(
                          'Select the screen to use then starting the app'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              RadioListTile<String>(
                                title: const Text('Overview page'),
                                value: 'list',
                                groupValue: _selectStartPage,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('startPage', 'list');
                                  setState(() {
                                    _selectStartPage = value!;
                                    gPrefStartPage = value;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Date entry'),
                                value: 'date',
                                groupValue: _selectStartPage,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('startPage', 'date');
                                  setState(() {
                                    _selectStartPage = value!;
                                    gPrefStartPage = value;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Time entry'),
                                value: 'time',
                                groupValue: _selectStartPage,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('startPage', 'time');
                                  setState(() {
                                    _selectStartPage = value!;
                                    gPrefStartPage = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),*/

                    ExpansionTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Color scheme'),
                      subtitle: const Text(
                          'Select your device settings, dark mode or light mode'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              RadioListTile<String>(
                                title: const Text('System'),
                                value: 'system',
                                groupValue: _selectColorScheme,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('colorScheme', 'system');
                                  setState(() {
                                    _selectColorScheme = value!;
                                    gPrefColorScheme = value;
                                    App.of(context)
                                        .changeTheme(ThemeMode.system);
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Dark mode'),
                                value: 'dark',
                                groupValue: _selectColorScheme,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('colorScheme', 'dark');
                                  setState(() {
                                    _selectColorScheme = value!;
                                    gPrefColorScheme = value;
                                    App.of(context).changeTheme(ThemeMode.dark);
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Light mode'),
                                value: 'light',
                                groupValue: _selectColorScheme,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('colorScheme', 'light');
                                  setState(() {
                                    _selectColorScheme = value!;
                                    gPrefColorScheme = value;
                                    App.of(context)
                                        .changeTheme(ThemeMode.light);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

      /*              ExpansionTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Content'),
                      subtitle: const Text(
                          'Choose to allow empty entries'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[

                              ListTile(
                                  title: const Text('Allow empty entries'),
                                  subtitle:
                                  Text('Allow entries without any text'),
                                  leading: Checkbox(
                                    value: gPrefAllowEmpty,
                                    onChanged: (value) async {
                                      SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                      prefs.setBool('allowEmpty', value!);
                                      setState(() {
                                        gPrefAllowEmpty = value;
                                      });
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),*/

                    const ListTile(
                      // leading: const Icon(Icons.settings),
                      title: Text('Overview'),
                      //subtitle: Text('Trailing expansion arrow icon'),
                    ),

                    ExpansionTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Action button'),
                      subtitle: const Text(
                          'Select the function for the action button on the list screen'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              RadioListTile<String>(
                                title: const Text('Create/edit date entry'),
                                value: 'date',
                                groupValue: _selectActionButton,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('actionButton', 'date');
                                  setState(() {
                                    _selectActionButton = value!;
                                    gPrefActionButton = value;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Create/edit time entry'),
                                value: 'time',
                                groupValue: _selectActionButton,
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('actionButton', 'time');
                                  setState(() {
                                    _selectActionButton = value!;
                                    gPrefActionButton = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

   /*                 ExpansionTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Summary'),
                      subtitle: const Text(
                          'Select the size of the summary shown in the overview'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40.0, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text('Number of lines'),
                                subtitle: Row(children: [
                                  NumericStepButton(
                                    key: const Key('abc'),
                                    minValue: 1,
                                    maxValue: 5,
                                    selectedValue: gPrefSummaryLines,
                                    onChanged: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setInt('summaryLines', value);
                                      setState(() {
                                        gPrefSummaryLines = value;
                                      });
                                    },
                                  ),
                                  Text('Lines shown in overview'),
                                ]),
                              ),
                              ListTile(
                                  title: const Text('Remove newlines'),
                                  subtitle:
                                      Text('Shows more text in the preview', overflow: TextOverflow.fade,),
                                  leading: Checkbox(
                                    value: gPrefSummaryNewlines,
                                    onChanged: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool('summaryNewlines', value!);
                                      setState(() {
                                        gPrefSummaryNewlines = value;
                                      });
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),*/

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
