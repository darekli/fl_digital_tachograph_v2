// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:fl_digital_tachograph_v2/widgets/main_top_clock.dart';

import 'package:fl_digital_tachograph_v2/main.dart';

void main() {
  testWidgets('OptionsView starts first, can switch to Polski, and UTC opens clock view', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('UTC'), findsOneWidget);
    expect(find.text('Change Time'), findsOneWidget);

    await tester.tap(find.text('Polski'));
    await tester.pumpAndSettle();

    expect(find.text('Zmień czas'), findsOneWidget);

    await tester.tap(find.text('UTC'));
    await tester.pumpAndSettle();

    expect(find.byType(MainTopClockWidget), findsOneWidget);
  });
}
