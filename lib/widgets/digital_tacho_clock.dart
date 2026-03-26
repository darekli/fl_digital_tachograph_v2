import 'dart:async';
import 'package:fl_digital_tachograph_v2/pictograms/tacho_digits.dart';
import 'package:flutter/material.dart';

class DigitalClock6Elm extends StatefulWidget {
  final List<List<List<int>>> elements; // custom symbols
  final double rectX;
  final double rectY;

  const DigitalClock6Elm.DigitalClock6Elm({
    super.key,
    required this.elements,
    this.rectX = 3,
    this.rectY = 3,
  });

  @override
  State<DigitalClock6Elm> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock6Elm> {
  late Timer _timer;
  bool _showH = true; // blinking toggle

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _showH = !_showH;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget buildClockRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int s = 0; s < widget.elements.length; s++) ...[
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
                          width: widget.rectX,
                          height: widget.rectY,
                          margin: const EdgeInsets.all(0.5),
                          color: _getSymbolPixelColor(widget.elements[s], row, col, s),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          if (s < widget.elements.length - 1)
            const SizedBox(width: 1), // gap
        ],
      ],
    );
  }

  Color _getSymbolPixelColor(
      List<List<int>> grid, int row, int col, int symbolIndex) {
    if (grid[row][col] == 1) {
      // blink only if element is exactly TachoDigits.h
      if (widget.elements[symbolIndex] == TachoDigits.h) {
        return _showH ? Colors.black : Colors.white;
      }
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildClockRow();
  }
}
