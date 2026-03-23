import 'package:fl_digital_tachograph_v2/time/main_top_clock.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/change_time/change_time_01.dart';
import 'package:flutter/material.dart';

class ChangeTimeView extends StatefulWidget {
  const ChangeTimeView({super.key});

  @override
  State<ChangeTimeView> createState() => _ChangeTimeViewState();
}

class _ChangeTimeViewState extends State<ChangeTimeView> {
  DateTime _sharedUTC = DateTime.now();
  late String _sharedTimeZoneLabel;

  @override
  void initState() {
    super.initState();
    _sharedTimeZoneLabel = _buildUtcOffsetLabel(DateTime
        .now()
        .timeZoneOffset);
  }

  String _buildUtcOffsetLabel(Duration offset) {
    if (offset == Duration.zero) {
      return 'UTC';
    }

    final totalMinutes = offset.inMinutes;
    final sign = totalMinutes >= 0 ? '+' : '-';
    final absoluteMinutes = totalMinutes.abs();
    final hours = absoluteMinutes ~/ 60;
    final minutes = absoluteMinutes % 60;

    if (minutes == 0) {
      return 'UTC$sign$hours';
    }

    return 'UTC$sign$hours:${minutes.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44),
      appBar: AppBar(
        title: const Text('Change Time'),
        backgroundColor: const Color(0xFF0A1F44),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ChangeTime01Widget(
            externalTime: _sharedUTC,
            timeZoneLabel: _sharedTimeZoneLabel,
            useArrowAdjustIcons: true,
            onStateChanged: (DateTime newTime, String newLabel) {
              setState(() {
                _sharedUTC = newTime;
                _sharedTimeZoneLabel = newLabel;
              });
            },
          ),
        ),
      ),
    );
  }
}

