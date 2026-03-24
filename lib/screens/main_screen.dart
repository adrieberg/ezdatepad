import 'package:flutter/material.dart';

import '../globals.dart';
import '../widgets/menu.dart';

/// Development only page
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState();

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
            automaticallyImplyLeading: false,
            actions: [mainMenuRight(context)],
          ),
         // drawer: const MenuLateral(),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                        padding: const EdgeInsets.all(listViewPadding),
                        children: <Widget>[
                          InkWell(
                            child: const ListTile(
                              title: Text('Today'),
                              subtitle: Text(
                                  'Create an entry for today, or add data to the existing entry'),
                            ),
                            onTap: () =>
                                Navigator.pushNamed(context, '/editor'),
                          ),
                          InkWell(
                            child: const ListTile(
                              title: Text('Overview'),
                              subtitle: Text('Display a list of all entries'),
                            ),
                            onTap: () => Navigator.pushNamed(context, '/list'),
                          ),
                          InkWell(
                            child: const ListTile(
                              title: Text('Settings'),
                              subtitle: Text('Modify/review settings'),
                            ),
                            onTap: () =>
                                Navigator.pushNamed(context, '/settings'),
                          ),
                          InkWell(
                            child: const ListTile(
                              title: Text('About'),
                              subtitle: Text('Information'),
                            ),
                            onTap: () => Navigator.pushNamed(context, '/about'),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
