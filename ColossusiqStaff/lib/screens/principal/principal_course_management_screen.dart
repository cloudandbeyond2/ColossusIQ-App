import 'package:flutter/material.dart';
import '../faculty/course_management_screen.dart';

// =============================================================================
// PRINCIPAL: COURSE MANAGEMENT SCREEN (WRAPS MASTER SCREEN)
// =============================================================================
class PrincipalCourseManagementScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalCourseManagementScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CourseManagementScreen(onBack: onBack);
  }
}
