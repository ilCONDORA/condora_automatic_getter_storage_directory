library dynamic_storage_directory;

import 'dart:io';
import 'package:flutter/foundation.dart';

/// Returns the storage directory based on the current platform and build mode.
///
/// If the current platform is web, returns the [webStorageDirectory] specified by the developer.
/// If the current platform is not web, returns the [releaseStorageDirectory] specified by the developer.
/// In debug mode, returns the debugStorageDirectory, which is a folder created in the project folder.
Future<Directory> getStorageDirectory({
  required Directory webStorageDirectory,
  required Future<Directory> releaseStorageDirectory,
}) async {
  if (kIsWeb) {
    return webStorageDirectory;
  } else if (kDebugMode) {
    // Store data in the project folder in debug mode.
    final projectDirectory = Directory.current;
    final debugStorageDirectory = Directory(
        '${projectDirectory.path}/REMEMBER TO DELETE -- DEBUG STORAGE FOLDER');

    // Create the folder if it doesn't exist
    if (!await debugStorageDirectory.exists()) {
      await debugStorageDirectory.create();
    }

    return debugStorageDirectory;
  } else {
    return await releaseStorageDirectory;
  }
}
