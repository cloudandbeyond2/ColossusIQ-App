import 'package:flutter/material.dart';
import '../faculty/faculty_exam_prep_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: EXAM PREP STUDIO (Matches Assessment Image 1)
// Wraps FacultyExamPrepScreen with HOD navigation and action delegates
// =============================================================================
class HodExamPrepScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodExamPrepScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultyExamPrepScreen(onBack: onBack);
  }
}
