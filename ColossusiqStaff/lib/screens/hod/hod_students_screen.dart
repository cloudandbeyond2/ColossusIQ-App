import 'package:flutter/material.dart';
import '../faculty/faculty_students_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: STUDENTS (Matches Image 2)
// Wraps FacultyStudentsScreen with HOD navigation and action delegates
// =============================================================================
class HodStudentsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodStudentsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultyStudentsScreen(onBack: onBack);
  }
}
