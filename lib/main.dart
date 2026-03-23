import 'package:flutter/material.dart';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:fl_digital_tachograph_v2/time/change_time/change_time_view.dart';
import 'package:fl_digital_tachograph_v2/options_view.dart';
import 'package:fl_digital_tachograph_v2/time/just_utc/utc_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageManager _languageManager = LanguageManager();

  @override
  Widget build(BuildContext context) {
    return LanguageScope(
      manager: _languageManager,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const OptionsView(),
        routes: {
          '/utc': (context) => const UtcView(),
          '/change-time': (context) => const ChangeTimeView(),
        },
      ),
    );
  }
}

