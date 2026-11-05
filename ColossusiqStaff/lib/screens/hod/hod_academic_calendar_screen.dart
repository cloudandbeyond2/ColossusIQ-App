import 'package:flutter/material.dart';
import '../faculty/academic_calendar_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: ACADEMIC CALENDAR (Matches Image 5)
// Wraps AcademicCalendarScreen with HOD navigation and action delegates
// =============================================================================
class HodAcademicCalendarScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodAcademicCalendarScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AcademicCalendarScreen(onBack: onBack);
  }
}
