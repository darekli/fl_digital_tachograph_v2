import 'dart:async';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:fl_digital_tachograph_v2/pictograms/tacho_icons.dart';
import 'package:fl_digital_tachograph_v2/widgets/real_time_setter.dart';
import 'package:fl_digital_tachograph_v2/widgets/tacho_utc_text.dart';
import 'package:flutter/material.dart';


typedef TopClockStateChanged = void Function(DateTime newTime, String newTimeZoneLabel);

class ChangeTime05Widget extends StatefulWidget {
  final DateTime externalTime;
  final String timeZoneLabel;
  final TopClockStateChanged onStateChanged;
  final bool useArrowAdjustIcons;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;
  final VoidCallback? onOkPressed;

  const ChangeTime05Widget({
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
  State<ChangeTime05Widget> createState() => _ChangeTime05WidgetState();
}

class _ChangeTime05WidgetState extends State<ChangeTime05Widget> {
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
                text: language.tachoEntry,
                rectX: 3,
                rectY: 3,
                color: Colors.white,
                slots: 16,
              ),
              SizedBox(height: 1),
              _showBottomRow
                  ? _EntryRow16(rectX: 3, rectY: 3)
                  : _buildBlankRow(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RealTimeSetter(
          useArrowAdjustIcons: widget.useArrowAdjustIcons,
          blinkOkButton: true,
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

class _EntryRow16 extends StatelessWidget {
  final double rectX;
  final double rectY;

  const _EntryRow16({
    required this.rectX,
    required this.rectY,
  });

  @override
  Widget build(BuildContext context) {
    final language = LanguageManager.of(context);

    final symbols = language.fitSymbolsToSlots(<List<List<int>>>[
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

