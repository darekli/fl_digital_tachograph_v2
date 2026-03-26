import 'package:fl_digital_tachograph_v2/language/language_manager.dart';
import 'package:fl_digital_tachograph_v2/options_view.dart';
import 'package:fl_digital_tachograph_v2/widgets/main_top_clock.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('UTC Time'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
              return;
            }
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const OptionsView()),
            );
          },
        ),
      ),
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
