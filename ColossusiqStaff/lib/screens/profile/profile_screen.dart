import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/mock_data.dart';
import '../../core/services/auth_session_service.dart';
import '../placement/placement_screen.dart';
import '../certificates/certificates_screen.dart';
import '../mentor/mentor_chat_screen.dart';
import '../auth/login_screen.dart';

// =============================================================================
// ULTRA-PREMIUM MODERN PROFILE & DIGITAL CAMPUS PASS SCREEN
// =============================================================================
class ProfileScreen extends StatefulWidget {
  final void Function(Widget screen, {String? title, Widget? badge})? onOpenSubScreen;

  const ProfileScreen({super.key, this.onOpenSubScreen});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userRole = "Student";
  String _userName = "Anand R";
  String _userDesignation = "Semester 5 · B.E.";
  String _userCollege = "Anna Institute of Technology";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      final role = await AuthSessionService.getRole();
      final name = await AuthSessionService.getName();
      final desig = await AuthSessionService.getDesignation();
      final col = await AuthSessionService.getCollege();
      if (mounted) {
        setState(() {
          _userRole = role;
          // If student data is loaded, preserve student name or session name
          if (role == "Student" || role.isEmpty) {
            _userName = "Anand R";
            _userDesignation = "Semester 5 · B.E.";
          } else {
            _userName = name;
            _userDesignation = desig;
          }
          _userCollege = col.isNotEmpty ? col : "Anna Institute of Technology";
        });
      }
    } catch (_) {}
  }

  void _navigateTo(Widget screen, {required String title}) {
    if (widget.onOpenSubScreen != null) {
      widget.onOpenSubScreen!(screen, title: title);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => screen),
      );
    }
  }

  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626), size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              "Sign Out",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to end your current session?",
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF64748B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await AuthSessionService.signOut();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: Text(
              "Sign Out",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = MockData.studentDashboard;
    final certs = MockData.certificates;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Ultra-Premium Digital Campus Pass Hero Card
            _buildDigitalCampusPass(student),
            const SizedBox(height: 18),

            // 2. Quick Portals (2x2 Grid)
            _buildQuickPortals(context, certs.length),
            const SizedBox(height: 18),

            // 3. Academic Standing & Core Benchmarks
            _buildAcademicStandingCard(),
            const SizedBox(height: 18),

            // 4. Competency & Skill Mastery Radar
            _buildSkillMasteryCard(student),
            const SizedBox(height: 18),

            // 5. Digital ID Barcode & Security Card
            _buildDigitalCredentialsCard(student),
            const SizedBox(height: 18),

            // 6. Account & Preferences Card
            _buildAccountPreferencesCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. DIGITAL CAMPUS PASS HERO CARD
  // ===========================================================================
  Widget _buildDigitalCampusPass(dynamic student) {
    final initials = _userName.trim().isNotEmpty
        ? _userName.trim().split(' ').map((p) => p.isNotEmpty ? p[0] : '').take(2).join().toUpperCase()
        : "AR";

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
            Color(0xFF131C38),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.22),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.14),
          width: 1.2,
        ),
      ),
      child: Stack(
        children: [
          // Background ambient holographic glow curves
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF38BDF8).withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6366F1).withValues(alpha: 0.10),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Campus Identity Strip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.school_rounded,
                              color: Color(0xFF38BDF8),
                              size: 15,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userCollege.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                                Text(
                                  "OFFICIAL DIGITAL ${_userRole.toUpperCase()} PASS",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.6,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF10B981).withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "VERIFIED",
                            style: GoogleFonts.poppins(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: const Color(0xFF34D399),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Main Student Identity Row
                Row(
                  children: [
                    // Avatar with glowing gradient rim
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF38BDF8)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF38BDF8).withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(2.5),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0F172A),
                        ),
                        child: Center(
                          child: Text(
                            initials,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Name, Roll, Dept & Degree
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "${student.rollNo} • ${student.department}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFCBD5E1),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _userDesignation,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF7DD3FC),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Divider line with subtle opacity
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.10),
                ),
                const SizedBox(height: 16),

                // 3 Rich Stat Capsules (Streak, Points, Tier) - Crisp, High Contrast
                Row(
                  children: [
                    Expanded(
                      child: _buildHeroStatCapsule(
                        icon: Icons.local_fire_department_rounded,
                        iconColor: const Color(0xFFFB923C),
                        value: "${student.streak} Days",
                        label: "Study Streak",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildHeroStatCapsule(
                        icon: Icons.emoji_events_rounded,
                        iconColor: const Color(0xFFFBBF24),
                        value: "${student.xp} XP",
                        label: "Campus Points",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildHeroStatCapsule(
                        icon: Icons.verified_user_rounded,
                        iconColor: const Color(0xFF34D399),
                        value: "Tier 1",
                        label: "Placement Ready",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStatCapsule({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. QUICK PORTALS (2x2 INTERACTIVE TILES)
  // ===========================================================================
  Widget _buildQuickPortals(BuildContext context, int certCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PORTALS & HIGHER-ED MODULES",
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildPortalCard(
                title: "Placement Hub",
                value: "74/100",
                badgeText: "Ready",
                badgeColor: const Color(0xFFF59E0B),
                subtitle: "Top 15% in cohort",
                icon: Icons.track_changes_rounded,
                accentColor: const Color(0xFFF59E0B),
                onTap: () => _navigateTo(const PlacementScreen(), title: "Placement Readiness"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPortalCard(
                title: "Certificates",
                value: "$certCount Earned",
                badgeText: "Verified",
                badgeColor: const Color(0xFF0D9488),
                subtitle: "Blockchain backed",
                icon: Icons.workspace_premium_rounded,
                accentColor: const Color(0xFF0D9488),
                onTap: () => _navigateTo(const CertificatesScreen(), title: "My Certificates"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildPortalCard(
                title: "AI Academic Mentor",
                value: "Persistent Copilot",
                badgeText: "Online",
                badgeColor: const Color(0xFF3B82F6),
                subtitle: "DBMS & DSA Assistance",
                icon: Icons.smart_toy_outlined,
                accentColor: const Color(0xFF3B82F6),
                onTap: () => _navigateTo(const MentorChatScreen(), title: "AI Academic Mentor"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPortalCard(
                title: "Capstone Project",
                value: "AI Crop Health",
                badgeText: "65%",
                badgeColor: const Color(0xFF8B5CF6),
                subtitle: "Sem 5 Innovation",
                icon: Icons.terminal_rounded,
                accentColor: const Color(0xFF8B5CF6),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Capstone Project: AI Crop Health Analyzer (65% Completed)"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPortalCard({
    required String title,
    required String value,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badgeText,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: badgeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. ACADEMIC STANDING & BENCHMARKS
  // ===========================================================================
  Widget _buildAcademicStandingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.auto_graph_rounded,
                        color: Color(0xFF059669),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Academic Standing",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            "Attendance, syllabus & test performance",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF15803D)),
                    const SizedBox(width: 4),
                    Text(
                      "Good Standing",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF15803D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 1. Attendance Benchmark Row with Visual Progress
          _buildMetricProgressRow(
            label: "Attendance Average",
            valueText: "94.2%",
            badgeText: "Safe Zone (>75%)",
            progress: 0.942,
            accentColor: const Color(0xFF059669),
            icon: Icons.how_to_reg_rounded,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFFF1F5F9), height: 1),
          ),

          // 2. Syllabus Completion
          _buildMetricProgressRow(
            label: "Semester Syllabus",
            valueText: "68% completed",
            badgeText: "Target: 75% for IA2",
            progress: 0.68,
            accentColor: const Color(0xFF2563EB),
            icon: Icons.menu_book_rounded,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFFF1F5F9), height: 1),
          ),

          // 3. Department Rank & CGPA
          _buildMetricProgressRow(
            label: "Department Rank",
            valueText: "Rank #4 (Top 5% in CSE)",
            badgeText: "CGPA: 8.84 / 10",
            progress: 0.95,
            accentColor: const Color(0xFFD97706),
            icon: Icons.leaderboard_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricProgressRow({
    required String label,
    required String valueText,
    required String badgeText,
    required double progress,
    required Color accentColor,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, size: 17, color: accentColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              valueText,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            badgeText,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. SKILL MASTERY & CAPABILITY MATRIX
  // ===========================================================================
  Widget _buildSkillMasteryCard(dynamic student) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.psychology_rounded,
                        color: Color(0xFF4F46E5),
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Skills & Readiness Radar",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Aggregated",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSkillBar("Technical Coding & DSA", student.technicalSkills, const Color(0xFF2563EB)),
          const SizedBox(height: 12),
          _buildSkillBar("Career & Industry Readiness", student.careerReadiness, const Color(0xFF059669)),
          const SizedBox(height: 12),
          _buildSkillBar("Communication & Soft Skills", student.communicationSkills, const Color(0xFFD97706)),
          const SizedBox(height: 12),
          _buildSkillBar("Interview & Problem Solving", student.interviewSkills, const Color(0xFF7C3AED)),
        ],
      ),
    );
  }

  Widget _buildSkillBar(String skill, int score, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF334155),
              ),
            ),
            Text(
              "$score%",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: (score / 100.0).clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5. DIGITAL CREDENTIALS & STUDENT ID
  // ===========================================================================
  Widget _buildDigitalCredentialsCard(dynamic student) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.qr_code_2_rounded,
                        color: Color(0xFFD97706),
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Digital Credentials",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: student.rollNo.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Copied Roll No: ${student.rollNo}"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    children: [
                      const Icon(Icons.copy_rounded, size: 13, color: Color(0xFF2563EB)),
                      const SizedBox(width: 4),
                      Text(
                        "Copy Roll No",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.fingerprint_rounded, size: 28, color: Color(0xFF64748B)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Smart Campus Pass Active",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        "Valid for Library, Labs, Cafeteria & Campus Entry",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "ACTIVE",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF15803D),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. ACCOUNT & PREFERENCES CARD
  // ===========================================================================
  Widget _buildAccountPreferencesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account & Preferences",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          _buildSettingRow(
            icon: Icons.security_rounded,
            title: "Security & MFA",
            subtitle: "Two-factor authentication active",
            badge: "Enabled",
            badgeColor: const Color(0xFF059669),
          ),
          const Divider(color: Color(0xFFF1F5F9), height: 16),
          _buildSettingRow(
            icon: Icons.notifications_active_outlined,
            title: "Student Alerts & Deadlines",
            subtitle: "Daily timetable & IA exam alerts",
            badge: "Active",
            badgeColor: const Color(0xFF2563EB),
          ),
          const Divider(color: Color(0xFFF1F5F9), height: 16),
          _buildSettingRow(
            icon: Icons.logout_rounded,
            title: "Sign Out",
            subtitle: "Log out from this device",
            isDestructive: true,
            onTap: _confirmSignOut,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required String subtitle,
    String? badge,
    Color? badgeColor,
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isDestructive
                    ? const Color(0xFFFEE2E2)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isDestructive
                    ? const Color(0xFFDC2626)
                    : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: isDestructive
                          ? const Color(0xFFDC2626)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            if (badge != null && badgeColor != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
              ),
            if (onTap != null && !isDestructive)
              const Icon(Icons.chevron_right, size: 18, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}
