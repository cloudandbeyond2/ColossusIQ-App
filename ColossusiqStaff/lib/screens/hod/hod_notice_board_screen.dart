import 'package:flutter/material.dart';
import '../faculty/notice_board_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: NOTICE BOARD (Matches Image 2)
// Wraps NoticeBoardScreen with HOD navigation and action delegates
// =============================================================================
class HodNoticeBoardScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodNoticeBoardScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return NoticeBoardScreen(onBack: onBack);
  }
}
