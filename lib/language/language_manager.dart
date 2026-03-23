import 'package:fl_digital_tachograph_v2/time/pictograms/tacho_chars.dart';
import 'package:fl_digital_tachograph_v2/time/pictograms/tacho_icons.dart';
import 'package:flutter/material.dart';

enum AppLanguage { english, polish }

class LanguageManager extends ChangeNotifier {
  AppLanguage _language = AppLanguage.english;

  AppLanguage get language => _language;
  bool get isEnglish => _language == AppLanguage.english;
  bool get isPolish => _language == AppLanguage.polish;

  void setLanguage(AppLanguage language) {
	if (_language == language) {
	  return;
	}
	_language = language;
	notifyListeners();
  }

  void toggle() {
	setLanguage(isEnglish ? AppLanguage.polish : AppLanguage.english);
  }

  static LanguageManager of(BuildContext context) {
	return LanguageScope.of(context);
  }

  String get englishLabel => 'English';
  String get polishLabel => 'Polski';
  String get utc => 'UTC';
  String get ok => 'OK';

  String get changeTime => isPolish ? 'Zmień czas' : 'Change Time';
  String get changeTimeTitle => isPolish ? 'Zmiana czasu' : 'Change Time';
  String get resetToCurrentTimezone =>
	  isPolish ? 'Resetuj do bieżącej strefy czasowej' : 'Reset to current timezone';
  String get addOneHour => isPolish ? 'Dodaj jedną godzinę' : 'Add one hour';
  String get subtractOneHour =>
	  isPolish ? 'Odejmij jedną godzinę' : 'Subtract one hour';

  String get tachoCallMainMenu => isPolish ? 'menu podstawowe?' : 'call main menu?';
  String get tachoPrintout => isPolish ? 'wydruk' : 'printout';
  String get tachoDisplay => isPolish ? 'wyświetlacz' : 'display';
  String get tachoEntry => isPolish ? 'wpis' : 'entry';
  String get tachoVehicle => isPolish ? 'pojazd' : 'vehicle';
  String get tachoDriver => isPolish ? 'kierowca' : 'driver';
  String get tachoOut => isPolish ? 'WYJ' : 'OUT';
  String get tachoBegin => isPolish ? 'pocz' : 'begin';
  String get tachoLicenceCode => isPolish ? 'kod licencji' : 'licence code';
  String get tachoCompanyTime => isPolish ? 'czas firmy' : 'company time';
  String get tachoLocalTime => isPolish ? 'czas lokalny' : 'local time';
  String get tachoEntryStored => isPolish ? 'zapis wpisu' : 'entry stored';

  String formatUtcOffset(Duration offset) {
    if (offset == Duration.zero) {
      return utc;
    }

    final totalMinutes = offset.inMinutes;
    final sign = totalMinutes >= 0 ? '+' : '-';
    final absoluteMinutes = totalMinutes.abs();
    final hours = absoluteMinutes ~/ 60;
    final minutes = absoluteMinutes % 60;

    if (minutes == 0) {
      return '$utc$sign$hours';
    }

    return '$utc$sign$hours:${minutes.toString().padLeft(2, '0')}';
  }

  List<List<List<int>>> tachoText(String text) {
	return text
		.split('')
		.map((char) => TachoChars.tachoChars(char) ?? TachoIcons.tacho_empty)
		.toList();
  }

  List<List<List<int>>> fitSymbolsToSlots(
  List<List<List<int>>> symbols,
  int slots,
  ) {
  final fitted = List<List<List<int>>>.from(symbols.take(slots));
  while (fitted.length < slots) {
    fitted.add(TachoIcons.tacho_empty);
  }
  return fitted;
  }
}

class LanguageScope extends InheritedNotifier<LanguageManager> {
  const LanguageScope({
	super.key,
	required LanguageManager manager,
	required super.child,
  }) : super(notifier: manager);

  static LanguageManager of(BuildContext context) {
	final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();
	assert(scope != null, 'LanguageScope not found in widget tree.');
	return scope!.notifier!;
  }
}


