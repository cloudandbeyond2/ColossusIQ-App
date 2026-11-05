import 'package:flutter/material.dart';
import '../faculty/faculty_experience_passport_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: EXPERIENCE PASSPORT (Matches Image 5)
// Wraps FacultyExperiencePassportScreen with HOD navigation and action delegates
// =============================================================================
class HodExperiencePassportScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodExperiencePassportScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultyExperiencePassportScreen(onBack: onBack);
  }
}
