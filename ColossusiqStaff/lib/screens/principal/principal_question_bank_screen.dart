import 'package:flutter/material.dart';
import '../faculty/question_bank_screen.dart';

// =============================================================================
// PRINCIPAL: ASSESSMENT QUESTION BANK SCREEN (Matches Screenshot 5)
// - Hero Blueprint Banner: "Home > Assessment > Question Bank", badges ASSESSMENT, MVP
// - Subheader: "Assessment Question Bank", "Generate with AI", "+ Add Question"
// - 5 KPI Stat Cards: 7 Topic Folders, 22 Total Questions, 4 Active & Ready, 18 Drafts, 5.9 Avg Marks
// - Filter & Search Bar: Search by query, Difficulties, Bloom Levels, Statuses, Sort
// - Folders Grid View: operating system, Transactions and concurrency control, Normalization
// - Expandable View & Folder Detail Drilldown with Bloom Taxonomy & Course Outcomes
// =============================================================================

class PrincipalQuestionBankScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalQuestionBankScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return QuestionBankScreen(
      onBack: onBack,
      portalRole: 'Principal',
    );
  }
}
