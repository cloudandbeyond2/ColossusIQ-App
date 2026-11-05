import 'package:flutter/material.dart';
import '../faculty/issued_certificates_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: ISSUED CERTIFICATES (Matches AI Course Image 3)
// Wraps IssuedCertificatesScreen with HOD navigation and action delegates
// =============================================================================
class HodIssuedCertificatesScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodIssuedCertificatesScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return IssuedCertificatesScreen(onBack: onBack);
  }
}
