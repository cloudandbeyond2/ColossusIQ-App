import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_current_affairs_desk_screen.dart';
import 'package:staff_app/screens/principal/principal_question_bank_screen.dart';

void main() {
  group('Principal Assessment Screens Widget Tests', () {
    testWidgets('PrincipalCurrentAffairsDeskScreen renders items, opens new item builder and edit item',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PrincipalCurrentAffairsDeskScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Header & Hero Banner
      expect(find.text('Current Affairs Desk'), findsWidgets);
      expect(find.text('ASSESSMENT'), findsOneWidget);
      expect(find.text('MVP'), findsOneWidget);

      // Verify 3 KPI Cards (Matching Screenshot 1)
      expect(find.text('5'), findsOneWidget);
      expect(find.text('Published'), findsWidgets);
      expect(find.text('Drafts'), findsWidgets);
      expect(find.text('Quiz questions this week'), findsOneWidget);

      // Verify Pre-populated Items from Screenshot 1
      expect(find.text('ISRO Launches Chandrayaan-4 Lunar Sample Return Mission'), findsOneWidget);
      expect(find.text('India Achieves 100% Electrification of Broad-Gauge Railway Network Under Mission 100%'), findsOneWidget);

      // Tap "+ New item" button
      final newItemBtn = find.text('New item');
      expect(newItemBtn, findsOneWidget);
      await tester.tap(newItemBtn);
      await tester.pumpAndSettle();

      // Verify New Item Form (Matching Screenshot 2 & 3)
      expect(find.text('New current-affairs item'), findsOneWidget);
      expect(find.text('Headline (0/140)'), findsOneWidget);
      expect(find.text('Summary (0/600)'), findsOneWidget);
      expect(find.text('UPSC CSE'), findsOneWidget);
      expect(find.text('Add a quiz question (used in the weekly quiz)'), findsOneWidget);

      // Cancel form
      final cancelBtn = find.text('Cancel');
      expect(cancelBtn, findsOneWidget);
      await tester.ensureVisible(cancelBtn);
      await tester.pumpAndSettle();
      await tester.tap(cancelBtn);
      await tester.pumpAndSettle();

      // Back to items list
      expect(find.text('ISRO Launches Chandrayaan-4 Lunar Sample Return Mission'), findsOneWidget);
    });

    testWidgets('PrincipalQuestionBankScreen renders topic folders, KPI cards, and search bar',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PrincipalQuestionBankScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Hero Banner & Subheader (Matching Screenshot 5)
      expect(find.text('Question Bank'), findsWidgets);
      expect(find.text('Assessment Question Bank'), findsOneWidget);
      expect(find.text('Generate with AI'), findsOneWidget);
      expect(find.text('Add Question'), findsOneWidget);

      // Verify 5 KPI Cards
      expect(find.text('7'), findsWidgets);
      expect(find.text('Topic Folders'), findsOneWidget);
      expect(find.text('22'), findsOneWidget);
      expect(find.text('Total Questions'), findsOneWidget);
      expect(find.text('4'), findsWidgets);
      expect(find.text('Active & Ready'), findsOneWidget);

      // Test Add New Question Modal (Image 1)
      final addQBtn = find.text('Add Question');
      await tester.tap(addQBtn);
      await tester.pumpAndSettle();
      expect(find.text('Add New Question'), findsOneWidget);
      expect(find.text('Topic / Folder Heading *'), findsOneWidget);
      expect(find.text('Question Statement *'), findsOneWidget);
      expect(find.text('Save Question'), findsOneWidget);
      final addModalCancel = find.text('Cancel').last;
      await tester.ensureVisible(addModalCancel);
      await tester.pumpAndSettle();
      await tester.tap(addModalCancel);
      await tester.pumpAndSettle();

      // Test Generate questions with AI Modal (Image 3)
      final aiGenBtn = find.text('Generate with AI');
      await tester.tap(aiGenBtn);
      await tester.pumpAndSettle();
      expect(find.text('Generate questions with AI'), findsOneWidget);
      expect(find.text('Subject or course (optional)'), findsOneWidget);
      expect(find.text('Topics'), findsOneWidget);
      final aiModalCancel = find.text('Cancel').last;
      await tester.ensureVisible(aiModalCancel);
      await tester.pumpAndSettle();
      await tester.tap(aiModalCancel);
      await tester.pumpAndSettle();

      // Test Expandable View (Image 5)
      final expandableTab = find.text('Expandable');
      expect(expandableTab, findsOneWidget);
      await tester.tap(expandableTab);
      await tester.pumpAndSettle();

      expect(find.text('operating system'), findsOneWidget);
      expect(find.text('Transactions and concurrency control'), findsOneWidget);
      expect(find.text('Normalization'), findsOneWidget);
      expect(find.text('Open Folder Page →'), findsWidgets);

      // Open Folder Page for Normalization (Image 2)
      final openFolderButtons = find.text('Open Folder Page →');
      await tester.tap(openFolderButtons.at(2)); // Normalization is 3rd (index 2)
      await tester.pumpAndSettle();

      // Verify Topic Folder Header & Buttons (Image 2)
      expect(find.text('Back to All Folders'), findsOneWidget);
      expect(find.text('AI Questions for Topic'), findsOneWidget);
      expect(find.text('Add Question to Topic'), findsOneWidget);
      expect(find.text('Delete Folder'), findsOneWidget);

      // Test Delete Folder Dialog (Image 4)
      final deleteFolderBtn = find.text('Delete Folder');
      await tester.tap(deleteFolderBtn);
      await tester.pumpAndSettle();

      expect(find.text('Delete Topic Folder?'), findsOneWidget);
      expect(find.textContaining('This action cannot be undone'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Back to all folders
      await tester.tap(find.text('Back to All Folders'));
      await tester.pumpAndSettle();
      expect(find.text('Assessment Question Bank'), findsOneWidget);
    });
  });
}

