import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import '../models/archive.dart';
import '../screens/editor_screen.dart';
import '../widgets/utils.dart';
import '../widgets/popup.dart';

Widget mainMenuRight(BuildContext context, {String currentItem = ''}) {
  return PopupMenuButton<String>(
      itemBuilder: (_) {
        return [
          PopupMenuItem<String>(
              value: menuItemList,
              enabled: (currentItem == menuItemList) ? false : true,
              child: const ListTile(
                leading: Icon(Icons.view_headline),
                title: Text('Overview'),
              )),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
              value: menuItemEditCurrentDate,
              enabled: (currentItem == menuItemEditCurrentDate) ? false : true,
              child: const ListTile(
                leading: Icon(Icons.mode_outlined),
                title: Text('Current date'),
              )),
          PopupMenuItem<String>(
              value: menuItemEditCurrentDateTime,
              enabled:
              (currentItem == menuItemEditCurrentDateTime) ? false : true,
              child: const ListTile(
                leading: Icon(Icons.mode_outlined),
                title: Text('Current time'),
              )),
          PopupMenuItem<String>(
              value: menuItemEditSelectTime,
              enabled: (currentItem == menuItemEditSelectTime) ? false : true,
              child: const ListTile(
                leading: Icon(Icons.watch_later),
                title: Text('Select time'),
                subtitle: Text('for current date'),
              )),
          PopupMenuItem<String>(
              value: menuItemEditSelectDate,
              enabled: (currentItem == menuItemEditSelectDate) ? false : true,
              child: const ListTile(
                leading: Icon(Icons.date_range),
                title: Text('Select date'),
              )),
          PopupMenuItem<String>(
              value: menuItemEditSelectDateTime,
              enabled:
              (currentItem == menuItemEditSelectDateTime) ? false : true,
              child: const ListTile(
                leading: Icon(Icons.date_range),
                title: Text('Select date and time'),
              )),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
              value: menuItemSettings,
              enabled: (currentItem == menuItemSettings) ? false : true,
              child: const ListTile(
                  leading: Icon(Icons.settings), title: Text('Settings'))),
          PopupMenuItem<String>(
              value: menuItemAbout,
              enabled: (currentItem == menuItemAbout) ? false : true,
              child: const ListTile(
                  leading: Icon(Icons.info), title: Text('About'))),
        ];
      },
      icon: const Icon(Icons.more_vert),
      onOpened: () => ScaffoldMessenger.of(context).clearSnackBars(),
      onSelected: (i) => mainMenuNavigate(context, i),
  );
}

Future<void> mainMenuNavigate(BuildContext context, String i) async {
  String newKey = '';

  if (i == menuItemEditCurrentDateTime) {
    newKey = currentDTKey();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditorScreen(
          entry:
              Provider.of<Archive>(context, listen: false).append(newKey, ''),
        ),
      ),
    );
  }

  if (i == menuItemEditCurrentDate) {
    newKey = currentDKey();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditorScreen(
          entry:
              Provider.of<Archive>(context, listen: false).append(newKey, ''),
        ),
      ),
    );
  }

  if (i == menuItemEditSelectTime) {
    final dynamic value = await popupSelectTime(context);
    if (!context.mounted) return;
    if (value != null) {
      newKey = value;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditorScreen(
            entry:
                Provider.of<Archive>(context, listen: false).append(newKey, ''),
          ),
        ),
      );
    }
  }

  if (i == menuItemEditSelectDate) {
    final dynamic value = await popupSelectDate(context);
    if (!context.mounted) return;
    if (value != null) {
      newKey = value;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditorScreen(
            entry:
                Provider.of<Archive>(context, listen: false).append(newKey, ''),
          ),
        ),
      );
    }
  }

  if (i == menuItemEditSelectDateTime) {
    final dynamic value = await popupSelectDateTime(context);
    if (!context.mounted) return;
    if (value != null) {
      newKey = value;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditorScreen(
            entry:
                Provider.of<Archive>(context, listen: false).append(newKey, ''),
          ),
        ),
      );
    }
  } else if (i == menuItemList) {
    Navigator.pushNamed(context, '/list');
  } else if (i == menuItemSettings) {
    Navigator.pushNamed(context, '/settings');
  } else if (i == menuItemAbout) {
    Navigator.pushNamed(context, '/about');
  }
}
