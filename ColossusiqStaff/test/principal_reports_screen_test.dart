import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_reports_screen.dart';

void main() {
  testWidgets('principal reports can create and manage a schedule', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1360, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: PrincipalReportsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('test'), findsOneWidget);
    await tester.tap(find.text('test'));
    await tester.pumpAndSettle();
    expect(find.text('EXECUTIVE BRIEFING'), findsOneWidget);
    await tester.tap(find.text('Close Preview'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Automated Schedules (0)'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('New schedule'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField).first,
      'Monthly Quality Summary',
    );
    await tester.tap(find.text('Create schedule'));
    await tester.pumpAndSettle();

    expect(find.text('Monthly Quality Summary'), findsOneWidget);
    expect(find.text('1 Active'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('principal can compile a report from the generation dialog', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1360, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: PrincipalReportsScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Generate report'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).first,
      'Semester Performance',
    );
    await tester.tap(find.text('Compile & Save Report'));
    await tester.pumpAndSettle();

    expect(find.text('Semester Performance'), findsOneWidget);
    expect(find.text('Generated Reports (2)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('principal reports fit a narrow mobile viewport', (tester) async {
    tester.view.physicalSize = const Size(360, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: PrincipalReportsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Reports'), findsWidgets);
    final schedulesTab = find.text('Automated Schedules (0)');
    await tester.ensureVisible(schedulesTab);
    await tester.tap(schedulesTab);
    await tester.pumpAndSettle();
    final scheduleDescription = find.text(
      'Each schedule compiles a new report from live records when it falls due. Only the principal office manages schedules.',
    );
    expect(tester.getSize(scheduleDescription).width, greaterThan(220));
    expect(tester.takeException(), isNull);
  });
}
