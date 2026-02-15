# Hydrate – Water Tracker

A cross-platform Flutter app to track daily water intake with a **glassmorphism** UI: frosted glass cards, circular progress ring, and soft gradients.

## Features

- **Circular progress ring** – Shows how much you’ve drunk vs your daily goal (default 2000 ml).
- **+ button** – Add one glass (250 ml) per tap; progress animates.
- **Today’s history** – List of each add in frosted cards.
- **Persistence** – Data saved with `shared_preferences`; resets at midnight.
- **Cross-platform** – Android, iOS, Web from one codebase.

## Prerequisites

- **Flutter SDK** – [Install Flutter](https://docs.flutter.dev/get-started/install) and add it to your PATH. Then run `flutter doctor` and fix any issues.
- Android Studio (for Android) and/or Xcode (for iOS on Mac), or use **Chrome** for web: `flutter run -d chrome`.

## Setup and run

From the project folder:

```bash
cd "d:\Ai coding Toola\water_tracker"
```

If this is a **new clone** or the `android/` / `ios/` folders are missing, generate them:

```bash
flutter create .
```

Then get dependencies and run:

```bash
flutter pub get
flutter run
```

Pick a device (emulator or connected phone) when prompted. For web:

```bash
flutter run -d chrome
```

## Project structure

```
water_tracker/
├── lib/
│   ├── main.dart              # App entry, theme, Provider
│   ├── screens/
│   │   └── home_screen.dart   # Main UI: ring, + button, history
│   ├── widgets/
│   │   ├── glass_card.dart    # Frosted glass container
│   │   └── progress_ring.dart # Circular progress painter
│   └── services/
│       └── storage_service.dart  # shared_preferences, daily reset
├── pubspec.yaml
└── README.md
```

## Tech stack

- **Flutter** – UI and cross-platform
- **Provider** – Simple state management
- **shared_preferences** – Local persistence
- **google_fonts** – Manrope font
- **intl** – Number formatting

Built with Cursor (agentic AI). Inspired by the [freeCodeCamp Antigravity Flutter tutorial](https://www.freecodecamp.org/news/build-an-ai-powered-flutter-app-with-google-antigravity/).
