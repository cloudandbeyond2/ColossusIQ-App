import 'package:flutter/material.dart';
import '../faculty/issued_certificates_screen.dart';

// =============================================================================
// PLACEMENT OFFICER: ISSUED CERTIFICATES (Matches Image 3)
// Wraps IssuedCertificatesScreen with Placement Officer navigation
// =============================================================================
class PlacementIssuedCertificatesScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const PlacementIssuedCertificatesScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return IssuedCertificatesScreen(onBack: onBack);
  }
}
