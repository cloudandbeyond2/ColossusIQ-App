import 'package:flutter/material.dart';
import '../faculty/ai_course_studio_screen.dart';

// =============================================================================
// PRINCIPAL: AI COURSE STUDIO SCREEN
// Reuses the full-featured, 5-view wizard AiCourseStudioScreen from Faculty portal
// with Principal portal role and action delegates.
// =============================================================================
class PrincipalAiCourseStudioScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalAiCourseStudioScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AiCourseStudioScreen(
      onBack: onBack,
      portalRole: 'Principal',
    );
  }
}
