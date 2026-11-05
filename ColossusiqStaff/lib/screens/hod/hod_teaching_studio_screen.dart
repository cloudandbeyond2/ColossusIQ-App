import 'package:flutter/material.dart';
import '../faculty/teaching_studio_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: TEACHING STUDIO (Matches Image 4)
// Wraps TeachingStudioScreen with HOD navigation and action delegates
// =============================================================================
class HodTeachingStudioScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodTeachingStudioScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return TeachingStudioScreen(onBack: onBack);
  }
}
