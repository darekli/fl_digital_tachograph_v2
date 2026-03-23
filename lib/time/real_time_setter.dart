import 'dart:async';
import 'package:flutter/material.dart';

class RealTimeSetter extends StatefulWidget {
  final void Function(DateTime time, String timeZoneLabel) onTimeChanged;
  final bool useArrowAdjustIcons;

  const RealTimeSetter({
    super.key,
    required this.onTimeChanged,
    this.useArrowAdjustIcons = false,
  });

  @override
  State<RealTimeSetter> createState() => _RealTimeSetterState();
}

class _RealTimeSetterState extends State<RealTimeSetter> {
  int _hourOffset = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final displayedTime = _getCurrentDisplayedTime();
      final label = _buildTimeZoneLabel();
      widget.onTimeChanged(displayedTime, label);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  DateTime _getCurrentDisplayedTime() {
    return DateTime.now().add(Duration(hours: _hourOffset));
  }

  String _buildTimeZoneLabel() {
    final totalMinutes = DateTime.now().timeZoneOffset.inMinutes + (_hourOffset * 60);

    if (totalMinutes == 0) {
      return 'UTC';
    }

    final sign = totalMinutes >= 0 ? '+' : '-';
    final absoluteMinutes = totalMinutes.abs();
    final hours = absoluteMinutes ~/ 60;
    final minutes = absoluteMinutes % 60;

    if (minutes == 0) {
      return 'UTC$sign$hours';
    }

    return 'UTC$sign$hours:${minutes.toString().padLeft(2, '0')}';
  }

  void _adjustTime(int hours) {
    setState(() => _hourOffset += hours);
    widget.onTimeChanged(_getCurrentDisplayedTime(), _buildTimeZoneLabel());
  }

  void _resetTime() {
    setState(() => _hourOffset = 0);
    widget.onTimeChanged(_getCurrentDisplayedTime(), _buildTimeZoneLabel());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay, size: 32),
          onPressed: _resetTime,
          tooltip: 'Reset to current timezone',
          color: Colors.white,
        ),
        const SizedBox(width: 32),
        IconButton(
          icon: Icon(
            widget.useArrowAdjustIcons
                ? Icons.arrow_circle_down_outlined
                : Icons.remove_circle_outline,
            size: 32,
          ),
          onPressed: () => _adjustTime(-1),
          tooltip: 'Subtract one hour',
          color: Colors.white,
        ),
        const SizedBox(width: 32), // more space between icons
        IconButton(
          icon: Icon(
            widget.useArrowAdjustIcons
                ? Icons.arrow_circle_up_outlined
                : Icons.add_circle_outline,
            size: 32,
          ),
          onPressed: () => _adjustTime(1),
          tooltip: 'Add one hour',
          color: Colors.white,
        ),
        const SizedBox(width: 32),
        OutlinedButton(
          onPressed: () => _adjustTime(0),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white, width: 2.5),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          ),
          child: const Text(
            'OK',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
