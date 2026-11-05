import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/main.dart';

void main() {
  testWidgets('StaffApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StaffApp());

    // Verify that StaffApp mounts
    expect(find.byType(StaffApp), findsOneWidget);
  });
}
