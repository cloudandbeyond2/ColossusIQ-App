import 'package:flutter/material.dart';
import '../faculty/faculty_assignments_screen.dart';

// =============================================================================
// ASSIGNMENTS SCREEN
// Wraps FacultyAssignmentsScreen for unified design parity
// =============================================================================
class AssignmentsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const AssignmentsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultyAssignmentsScreen(onBack: onBack);
  }
}
