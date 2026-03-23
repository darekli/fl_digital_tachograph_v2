import 'package:fl_digital_tachograph_v2/time/pictograms/tacho_chars.dart';
import 'package:fl_digital_tachograph_v2/time/pictograms/tacho_icons.dart';
import 'package:fl_digital_tachograph_v2/time/real_time_setter.dart';
import 'package:flutter/material.dart';

typedef TopClockStateChanged = void Function(DateTime newTime, String newTimeZoneLabel);

class ChangeTime07Widget extends StatelessWidget {
  final DateTime externalTime;
  final String timeZoneLabel;
  final TopClockStateChanged onStateChanged;
  final bool useArrowAdjustIcons;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;
  final VoidCallback? onOkPressed;

  const ChangeTime07Widget({
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
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _VehicleRow16(rectX: 3, rectY: 3),
              SizedBox(height: 1),
              _LicenceCodeRow16(rectX: 3, rectY: 3),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RealTimeSetter(
          useArrowAdjustIcons: useArrowAdjustIcons,
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

class _VehicleRow16 extends StatelessWidget {
  final double rectX;
  final double rectY;

  const _VehicleRow16({
    required this.rectX,
    required this.rectY,
  });

  @override
  Widget build(BuildContext context) {
    final symbols = <List<List<int>>>[
      TachoIcons.tacho_vehicle,
      TachoIcons.tacho_arrow_down_right,
      TachoIcons.tacho_empty,
      TachoChars.tachoChars('v') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('e') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('h') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('i') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('c') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('l') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('e') ?? TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
    ];

    return _GridRow16(symbols: symbols, rectX: rectX, rectY: rectY);
  }
}

class _LicenceCodeRow16 extends StatelessWidget {
  final double rectX;
  final double rectY;

  const _LicenceCodeRow16({
    required this.rectX,
    required this.rectY,
  });

  @override
  Widget build(BuildContext context) {
    final symbols = <List<List<int>>>[
      TachoIcons.tacho_dollar,
      TachoIcons.tacho_empty,
      TachoChars.tachoChars('l') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('i') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('c') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('e') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('n') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('c') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('e') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars(' ') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('c') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('o') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('d') ?? TachoIcons.tacho_empty,
      TachoChars.tachoChars('e') ?? TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
    ];

    return _GridRow16(symbols: symbols, rectX: rectX, rectY: rectY);
  }
}

class _GridRow16 extends StatelessWidget {
  final List<List<List<int>>> symbols;
  final double rectX;
  final double rectY;

  const _GridRow16({
    required this.symbols,
    required this.rectX,
    required this.rectY,
  });

  @override
  Widget build(BuildContext context) {
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

