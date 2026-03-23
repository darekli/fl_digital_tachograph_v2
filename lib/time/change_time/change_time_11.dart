import 'dart:async';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/real_time_setter.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/tacho_utc_text.dart';
import 'package:flutter/material.dart';

class ChangeTime11Widget extends StatefulWidget {
  final VoidCallback onAutoReturnToScreen9;

  const ChangeTime11Widget({
    super.key,
    required this.onAutoReturnToScreen9,
  });

  @override
  State<ChangeTime11Widget> createState() => _ChangeTime11WidgetState();
}

class _ChangeTime11WidgetState extends State<ChangeTime11Widget> {
  Timer? _autoReturnTimer;

  @override
  void initState() {
    super.initState();
    _autoReturnTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      widget.onAutoReturnToScreen9();
    });
  }

  @override
  void dispose() {
    _autoReturnTimer?.cancel();
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
                text: language.tachoEntryStored,
                rectX: 3,
                rectY: 3,
                color: Colors.white,
                slots: 16,
              ),
              SizedBox(height: 1),
              TachoTextUTC(
                text: '',
                rectX: 3,
                rectY: 3,
                color: Colors.white,
                slots: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        RealTimeSetter(
          useArrowAdjustIcons: true,
          onIncreasePressed: () {},
          onDecreasePressed: () {},
          onOkPressed: () {},
          onTimeChanged: _ignore,
        ),
      ],
    );
  }

  static void _ignore(DateTime _, String __) {}
}

