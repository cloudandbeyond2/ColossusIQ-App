import 'package:flutter/material.dart';
import '../faculty/notice_board_screen.dart';

// =============================================================================
// PLACEMENT OFFICER: NOTICE BOARD (Matches Image 2)
// Wraps NoticeBoardScreen with Placement Officer navigation
// =============================================================================
class PlacementNoticeBoardScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PlacementNoticeBoardScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return NoticeBoardScreen(onBack: onBack);
  }
}
