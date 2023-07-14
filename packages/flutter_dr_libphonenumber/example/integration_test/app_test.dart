import 'package:flutter_dr_libphonenumber_example/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Example app smoke test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const app.MyApp());

      expect(find.text('-'), findsOneWidget);

      await tester.tap(find.text('Run format number'));
      await tester.pump();

      expect(find.text('+60129602189'), findsOneWidget);
    },
  );
}
