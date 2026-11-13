import 'package:flutter/material.dart';
import '../faculty/curriculum_studio_screen.dart';

// =============================================================================
// PRINCIPAL: UNIVERSITY CURRICULUM STUDIO (WRAPS MASTER SCREEN)
// =============================================================================
class PrincipalCurriculumStudioScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalCurriculumStudioScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CurriculumStudioScreen(onBack: onBack);
  }
}
