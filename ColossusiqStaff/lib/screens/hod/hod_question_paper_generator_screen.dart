import 'package:flutter/material.dart';
import '../faculty/question_paper_generator_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: QUESTION PAPER GENERATOR (Matches Image 3)
// Wraps QuestionPaperGeneratorScreen with HOD navigation and action delegates
// =============================================================================
class HodQuestionPaperGeneratorScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodQuestionPaperGeneratorScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return QuestionPaperGeneratorScreen(onBack: onBack);
  }
}
