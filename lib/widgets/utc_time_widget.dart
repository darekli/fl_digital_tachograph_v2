import 'dart:async';

import 'package:flutter/material.dart';

import 'tacho_clock_row.dart';
import '../pictograms/tacho_chars.dart';
import '../pictograms/tacho_icons.dart';

class UTC_TimeWidget extends StatefulWidget {
  const UTC_TimeWidget({super.key});

  @override
  State<UTC_TimeWidget> createState() => _UTC_TimeWidgetState();
}

class _UTC_TimeWidgetState extends State<UTC_TimeWidget> {
  late DateTime _displayedUtc;
  int _hourOffset = 0;
  Timer? _timer;

  int _localOffsetHoursNow() => DateTime.now().timeZoneOffset.inHours;

  DateTime _buildDisplayedTime() {
    return DateTime.now().toUtc().add(Duration(hours: _hourOffset));
  }

  @override
  void initState() {
    super.initState();
    _hourOffset = _localOffsetHoursNow();
    _displayedUtc = _buildDisplayedTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _displayedUtc = _buildDisplayedTime();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _adjustHours(int hours) {
    setState(() {
      _hourOffset += hours;
      _displayedUtc = _buildDisplayedTime();
    });
  }

  void _resetToLocalOffset() {
    setState(() {
      _hourOffset = _localOffsetHoursNow();
      _displayedUtc = _buildDisplayedTime();
    });
  }

  String _utcLabel() {
    if (_hourOffset == 0) {
      return 'UTC';
    }
    return _hourOffset > 0 ? 'UTC+$_hourOffset' : 'UTC$_hourOffset';
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
              TachoClockRow(
                externalTime: _displayedUtc,
                rectX: 3,
                rectY: 3,
              ),
              const SizedBox(height: 1),
              _UtcSecondRow(
                text: _utcLabel(),
                rectX: 3,
                rectY: 3,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay, size: 32),
              onPressed: _resetToLocalOffset,
              tooltip: 'Reset to local UTC',
              color: Colors.white,
              disabledColor: Colors.white,
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.arrow_circle_up_outlined, size: 32),
              onPressed: () => _adjustHours(1),
              tooltip: 'Add one hour',
              color: Colors.white,
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.arrow_circle_down_outlined, size: 32),
              onPressed: () => _adjustHours(-1),
              tooltip: 'Subtract one hour',
              color: Colors.white,
            ),
            const SizedBox(width: 48),
            OutlinedButton(
              onPressed: null,
              style: ButtonStyle(
                side: WidgetStateProperty.resolveWith(
                  (_) => const BorderSide(color: Colors.white, width: 2.5),
                ),
                foregroundColor: WidgetStateProperty.resolveWith(
                  (_) => Colors.white,
                ),
                overlayColor: WidgetStateProperty.resolveWith(
                  (_) => Colors.transparent,
                ),
                padding: WidgetStateProperty.resolveWith(
                  (_) => const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UtcSecondRow extends StatelessWidget {
  final String text;
  final double rectX;
  final double rectY;

  const _UtcSecondRow({
    required this.text,
    required this.rectX,
    required this.rectY,
  });

  List<List<List<int>>> _buildSymbols() {
    final symbols = List<List<List<int>>>.filled(16, TachoIcons.tacho_empty);

    // Grid 0 -> bed, grid 1 -> empty, grid 2 -> empty, grid 3.. -> UTC text, grid 15 -> bed.
    symbols[0] = TachoIcons.tacho_bed;
    symbols[1] = TachoIcons.tacho_card;
    symbols[2] = TachoIcons.tacho_empty;
    symbols[15] = TachoIcons.tacho_bed;

    var insertAt = 3;
    for (final char in text.characters) {
      if (insertAt >= 15) {
        break;
      }
      final glyph = TachoChars.tachoChars(char) ??
          TachoChars.tachoChars(char.toLowerCase());
      symbols[insertAt] = glyph ?? TachoIcons.tacho_empty;
      insertAt += 1;
    }

    return symbols;
  }

  @override
  Widget build(BuildContext context) {
    final symbols = _buildSymbols();

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

