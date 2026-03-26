import 'dart:async';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:flutter/material.dart';

import '../../pictograms/tacho_icons.dart';
import '../../widgets/real_time_setter.dart';

typedef TopClockStateChanged = void Function(DateTime newTime, String newTimeZoneLabel);

class ChangeTime06Widget extends StatefulWidget {
  final DateTime externalTime;
  final String timeZoneLabel;
  final TopClockStateChanged onStateChanged;
  final bool useArrowAdjustIcons;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;
  final VoidCallback? onOkPressed;

  const ChangeTime06Widget({
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
  State<ChangeTime06Widget> createState() => _ChangeTime06WidgetState();
}

class _ChangeTime06WidgetState extends State<ChangeTime06Widget> {
  late Timer _blinkTimer;
  bool _showBottomRow = true;

  @override
  void initState() {
    super.initState();
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _showBottomRow = !_showBottomRow;
      });
    });
  }

  @override
  void dispose() {
    _blinkTimer.cancel();
    super.dispose();
  }

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _VehicleEntryRow16(rectX: 3, rectY: 3),
              SizedBox(height: 1),
              _showBottomRow
                  ? _OutBeginRow16(rectX: 3, rectY: 3)
                  : _buildBlankRow(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RealTimeSetter(
          useArrowAdjustIcons: widget.useArrowAdjustIcons,
          blinkIncreaseButton: true,
          onIncreasePressed: widget.onArrowUpPressed,
          onDecreasePressed: widget.onArrowDownPressed,
          onOkPressed: widget.onOkPressed,
          onTimeChanged: _ignore,
        ),
      ],
    );
  }

  Widget _buildBlankRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(16, (i) => [
        Container(
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
                        width: 3,
                        height: 3,
                        margin: const EdgeInsets.all(0.5),
                        color: Colors.black,
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (i < 15) const SizedBox(width: 1),
      ]).expand((x) => x).toList(),
    );
  }

  static void _ignore(DateTime _, String __) {}
}

class _VehicleEntryRow16 extends StatelessWidget {
  final double rectX;
  final double rectY;

  const _VehicleEntryRow16({
    required this.rectX,
    required this.rectY,
  });

  @override
  Widget build(BuildContext context) {
    final language = LanguageManager.of(context);

    final symbols = <List<List<int>>>[
      TachoIcons.tacho_vehicle,
      TachoIcons.tacho_arrow_down_right,
      TachoIcons.tacho_empty,
      ...language.tachoText(language.tachoVehicle),
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

class _OutBeginRow16 extends StatelessWidget {
  final double rectX;
  final double rectY;

  const _OutBeginRow16({
    required this.rectX,
    required this.rectY,
  });

  @override
  Widget build(BuildContext context) {
    final language = LanguageManager.of(context);

    final symbols = <List<List<int>>>[
      ...language.tachoText(language.tachoOut),
      TachoIcons.tacho_arrow_right,
      TachoIcons.tacho_empty,
      ...language.tachoText(language.tachoBegin),
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
    final normalizedSymbols = LanguageManager().fitSymbolsToSlots(symbols, 16);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < normalizedSymbols.length; i++) ...[
          _buildCell(normalizedSymbols[i]),
          if (i < normalizedSymbols.length - 1) const SizedBox(width: 1),
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

