import 'package:flutter/material.dart';
import '../faculty/curriculum_studio_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: CURRICULUM STUDIO (Matches Image 3)
// Wraps CurriculumStudioScreen with HOD navigation and action delegates
// =============================================================================
class HodCurriculumStudioScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodCurriculumStudioScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CurriculumStudioScreen(onBack: onBack);
  }
}
