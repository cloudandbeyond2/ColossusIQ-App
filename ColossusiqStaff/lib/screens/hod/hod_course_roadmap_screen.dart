import 'package:flutter/material.dart';
import '../faculty/course_roadmap_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: COURSE ROADMAP (Matches Image 1)
// Wraps CourseRoadmapScreen with HOD navigation and action delegates
// =============================================================================
class HodCourseRoadmapScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodCourseRoadmapScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CourseRoadmapScreen(onBack: onBack);
  }
}
