import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:fl_digital_tachograph_v2/time/pictograms/tacho_icons.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/real_time_setter.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/tacho_utc_text.dart';
import 'package:flutter/material.dart';

typedef TopClockStateChanged = void Function(DateTime newTime, String newTimeZoneLabel);

class ChangeTime04Widget extends StatelessWidget {
  final DateTime externalTime;
  final String timeZoneLabel;
  final TopClockStateChanged onStateChanged;
  final bool useArrowAdjustIcons;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;
  final VoidCallback? onOkPressed;

  const ChangeTime04Widget({
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
              TachoTextUTC(
                text: language.tachoDisplay,
                rectX: 3,
                rectY: 3,
                color: Colors.white,
                slots: 16,
              ),
              SizedBox(height: 1),
              _DisplayVehicleRow16(rectX: 3, rectY: 3),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RealTimeSetter(
          useArrowAdjustIcons: useArrowAdjustIcons,
          blinkIncreaseButton: true,
          onIncreasePressed: onArrowUpPressed,
          onDecreasePressed: onArrowDownPressed,
          onOkPressed: onOkPressed,
          onTimeChanged: _ignore,
        ),
      ],
    );
  }

  static void _ignore(DateTime _, String __) {}
}

class _DisplayVehicleRow16 extends StatelessWidget {
  final double rectX;
  final double rectY;

  const _DisplayVehicleRow16({
    required this.rectX,
    required this.rectY,
  });

  @override
  Widget build(BuildContext context) {
    final language = LanguageManager.of(context);

    final symbols = language.fitSymbolsToSlots(<List<List<int>>>[
      TachoIcons.tacho_vehicle,
      TachoIcons.tacho_rectangle,
      TachoIcons.tacho_empty,
      ...language.tachoText(language.tachoVehicle),
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
    ], 16);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < symbols.length; i++) ...[
          _buildCell(symbols[i]),
          if (i < symbols.length - 1) const SizedBox(width: 1),
        ],
      ],
    );
  }

  Widget _buildCell(List<List<int>> symbol) {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.grey[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int row = 0; row < 7; row++)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int col = 0; col < 5; col++)
                  Container(
                    width: rectX,
                    height: rectY,
                    margin: const EdgeInsets.all(0.5),
                    color: (row < symbol.length &&
                            col < symbol[row].length &&
                            symbol[row][col] == 1)
                        ? Colors.white
                        : Colors.black,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

