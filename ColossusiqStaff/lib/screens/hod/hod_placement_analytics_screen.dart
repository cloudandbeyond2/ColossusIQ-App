import 'package:flutter/material.dart';
import '../placement/placement_analytics_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: PLACEMENT ANALYTICS SCREEN
// Wraps the responsive PlacementAnalyticsScreen with HOD back navigation
// =============================================================================
class HodPlacementAnalyticsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodPlacementAnalyticsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PlacementAnalyticsScreen(onBack: onBack);
  }
}
