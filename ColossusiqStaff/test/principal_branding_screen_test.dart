import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_branding_screen.dart';

void main() {
  testWidgets('DNS CNAME fields fit a narrow viewport', (tester) async {
    tester.view.physicalSize = const Size(600, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: PrincipalBrandingScreen()),
    );
    await tester.pumpAndSettle();

    final domainTab = find.text('Domain & White-Label');
    await tester.ensureVisible(domainTab);
    await tester.tap(domainTab);
    await tester.pumpAndSettle();

    expect(find.text('DNS CNAME SETUP'), findsOneWidget);
    final recordRect = tester.getRect(
      find.byKey(const ValueKey('dns-cname-record')),
    );
    final hostRect = tester.getRect(find.text('portal'));
    final targetRect = tester.getRect(find.text('cname.colossusiq.ai'));
    final statusRect = tester.getRect(find.text('✔ Active'));

    expect(recordRect.contains(targetRect.topLeft), isTrue);
    expect(recordRect.contains(targetRect.bottomRight), isTrue);
    expect(recordRect.contains(statusRect.topLeft), isTrue);
    expect(recordRect.contains(statusRect.bottomRight), isTrue);
    expect(targetRect.top, greaterThan(hostRect.bottom));
  });
}
