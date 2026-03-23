import 'package:fl_digital_tachograph_v2/time/change_time/change_time_01.dart';
import 'package:flutter/material.dart';

class ChangeTime12Widget extends StatelessWidget {
  final DateTime externalTime;
  final String timeZoneLabel;
  final TopClockStateChanged onStateChanged;
  final bool useArrowAdjustIcons;
  final VoidCallback? onArrowUpPressed;
  final VoidCallback? onArrowDownPressed;

  const ChangeTime12Widget({
    super.key,
    required this.externalTime,
    required this.timeZoneLabel,
    required this.onStateChanged,
    this.useArrowAdjustIcons = false,
    this.onArrowUpPressed,
    this.onArrowDownPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeTime01Widget(
      externalTime: externalTime,
      timeZoneLabel: timeZoneLabel,
      onStateChanged: onStateChanged,
      useArrowAdjustIcons: useArrowAdjustIcons,
      blinkOkButton: false,
      onArrowUpPressed: onArrowUpPressed,
      onArrowDownPressed: onArrowDownPressed,
    );
  }
}

