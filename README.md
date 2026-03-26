# FL Digital Tachograph v2

Flutter app that simulates digital tachograph style screens, including UTC view, change-time flow, and language switching (English/Polski).

## Preview

![Options view](docs/assets/screenshots/options_view.png)
![UTC view](docs/assets/screenshots/utc_view.png)
![Change Time view](docs/assets/screenshots/change_time_view.png)

`docs/config/gradle.properties.example` contains a docs-safe Gradle template matching your local setup pattern.

## Features

- Pixel-grid tachograph inspired UI widgets
- Dedicated `UTC` screen
- Multi-step `Change Time` screen flow
- Language switch: `English` / `Polski`
- Navigation starts from `OptionsView`

## Project Structure

- `lib/main.dart` - app entry point, routes, language scope
- `lib/options_view.dart` - start screen with language + navigation buttons
- `lib/time/just_utc/utc_view.dart` - UTC screen
- `lib/time/change_time/` - change-time screens and flow
- `lib/language/language_manager.dart` - labels and language handling
- `lib/widgets/` and `lib/pictograms/` - reusable UI and icon/char grids
- `docs/assets/screenshots/` - GitHub README screenshots
- `docs/config/` - non-sensitive config examples

## Run Locally

```bash
flutter pub get
flutter run
```

## Verify

```bash
flutter analyze
flutter test
```

## Requirements

- Flutter SDK (stable)
- Dart SDK (comes with Flutter)
- Android Studio / Xcode depending on target platform

## License

Private/internal project unless you add a separate `LICENSE` file.
