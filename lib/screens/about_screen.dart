import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../globals.dart';
import '../oss_licenses.dart';
import '../widgets/menu.dart';
import '../widgets/utils.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        title: const Text('About'),
        automaticallyImplyLeading: true,
        actions: [mainMenuRight(context, currentItem: menuItemAbout)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  const ExpansionTile(
                    leading: Icon(Icons.info),
                    title: Text(appTitle),
                    subtitle: Text('Version, author, contact'),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: MarkdownBody(data: mdAuthor),
                      ),
                    ],
                  ),
                  const ExpansionTile(
                    leading: Icon(Icons.info),
                    title: Text('Terms and conditions'),
                    //subtitle: Text('Trailing expansion arrow icon'),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: MarkdownBody(data: mdTerms),
                      ),
                    ],
                  ),
                  const ExpansionTile(
                    leading: Icon(Icons.info),
                    title: Text('Privacy policy'),
                    //subtitle: Text('Trailing expansion arrow icon'),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: MarkdownBody(data: mdPrivacy),
                      ),
                    ],
                  ),

                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Acknowledgements'),
                    subtitle: const Text('Licenses'),
                    trailing: const Icon(Icons.chevron_right),

                     onTap: () => Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context) => const MiscOssLicenseAll(),
                       ),
                     ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MiscOssLicenseAll extends StatelessWidget {
  const MiscOssLicenseAll({Key? key}) : super(key: key);

  static Future<List<Package>> loadLicenses() async {
    // merging non-dart dependency list using LicenseRegistry.
    final lm = <String, List<String>>{};
    await for (var l in LicenseRegistry.licenses) {
      for (var p in l.packages) {
        final lp = lm.putIfAbsent(p, () => []);
        lp.addAll(l.paragraphs.map((p) => p.text));
      }
    }
    final licenses = allDependencies.toList();
    for (var key in lm.keys) {
      licenses.add(Package(
        name: key,
        description: '',
        authors: [],
        version: '',
        license: lm[key]!.join('\n\n'),
        isMarkdown: false,
        isSdk: false,
        dependencies: [],
      ));
    }
    return licenses..sort((a, b) => a.name.compareTo(b.name));
  }

  static final _licenses = loadLicenses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Licenses'),
        actions: [mainMenuRight(context)],
      ),
      body: SafeArea(child: Container(
        color: Theme.of(context).canvasColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return FutureBuilder<List<Package>>(
              future: _licenses,
              initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return workingIndicator();
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 40.0),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final package = snapshot.data![index];
                      return ListTile(
                        title: Text('${package.name} ${package.version}'),
                        subtitle: package.description.isNotEmpty ? Text(package.description) : null,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MiscOssLicenseSingle(package: package),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                );
                
              },
            );
          },
        ),
      )),
    );
  }
}


class MiscOssLicenseSingle extends StatelessWidget {
  final Package package;

  const MiscOssLicenseSingle({Key? key, required this.package}) : super(key: key);

  String _bodyText() {
    return package.license!.split('\n').map((line) {
      if (line.startsWith('//')) line = line.substring(2);
      line = line.trim();
      return line;
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${package.name} ${package.version}'),
        actions: [mainMenuRight(context)],
      ),
      body: SafeArea(child: Container(
        color: Theme.of(context).canvasColor,
        child: ListView(children: <Widget>[
          if (package.description.isNotEmpty)
            Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: Text(package.description,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold))),
          if (package.homepage != null)
            Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: InkWell(
                  child: Text(package.homepage!,
                      style: const TextStyle(decoration: TextDecoration.underline)),
                )),
          if (package.description.isNotEmpty || package.homepage != null) const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: Text(_bodyText(), style: Theme.of(context).textTheme.bodyMedium),
          ),
        ]),
      )),
    );
  }
}