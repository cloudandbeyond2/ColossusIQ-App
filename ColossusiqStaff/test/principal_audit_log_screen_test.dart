import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_audit_log_screen.dart';

void main() {
  testWidgets('audit log shows events, expands details, and copies JSON', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: PrincipalAuditLogScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Total Events'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('ai-provider.update'), findsOneWidget);

    String? copiedJson;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copiedJson = (call.arguments as Map<Object?, Object?>)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    final copyButton = find.widgetWithText(OutlinedButton, 'Copy JSON');
    await tester.tap(copyButton);
    await tester.pumpAndSettle();
    expect(copiedJson, contains('"logId": "a001"'));
    expect(copiedJson, contains('"detail": "Default model changed'));

    final firstRow = find.text('ai-provider.update');
    await tester.ensureVisible(firstRow);
    await tester.tap(firstRow);
    await tester.pumpAndSettle();
    expect(find.text('ACTOR EMAIL'), findsOneWidget);
    expect(find.text('rajesh@colossusiq.com'), findsOneWidget);
    expect(find.text('gemini-1.5-pro'), findsOneWidget);
  });

  testWidgets('search filters audit rows and metrics', (tester) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: PrincipalAuditLogScreen()));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField),
      'research-agent',
    );
    await tester.pumpAndSettle();

    expect(find.text('Total Events'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('audit-metric-value-Total Events')),
      findsOneWidget,
    );
    expect(
      tester.widget<Text>(
        find.byKey(const ValueKey('audit-metric-value-Total Events')),
      ).data,
      '1',
    );
    expect(find.text('ai.request.failed'), findsOneWidget);
    expect(find.text('ai-provider.update'), findsNothing);
  });

  testWidgets('outcome dropdown filters the audit table', (tester) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: PrincipalAuditLogScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('audit-filter-outcome')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Failure').last);
    await tester.pumpAndSettle();

    expect(
      tester.widget<Text>(
        find.byKey(const ValueKey('audit-metric-value-Total Events')),
      ).data,
      '2',
    );
    expect(find.text('ai.request.failed'), findsOneWidget);
    expect(find.text('auth.login.failed'), findsOneWidget);
    expect(find.text('ai-provider.update'), findsNothing);
  });

  testWidgets('audit log layout stays within mobile viewports', (tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [
      320.0,
      360.0,
      390.0,
      640.0,
      720.0,
      767.0,
      768.0,
      900.0,
      1024.0,
      1208.0,
      1280.0,
    ]) {
      tester.view.physicalSize = Size(width, 844);
      await tester.pumpWidget(
        const MaterialApp(home: PrincipalAuditLogScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Search actor, action, IP, detail...'), findsOneWidget);
      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');

      final firstRow = find.text('ai-provider.update');
      await tester.ensureVisible(firstRow);
      await tester.tap(firstRow);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'Expanded at width: $width');
    }
  });
}
