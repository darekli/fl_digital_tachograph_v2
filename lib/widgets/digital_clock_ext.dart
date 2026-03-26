import 'dart:async';
import 'package:flutter/material.dart';

import '../pictograms/tacho_chars.dart';
import '../pictograms/tacho_digits.dart';
import '../pictograms/tacho_icons.dart';

class DigitalClockExt extends StatefulWidget {
  final DateTime? externalTime;
  final String? externalTimeZoneLabel;
  final double rectX; // width of each LED pixel
  final double rectY; // height of each LED pixel

  const DigitalClockExt({
    super.key,
    this.externalTime,
    this.externalTimeZoneLabel,
    this.rectX = 3,
    this.rectY = 3,
  });

  @override
  State<DigitalClockExt> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClockExt> {
  late Timer _timer;
  DateTime _now = DateTime.now();
  bool _showColon = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = widget.externalTime ?? DateTime.now();
        _showColon = !_showColon;
      });
    });
  }

  @override
  void didUpdateWidget(covariant DigitalClockExt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.externalTime != null) {
      setState(() {
        _now = widget.externalTime!;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hour = _now.hour.toString().padLeft(2, '0');
    final minute = _now.minute.toString().padLeft(2, '0');
    final weekdayStr = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"][_now.weekday-1];

    final symbols = [
      ...weekdayStr.split('').map((c) => TachoChars.tachoChars(c) ?? TachoIcons.tacho_empty),
      TachoChars.tachoChars(" ")!,
      TachoDigits.digits[hour[0]]!,
      TachoDigits.digits[hour[1]]!,
      TachoChars.tachoChars(":")!,
      TachoDigits.digits[minute[0]]!,
      TachoDigits.digits[minute[1]]!,
    ];

    if (widget.externalTimeZoneLabel != null) {
      symbols.add(TachoChars.tachoChars(" ")!);
      symbols.addAll(widget.externalTimeZoneLabel!
          .split('')
          .map((c) => TachoChars.tachoChars(c) ?? TachoIcons.tacho_empty));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int s = 0; s < symbols.length; s++) ...[
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
                          color: (symbols[s][row][col] == 1)
                              ? (s == 6 ? (_showColon ? Colors.white : Colors.black) : Colors.white)
                              : Colors.black,
                        ),
                    ],
                  ),
              ],
            ),
          ),
          if (s < symbols.length - 1) const SizedBox(width: 1),
        ]
      ],
    );
  }
}
