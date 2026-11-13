import 'package:flutter/material.dart';
import '../faculty/academic_calendar_screen.dart';

// =============================================================================
// PRINCIPAL: ACADEMIC CALENDAR SCREEN
// Wraps the master AcademicCalendarScreen for full parity across staff portals
// =============================================================================
class PrincipalAcademicCalendarScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PrincipalAcademicCalendarScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AcademicCalendarScreen(onBack: onBack);
  }
}
