import 'package:flutter/material.dart';
import '../faculty/notice_board_screen.dart';

// =============================================================================
// INCUBATION NOTICE BOARD SCREEN (WRAPS MASTER NOTICE BOARD SCREEN)
// =============================================================================
class IncubationNoticeBoardScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const IncubationNoticeBoardScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return NoticeBoardScreen(onBack: onBack);
  }
}
