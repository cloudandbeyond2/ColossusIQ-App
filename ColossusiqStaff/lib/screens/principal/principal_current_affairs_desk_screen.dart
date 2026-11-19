import 'package:flutter/material.dart';
import '../faculty/current_affairs_desk_screen.dart';

// =============================================================================
// PRINCIPAL: CURRENT AFFAIRS DESK SCREEN (Matches Screenshots 1, 2, 3, 4)
// - Hero Blueprint Banner: "Home > Assessment > Current Affairs Desk", badges ASSESSMENT, MVP
// - 3 Stat KPI Cards: Published (5), Drafts (0), Quiz questions this week (0)
// - Items Card: Filter pills (All, Published, Drafts), "+ New item" action
// - Real-time Current Affairs cards with ISRO Chandrayaan-4, Broad-Gauge Electrification, Ramsar wetlands
// - Full New Item & Edit Item builder forms with dynamic counters (0/140, 0/600),
//   category dropdown, date picker, 34 exam chips, and embedded weekly quiz question editor.
// =============================================================================

class PrincipalCurrentAffairsDeskScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalCurrentAffairsDeskScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CurrentAffairsDeskScreen(
      onBack: onBack,
      portalRole: 'Principal',
    );
  }
}
