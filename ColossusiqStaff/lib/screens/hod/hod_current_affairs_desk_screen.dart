import 'package:flutter/material.dart';
import '../faculty/current_affairs_desk_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: CURRENT AFFAIRS DESK (Matches Assessment Image 2)
// Wraps CurrentAffairsDeskScreen with HOD navigation and action delegates
// =============================================================================
class HodCurrentAffairsDeskScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodCurrentAffairsDeskScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CurrentAffairsDeskScreen(onBack: onBack);
  }
}
