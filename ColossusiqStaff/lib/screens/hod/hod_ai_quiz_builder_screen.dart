import 'package:flutter/material.dart';
import '../faculty/ai_quiz_builder_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: AI QUIZ BUILDER (Matches AI Course Image 2)
// Wraps AiQuizBuilderScreen with HOD navigation and action delegates
// =============================================================================
class HodAiQuizBuilderScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodAiQuizBuilderScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AiQuizBuilderScreen(onBack: onBack);
  }
}
