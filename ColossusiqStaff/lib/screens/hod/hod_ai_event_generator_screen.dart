import 'package:flutter/material.dart';
import '../faculty/ai_event_generator_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: AI EVENT GENERATOR (Matches Images 3 & 4)
// Wraps AiEventGeneratorScreen with HOD navigation and action delegates
// =============================================================================
class HodAiEventGeneratorScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodAiEventGeneratorScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AiEventGeneratorScreen(onBack: onBack);
  }
}
