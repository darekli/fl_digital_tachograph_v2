import 'package:flutter/material.dart';
import 'package:fl_digital_tachograph_v2/change_time_view.dart';
import 'package:fl_digital_tachograph_v2/options_view.dart';
import 'package:fl_digital_tachograph_v2/utc_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OptionsView(),
      routes: {
        '/utc': (context) => const UtcView(),
        '/change-time': (context) => const ChangeTimeView(),
      },
    );
  }
}

