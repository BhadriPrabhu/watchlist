# Watchlist

A simple, initial-stage Flutter app for tracking items you want to watch. 

This version of the project is built as a minimal viable product (MVP) to demonstrate core functionality, with all logic.

## Key Features

- Add new items to your watchlist
- Toggle items between "watched" and "unwatched"
- Delete items from the list

## Prerequisites

- Flutter SDK (see https://flutter.dev)
- Android Studio mobile development (optional for web/desktop)

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

3. Run the app on a device or emulator:

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

- Web, Windows, macOS, Linux:

```bash
flutter build web
flutter build windows
flutter build macos
flutter build linux
```

## Dependencies

Major dependencies listed in `pubspec.yaml`:

- `google_fonts` - typography
- `uuid` - generating unique IDs for watchlist items

## Author
Developed by Bhadri Prabhu K