import 'package:flutter/material.dart';
import '../faculty/faculty_exam_prep_screen.dart';

// =============================================================================
// PRINCIPAL: EXAM PREP STUDIO SCREEN (Matches Screenshots 1, 2, 3)
// - Hero Blueprint Banner: "Home > Assessment > Exam Prep Studio", badges ASSESSMENT, MVP
// - AI Suggestions Warning Alert Banner
// - 3 Stat KPI Cards: Published question sets (0), Topic notes by faculty (0), AI notes to review (0)
// - Sub Tabs: Question sets / Study notes
// - Question sets Panel with "+ New set" action & technical blueprint grid empty state
// - New Question Set builder form with 33 exam chips, "Draft with AI", dynamic questions, and publish
// =============================================================================

class PrincipalExamPrepScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalExamPrepScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultyExamPrepScreen(
      onBack: onBack,
      portalRole: 'Principal',
      startEmpty: true,
    );
  }
}
