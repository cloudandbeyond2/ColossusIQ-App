import 'package:flutter/material.dart';
import '../faculty/certificate_requests_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: CERTIFICATE REQUESTS (Matches AI Course Images 4 & 5)
// Wraps CertificateRequestsScreen with HOD navigation and action delegates
// =============================================================================
class HodCertificateRequestsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodCertificateRequestsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return CertificateRequestsScreen(onBack: onBack);
  }
}
