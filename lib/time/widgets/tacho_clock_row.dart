import 'dart:async';
import 'package:fl_digital_tachograph_v2/time/pictograms/tacho_chars.dart';
import 'package:fl_digital_tachograph_v2/time/pictograms/tacho_icons.dart';
import 'package:flutter/material.dart';

/// A 16-grid pixel-art clock row:
///  1-2  : HH
///  3    : ':' blinking
///  4-5  : MM
///  6    : tacho_dot
///  7    : empty
///  8    : tacho_driving_7x5
///  9-11 : empty
///  12   : '0'
///  13   : 'k'
///  14   : 'm'
///  15   : tacho_backslash
///  16   : 'h'
class TachoClockRow extends StatefulWidget {
  final DateTime externalTime;
  final double rectX;
  final double rectY;

  const TachoClockRow({
    super.key,
    required this.externalTime,
    this.rectX = 3,
    this.rectY = 3,
  });

  @override
  State<TachoClockRow> createState() => _TachoClockRowState();
}

class _TachoClockRowState extends State<TachoClockRow> {
  bool _showColon = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _showColon = !_showColon);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.externalTime.hour.toString().padLeft(2, '0');
    final m = widget.externalTime.minute.toString().padLeft(2, '0');

    final symbols = <List<List<int>>>[
      TachoChars.tachoChars(h[0]) ?? TachoIcons.tacho_empty, // 1  H tens
      TachoChars.tachoChars(h[1]) ?? TachoIcons.tacho_empty, // 2  H units
      _showColon                                              // 3  : blinking
          ? (TachoChars.tachoChars(':') ?? TachoIcons.tacho_empty)
          : TachoIcons.tacho_empty,
      TachoChars.tachoChars(m[0]) ?? TachoIcons.tacho_empty, // 4  M tens
      TachoChars.tachoChars(m[1]) ?? TachoIcons.tacho_empty, // 5  M units
      TachoIcons.tacho_dot,                                   // 6
      TachoIcons.tacho_empty,                                 // 7
      TachoIcons.tacho_driving_7x5,                           // 8
      TachoIcons.tacho_empty,                                 // 9
      TachoIcons.tacho_empty,                                 // 10
      TachoIcons.tacho_empty,                                 // 11
      TachoChars.tachoChars('0') ?? TachoIcons.tacho_empty,  // 12
      TachoChars.tachoChars('k') ?? TachoIcons.tacho_empty,  // 13
      TachoChars.tachoChars('m') ?? TachoIcons.tacho_empty,  // 14
      TachoIcons.tacho_backslash,                             // 15
      TachoChars.tachoChars('h') ?? TachoIcons.tacho_empty,  // 16
    ];

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
                    width: widget.rectX,
                    height: widget.rectY,
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

/// A static 16-grid second row:
///  1    : tacho_hammers
///  2-3  : empty
///  4-13 : chars '2','4','3','2','0','0','.','0','k','m'
///  14-15: empty
///  16   : tacho_bed
class TachoSecondRow extends StatelessWidget {
  final double rectX;
  final double rectY;

  const TachoSecondRow({
    super.key,
    this.rectX = 3,
    this.rectY = 3,
  });

  @override
  Widget build(BuildContext context) {
    final symbols = <List<List<int>>>[
      TachoIcons.tacho_hammers,                                // 1
      TachoIcons.tacho_empty,                                  // 2
      TachoIcons.tacho_empty,                                  // 3
      TachoChars.tachoChars('2') ?? TachoIcons.tacho_empty,   // 4
      TachoChars.tachoChars('4') ?? TachoIcons.tacho_empty,   // 5
      TachoChars.tachoChars('3') ?? TachoIcons.tacho_empty,   // 6
      TachoChars.tachoChars('2') ?? TachoIcons.tacho_empty,   // 7
      TachoChars.tachoChars('0') ?? TachoIcons.tacho_empty,   // 8
      TachoChars.tachoChars('0') ?? TachoIcons.tacho_empty,   // 9
      TachoChars.tachoChars('.') ?? TachoIcons.tacho_empty,   // 10
      TachoChars.tachoChars('0') ?? TachoIcons.tacho_empty,   // 11
      TachoChars.tachoChars('k') ?? TachoIcons.tacho_empty,   // 12
      TachoChars.tachoChars('m') ?? TachoIcons.tacho_empty,   // 13
      TachoIcons.tacho_empty,                                  // 14
      TachoIcons.tacho_empty,                                  // 15
      TachoIcons.tacho_bed,                                    // 16
    ];

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
