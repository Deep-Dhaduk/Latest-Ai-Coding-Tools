# Hydrate – Water Tracker

A cross-platform Flutter app to track daily water intake with a **glassmorphism** UI: frosted glass cards, circular progress ring, and soft blue gradients. Add glasses with one tap; progress resets at midnight.

---

## Features

- **Circular progress ring** – Visual progress toward your daily goal (default 2000 ml).
- **One-tap add** – Big **+** button adds one glass (250 ml); ring animates.
- **Today’s history** – Each add shown in a frosted glass card.
- **Persistence** – Data saved locally with `shared_preferences`; survives app restart.
- **Daily reset** – Intake resets at midnight automatically.
- **Cross-platform** – Same codebase for Android, iOS, and Web.

---

## Prerequisites

- **Flutter SDK** – [Install Flutter](https://docs.flutter.dev/get-started/install) and add it to your PATH. Run `flutter doctor` and fix any issues.
- For **Android**: Android Studio + emulator or device.
- For **iOS**: Xcode (Mac only).
- For **Web**: no extra setup; use `flutter run -d chrome`.

---

## Run locally

### 0. Fix “flutter not recognized” (Windows, one-time per terminal)

If `flutter` isn’t in your PATH, run this **first** in the same PowerShell window (use your real Flutter path if different):

```powershell
$env:Path += ";C:\Users\dhadu\Downloads\flutter_windows_3.41.1-stable\flutter\bin"
```

Or use the full path for each command:  
`& "C:\Users\dhadu\Downloads\flutter_windows_3.41.1-stable\flutter\bin\flutter.bat" create .`

### 1. Open the project

```powershell
cd "d:\Ai coding Toola\water_tracker"
```

(Use your actual path to the `water_tracker` folder.)

### 2. Create platform folders (first time only)

If `android/` or `ios/` are missing (e.g. new clone):

```bash
flutter create .
```

### 3. Install dependencies and run

```bash
flutter pub get
flutter run
```

Choose a device when prompted. To run in **Chrome**:

```bash
flutter run -d chrome
```

To run on **Windows desktop** (if Flutter supports it and Developer Mode is enabled):

```bash
flutter run -d windows
```

---

## Project structure

```
water_tracker/
├── lib/
│   ├── main.dart                 # App entry, theme, Provider setup
│   ├── screens/
│   │   └── home_screen.dart      # Main screen: ring, + button, history list
│   ├── widgets/
│   │   ├── glass_card.dart       # Frosted glass (BackdropFilter) container
│   │   └── progress_ring.dart    # Circular progress CustomPainter
│   └── services/
│       └── storage_service.dart  # shared_preferences, daily reset logic
├── pubspec.yaml
├── README.md
└── RUN_FLUTTER.md                # Flutter path / run notes (Windows)
```

---

## Tech stack

| Layer        | Technology |
|-------------|------------|
| Framework   | Flutter    |
| State       | Provider   |
| Storage     | shared_preferences |
| Fonts       | google_fonts (Manrope) |
| Formatting  | intl       |

---

## Usage

- **Add water** – Tap the **+** button once per glass (250 ml).
- **View progress** – The ring and “X glasses · Y of Z ml” show today’s intake vs goal.
- **History** – Scroll to see each add in order; empty state shows when there are no entries yet.

---

## License

Open source. Part of **Latest-Ai-Coding-Tools**.

Built with Cursor (agentic AI). Inspired by the [freeCodeCamp Flutter + Antigravity tutorial](https://www.freecodecamp.org/news/build-an-ai-powered-flutter-app-with-google-antigravity/).
