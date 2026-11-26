import 'package:flutter/material.dart';
import '../hod/hod_reports_screen.dart';

class PrincipalReportsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const PrincipalReportsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return HodReportsScreen(onBack: onBack, principalManagement: true);
  }
}
