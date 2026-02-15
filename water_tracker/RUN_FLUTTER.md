# Run Water Tracker – correct Flutter path

Your Flutter SDK is in a **nested** folder. The real path is:

```
C:\Users\dhadu\Downloads\flutter_windows_3.41.1-stable\flutter\bin
```

(Notice the extra **\flutter** before **\bin**.)

## 1. Update your PATH

In **Environment Variables** → **Path**, make sure you have this (and remove the old one without `\flutter`):

```
C:\Users\dhadu\Downloads\flutter_windows_3.41.1-stable\flutter\bin
```

## 2. In a new terminal (after PATH is set)

```powershell
cd "d:\Ai coding Toola\water_tracker"
flutter create .
flutter pub get
flutter run -d chrome
```

## 3. Or run without changing PATH (current terminal only)

```powershell
cd "d:\Ai coding Toola\water_tracker"
& "C:\Users\dhadu\Downloads\flutter_windows_3.41.1-stable\flutter\bin\flutter.bat" create .
& "C:\Users\dhadu\Downloads\flutter_windows_3.41.1-stable\flutter\bin\flutter.bat" pub get
& "C:\Users\dhadu\Downloads\flutter_windows_3.41.1-stable\flutter\bin\flutter.bat" run -d chrome
```

Use **flutter.bat**, not flutter.exe.
