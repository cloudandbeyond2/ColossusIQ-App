import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/certificate_pdf_service.dart';

// =============================================================================
// AI COURSE & CERTIFICATION: ISSUED CERTIFICATES SCREEN
// Matches screenshot 5: Blueprint grid hero banner, 6 grade metric cards
// (Issued 0, Grade O 0, Grade A+ 0, Grade A 0, Grade B 0, Grade C 0),
// and "Course & quiz certificates" card with search/filter and blueprint graph paper empty state.
// =============================================================================
class IssuedCertificatesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const IssuedCertificatesScreen({super.key, this.onBack});

  @override
  State<IssuedCertificatesScreen> createState() =>
      _IssuedCertificatesScreenState();
}

class _IssuedCertificatesScreenState extends State<IssuedCertificatesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedGrade = "All";

  final List<Map<String, dynamic>> _certificates = [
    {
      "certificate": "CIQ-2026-E4A7CF18",
      "student": "Anand Kumar",
      "quiz": "Emerging Technologies — final assessment",
      "dept": "Computer Science & Engineering",
      "marks": "26/30 (87%)",
      "grade": "A+",
      "issued": "21 Oct 2026",
    },
    {
      "certificate": "CIQ-2026-E1453EBA",
      "student": "Anand Kumar",
      "quiz":
          "Computer Science & Engineering — Data Structures and Algorithms quiz",
      "dept": "Computer Science & Engineering",
      "marks": "9/10 (90%)",
      "grade": "O",
      "issued": "15 Oct 2026",
    },
    {
      "certificate": "CIQ-2026-9C6D8BFD",
      "student": "Anand Kumar",
      "quiz": "Computer Science & Engineering — Web Technologies quiz",
      "dept": "Computer Science & Engineering",
      "marks": "8/10 (80%)",
      "grade": "A+",
      "issued": "6 Oct 2026",
    },
    {
      "certificate": "CIQ-2026-A8B5E350",
      "student": "Anand Kumar",
      "quiz": "Computer Science & Engineering — DBMS quiz",
      "dept": "Computer Science & Engineering",
      "marks": "4/8 (50%)",
      "grade": "C",
      "issued": "6 Oct 2026",
    },
    {
      "certificate": "CIQ-2026-B2CF82C3",
      "student": "Divya Ramesh",
      "quiz": "Operating Systems — final assessment",
      "dept": "Computer Science & Engineering",
      "marks": "30/30 (100%)",
      "grade": "O",
      "issued": "5 Oct 2026",
    },
    {
      "certificate": "CIQ-2026-B1FB8977",
      "student": "Anand Kumar",
      "quiz": "Database Management Systems — final assessment",
      "dept": "Computer Science & Engineering",
      "marks": "4/4 (100%)",
      "grade": "O",
      "issued": "29 Sept 2026",
    },
  ];

  void _showViewCertificateDialog(Map<String, dynamic> c) {
    final String recipient = (c["student"] as String?) ?? "Anand Kumar";
    final String quizTitle = (c["quiz"] as String?) ?? "Emerging Technologies — final assessment";
    final String certId = (c["certificate"] as String?) ?? (c["id"] as String?) ?? "CIQ-2026-031207A0";
    final String grade = (c["grade"] as String?) ?? "A+";
    final String date = (c["issued"] as String?) ?? (c["date"] as String?) ?? "8 October 2026";
    final String dept = (c["dept"] as String?) ?? "Computer Science & Engineering";
    final String marks = (c["marks"] as String?) ?? "26/30 (87%)";

    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: const Color(0xFFFBFBFD),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Close Button Row
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded, size: 22, color: Color(0xFF64748B)),
                      splashRadius: 18,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 1. TOP VERIFICATION HEADER & ACTIONS (Matching Screenshot 2)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 700;

                      final verifiedBanner = Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: Color(0xFF047857),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check, size: 16, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Verified: this certificate is genuine",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF065F46),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xFF064E3B),
                                        height: 1.35,
                                      ),
                                      children: [
                                        const TextSpan(text: "Certificate of achievement issued to "),
                                        TextSpan(
                                          text: recipient,
                                          style: const TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        TextSpan(
                                          text:
                                              " by Anna Institute of Technology on $date. Signed under the authority of Dr. Lakshmi Sundaram, Principal.",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "ID $certId · digital signature checked",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF047857),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );

                      final actionButtons = Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 1. Print / Save PDF (Native print preview)
                          SizedBox(
                            width: 200,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                try {
                                  await CertificatePdfService.printOrSavePdf(
                                    recipient: recipient,
                                    type: "Achievement",
                                    event: quizTitle,
                                    date: date,
                                    certId: certId,
                                    citation:
                                        "has successfully demonstrated excellence and secured $marks with Grade $grade in $quizTitle.",
                                    rollNumber: "110124001 · $dept",
                                  );
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Error opening print dialog: $e"),
                                        backgroundColor: const Color(0xFFDC2626),
                                      ),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.print_outlined, size: 15),
                              label: const Text("Print / save PDF"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2865),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // 2. Copy Verification Link
                          SizedBox(
                            width: 200,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                final link = "https://colossus-iq-new.vercel.app/verify/$certId";
                                Clipboard.setData(ClipboardData(text: link));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "Verification link copied to clipboard:\n$link",
                                            style: GoogleFonts.poppins(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFF1E2865),
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.link_rounded, size: 15),
                              label: const Text("Copy verification link"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1E293B),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // 3. Add to LinkedIn Dialog
                          SizedBox(
                            width: 200,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _showLinkedInDialog(
                                  context: context,
                                  recipient: recipient,
                                  type: "Achievement",
                                  certId: certId,
                                  event: quizTitle,
                                );
                              },
                              icon: const Icon(Icons.share_outlined, size: 15),
                              label: const Text("Add to LinkedIn"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF0A66C2),
                                side: const BorderSide(color: Color(0xFF0A66C2)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ],
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            verifiedBanner,
                            const SizedBox(height: 12),
                            actionButtons,
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 11, child: verifiedBanner),
                          const SizedBox(width: 14),
                          Flexible(flex: 9, child: Align(alignment: Alignment.centerRight, child: actionButtons)),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  // 2. THE AUTHENTIC CERTIFICATE DOCUMENT (Matching Screenshot 2 & 3)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF8), // Ivory parchment
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF1E2865), width: 2.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFD4AF37), width: 1.2), // Gold inner border
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Top Header Row: Crest, Institute Name, NAAC Badge
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left: AIT Gold Seal Crest
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFD4AF37), width: 0.8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "AIT",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF1E2865),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Center: Institute Details
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "ANNA INSTITUTE OF TECHNOLOGY",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.2,
                                        color: const Color(0xFF1E2865),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Affiliated to Tamil Nadu Technical University",
                                      style: GoogleFonts.poppins(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF475569),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Chennai, Tamil Nadu\nPhone 9840012345 · office@ait.edu.in",
                                      style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        color: const Color(0xFF64748B),
                                        height: 1.25,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              // Right: NAAC ACCREDITED Badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: const Color(0xFFD4AF37), width: 1),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "NAAC",
                                      style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      "ACCREDITED",
                                      style: GoogleFonts.poppins(
                                        fontSize: 7,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFD97706),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // CERTIFICATE Main Title
                          Text(
                            "CERTIFICATE",
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4.0,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Golden Ribbon Banner
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFCA8A04), Color(0xFFB45309)],
                              ),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFB45309).withValues(alpha: 0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              "OF ACHIEVEMENT",
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Subtitle
                          Text(
                            "This is to certify that",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12.5,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Recipient Name
                          Text(
                            recipient,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF78350F),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Roll & Department Line
                          Text(
                            "110124001 · $dept",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Citation / Achievement Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "has successfully demonstrated excellence and secured $marks with Grade $grade in $quizTitle.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF334155),
                                height: 1.45,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Three Info Pill Boxes: EVENT, HELD ON, DATE OF ISSUE
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            alignment: WrapAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "QUIZ / COURSE ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      TextSpan(
                                        text: quizTitle,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "GRADE ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Grade $grade ($marks)",
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "DATE OF ISSUE ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      TextSpan(
                                        text: date,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Bottom Signatures, Gold Seal & QR Code Row (Screenshot 3)
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 650,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left: QR Code Box + Verify URL
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color(0xFFCBD5E1)),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: const Icon(
                                          Icons.qr_code_2_rounded,
                                          size: 44,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "SCAN TO VERIFY",
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF92400E),
                                            ),
                                          ),
                                          Text(
                                            certId,
                                            style: GoogleFonts.poppins(
                                              fontSize: 8.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                          Text(
                                            "localhost:3000/verify",
                                            style: GoogleFonts.poppins(
                                              fontSize: 7.5,
                                              color: const Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Center: Scalloped Embossed Gold Seal Medallion with Ribbon Tails
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 58,
                                        height: 58,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: const RadialGradient(
                                            colors: [
                                              Color(0xFFFEF3C7),
                                              Color(0xFFF59E0B),
                                              Color(0xFFB45309),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFB45309).withValues(alpha: 0.35),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: const Color(0xFF78350F), width: 0.8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.check_rounded,
                                                  size: 16,
                                                  color: Color(0xFF78350F),
                                                ),
                                                Text(
                                                  "VERIFIED",
                                                  style: GoogleFonts.cinzel(
                                                    fontSize: 6,
                                                    fontWeight: FontWeight.w900,
                                                    color: const Color(0xFF78350F),
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Ribbon tails below seal
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Transform.rotate(
                                            angle: -0.2,
                                            child: Container(
                                              width: 9,
                                              height: 14,
                                              color: const Color(0xFFB45309),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Transform.rotate(
                                            angle: 0.2,
                                            child: Container(
                                              width: 9,
                                              height: 14,
                                              color: const Color(0xFFB45309),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Right: Official Seal Stamp + Signature of Dr. Lakshmi Sundaram
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Circular AIT Seal Stamp
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xFF334155), width: 1.2),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: const Color(0xFF334155), width: 0.6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "AIT\nSEAL",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 7.5,
                                                  fontWeight: FontWeight.w800,
                                                  color: const Color(0xFF334155),
                                                  height: 1.1,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Signature Column
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Dr. Lakshmi Sundaram",
                                            style: GoogleFonts.greatVibes(
                                              fontSize: 22,
                                              color: const Color(0xFF1E2865),
                                            ),
                                          ),
                                          Container(
                                            width: 130,
                                            height: 1,
                                            color: const Color(0xFFCBD5E1),
                                            margin: const EdgeInsets.symmetric(vertical: 2),
                                          ),
                                          Text(
                                            "Dr. Lakshmi Sundaram",
                                            style: GoogleFonts.poppins(
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                          Text(
                                            "Principal, Anna Institute of Technology",
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: const Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. EXPLANATORY FOOTER NOTE (Screenshot 3)
                  Text(
                    "Scan the QR code on a printed copy, or open this page, to confirm a certificate at any time. Anyone presenting an altered copy will see it fail here.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Certificates are signed by the university and can be checked here at any time.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Bottom Close Button
                  Align(
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1E2865),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        "Close",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLinkedInDialog({
    required BuildContext context,
    required String recipient,
    required String type,
    required String certId,
    required String event,
  }) {
    final certName = "Certificate of $type · $event";
    const org = "Anna Institute of Technology";
    final url = "https://colossus-iq-new.vercel.app/verify/$certId";
    final linkedInAddUrl =
        "https://www.linkedin.com/profile/add?startTask=CERTIFICATION_NAME&name=${Uri.encodeComponent(certName)}&organizationName=${Uri.encodeComponent(org)}&issueYear=2026&issueMonth=10&certUrl=${Uri.encodeComponent(url)}&certId=$certId";

    showDialog(
      context: context,
      builder: (lCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF0A66C2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.share, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              "Add to LinkedIn Profile",
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The following verified credential details are ready for $recipient's LinkedIn profile:",
                style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569)),
              ),
              const SizedBox(height: 14),
              _buildLinkedInField("Certification Name", certName),
              const SizedBox(height: 8),
              _buildLinkedInField("Issuing Organization", org),
              const SizedBox(height: 8),
              _buildLinkedInField("Issue Date", "October 2026"),
              const SizedBox(height: 8),
              _buildLinkedInField("Credential ID", certId),
              const SizedBox(height: 8),
              _buildLinkedInField("Credential URL", url),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(lCtx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: linkedInAddUrl));
              Navigator.pop(lCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("LinkedIn 1-Click certification link copied to clipboard!"),
                  backgroundColor: Color(0xFF0A66C2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.copy_rounded, size: 15),
            label: const Text("Copy LinkedIn 1-Click Link"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A66C2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedInField(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 10, color: const Color(0xFF64748B), fontWeight: FontWeight.w600)),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF0F172A), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final issuedCount = "${_certificates.length}";
    final gradeOCount =
        "${_certificates.where((c) => c["grade"] == "O").length}";
    final gradeAPlusCount =
        "${_certificates.where((c) => c["grade"] == "A+").length}";
    final gradeACount =
        "${_certificates.where((c) => c["grade"] == "A").length}";
    final gradeBCount =
        "${_certificates.where((c) => c["grade"] == "B").length}";
    final gradeCCount =
        "${_certificates.where((c) => c["grade"] == "C").length}";

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 750;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. 6 Grade Metric Cards
              if (isNarrow)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildGradeMetric("Issued", issuedCount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade O", gradeOCount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade A+", gradeAPlusCount)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildGradeMetric("Grade A", gradeACount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade B", gradeBCount)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildGradeMetric("Grade C", gradeCCount)),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: _buildGradeMetric("Issued", issuedCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade O", gradeOCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade A+", gradeAPlusCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade A", gradeACount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade B", gradeBCount)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildGradeMetric("Grade C", gradeCCount)),
                  ],
                ),
              const SizedBox(height: 20),

              _buildCertificatesCard(),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.military_tech_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "AI Course & Certification",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Issued Certificates",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.military_tech_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "AI COURSE & CERTIFICATION",
                                  backgroundColor: const Color(0xFF1E2958),
                                  textColor: const Color(0xFF93C5FD),
                                ),
                                _buildPillBadge(
                                  "MVP",
                                  backgroundColor: const Color(0xFF0F766E),
                                  textColor: const Color(0xFFCCFBF1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Issued Certificates",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Every certificate issued in your college, with grade, marks and verification status.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. 6 GRADE METRIC CARDS
  // ===========================================================================
  Widget _buildGradeMetric(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN CARD: COURSE & QUIZ CERTIFICATES
  // ===========================================================================
  Widget _buildCertificatesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Course & quiz certificates",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Issued automatically when students pass · signed under the Principal's authority · verifiable by QR at /verify",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          // Search + Dropdown Filter (Responsive & Matching Screenshot 1 & 2)
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 640;

              final searchField = Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFD),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.search_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: "Search student, quiz or ID",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: false,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );

              final gradeDropdown = Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedGrade,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 18, color: Color(0xFF64748B)),
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: const Color(0xFF334155)),
                    items: ["All", "O", "A+", "A", "B", "C"]
                        .map((g) => DropdownMenuItem(
                            value: g,
                            child: Text(g, overflow: TextOverflow.ellipsis)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedGrade = val);
                    },
                  ),
                ),
              );

              return Row(
                children: [
                  Expanded(
                    flex: isDesktop ? 0 : 1,
                    child: SizedBox(
                      width: isDesktop ? 260 : null,
                      child: searchField,
                    ),
                  ),
                  const SizedBox(width: 10),
                  gradeDropdown,
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Certificate Data Table matching Screenshot 1
          () {
            final query = _searchController.text.trim().toLowerCase();
            final filtered = _certificates.where((c) {
              if (_selectedGrade != "All" && c["grade"] != _selectedGrade) {
                return false;
              }
              if (query.isNotEmpty) {
                final student = (c["student"] as String).toLowerCase();
                final quiz = (c["quiz"] as String).toLowerCase();
                final cert = (c["certificate"] as String).toLowerCase();
                if (!student.contains(query) &&
                    !quiz.contains(query) &&
                    !cert.contains(query)) {
                  return false;
                }
              }
              return true;
            }).toList();

            if (filtered.isEmpty) {
              return Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 220),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFD),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "No certificates found",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Try a different search keyword or grade filter.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 40,
                dataRowMinHeight: 52,
                dataRowMaxHeight: 62,
                horizontalMargin: 12,
                columnSpacing: 28,
                showCheckboxColumn: false,
                columns: [
                  DataColumn(
                    label: Text(
                      "CERTIFICATE",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "STUDENT",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "QUIZ",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "MARKS",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "GRADE",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "ISSUED",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
                rows: filtered.map((c) {
                  return DataRow(
                    onSelectChanged: (_) => _showViewCertificateDialog(c),
                    cells: [
                      // CERTIFICATE
                      DataCell(
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            c["certificate"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                        onTap: () => _showViewCertificateDialog(c),
                      ),
                      // STUDENT
                      DataCell(
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            c["student"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        onTap: () => _showViewCertificateDialog(c),
                      ),
                      // QUIZ
                      DataCell(
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            width: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  c["quiz"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  c["dept"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () => _showViewCertificateDialog(c),
                      ),
                      // MARKS
                      DataCell(
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            c["marks"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                        onTap: () => _showViewCertificateDialog(c),
                      ),
                      // GRADE
                      DataCell(
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              c["grade"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ),
                        onTap: () => _showViewCertificateDialog(c),
                      ),
                      // ISSUED
                      DataCell(
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            c["issued"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        onTap: () => _showViewCertificateDialog(c),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          }(),
        ],
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildPillBadge(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT / GRAPH PAPER GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
