import 'package:flutter/material.dart';
import '../faculty/course_management_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: COURSE MANAGEMENT (Matches Image 4)
// Wraps CourseManagementScreen with HOD navigation and action delegates
// =============================================================================
class HodCourseManagementScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodCourseManagementScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CourseManagementScreen(onBack: onBack);
  }
}
