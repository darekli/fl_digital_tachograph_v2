import 'package:fl_digital_tachograph_v2/options_view.dart';
import 'package:fl_digital_tachograph_v2/widgets/utc_time_widget.dart';
import 'package:flutter/material.dart';

class UtcView extends StatefulWidget {
  const UtcView({super.key});

  @override
  State<UtcView> createState() => _UtcViewState();
}

class _UtcViewState extends State<UtcView> {
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
          child: const UTC_TimeWidget(),
        ),
      ),
    );
  }
}
