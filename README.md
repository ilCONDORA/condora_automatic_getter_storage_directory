# dynamic_storage_directory

A Flutter package that provides a clean way to handle storage directory path on both web and non-web platforms and debug and release builds.

## Features

- Automatic platform detection (web vs non-web)
- Different storage paths for debug and release builds
- Debug storage in project directory for easy access during development
- Declaration by developer of web storage directory
- Declaration by developer of release storage directory
- Cross-platform support (Android, iOS, Windows, macOS, Linux, Web)

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  dynamic_storage_directory: ^1.0.0
```

## Usage

The package provides a simple way to get the appropriate storage directory based on your platform and build mode:
```dart
import 'package:dynamic_storage_directory/dynamic_storage_directory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the storage directory
  final storageDir = await getStorageDirectory(
    webStorageDirectory: Directory('your_web_storage_path'),
    releaseStorageDirectory: getApplicationSupportDirectory(), // Or any other directory
  );

  // Use the directory
  print('Storage directory: ${storageDir.path}');
}
```

### With Hydrated Bloc

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hydrated Bloc Storage dynamically
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getStorageDirectory(
      webStorageDirectory: HydratedStorage.webStorageDirectory,
      releaseStorageDirectory: getApplicationSupportDirectory(),
    ),
  );

  runApp(const MyApp());
}
```

## Storage Directory Behavior

- Web Platform: Uses the provided webStorageDirectory
- Debug Mode: Creates a clearly marked debug folder in your project directory
- Release Mode: Uses the provided releaseStorageDirectory

## Additional information

This package is particularly useful when:

- You need different storage locations for web and native platforms
- You want to easily access stored data during development
- You're using packages like hydrated_bloc that require different storage handling for web

## Contributing

Feel free to file issues, PRs, or suggestions on the GitHub repository.

## License

MIT License - see LICENSE file for details