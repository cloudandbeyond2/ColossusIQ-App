import 'package:flutter/material.dart';
import '../faculty/student_success_early_warning_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: STUDENT SUCCESS & EARLY WARNING SCREEN
// Wraps the responsive StudentSuccessEarlyWarningScreen with HOD navigation
// =============================================================================
class HodStudentSuccessEarlyWarningScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodStudentSuccessEarlyWarningScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return StudentSuccessEarlyWarningScreen(onBack: onBack);
  }
}
