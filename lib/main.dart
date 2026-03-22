import 'package:fl_digital_tachograph_v2/time/main_top_clock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _sharedUTC = DateTime.now();
  late String _sharedTimeZoneLabel;

  @override
  void initState() {
    super.initState();
    _sharedTimeZoneLabel = _buildUtcOffsetLabel(DateTime.now().timeZoneOffset);
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
      body: SafeArea(
        child: Center(
          /**
           * CLOCK WIDGET
           */
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