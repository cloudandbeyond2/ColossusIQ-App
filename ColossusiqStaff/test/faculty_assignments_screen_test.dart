import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/assignments/assignments_screen.dart';

void main() {
  testWidgets('faculty assignments table has no mobile layout overflow', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: AssignmentsScreen()),
    );

    for (final width in [320.0, 360.0, 375.0, 414.0, 768.0]) {
      tester.view.physicalSize = Size(width, 844);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
      expect(find.text('Closed'), findsOneWidget);
      expect(
        tester.getSize(find.text('Closed')).height,
        lessThan(22),
        reason: 'Status label wrapped at viewport width: $width',
      );
    }
  });
}
