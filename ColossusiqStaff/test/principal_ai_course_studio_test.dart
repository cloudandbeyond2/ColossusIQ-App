import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_app/screens/principal/principal_ai_course_studio_screen.dart';

void main() {
  group('PrincipalAiCourseStudioScreen Widget Tests', () {
    testWidgets('renders main dashboard, KPI cards, table, and launches course wizard',
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
            body: PrincipalAiCourseStudioScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Verify Hero Banner & Badges
      expect(find.text('AI Course Studio'), findsWidgets);
      expect(find.text('AI COURSE & CERTIFICATION'), findsOneWidget);
      expect(find.text('MVP'), findsOneWidget);

      // 2. Verify 4 KPI Metric Cards
      expect(find.text('Courses'), findsOneWidget);
      expect(find.text('Published to students'), findsOneWidget);
      expect(find.text('Students learning'), findsOneWidget);
      expect(find.text('Certificates issued'), findsOneWidget);

      // 3. Verify Course Table and Sample Courses
      expect(find.text('Emerging Technologies'), findsOneWidget);
      expect(find.text('Web Technologies'), findsOneWidget);
      expect(find.text('New course'), findsOneWidget);

      // 4. Tap "+ New course" button to enter Wizard Step 1
      final newCourseBtn = find.text('New course');
      await tester.tap(newCourseBtn);
      await tester.pumpAndSettle();

      // Verify Wizard Step 1 (Course Details)
      expect(find.text('Course details'), findsWidgets);
      expect(find.text('Department'), findsWidgets);
      expect(find.text('Course title'), findsWidgets);
      expect(find.text('Build lessons from'), findsOneWidget);

      // Verify that Principal role is applied as assigned faculty
      expect(find.text('Dr. K. S. Ramanathan, Principal'), findsWidgets);
    });
  });
}
