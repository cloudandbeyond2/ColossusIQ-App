import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_app/screens/auth/login_screen.dart';

void main() {
  testWidgets('student login stays within phone and tablet widths', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [320.0, 390.0, 646.0]) {
      tester.view.physicalSize = Size(width, 867);
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      await tester.pump(const Duration(milliseconds: 1000));

      final card = tester.getRect(
        find.byKey(const ValueKey('student-login-form-card')),
      );
      expect(
        card.width,
        width < 500 ? width - 40 : 460,
        reason: 'Viewport width: $width',
      );
      expect(card.left, greaterThanOrEqualTo(0));
      expect(card.right, lessThanOrEqualTo(width));
      expect(find.text('Student Portal Sign In'), findsOneWidget);
      expect(find.text('Sign in to StudentApp'), findsOneWidget);
      expect(find.text('Student Portal Authentication'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
    }
  });

  testWidgets('student login uses the left-right split from 980 pixels', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [979.0, 980.0]) {
      tester.view.physicalSize = Size(width, 867);
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      await tester.pump(const Duration(milliseconds: 1000));

      final showcase = find.byKey(
        const ValueKey('student-login-showcase-panel'),
      );
      if (width >= 980) {
        expect(showcase, findsOneWidget);
        final showcaseBounds = tester.getRect(showcase);
        final formBounds = tester.getRect(
          find.byKey(const ValueKey('student-login-form-card')),
        );
        expect(showcaseBounds.right, lessThanOrEqualTo(formBounds.left));
      } else {
        expect(showcase, findsNothing);
      }

      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
    }
  });
}
