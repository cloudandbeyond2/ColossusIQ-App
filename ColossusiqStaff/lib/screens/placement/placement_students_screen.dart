import 'package:flutter/material.dart';
import '../faculty/faculty_students_screen.dart';

// =============================================================================
// PLACEMENT: STUDENTS SCREEN
// Uses FacultyStudentsScreen to render exact design from Image 1:
// - Blueprint grid hero banner with watermark & badges (FACULTY, MVP)
// - Top Action & Filter Bar (Search students, All dropdown, Export excel, Import students, + Add Student)
// - Big card with "No students registered yet" empty state and dual action buttons
// - Footer showing "Showing 0 of 0 students" and "Institutional Student Directory"
// =============================================================================

class PlacementStudentsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PlacementStudentsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultyStudentsScreen(onBack: onBack);
  }
}
