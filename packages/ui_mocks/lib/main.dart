import 'package:core/core.dart';
import 'package:flutter_mobx/flutter_mobx.dart' as mobx show enableWarnWhenNoObservables;
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';

import 'features/routes.dart';

void main() {
  mobx.enableWarnWhenNoObservables = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => RoutesPage(routes: routes.keys),
        ...routes,
      },
    );
  }
}

class RoutesPage extends StatelessWidget {
  RoutesPage({super.key, required Iterable<String> routes}) : _files = parseFiles(routes);

  final List<FileBase> _files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
      ),
      body: ExpansionGroup<String>.single(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final file in _files) file.build(),
              ],
            ),
          );
        },
      ),
    );
  }
}

@visibleForTesting
// ignore: library_private_types_in_public_api
List<FileBase> parseFiles(Iterable<String> routes) {
  Folder rootFolder = Folder(path: '/', name: '');

  void putInFolder(String path, Folder folder) {
    final pathParts = path.split('/').where((element) => element.isNotEmpty);
    if (pathParts.isEmpty) return;

    if (pathParts.length == 1) {
      final name = pathParts.single;
      folder.files.add(File(name: name, path: '${folder.path}$name'));
      return;
    }
    final folderName = pathParts.first;
    final subFolder = folder.subFolder(folderName);
    putInFolder('/${pathParts.skip(1).join('/')}', subFolder);
  }

  for (final path in routes) {
    putInFolder(path, rootFolder);
  }
  return rootFolder.files;
}

@visibleForTesting
abstract class FileBase {
  FileBase({required this.name, required this.path});

  final String name;
  final String path;

  Widget build();
}

@visibleForTesting
class File extends FileBase {
  File({required super.name, required super.path});

  @override
  Widget build() {
    return Builder(builder: (context) {
      final theme = Theme.of(context);
      return AppTile(
        onTap: () {
          Navigator.pushNamed(context, path);
        },
        title: Text(
          name,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
        ),
      );
    });
  }
}

@visibleForTesting
class Folder extends FileBase {
  Folder({
    required super.name,
    required super.path,
    List<FileBase>? files,
  }) : files = files ?? [];

  final List<FileBase> files;

  Folder subFolder(String name) {
    final folder = files.firstWhereOrNull((file) => file.name == name && file is Folder);
    if (folder != null) return folder as Folder;
    final newFolder = Folder(name: name, path: '$path$name/');
    files.add(newFolder);
    return newFolder;
  }

  @override
  Widget build() {
    return Builder(
      builder: (context) {
        final groupController = ExpansionGroup.of<String>(context);
        return ExpandableTile(
          isExpanded: groupController.isExpanded(name),
          title: Text(name),
          content: ExpansionGroup<String>.multiple(
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final file in files)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: file.build(),
                    ),
                ],
              );
            },
          ),
          onChange: (_) {
            groupController.onTap(name);
          },
        );
      },
    );
  }
}
