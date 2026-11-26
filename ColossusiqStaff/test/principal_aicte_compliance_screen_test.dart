import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_aicte_compliance_screen.dart';

void main() {
  testWidgets('AICTE compliance reference metrics and actions are functional', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1360, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PrincipalAicteComplianceScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('72%'), findsOneWidget);
    expect(find.text('1 : 1.8'), findsOneWidget);
    expect(find.text('5 / 6 Constituted'), findsOneWidget);
    expect(find.text('Department Breakdown (9)'), findsOneWidget);

    await tester.tap(find.text('Enter AICTE ID'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, '1-1101-AICTE-TN');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('PID: 1-1101-AICTE-TN'), findsOneWidget);

    final committeesTab = find.text('Statutory Committees & Disclosures');
    await tester.ensureVisible(committeesTab);
    await tester.tap(committeesTab);
    await tester.pumpAndSettle();

    final editCommittee = find.text('Update details').first;
    await tester.ensureVisible(editCommittee);
    await tester.tap(editCommittee);
    await tester.pumpAndSettle();
    expect(find.text('4 Sept 2026'), findsNWidgets(2));
    await tester.enterText(
      find.byType(TextFormField).first,
      'Dr. Updated Lead',
    );
    await tester.tap(find.text('Save committee'));
    await tester.pumpAndSettle();
    expect(find.text('Dr. Updated Lead'), findsOneWidget);

    final actionPlanTab = find.text('Compliance Action Plan (4)');
    await tester.ensureVisible(actionPlanTab);
    await tester.tap(actionPlanTab);
    await tester.pumpAndSettle();
    expect(find.text('2 open · 1 in progress · 1 resolved'), findsOneWidget);
    expect(find.text('· 3 overdue'), findsOneWidget);
    expect(
      find.text(
        'Reconstitute the SC / ST Committee and hold its first meeting',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Log Action Item'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField).first,
      'Test compliance follow-up',
    );
    await tester.tap(find.text('Save Action'));
    await tester.pumpAndSettle();

    expect(find.text('Test compliance follow-up'), findsOneWidget);
    expect(find.text('3 open · 1 in progress · 1 resolved'), findsOneWidget);
    await tester.tap(
      find.byKey(const ValueKey('action-status-Test compliance follow-up')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('In Progress').last);
    await tester.pumpAndSettle();
    expect(find.text('2 open · 2 in progress · 1 resolved'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete action').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Test compliance follow-up'), findsNothing);
    expect(find.text('2 open · 1 in progress · 1 resolved'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('AICTE compliance screen renders without overflow on mobile', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PrincipalAicteComplianceScreen())),
    );
    await tester.pumpAndSettle();
    expect(find.text('AICTE Compliance Index'), findsOneWidget);
    expect(tester.takeException(), isNull);

    final departmentTab = find.text('Department Breakdown (9)');
    await tester.ensureVisible(departmentTab);
    await tester.tap(departmentTab);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final committeesTab = find.text('Statutory Committees & Disclosures');
    await tester.ensureVisible(committeesTab);
    await tester.tap(committeesTab);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final actionPlanTab = find.text('Compliance Action Plan (4)');
    await tester.ensureVisible(actionPlanTab);
    await tester.tap(actionPlanTab);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Log Action Item'));
    await tester.pumpAndSettle();
    expect(find.text('Log AICTE Compliance Action'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });
}
