import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/auth/login_screen.dart';

void main() {
  testWidgets('login card stays centered and fits phone and reference widths', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [320.0, 390.0, 511.0]) {
      tester.view.physicalSize = Size(width, 875);
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      await tester.pumpAndSettle();

      final card = tester.getRect(
        find.byKey(const ValueKey('login-form-card')),
      );
      expect(
        card.width,
        equals(width < 400 ? width - 40 : 360),
        reason: 'Viewport width: $width',
      );
      expect(
        card.left,
        greaterThanOrEqualTo(0),
        reason: 'Viewport width: $width',
      );
      expect(
        card.right,
        lessThanOrEqualTo(width),
        reason: 'Viewport width: $width',
      );
      expect(find.text('College Portal Authentication'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
    }
  });

  testWidgets('role selection updates the sign-in action', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Principal').last);
    await tester.pumpAndSettle();

    expect(find.text('Sign in as Principal'), findsOneWidget);
  });
}
