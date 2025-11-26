# pry_clean_arquitecture

A simple Flutter app to calculate employee bonuses, store calculation history, and export/share history as PDF.

## Key features
- Enter employee data (name, salary, years) and compute bonus + final salary.
- In-memory history of all calculations.
- View history list and open individual results.
- Export history to PDF and share it.
- Routes: `/` (Home), `/result`, `/history`.

## Architecture
Project follows a lightweight clean architecture:
- domain: entities and use cases
- presentation: views, viewmodels, routes, themes
- viewmodels contain state and small services (history, PDF)

## Requirements
- Flutter SDK (stable)
- Android/iOS device or emulator

## Important dependencies
Add and keep updated in `pubspec.yaml`:
- provider
- pdf
- printing
- path_provider
- (optional) file_picker — allows user to pick an export folder (may cause platform plugin issues on some setups)

Example (partial):
```
provider: ^6.0.0
pdf: ^3.10.0
printing: ^5.9.0
path_provider: ^2.0.0
# file_picker: ^5.2.0  # optional — platform support varies
```

## Setup & run
1. From project root:
   ```
   flutter pub get
   flutter run
   ```

2. If you add native permissions (Android):
   - For legacy Android write access (API <= 28) add in `android/app/src/main/AndroidManifest.xml`:
     ```xml
     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28" />
     ```
   - For Android 29+ use scoped storage / SAF (the file_picker plugin manages this on supported devices).

## Troubleshooting
- If build fails complaining about `file_picker` and Android embedding (errors referencing `Registrar`), try:
  1. Upgrade packages and Flutter:
     ```
     flutter pub upgrade
     flutter clean
     flutter pub get
     flutter upgrade
     ```
  2. If issue persists, remove `file_picker` from `pubspec.yaml` and use the app's fallback (save to Downloads/Documents) or use `file_selector` instead.
  3. Clear pub cache for a package if necessary:
     ```
     rm -rf ~/.pub-cache/hosted/pub.dev/file_picker-*
     flutter pub get
     ```

## Notes about PDF export
- PDFs are generated using the `pdf` package and shared with `printing`.
- Default save location attempts:
  - Android: Downloads (or app documents directory as fallback)
  - iOS: App Documents
  - Desktop: system Downloads if available
- If you enable `file_picker` the user can select a folder (Android/Desktop). On platforms without folder picking support the app will fallback.

## Project structure (high level)
- lib/
  - domain/        -> entities, usecases
  - presentation/
    - views/        -> home_page.dart, result_page.dart, history_page.dart
    - viewmodels/   -> employee_viewmodel.dart, history_pdf_service.dart, history_repository.dart
    - routes/       -> app_routes.dart
    - themes/       -> general themes

