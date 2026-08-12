import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:to_mime/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Application Test', () {
    testWidgets('App launches and displays main screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify the app root is present
      expect(find.byType(app.MyApp), findsOneWidget);
    });
  });
}
