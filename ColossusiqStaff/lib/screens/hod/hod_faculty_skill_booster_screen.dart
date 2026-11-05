import 'package:flutter/material.dart';
import '../faculty/faculty_skill_booster_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: FACULTY SKILL BOOSTER (Matches Screenshots 1 & 2)
// Displays faculty professional progression, levels, badges, teaching tasks & skill tracks
// =============================================================================
class HodFacultySkillBoosterScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodFacultySkillBoosterScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultySkillBoosterScreen(onBack: onBack);
  }
}
