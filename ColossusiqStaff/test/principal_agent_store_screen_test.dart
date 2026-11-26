import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_agent_store_screen.dart';

void main() {
  testWidgets('agent switch buttons update status and enabled count', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: PrincipalAgentStoreScreen()),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('29 of 30 agents are on for your college'),
      findsOneWidget,
    );

    final switchOnButton = find.widgetWithText(OutlinedButton, 'Switch on');
    expect(switchOnButton, findsOneWidget);
    await tester.ensureVisible(switchOnButton);
    await tester.tap(switchOnButton);
    await tester.pumpAndSettle();

    expect(
      find.text('30 of 30 agents are on for your college'),
      findsOneWidget,
    );
    expect(find.text('Off'), findsNothing);

    final switchOffButton = find
        .widgetWithText(OutlinedButton, 'Switch off')
        .first;
    await tester.ensureVisible(switchOffButton);
    await tester.tap(switchOffButton);
    await tester.pumpAndSettle();

    expect(
      find.text('29 of 30 agents are on for your college'),
      findsOneWidget,
    );
    expect(find.text('Off'), findsOneWidget);
  });
}
