import 'package:flutter/material.dart';
import '../faculty/question_bank_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: QUESTION BANK (Matches Assessment Image 3)
// Wraps QuestionBankScreen with HOD navigation and action delegates
// =============================================================================
class HodQuestionBankScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodQuestionBankScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return QuestionBankScreen(onBack: onBack);
  }
}
