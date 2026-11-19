import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_exam_prep_screen.dart';

void main() {
  testWidgets('PrincipalExamPrepScreen renders empty state, opens builder, drafts AI MCQs and publishes',
      (WidgetTester tester) async {
    // 1. Set mobile viewport (390x844 iPhone / Android)
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PrincipalExamPrepScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final mainListView = find.byType(ListView).first;

    // Verify Title & Hero Banner
    expect(find.text('Exam Prep Studio'), findsWidgets);
    expect(find.text('ASSESSMENT'), findsOneWidget);
    expect(find.text('MVP'), findsOneWidget);

    // Verify 3 KPI Cards at 0 initial state (Matching Screenshot 3)
    expect(find.text('Published question sets'), findsOneWidget);
    expect(find.text('0 questions reaching students'), findsOneWidget);
    expect(find.text('Topic notes by faculty'), findsOneWidget);
    expect(find.text('AI notes to review'), findsOneWidget);

    // Scroll down the ListView to reveal Question Sets card
    await tester.drag(mainListView, const Offset(0, -350));
    await tester.pumpAndSettle();

    // Verify Blueprint Empty State (Screenshot 3)
    expect(find.text('No question sets yet'), findsOneWidget);
    final newSetBtn = find.text('New set');
    expect(newSetBtn, findsOneWidget);

    // 2. Click "+ New set" button
    await tester.tap(newSetBtn);
    await tester.pumpAndSettle();

    // Verify New Question Set Form opened (Matching Screenshot 1 & 2)
    expect(find.text('New question set'), findsOneWidget);

    // Scroll down to reveal AI draft box & exam chips
    await tester.drag(mainListView, const Offset(0, -1350));
    await tester.pumpAndSettle();

    expect(find.text('How many to draft'), findsOneWidget);
    expect(find.text('JEE Main'), findsOneWidget);
    expect(find.text('GATE'), findsOneWidget);
    expect(find.text('UPSC CSE'), findsOneWidget);

    final draftWithAiBtn = find.text('Draft with AI');
    expect(draftWithAiBtn, findsOneWidget);

    // 3. Click "Draft with AI"
    await tester.tap(draftWithAiBtn);
    await tester.pumpAndSettle();

    // Verify AI drafted questions (e.g. Question 10)
    expect(find.text('Question 10', skipOffstage: false), findsOneWidget);

    // 4. Scroll down and click "Publish" button
    await tester.drag(mainListView, const Offset(0, -2500));
    await tester.pumpAndSettle();
    await tester.drag(mainListView, const Offset(0, -2500));
    await tester.pumpAndSettle();

    final publishBtn = find.text('Publish');
    expect(publishBtn, findsOneWidget);
    await tester.tap(publishBtn);
    await tester.pumpAndSettle();

    // Scroll back to top using mainListView
    await tester.drag(find.byType(ListView).first, const Offset(0, 5000));
    await tester.pumpAndSettle();

    // Verify returned to Question Sets list with 1 Published Set and updated KPI count
    expect(find.text('1'), findsWidgets);
    expect(find.text('10 questions reaching students'), findsOneWidget);

    // Scroll to see published set in list
    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pumpAndSettle();
    expect(find.text('· by Dr. K. S. Ramanathan, Principal'), findsOneWidget);
  });
}
