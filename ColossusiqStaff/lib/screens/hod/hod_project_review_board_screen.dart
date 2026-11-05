import 'package:flutter/material.dart';
import '../faculty/ai_project_review_board_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: AI PROJECT REVIEW BOARD (Matches Image 1)
// Wraps AiProjectReviewBoardScreen with HOD navigation and action delegates
// =============================================================================
class HodProjectReviewBoardScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodProjectReviewBoardScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AiProjectReviewBoardScreen(onBack: onBack);
  }
}
