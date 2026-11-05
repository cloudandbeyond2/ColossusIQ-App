import 'package:flutter/material.dart';
import '../faculty/faculty_campus_events_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: CAMPUS EVENTS (Matches Image 2)
// Wraps FacultyCampusEventsScreen with HOD navigation and action delegates
// =============================================================================
class HodCampusEventsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodCampusEventsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return FacultyCampusEventsScreen(onBack: onBack);
  }
}
