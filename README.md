# condora_automatic_getter_storage_directory

A Flutter package that provides an automatic and platform-aware solution for managing storage directories across web and non-web platforms, handling both debug and release environments efficiently.

## Features

- Intelligent platform-specific storage paths following best practices:
  - iOS/macOS: Library directory (Apple guidelines)
  - Android: External storage directory if available, falls back to application support directory if external storage is not accessible
  - Windows: AppData/Roaming with optional Local storage
  - Linux: ~/.local/share/[app_name] (XDG spec)
  - Web: Configurable storage directory
- Debug mode development support with easily accessible project directory storage
- Comprehensive error handling and validation
- Cross-platform support (Android, iOS, Windows, macOS, Linux, Web)

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  condora_automatic_getter_storage_directory: ^1.0.1
```

## Usage

### Without Hydrated BLoC

```dart
import 'package:condora_automatic_getter_storage_directory/condora_automatic_getter_storage_directory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the storage directory
  final storageDir = await condoraAutomaticGetterStorageDirectory(
    webStorageDirectory: Directory('your_web_storage_path'),
    windowsUseLocalStorage: false, // Optional: use AppData/Local instead of Roaming
  );

  // Use the directory
  print('Storage directory: ${storageDir.path}');
}
```

### With Hydrated BLoC

```dart
import 'package:condora_automatic_getter_storage_directory/condora_automatic_getter_storage_directory.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hydrated Bloc Storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await condoraAutomaticGetterStorageDirectory(
      webStorageDirectory: HydratedStorage.webStorageDirectory,
    ),
  );

  runApp(const MyApp());
}
```

## Storage Directory Behavior

Platform-specific storage locations:

- iOS/macOS: Library directory (follows Apple guidelines)
- Android: External storage directory if available, falls back to application support directory if external storage is not accessible
- Windows: AppData/Roaming (configurable to Local)
- Linux: ~/.local/share/[app_name] (follows XDG spec)
- Web: Custom configurable directory
- Debug Mode: Creates a clearly marked debug folder in project directory

## Additional information

This package is particularly useful when:

- You're building a Flutter app for multiple platforms
- You need platform-appropriate storage locations
- You want development-friendly debug storage
- You're using packages like hydrated_bloc that require web-compatible storage
- You need to follow platform-specific storage guidelines

## Contributing

Feel free to file issues, PRs, or suggestions on the GitHub repository.

## License

MIT License - see LICENSE file for details
