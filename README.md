# FL Digital Tachograph v2

Flutter app that simulates digital tachograph style screens, including UTC view, change-time flow, and language switching (English/Polski).

## Preview

<p align="center">
  <a href="assets/options_view.png">
	<img src="assets/options_view.png" alt="Options view" width="30%" />
  </a>
  <a href="assets/utc_view.png">
	<img src="assets/utc_view.png" alt="UTC view" width="30%" />
  </a>
  <a href="assets/change_time_view.png">
	<img src="assets/change_time_view.png" alt="Change Time view" width="30%" />
  </a>
</p>

<p align="center">
  <strong>Options View</strong> &nbsp;•&nbsp; <strong>UTC View</strong> &nbsp;•&nbsp; <strong>Change Time View</strong>
</p>

Click any screenshot to open the full-size image.

`docs/config/gradle.properties.example` contains a docs-safe Gradle template matching your local setup pattern.

## Features

- **Pixel-grid tachograph inspired UI widgets** - 16-grid display system with 5x7 pixel characters
- **Dedicated UTC Screen** - Real-time UTC time display with hourly offset adjustment
  - Live clock display with blinking colon separator
  - Add/subtract hours with arrow buttons
  - Reset to local UTC offset
  - Dynamic UTC label (UTC, UTC+X, UTC-X)
- **Multi-step Change Time Screen Flow** - Interactive time adjustment interface
- **Language Support** - Switch between `English` and `Polski` (Polish)
- **Navigation** - Starts from `OptionsView` with intuitive menu structure
- **Responsive Grid System** - Customizable pixel dimensions (rectX, rectY)

## Project Structure

### Main Files
- `lib/main.dart` - App entry point, routing configuration, and language scope
- `lib/options_view.dart` - Main menu with language selection and navigation buttons
- `lib/language/language_manager.dart` - Text labels and multi-language support (English/Polish)

### Screens & Views
- `lib/time/just_utc/utc_view.dart` - UTC time display screen with navigation
- `lib/time/change_time/` - Multi-step time adjustment interface with various menu screens

### Core Widgets
- `lib/widgets/utc_time_widget.dart` - UTC clock display with offset controls
- `lib/widgets/tacho_clock_row.dart` - 16-grid time display with HH:MM format
- `lib/widgets/main_top_clock.dart` - Main clock widget with timezone support
- `lib/widgets/tacho_utc_text.dart` - Utility widget for UTC label rendering

### Pictograms & Icons
- `lib/pictograms/tacho_icons.dart` - 5x7 pixel grid icons (truck, bed, clock, arrows, etc.)
- `lib/pictograms/tacho_chars.dart` - 5x7 pixel grid characters (0-9, letters)
- `lib/pictograms/tacho_digits.dart` - Special digit representations

### Assets
- `assets/` - Screenshots and image assets for Flutter configuration
- `docs/config/` - Non-sensitive configuration examples (Gradle properties template)

## UTC Time Widget

The `UTC_TimeWidget` is a comprehensive UTC time display component featuring:

### Components
1. **TachoClockRow** - Displays time in format: `HH : MM 0km/h`
   - Blinking colon separator (updates every second)
   - Tacho-style pixel-grid display

2. **_UtcSecondRow** - Shows UTC offset information
   - Grid layout: bed | empty | empty | UTC label text | ... | bed
   - Dynamically renders "UTC", "UTC+X", or "UTC-X"

3. **Control Buttons**
   - Reset (↻) - Returns to local UTC offset
   - Arrow Up (↑) - Adds 1 hour to offset
   - Arrow Down (↓) - Subtracts 1 hour from offset
   - OK - Confirms selection (currently inactive)

### Usage
```dart
const UTC_TimeWidget()
```

Automatically initializes with the device's local timezone offset and updates in real-time.

## Pictogram System

The app uses a custom pixel-grid system for rendering tachograph-style UI:

### Grid Format
- **5x7 pixel grids** - Each character/icon is rendered as a 5-column by 7-row grid
- **16-grid rows** - Display rows contain 16 grid cells for layout flexibility
- **Customizable size** - `rectX` and `rectY` parameters control pixel dimensions

### Available Icons
- **Vehicles**: `tacho_truck`, `tacho_vehicle`, `tacho_train`
- **Status**: `tacho_bed`, `tacho_driving`, `tacho_clock`, `tacho_time`
- **Arrows**: `tacho_arrow_down`, `tacho_arrow_right`, `tacho_arrow_down_right`
- **Indicators**: `tacho_dot`, `tacho_battery`, `tacho_hammers`, `tacho_start`, `tacho_end`
- **Symbols**: `tacho_plus`, `tacho_dollar`, `tacho_backslash`, `tacho_rectangle`, `tacho_info`
- **Empty**: `tacho_empty` (blank grid cell)

### Character Support
All alphanumeric characters (0-9, A-Z) are supported through `TachoChars.tachoChars(char)` for dynamic text rendering.

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

This project is licensed under the MIT License.

You are free to use, copy, modify, and share the whole project or separate parts of it, as long as the MIT license notice is kept with substantial portions of the code.

See [`LICENSE`](LICENSE) for details.
