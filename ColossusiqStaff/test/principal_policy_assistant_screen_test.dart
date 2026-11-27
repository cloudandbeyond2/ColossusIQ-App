import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_policy_assistant_screen.dart';

void main() {
  testWidgets('policy assistant follows responsive layout without overflow', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [360.0, 768.0, 1310.0]) {
      tester.view.physicalSize = Size(width, 900);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PrincipalPolicyAssistantScreen(onBack: () {})),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Policy Assistant'), findsOneWidget);
      expect(find.text('What I answer from'), findsOneWidget);
      expect(
        find.textContaining('Student Code of Conduct & Lab Guidelines'),
        findsWidgets,
      );
      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
    }
  });

  testWidgets('asking a question shows an approved-document answer', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PrincipalPolicyAssistantScreen())),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('policy-question-input')),
      'What is the minimum attendance requirement?',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('policy-ask-button')));
    await tester.tap(find.byKey(const ValueKey('policy-ask-button')));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('minimum attendance requirement published'),
      findsOneWidget,
    );
    expect(find.text('Sources (1)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('document search filters the source list', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PrincipalPolicyAssistantScreen())),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('policy-document-search')),
      'Library',
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Anna Institute of Technology - Library Use Guidelines'),
      findsOneWidget,
    );
    expect(
      find.text('Anna Institute of Technology - Examination Handbook'),
      findsNothing,
    );
  });
}
