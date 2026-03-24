import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import '../models/archive.dart';
import '../widgets/menu.dart';
import '../widgets/utils.dart';
import 'editor_screen.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

final Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});
  static const routeName = '/list';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    _searchController.text = '';
    debugPrint('start list screen');
  }

  @override
  void dispose() {
    debugPrint('close list screen');
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TextField(
                controller: _searchController,
                maxLength: 40,
                decoration: (_searchController.text.isNotEmpty)
                    ? InputDecoration(
                        counterText: '',
                        contentPadding:
                            const EdgeInsets.fromLTRB(28.0, 16.0, 8.0, 0.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        labelText: 'search...',
                        suffixIcon: IconButton(
                          tooltip:
                              '${globalTooltipStart}clear search$globalTooltipEnd',
                          icon: gIconCancel,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 30, minHeight: 25),
                        prefixIcon: gIconSearch,
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 50, minHeight: 45),
                      )
                    : InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'search...',
                        hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        suffixIcon: (_searchController.text.isNotEmpty)
                            ? IconButton(
                                tooltip:
                                    '${globalTooltipStart}clear search$globalTooltipEnd',
                                icon: gIconCancel,
                                color: Theme.of(context).colorScheme.secondary,
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : Container(),
                        contentPadding:
                            const EdgeInsets.fromLTRB(28.0, 16.0, 8.0, 0.0),
                        prefixIcon: gIconSearch,
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 50, minHeight: 45),
                      ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [mainMenuRight(context, currentItem: menuItemList)],
      ),
      //drawer: const MenuLateral(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.mode_outlined),
        onPressed: () {
          String newKey = '';
          if (gPrefActionButton == 'date') {
            newKey = currentDKey();
          } else {
            newKey = currentDTKey();
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorScreen(
                entry: Provider.of<Archive>(context, listen: false)
                    .append(newKey, ''),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<Archive>(
              builder: (context, arc, child) =>
                  arc.search(context, _searchController.text)),
        ),
      ),
    );
  }

}
