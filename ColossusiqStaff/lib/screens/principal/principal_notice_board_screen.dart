import 'package:flutter/material.dart';
import '../faculty/notice_board_screen.dart';

// =============================================================================
// PRINCIPAL NOTICE BOARD SCREEN (WRAPS MASTER NOTICE BOARD SCREEN)
// =============================================================================
class PrincipalNoticeBoardScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalNoticeBoardScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return NoticeBoardScreen(onBack: onBack);
  }
}
