import 'package:flutter/material.dart';
import 'package:fl_digital_tachograph_v2/language/language_manager.dart';

class OptionsView extends StatelessWidget {
  const OptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final language = LanguageManager.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ToggleButtons(
                isSelected: [language.isEnglish, language.isPolish],
                onPressed: (index) {
                  language.setLanguage(
                    index == 0 ? AppLanguage.english : AppLanguage.polish,
                  );
                },
                borderRadius: BorderRadius.circular(10),
                color: Colors.white70,
                selectedColor: Colors.white,
                fillColor: Colors.white24,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(language.englishLabel),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(language.polishLabel),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/utc'),
                child: Text(language.utc),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/change-time'),
                child: Text(language.changeTime),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

