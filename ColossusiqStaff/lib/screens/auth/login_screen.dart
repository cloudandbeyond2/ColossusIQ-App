import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verify_screen.dart';

class RoleProfile {
  final String role;
  final String name;
  final String designation;
  final String email;
  final String password;
  final String college;
  final IconData icon;

  const RoleProfile({
    required this.role,
    required this.name,
    required this.designation,
    required this.email,
    required this.password,
    required this.college,
    required this.icon,
  });
}

class LoginScreen extends StatefulWidget {
  final bool wasSignedOut;

  const LoginScreen({
    super.key,
    this.wasSignedOut = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = true;
  String _selectedCollege = "Anna Institute of Technology";

  final List<String> _colleges = [
    "Anna Institute of Technology",
    "Kaveri Engineering College",
    "Kongu Arts & Science College",
    "CSM Institute of Technology",
    "Vaigai Polytechnic College",
  ];

  static const List<RoleProfile> _profiles = [
    // RoleProfile(
    //   role: "Student",
    //   name: "Anand R",
    //   designation: "22CS104 · B.E. Computer Science",
    //   email: "student1@ait.edu.in",
    //   password: "password123",
    //   college: "Anna Institute of Technology",
    //   icon: Icons.school_rounded,
    // ),
    RoleProfile(
      role: "Faculty",
      name: "Dr. Meena Raghavan",
      designation: "Asst. Professor · Computer Science",
      email: "demo@ait.edu.in",
      password: "password123",
      college: "Anna Institute of Technology",
      icon: Icons.person_rounded,
    ),
    RoleProfile(
      role: "HOD",
      name: "Dr. K. Senthil Kumar",
      designation: "Head of Department · CSE",
      email: "hod.cse@ait.edu.in",
      password: "password123",
      college: "Anna Institute of Technology",
      icon: Icons.account_balance_rounded,
    ),
    RoleProfile(
      role: "Placement Officer",
      name: "Ms. Priya Nair",
      designation: "Training & Placement Officer",
      email: "placement@ait.edu.in",
      password: "password123",
      college: "Anna Institute of Technology",
      icon: Icons.work_outline_rounded,
    ),
    RoleProfile(
      role: "Incubation Head",
      name: "Dr. Anita Sharma",
      designation: "Head · Innovation & Incubation",
      email: "incubation@ait.edu.in",
      password: "password123",
      college: "Anna Institute of Technology",
      icon: Icons.lightbulb_outline_rounded,
    ),
    RoleProfile(
      role: "Principal",
      name: "Dr. V. Ramanathan",
      designation: "Principal & Academic Dean",
      email: "principal@ait.edu.in",
      password: "password123",
      college: "Anna Institute of Technology",
      icon: Icons.workspace_premium_rounded,
    ),
  ];

  late RoleProfile _selectedProfile;

  @override
  void initState() {
    super.initState();
    _selectedProfile = _profiles.firstWhere(
      (p) => p.role == "Faculty",
      orElse: () => _profiles.first,
    );
    _emailController = TextEditingController(text: _selectedProfile.email);
    _passwordController = TextEditingController(text: _selectedProfile.password);

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _selectRole(RoleProfile p) {
    setState(() {
      _selectedProfile = p;
      _emailController.text = p.email;
      _passwordController.text = p.password;
    });
  }

  void _handleSignIn() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 550), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => VerifyScreen(
            email: _emailController.text.trim().isNotEmpty
                ? _emailController.text.trim()
                : _selectedProfile.email,
            role: _selectedProfile.role,
            name: _selectedProfile.name,
            designation: _selectedProfile.designation,
            college: _selectedCollege,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.05);
            const end = Offset.zero;
            const curve = Curves.easeOutCubic;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 350),
        ),
      );
    });
  }

  void _showCollegePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: const Color(0xFF131838).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.account_balance_rounded, size: 18, color: Color(0xFF131838)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Select Campus / Institution",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ..._colleges.map((col) {
                  final isSelected = col == _selectedCollege;
                  return InkWell(
                    onTap: () {
                      setState(() => _selectedCollege = col);
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2E3A94) : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.school_rounded,
                            size: 18,
                            color: isSelected ? const Color(0xFF2E3A94) : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              col,
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? const Color(0xFF131838) : const Color(0xFF334155),
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: Color(0xFF2E3A94),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 940;

          if (isDesktop) {
            return Row(
              children: [
                // 1. LEFT BLUEPRINT BRAND SHOWCASE PANEL (DESKTOP)
                Expanded(
                  flex: 44,
                  child: _buildDesktopLeftShowcase(),
                ),

                // 2. RIGHT LOGIN FORM PANEL
                Expanded(
                  flex: 56,
                  child: _buildFormPanel(isDesktop: true),
                ),
              ],
            );
          }

          // Single Column Responsive for Mobile & Tablet
          return _buildFormPanel(isDesktop: false);
        },
      ),
    );
  }

  // ===========================================================================
  // 1. LEFT BLUEPRINT BRAND SHOWCASE PANEL (DESKTOP)
  // ===========================================================================
  Widget _buildDesktopLeftShowcase() {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF131838), Color(0xFF1B2358), Color(0xFF232D6E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Blueprint grid overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _BlueprintDarkGridPainter(),
            ),
          ),

          // Faint Background Watermark Icon
          Positioned(
            right: -24,
            bottom: -30,
            child: Opacity(
              opacity: 0.05,
              child: const Icon(
                Icons.account_balance_rounded,
                size: 380,
                color: Colors.white,
              ),
            ),
          ),

          // Content Inside Showcase
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand Header with Golden Squircle
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.20),
                          width: 1.2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.account_balance_rounded,
                          color: Color(0xFFFBBF24),
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Colossus",
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              TextSpan(
                                text: "IQ",
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFBBF24),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "COLLEGE MANAGEMENT SYSTEM",
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withValues(alpha: 0.75),
                                letterSpacing: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),

                // Headline & Subtitle
                Text(
                  "Unified College\nManagement Portal.",
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.22,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "Empowering students, faculty, heads of departments, placement cell, and college administration with unified digital workflows.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFFCBD5E1),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),

                // Live Role Feature Pills
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildPillFeature(Icons.school_rounded, "Student Learning"),
                    _buildPillFeature(Icons.menu_book_rounded, "Faculty Academics"),
                    _buildPillFeature(Icons.analytics_rounded, "HOD Department Insights"),
                    _buildPillFeature(Icons.work_rounded, "Placement Drives"),
                    _buildPillFeature(Icons.workspace_premium_rounded, "Principal Governance"),
                  ],
                ),
                const SizedBox(height: 28),

                // Active Profile Quote Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\"Seamless portal switching across all academic, departmental, examination, and placement operations.\"",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.white.withValues(alpha: 0.92),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBBF24),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _selectedProfile.icon,
                              size: 18,
                              color: const Color(0xFF131838),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_selectedProfile.name} · ${_selectedProfile.role}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${_selectedProfile.designation} · ${_selectedProfile.college}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // Bottom Security Compliance Badges
                Row(
                  children: [
                    const Icon(Icons.verified_user_rounded, size: 15, color: Color(0xFF34D399)),
                    const SizedBox(width: 6),
                    Text(
                      "College Cloud Security",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFFCBD5E1)),
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.lock_rounded, size: 14, color: Color(0xFF34D399)),
                    const SizedBox(width: 6),
                    Text(
                      "Role-Based Access Control",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFFCBD5E1)),
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

  Widget _buildPillFeature(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFFFBBF24)),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. RIGHT LOGIN FORM PANEL (FULL SCREEN RESPONSIVE)
  // ===========================================================================
  Widget _buildFormPanel({required bool isDesktop}) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 20,
              vertical: isDesktop ? 36 : 24,
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    children: [
                      // MOBILE HERO BANNER (When not on desktop)
                      if (!isDesktop) ...[
                        _buildMobileHeroBanner(),
                        const SizedBox(height: 16),
                      ],

                      // MAIN CARD CONTAINER
                      Container(
                        padding: EdgeInsets.all(isDesktop ? 34 : 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A0F172A),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Desktop-only Card Header
                              if (isDesktop) ...[
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFECFDF5),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: const Color(0xFFA7F3D0)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF059669),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "MULTI-ROLE ACCESS",
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF047857),
                                              letterSpacing: 0.6,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "v2.4",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  "Campus Portal Sign In",
                                  style: GoogleFonts.poppins(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF0F172A),
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Select your portal role below to sign in to your dashboard.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: const Color(0xFF64748B),
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: 18),
                              ],

                              // 1. ALL ROLE SELECTOR SECTION
                              _buildAllRoleSelector(),
                              const SizedBox(height: 16),

                              // 3. CAMPUS SELECTOR
                              _buildCampusSelector(),
                              const SizedBox(height: 16),

                              // 4. EMAIL FIELD
                              _buildEmailField(),
                              const SizedBox(height: 16),

                              // 5. PASSWORD FIELD
                              _buildPasswordField(),
                              const SizedBox(height: 14),

                              // Remember Me & Forgot Password row
                              Row(
                                children: [
                                  SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged: (val) {
                                        setState(() => _rememberMe = val ?? true);
                                      },
                                      activeColor: const Color(0xFF2E3A94),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => _rememberMe = !_rememberMe);
                                    },
                                    child: Text(
                                      "Remember this device",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0xFF475569),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Need assistance?",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2E3A94),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),

                              // Primary Continue Button
                              _buildSignInButton(),
                              const SizedBox(height: 12),

                              // SSO Button
                              _buildSsoButton(),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Footer copyright
                      Center(
                        child: Text(
                          "© 2026 ColossusIQ · Secure Multi-Role College & Campus Management Platform",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // MOBILE HERO BANNER (When not on desktop)
  // ===========================================================================
  Widget _buildMobileHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF131838),
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF131838),
            Color(0xFF1B2358),
            Color(0xFF232D6E),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131838).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintDarkGridPainter(),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -15,
              child: Opacity(
                opacity: 0.06,
                child: const Icon(
                  Icons.account_balance_rounded,
                  size: 140,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.20),
                        width: 1.2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.account_balance_rounded,
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
                        Row(
                          children: [
                            Text(
                              "ColossusIQ",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "ALL ROLES",
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF6EE7B7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "College Portal Authentication",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
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
  // 3. ALL ROLE SELECTOR SECTION (Chips with Icons for Student, Faculty, HOD, etc.)
  // ===========================================================================
  Widget _buildAllRoleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Select Portal Role",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "6 ROLES AVAILABLE",
                style: GoogleFonts.poppins(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFB45309),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _profiles.map((p) {
            final isSelected = p.role == _selectedProfile.role;
            return InkWell(
              onTap: () => _selectRole(p),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFF131838), Color(0xFF2E3A94)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF131838) : const Color(0xFFE2E8F0),
                    width: isSelected ? 1.4 : 1.0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF131838).withValues(alpha: 0.24),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      p.icon,
                      size: 14,
                      color: isSelected ? const Color(0xFFFBBF24) : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      p.role,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }



  // ===========================================================================
  // 5. CAMPUS SELECTOR
  // ===========================================================================
  Widget _buildCampusSelector() {
    return InkWell(
      onTap: _showCollegePicker,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFDE68A)),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFD97706),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Campus: ",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF78350F),
                      ),
                    ),
                    TextSpan(
                      text: _selectedCollege,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF78350F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.unfold_more_rounded,
              size: 18,
              color: Color(0xFFB45309),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 6. EMAIL FIELD
  // ===========================================================================
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "College Email / User ID",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "Enter email or ID",
            hintStyle: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF94A3B8),
            ),
            prefixIcon: const Icon(
              Icons.alternate_email_rounded,
              size: 18,
              color: Color(0xFF64748B),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2E3A94), width: 1.8),
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return "Please enter your college email or ID";
            }
            return null;
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 7. PASSWORD FIELD
  // ===========================================================================
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: "••••••••••••",
            hintStyle: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF94A3B8),
            ),
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              size: 18,
              color: Color(0xFF64748B),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 19,
                color: const Color(0xFF64748B),
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2E3A94), width: 1.8),
            ),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your password";
            }
            return null;
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 8. SIGN IN PRIMARY ACTION (Deep Navy Blueprint Button)
  // ===========================================================================
  Widget _buildSignInButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B2358), Color(0xFF2E3A94)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2358).withValues(alpha: 0.32),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _handleSignIn,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign in as ${_selectedProfile.role}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 9. INSTITUTION SSO BUTTON
  // ===========================================================================
  Widget _buildSsoButton() {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleSignIn,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shield_outlined,
                  size: 17,
                  color: Color(0xFF131838),
                ),
                const SizedBox(width: 8),
                Text(
                  "Sign in with College SSO",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

// =============================================================================
// BLUEPRINT GRID PAINTER FOR DESKTOP SHOWCASE & MOBILE HEADER
// =============================================================================
class _BlueprintDarkGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.055)
      ..strokeWidth = 1.0;

    const double step = 24.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
