library condora_automatic_getter_storage_directory;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Returns the storage directory for debug mode on desktop platforms.
Future<Directory> _desktopDebugDirectory() async {
  // Get the desktop project directory
  final projectDirectory = Directory.current;
  // Create a debug storage directory
  final desktopDebugStorageDirectory = Directory(
      '${projectDirectory.path}/REMEMBER TO DELETE -- DEBUG STORAGE FOLDER');
  // Create the directory if it doesn't exist
  if (!await desktopDebugStorageDirectory.exists()) {
    await desktopDebugStorageDirectory.create();
  }
  return desktopDebugStorageDirectory;
}

/// Returns the storage directory based on the current platform and build mode.
///
/// Storage locations by platform:
/// - iOS/macOS: Library directory (follows Apple guidelines)
/// - Android: External storage directory if available, falls back to application 
///   support directory if external storage is not accessible
/// - Windows: AppData/Roaming for roaming data, AppData/Local for device-specific data
/// - Linux: ~/.local/share/[app_name] (follows XDG spec)
/// - Web: Requires explicit directory
///
/// Parameters:
/// * [webStorageDirectory]: Required when running on web platform. Specifies the
///   storage directory to use for web applications.
/// * [windowsUseLocalStorage]: Optional boolean to specify if Windows should use
///   local storage (AppData/Local; true) instead of roaming storage (AppData/Roaming; false).
///   Defaults to false.
///
/// Throws:
/// * [StateError]: If running on web platform and webStorageDirectory is null.
///
/// Debug Mode:
/// When running in debug mode on desktop platforms (Windows, macOS, Linux),
/// creates a temporary debug storage directory in the current project folder.
///
/// Returns a [Directory] instance pointing to the appropriate storage location
/// based on the current platform and configuration.
Future<Directory> condoraAutomaticGetterStorageDirectory({
  Directory? webStorageDirectory,
  // Add this if you want to support local-only data on Windows
  bool windowsUseLocalStorage = false,
}) async {
  // Debug-time check
  assert(!kIsWeb || webStorageDirectory != null,
      '!!!!!!!!!!! webStorageDirectory must be provided when running in web platform. Please provide a valid Directory instance for web storage. !!!!!!!!!!!');
  if (kIsWeb) {
    // Runtime check
    if (webStorageDirectory == null) {
      throw StateError(
          '!!!!!!!!!!! webStorageDirectory must be provided when running in web platform. Please provide a valid Directory instance for web storage. !!!!!!!!!!!');
    }
    return webStorageDirectory;
  } else if (Platform.isAndroid) {
    final Directory? appStorageDirectory = await getExternalStorageDirectory();
    if (appStorageDirectory == null) {
      if (kDebugMode) {
        print(
            '!!! external storage not available, falling back to application support directory !!!');
      }
      return await getApplicationSupportDirectory();
    }
    return appStorageDirectory;
  } else if (Platform.isIOS || (Platform.isMacOS && !kDebugMode)) {
    return await getLibraryDirectory();
  } else if ((Platform.isMacOS || Platform.isWindows || Platform.isLinux) &&
      kDebugMode) {
    return await _desktopDebugDirectory();
  } else if (Platform.isWindows) {
    // If you want to support local-only data on Windows
    if (windowsUseLocalStorage) {
      return await getApplicationDocumentsDirectory();
    }
    // For data that should follow the user (default)
    return await getApplicationSupportDirectory();
  } else if (Platform.isLinux) {
    return await getApplicationSupportDirectory();
  } else {
    return await getApplicationSupportDirectory();
  }
}
