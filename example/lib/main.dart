import 'package:flutter/material.dart';
import 'package:dynamic_storage_directory/dynamic_storage_directory.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hydrated Bloc Storage dynamically.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getStorageDirectory(
      webStorageDirectory: HydratedStorage
          .webStorageDirectory, // web storage directory specified by hydrated_bloc
      releaseStorageDirectory:
          getApplicationSupportDirectory(), // release storage directory specified by developer
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
