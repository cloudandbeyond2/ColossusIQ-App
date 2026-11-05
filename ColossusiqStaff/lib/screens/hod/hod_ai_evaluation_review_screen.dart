import 'package:flutter/material.dart';
import '../faculty/ai_evaluation_review_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: AI EVALUATION REVIEW (Matches Assessment Images 4 & 5)
// Wraps AiEvaluationReviewScreen with HOD navigation and action delegates
// =============================================================================
class HodAiEvaluationReviewScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodAiEvaluationReviewScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AiEvaluationReviewScreen(onBack: onBack);
  }
}
