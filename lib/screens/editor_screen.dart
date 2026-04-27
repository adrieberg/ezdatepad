import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../globals.dart';
import '../models/archive.dart';
import '../widgets/utils.dart';
import '../widgets/menu.dart';

/**
 * Use focus for the textfield, to store the item when the focus is lost:
 *   https://api.flutter.dev/flutter/widgets/FocusNode-class.html
 *   https://stackoverflow.com/questions/68675718/how-can-i-catch-event-when-a-text-field-is-exiting-focus-on-blur-in-flutter
 **/

/// Implement swipe to go to next and previous entries (if available)
///   https://pub.dev/packages/carousel_slider/example
///
class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key, required this.entry});
  static const routeName = '/editor';

  final Entry entry;

  //final FocusNode focusNode;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen>
    with WidgetsBindingObserver {
  final myController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  _EditorScreenState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (kDebugMode) debugPrint('start editor ');

    if (widget.entry.value == '') {
      myController.text = Provider.of<Archive>(context, listen: false)
          .get(widget.entry.dtKey)
          .value
          .trim();
    } else {
      myController.text = widget.entry.value.trim();
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        return;
      }
      _saveText();
    });
  }

  void _saveText() {
    final archive = Provider.of<Archive>(context, listen: false);
    final text = myController.text.trim();
    final currentValue = archive.get(widget.entry.dtKey).value.trim();

    if (text != currentValue) {
      debugPrint("text updated and stored");
      archive.update(Entry(widget.entry.id, widget.entry.dtKey, text));
      archive.store();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _saveText();
    }
  }

  @override
  void dispose() {
    if (kDebugMode) debugPrint('close editor ');
    WidgetsBinding.instance.removeObserver(this);
    _saveText();
    focusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          titleSpacing: 8.0,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(labelKey(widget.entry.dtKey),
                overflow: TextOverflow.ellipsis),
          ),
          automaticallyImplyLeading: false,
          //
          // If current item is 'today' disable the menu option. If it is any
          // other day leave the menu option active
          actions: <Widget>[
            Builder(builder: (shareContext) {
              return IconButton(
                icon: const Icon(Icons.ios_share),
                onPressed: () async {
                  final shareText = myController.text.trim();
                  if (shareText.isEmpty) {
                    final messenger = ScaffoldMessenger.of(context);
                    messenger.clearSnackBars();
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Nothing to share.'),
                      ),
                    );
                    return;
                  }

                  final box = shareContext.findRenderObject() as RenderBox?;
                  final origin = box == null
                      ? null
                      : box.localToGlobal(Offset.zero) & box.size;

                  await SharePlus.instance.share(
                    ShareParams(
                      text: shareText,
                      subject: labelKey(widget.entry.dtKey),
                      sharePositionOrigin: origin,
                    ),
                  );
                },
              );
            }),
            mainMenuRight(context),
          ]),
      floatingActionButton: FloatingActionButton(
        key: const Key('overview'),
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          _saveText();
          FocusScope.of(context).unfocus();
          Navigator.pushNamedAndRemoveUntil(context, '/list', (r) => false);
        },
        child: const Icon(Icons.view_headline),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                  height: constraints.maxHeight,
                  child: GestureDetector(
                    onVerticalDragStart: (_) {
                      // Dismiss the keyboard when swiping down
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: TextField(
                      focusNode: focusNode,
                      expands: true,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(textFieldPadding),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      controller: myController,
                      scrollPadding: const EdgeInsets.all(20.0),
                      autofocus: true,
                      maxLines: null,
                    ),
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}
