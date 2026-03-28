# Documentation

This folder contains repository documentation assets used by the main `README.md`.

## Structure

- `../assets/` - App screenshots (PNG files) used by both Flutter assets and `README.md`
- `config/` - Safe example configurations for documentation

## Asset Files

### Screenshots
- **options_view.png** - Main menu screen with language selection and navigation buttons
- **utc_view.png** - UTC time display screen with timezone offset controls
- **change_time_view.png** - Time adjustment interface (first screen of multi-step flow)

## Key Components

### UTC Time Widget (`lib/widgets/utc_time_widget.dart`)

A comprehensive tachograph-style UTC time display featuring:

- **Real-time clock display** - Updates every second with blinking colon
- **Timezone offset controls** - Add/subtract hours with arrow buttons
- **Dynamic UTC label** - Shows "UTC", "UTC+X", or "UTC-X"
- **16-grid pixel display** - Standard tachograph layout with 5x7 character grids
- **Reset button** - Returns to device's local UTC offset

#### Grid Layout
**First Row (Time Display):**
- Positions 1-2: Hours (HH)
- Position 3: Colon separator (blinking)
- Positions 4-5: Minutes (MM)
- Position 6: Dot indicator
- Position 8: Driving indicator
- Positions 12-14: "0km"
- Position 15: Backslash and "h" (speed indicator)

**Second Row (UTC Label):**
- Position 1: Bed icon
- Positions 3-14: UTC offset text
- Position 16: Bed icon

### Tacho Clock Row (`lib/widgets/tacho_clock_row.dart`)

Displays time in tachograph format with:
- Pixel-grid character rendering
- Blinking colon every second
- Responsive grid sizing via `rectX` and `rectY` parameters

### Pictogram System

#### Icon Set (`lib/pictograms/tacho_icons.dart`)
```
Vehicles:    tacho_truck, tacho_vehicle, tacho_train
Status:      tacho_bed, tacho_driving, tacho_clock, tacho_time
Arrows:      tacho_arrow_down, tacho_arrow_right, tacho_arrow_down_right
Indicators:  tacho_dot, tacho_battery, tacho_hammers, tacho_start, tacho_end
Symbols:     tacho_plus, tacho_dollar, tacho_backslash, tacho_rectangle, tacho_info
Special:     tacho_empty (blank cell)
```

#### Character Set (`lib/pictograms/tacho_chars.dart`)
- Numerals: 0-9
- Letters: A-Z (case-insensitive)
- Special: Colon (:), plus (+), minus (-)
- All rendered as 5x7 pixel grids

### Multi-Language Support (`lib/language/language_manager.dart`)

Supports:
- **English** - Default language
- **Polski** - Polish language
- Easily extensible for additional languages

Each string label can be translated and accessed through the `LanguageManager` singleton.

## Navigation Flow

```
OptionsView (Entry point)
  ├── Language selection (ENG/PL)
  ├── → UTC Time View
  │   └── UTC_TimeWidget with offset controls
  └── → Change Time Flow
      └── Multi-step time adjustment sequence
```

## Development Notes

- All pixel grids are implemented as `List<List<int>>` where 1 = lit pixel, 0 = dark
- Grid dimensions can be customized per widget instance
- No external graphics library dependency - pure Flutter Canvas
- Dark theme with white pixel rendering for high contrast

## Notes

- Keep screenshot filenames stable so links in `README.md` do not break.
- Do not commit machine-specific secrets or absolute local paths in real config files.

