import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_security_settings_screen.dart';

void main() {
  testWidgets('security settings fit mobile and tablet viewports', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [
      320.0,
      360.0,
      390.0,
      430.0,
      600.0,
      768.0,
      900.0,
      1024.0,
    ]) {
      tester.view.physicalSize = Size(width, 844);
      await tester.pumpWidget(
        const MaterialApp(home: PrincipalSecuritySettingsScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('A Strong'), findsOneWidget);
      expect(find.text('•  Real-Time Compliance Score'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
    }
  });
}
