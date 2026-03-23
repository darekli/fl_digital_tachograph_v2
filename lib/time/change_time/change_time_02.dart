import 'package:fl_digital_tachograph_v2/time/widgets/real_time_setter.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/tacho_utc_text.dart';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:flutter/material.dart';

typedef TopClockStateChanged = void Function(DateTime newTime, String newTimeZoneLabel);

class ChangeTime02Widget extends StatelessWidget {
  final DateTime externalTime;
  final String timeZoneLabel;
  final TopClockStateChanged onStateChanged;
  final bool useArrowAdjustIcons;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;
  final VoidCallback? onOkPressed;

  const ChangeTime02Widget({
    super.key,
    required this.externalTime,
    required this.timeZoneLabel,
    required this.onStateChanged,
    this.useArrowAdjustIcons = false,
    this.onArrowUpPressed,
    this.onArrowDownPressed,
    this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    final language = LanguageManager.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
              // First row: "call main menu?" then empty grids up to 16 slots.
              TachoTextUTC(
                text: language.tachoCallMainMenu,
                rectX: 3,
                rectY: 3,
                color: Colors.white,
                slots: 16,
              ),
              SizedBox(height: 1),
              // Second row: keep all 16 grids empty.
              TachoTextUTC(
                text: '',
                rectX: 3,
                rectY: 3,
                color: Colors.white,
                slots: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RealTimeSetter(
          useArrowAdjustIcons: useArrowAdjustIcons,
          blinkOkButton: true,
          onIncreasePressed: onArrowUpPressed,
          onDecreasePressed: onArrowDownPressed,
          onOkPressed: onOkPressed,
          onTimeChanged: (DateTime newTimeFromSetter, String newLabelFromSetter) {
            onStateChanged(newTimeFromSetter, newLabelFromSetter);
          },
        ),
      ],
    );
  }
}

