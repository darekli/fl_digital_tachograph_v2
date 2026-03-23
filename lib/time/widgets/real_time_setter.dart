import 'dart:async';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:flutter/material.dart';

class RealTimeSetter extends StatefulWidget {
  final void Function(DateTime time, String timeZoneLabel) onTimeChanged;
  final bool useArrowAdjustIcons;
  final bool blinkIncreaseButton;
  final bool blinkDecreaseButton;
  final bool blinkOkButton;
  final VoidCallback? onIncreasePressed;
  final VoidCallback? onDecreasePressed;
  final VoidCallback? onOkPressed;

  const RealTimeSetter({
    super.key,
    required this.onTimeChanged,
    this.useArrowAdjustIcons = false,
    this.blinkIncreaseButton = false,
    this.blinkDecreaseButton = false,
    this.blinkOkButton = false,
    this.onIncreasePressed,
    this.onDecreasePressed,
    this.onOkPressed,
  });

  @override
  State<RealTimeSetter> createState() => _RealTimeSetterState();
}

class _RealTimeSetterState extends State<RealTimeSetter> {
  int _hourOffset = 0;
  Timer? _timer;
  bool _showBlinkPhase = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _showBlinkPhase = !_showBlinkPhase;
        });
      }
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
    return LanguageManager().formatUtcOffset(Duration(minutes: totalMinutes));
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
    final language = LanguageManager.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay, size: 32),
          onPressed: _resetTime,
          tooltip: language.resetToCurrentTimezone,
          color: Colors.white,
        ),
        const SizedBox(width: 32),
        IconButton(
          icon: Icon(
            widget.useArrowAdjustIcons
                ? Icons.arrow_circle_up_outlined
                : Icons.add_circle_outline,
            size: 32,
          ),
          onPressed: widget.onIncreasePressed ?? () => _adjustTime(1),
          color: widget.blinkIncreaseButton && !_showBlinkPhase
              ? Colors.transparent
              : Colors.white,
        ),
        const SizedBox(width: 32), // more space between icons
        IconButton(
          icon: Icon(
            widget.useArrowAdjustIcons
                ? Icons.arrow_circle_down_outlined
                : Icons.remove_circle_outline,
            size: 32,
          ),
          onPressed: widget.onDecreasePressed ?? () => _adjustTime(-1),
          color: widget.blinkDecreaseButton && !_showBlinkPhase
              ? Colors.transparent
              : Colors.white,
        ),
        const SizedBox(width: 32),
        OutlinedButton(
          onPressed: widget.onOkPressed ?? () => _adjustTime(0),
          style: OutlinedButton.styleFrom(
            foregroundColor: widget.blinkOkButton && !_showBlinkPhase
                ? Colors.transparent
                : Colors.white,
            side: BorderSide(
              color: widget.blinkOkButton && !_showBlinkPhase
                  ? Colors.transparent
                  : Colors.white,
              width: 2.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          ),
          child: Text(
            language.ok,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
