# watchlist

A feature-based Flutter app for tracking items you want to watch.

## Key Features

- Feature-based project structure
- Local persistence using Isar (via `isar_community`)
- State management with `bloc` and `flutter_bloc`
- Custom fonts via `google_fonts`

## Prerequisites

- Flutter SDK (see https://flutter.dev)
- Android Studio / Xcode for mobile development (optional for web/desktop)

## Getting Started

1. Clone the repo:

```bash
git clone https://github.com/BhadriPrabhu/watchlist.git
cd watchlist
```

2. Install dependencies:

```bash
flutter pub get
```

3. (Optional) Generate code for Isar models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app on a device or emulator:

```bash
flutter run
```

## Building

- Android APK:

```bash
flutter build apk --release
```

- iOS (requires macOS + Xcode):

```bash
flutter build ios --release
```

- Web:

```bash
flutter build web
```

- Windows/macOS/Linux:

```bash
flutter build windows
flutter build macos
flutter build linux
```

## Tests

Run unit and widget tests with:

```bash
flutter test
```

## Project Structure (high-level)

- `lib/` - main Dart code
	- `app_routes.dart`, `main.dart`
	- `core/` - shared utilities, constants, network, widgets
	- `features/` - feature modules (e.g., `home`)
- `android/`, `ios/`, `web/`, `macos/`, `windows/`, `linux/` - platform code
- `pubspec.yaml` - dependencies and assets

## Dependencies

Major dependencies listed in `pubspec.yaml`:

- `bloc`, `flutter_bloc` - state management
- `isar_community`, `isar_community_flutter_libs` - local DB
- `google_fonts` - typography
- `path_provider` - filesystem access
- `uuid` - unique IDs

Dev dependencies:

- `build_runner`, `isar_community_generator` - code generation for Isar

## Author
Developed by Bhadri Prabhu K