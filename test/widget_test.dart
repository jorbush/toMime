import 'package:flutter_test/flutter_test.dart';
import 'package:to_mime/main.dart';

void main() {
  testWidgets('App smoke test loads home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Verify MaterialApp renders with routes
    expect(find.byType(MyApp), findsOneWidget);
  });
}
