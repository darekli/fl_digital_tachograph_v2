import 'package:fl_digital_tachograph_v2/time/widgets/real_time_setter.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/tacho_clock_row.dart';
import 'package:flutter/material.dart';



// --- ASSUMED IMPORTS - Adjust paths as per your project structure ---
// You MUST have these widgets defined and correctly imported.
    // For RealTimeSetter

// If DigitalClock6Elm is in a separate file, import it.
// Example: import 'package:fl_ferry561_2025/digital_clock_6_elm.dart';
// For the purpose of this snippet, I'll assume DigitalClock6Elm.DigitalClock6Elm
// is a valid way to instantiate it (e.g., a static factory or named constructor).

// --- End of Assumed Imports ---

// Define a callback type for when time or timezone label changes via RealTimeSetter
typedef TopClockStateChanged = void Function(DateTime newTime, String newTimeZoneLabel);

class ChangeTime01Widget extends StatelessWidget {
  final DateTime externalTime; // The current time to display (e.g., _sharedUTC from parent)
  final String timeZoneLabel;  // The current timezone label (e.g., _sharedTimeZoneLabel from parent)
  final TopClockStateChanged onStateChanged; // Callback to notify parent of changes
  final bool useArrowAdjustIcons;
  final bool blinkArrowUp;
  final bool blinkOkButton;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;

  const ChangeTime01Widget({
    Key? key,
    required this.externalTime,
    required this.timeZoneLabel,
    required this.onStateChanged,
    this.useArrowAdjustIcons = false,
    this.blinkArrowUp = false,
    this.blinkOkButton = false,
    this.onArrowUpPressed,
    this.onArrowDownPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Takes up minimum vertical space
      children: [
        // Part 1: The clock display container
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24, width: 1),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[900]?.withValues(alpha: 0.3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // First row: 16 grids — HH:MM | dot | empty | driving | empty×3 | 0km\h
              TachoClockRow(
                externalTime: externalTime,
                rectX: 3,
                rectY: 3,
              ),
             const SizedBox(height: 1),
              // Second row: 16 grids — hammers | empty×2 | 243200.0km | empty×2 | bed
              TachoSecondRow(
                rectX: 3,
                rectY: 3,
              ),
            ],
          ),
        ),

        // Part 2: Spacing (optional, can be adjusted)
        const SizedBox(height: 12), // This was in your original snippet

        // Part 3: The RealTimeSetter
        /**
         * BUTTONS
         */
        RealTimeSetter(
          useArrowAdjustIcons: useArrowAdjustIcons,
          blinkIncreaseButton: blinkArrowUp,
          blinkOkButton: blinkOkButton,
          onIncreasePressed: onArrowUpPressed,
          onDecreasePressed: onArrowDownPressed,
          // The onTimeChanged callback of RealTimeSetter will now call
          // the onStateChanged callback passed to MainTopClockWidget.
          onTimeChanged: (DateTime newTimeFromSetter, String newLabelFromSetter) {
            // Forward the changes to the parent widget
            onStateChanged(newTimeFromSetter, newLabelFromSetter);
          },
          // If RealTimeSetter needs initial values to display its own state correctly:
          // initialUtcTime: externalTime,
          // initialTimeZoneLabel: timeZoneLabel, // Or initial offset if it works with offsets
        ),
      ],
    );
  }
}
