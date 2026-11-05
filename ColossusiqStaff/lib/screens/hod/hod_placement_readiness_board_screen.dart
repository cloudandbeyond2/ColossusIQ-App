import 'package:flutter/material.dart';
import '../placement/placement_readiness_board_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: PLACEMENT READINESS BOARD SCREEN
// Wraps the responsive PlacementReadinessBoardScreen with HOD back navigation
// =============================================================================
class HodPlacementReadinessBoardScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodPlacementReadinessBoardScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PlacementReadinessBoardScreen(onBack: onBack);
  }
}
