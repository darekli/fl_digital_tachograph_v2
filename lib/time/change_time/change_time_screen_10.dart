import 'dart:async';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:flutter/material.dart';

import '../../pictograms/tacho_chars.dart';
import '../../pictograms/tacho_icons.dart';
import '../../widgets/real_time_setter.dart';

typedef TopClockStateChanged = void Function(DateTime newTime, String newTimeZoneLabel);

class ChangeTime10Widget extends StatefulWidget {
  final DateTime externalTime;
  final String timeZoneLabel;
  final TopClockStateChanged onStateChanged;
  final bool useArrowAdjustIcons;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;
  final VoidCallback? onOkPressed;

  const ChangeTime10Widget({
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
  State<ChangeTime10Widget> createState() => _ChangeTime10WidgetState();
}

class _ChangeTime10WidgetState extends State<ChangeTime10Widget> {
  late Timer _timer;
  late Timer _blinkTimer;
  DateTime _now = DateTime.now();
  int _rightTimeOffsetMinutes = 0;
  bool _showBlinkingRight = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _showBlinkingRight = !_showBlinkingRight;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
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
              _GridRow16(symbols: _buildTopRow(), rectX: 3, rectY: 3),
              const SizedBox(height: 1),
              _GridRow16(symbols: _buildBottomRow(), rectX: 3, rectY: 3),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RealTimeSetter(
          useArrowAdjustIcons: widget.useArrowAdjustIcons,
          blinkIncreaseButton: true,
          blinkDecreaseButton: true,
          blinkOkButton: true,
          onIncreasePressed: _addThirtyMinutesOnRight,
          onDecreasePressed: _subtractThirtyMinutesOnRight,
          onOkPressed: widget.onOkPressed,
          onTimeChanged: _ignore,
        ),
      ],
    );
  }

  List<List<List<int>>> _buildTopRow() {
    final language = LanguageManager.of(context);
    final date = _formatDate(_now);
    return <List<List<int>>>[
      ...language.tachoText(language.utc),
      TachoIcons.tacho_clock,
      TachoIcons.tacho_empty,
      ...date.split('').map((c) => TachoChars.tachoChars(c) ?? TachoIcons.tacho_empty),
      TachoIcons.tacho_empty,
    ];
  }

  List<List<List<int>>> _buildBottomRow() {
    final leftTime = _formatTime(_now);
    final rightTime = _formatTime(
      _now.add(Duration(minutes: _rightTimeOffsetMinutes)),
    );
    
    final rightTimeSymbols = _showBlinkingRight
        ? rightTime
            .split('')
            .map((c) => TachoChars.tachoChars(c) ?? TachoIcons.tacho_empty)
            .toList()
        : List.filled(5, TachoIcons.tacho_empty);
    
    final rightDotSymbol = _showBlinkingRight
        ? TachoIcons.tacho_dot
        : TachoIcons.tacho_empty;

    return <List<List<int>>>[
      ...leftTime
          .split('')
          .map((c) => TachoChars.tachoChars(c) ?? TachoIcons.tacho_empty),
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      TachoIcons.tacho_empty,
      ...rightTimeSymbols,
      rightDotSymbol,
    ];
  }

  void _addThirtyMinutesOnRight() {
    setState(() {
      _rightTimeOffsetMinutes += 30;
    });
    _notifyAdjustedRightTime();
  }

  void _subtractThirtyMinutesOnRight() {
    setState(() {
      _rightTimeOffsetMinutes -= 30;
    });
    _notifyAdjustedRightTime();
  }

  void _notifyAdjustedRightTime() {
    final adjustedRightTime = _now.add(Duration(minutes: _rightTimeOffsetMinutes));
    widget.onStateChanged(adjustedRightTime, widget.timeZoneLabel);
  }

  String _formatDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year.toString();
    return '$day.$month.$year';
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static void _ignore(DateTime _, String __) {}
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

