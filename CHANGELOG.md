## 1.0.0

- Initial release of condora_automatic_getter_storage_directory
- Added `condoraAutomaticGetterStorageDirectory` function
- Platform-specific storage paths following best practices:
  - iOS/macOS: Library directory (Apple guidelines)
  - Android: Application support directory
  - Windows: AppData/Roaming (configurable to Local)
  - Linux: ~/.local/share/[app_name]
  - Web: Custom directory support
- Debug mode support with dedicated project directory storage
- Comprehensive error handling for web storage configuration
- Cross-platform support (Android, iOS, Windows, macOS, Linux, Web)
- Detailed documentation and examples

## 1.0.1

- Updated Android storage path to use external storage directory when available, with fallback to application support directory when external storage is not accessible
- Enhanced reliability for Android storage handling
- Updated documentation to reflect new Android storage behavior
