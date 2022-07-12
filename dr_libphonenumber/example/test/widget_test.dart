// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dr_libphonenumber_example/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Example app smoke test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const app.MyApp());

      expect(find.text('-'), findsOneWidget);

      await tester.tap(find.text('Run format number'));
      await tester.pump();
    },
  );
}
