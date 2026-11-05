import 'package:flutter/material.dart';
import '../faculty/ai_course_studio_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: AI COURSE STUDIO (Matches AI Course Image 1)
// Wraps AiCourseStudioScreen with HOD navigation and action delegates
// =============================================================================
class HodAiCourseStudioScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodAiCourseStudioScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AiCourseStudioScreen(onBack: onBack);
  }
}
