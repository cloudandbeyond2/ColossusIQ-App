import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_institutional_knowledge_screen.dart';

void main() {
  testWidgets('knowledge documents search and grounded questions work', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1360, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: PrincipalInstitutionalKnowledgeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('9'), findsWidgets);
    expect(
      find.text('Anna Institute of Technology - Academic Regulations 2026'),
      findsOneWidget,
    );

    await tester.enterText(
      find.byType(TextField).first,
      'Academic Regulations',
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Anna Institute of Technology - Academic Regulations 2026'),
      findsOneWidget,
    );
    expect(find.text('Student Code of Conduct'), findsNothing);

    await tester.tap(find.text('Ask the knowledge base'));
    await tester.pumpAndSettle();
    final questionField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField &&
          widget.decoration?.hintText ==
              'Ask a question about approved documents',
    );
    await tester.enterText(questionField, 'minimum attendance for exams');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.textContaining('75% attendance'), findsOneWidget);
    expect(find.textContaining('Source:'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('knowledge portal fits a narrow mobile viewport', (tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: PrincipalInstitutionalKnowledgeScreen()),
      ),
    );

    for (final width in [320.0, 360.0, 414.0, 768.0]) {
      tester.view.physicalSize = Size(width, 844);
      await tester.pumpAndSettle();

      expect(find.text('Institutional Knowledge (RAG)'), findsWidgets);
      expect(tester.takeException(), isNull, reason: 'Viewport width: $width');
    }
  });
}
