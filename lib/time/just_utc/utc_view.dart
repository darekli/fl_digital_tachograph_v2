import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:fl_digital_tachograph_v2/time/widgets/main_top_clock.dart';
import 'package:flutter/material.dart';

class UtcView extends StatefulWidget {
  const UtcView({super.key});

  @override
  State<UtcView> createState() => _UtcViewState();
}

class _UtcViewState extends State<UtcView> {
  DateTime _sharedUTC = DateTime.now();
  late String _sharedTimeZoneLabel;

  @override
  void initState() {
    super.initState();
    _sharedTimeZoneLabel = LanguageManager().formatUtcOffset(
      DateTime.now().timeZoneOffset,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44),
      body: SafeArea(
        child: Center(
          child: MainTopClockWidget(
            externalTime: _sharedUTC,
            timeZoneLabel: _sharedTimeZoneLabel,
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

