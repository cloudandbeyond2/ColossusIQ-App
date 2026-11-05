import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verify_screen.dart';

class StudentProfile {
  final String role;
  final String name;
  final String designation;
  final String email;
  final String password;
  final String college;

  const StudentProfile({
    required this.role,
    required this.name,
    required this.designation,
    required this.email,
    required this.password,
    required this.college,
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

  static const StudentProfile defaultStudent = StudentProfile(
    role: "Student",
    name: "Anand R",
    designation: "22CS104 · B.E. Computer Science",
    email: "student1@ait.edu.in",
    password: "password123",
    college: "Anna Institute of Technology",
  );

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: defaultStudent.email);
    _passwordController = TextEditingController(text: defaultStudent.password);

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.06),
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
                : defaultStudent.email,
            role: "Student",
            name: defaultStudent.name,
            designation: defaultStudent.designation,
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
                    Text(
                      "Select Campus / Institution",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF93C5FD) : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.school_rounded,
                            size: 18,
                            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              col,
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF334155),
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: Color(0xFF2563EB),
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
                // 1. LEFT BRAND SHOWCASE PANEL
                Expanded(
                  flex: 42,
                  child: _buildDesktopLeftShowcase(),
                ),

                // 2. RIGHT LOGIN FORM PANEL
                Expanded(
                  flex: 58,
                  child: _buildFormPanel(isDesktop: true),
                ),
              ],
            );
          }

          // Single Column for Mobile & Tablet (Full Screen Responsive)
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
          colors: [Color(0xFF0A1647), Color(0xFF0F2475), Color(0xFF1E3A8A)],
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
            right: -20,
            bottom: -30,
            child: Opacity(
              opacity: 0.06,
              child: const Icon(
                Icons.school_rounded,
                size: 340,
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
                // Brand Header
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Color(0xFFFBBF24),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Colossus",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: "IQ",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF60A5FA),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Headline & Subtitle
                Text(
                  "ColossusIQ StudentApp.",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.25,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "All your coursework, AI study twin, class notes, mock tests, and career placement readiness in one intelligent unified portal.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFFCBD5E1),
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 32),

                // Student Testimonial Quote Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\"ColossusIQ keeps all my lecture notes, AI mock tests, lab submissions, and placement roadmap organized in one single app.\"",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.white.withValues(alpha: 0.9),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 14,
                            backgroundColor: Color(0xFFFBBF24),
                            child: Icon(Icons.person_rounded, size: 16, color: Color(0xFF0F172A)),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Anand R · 22CS104",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "B.E. Computer Science · Anna Institute of Technology",
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
                      "StudentApp Verified",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFFCBD5E1)),
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.lock_rounded, size: 14, color: Color(0xFF34D399)),
                    const SizedBox(width: 6),
                    Text(
                      "TLS 1.3 Encryption",
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

  // ===========================================================================
  // 2. RIGHT LOGIN FORM PANEL (FULL SCREEN RESPONSIVE)
  // ===========================================================================
  Widget _buildFormPanel({required bool isDesktop}) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 460;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : (isNarrow ? 16 : 24),
                vertical: isDesktop ? 32 : 18,
              ),
              child: Align(
                alignment: isDesktop ? Alignment.center : Alignment.topCenter,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 1. TOP HERO BLUEPRINT BANNER
                          _buildStudentPortalBanner(),
                          const SizedBox(height: 16),

                          // 2. MAIN LOGIN CARD CONTAINER
                          Container(
                            padding: EdgeInsets.all(isNarrow ? 20 : 28),
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
                                  // Card Top Role Badge Row
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEFF6FF),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: const Color(0xFFBFDBFE)),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF2563EB),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "STUDENT ACCESS",
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF1D4ED8),
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

                                  // Card Title & Subtitle
                                  Text(
                                    "Student Portal Sign In",
                                    style: GoogleFonts.poppins(
                                      fontSize: isNarrow ? 22 : 24,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF0F172A),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Sign in with your student register number or college email.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color(0xFF64748B),
                                      height: 1.45,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Campus Selector Dropdown Card
                                  _buildCampusSelector(),
                                  const SizedBox(height: 16),

                                  // Email Field
                                  _buildEmailField(),
                                  const SizedBox(height: 16),

                                  // Password Field
                                  _buildPasswordField(),
                                  const SizedBox(height: 14),

                                  // Remember Me & Forgot Password Row
                                  _buildRememberForgotRow(),
                                  const SizedBox(height: 20),

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

                          // 3. FOOTER COPYRIGHT
                          Center(
                            child: Text(
                              "© 2026 ColossusIQ · Secure Student Portal Access",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================================
  // REMEMBER ME & FORGOT PASSWORD ROW
  // ===========================================================================
  Widget _buildRememberForgotRow() {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (val) {
              setState(() => _rememberMe = val ?? true);
            },
            activeColor: const Color(0xFF2563EB),
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
            "Remember me",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF475569),
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Password reset link sent to your student email.",
                  style: GoogleFonts.poppins(fontSize: 12.5),
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: const Color(0xFF131838),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Text(
            "Forgot password?",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2563EB),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // STUDENT PORTAL HERO BANNER
  // ===========================================================================
  Widget _buildStudentPortalBanner() {
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
            // Blueprint Dark Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintDarkGridPainter(),
              ),
            ),

            // Decorative Vertical Capsule Pills (Right side)
            Positioned(
              right: 18,
              top: 12,
              bottom: 12,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.only(left: 6),
                    width: 14,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.045),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ),

            // Faint Institution Watermark
            Positioned(
              right: -10,
              bottom: -15,
              child: Opacity(
                opacity: 0.06,
                child: const Icon(
                  Icons.account_balance_rounded,
                  size: 130,
                  color: Colors.white,
                ),
              ),
            ),

            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: [
                  // Gold Squircle Icon Container
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

                  // Brand Title & Student Portal Badge
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Text(
                              "ColossusIQ",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.4),
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                "STUDENT PORTAL",
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF6EE7B7),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Student Portal Login",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
  // 4. CAMPUS SELECTOR
  // ===========================================================================
  Widget _buildCampusSelector() {
    return InkWell(
      onTap: _showCollegePicker,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
  // 5. EMAIL FIELD
  // ===========================================================================
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Student Email / Register No.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
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
            hintText: "student1@ait.edu.in or 22CS104",
            hintStyle: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF94A3B8),
            ),
            prefixIcon: const Icon(
              Icons.alternate_email_rounded,
              size: 19,
              color: Color(0xFF64748B),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.8),
            ),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return "Please enter your student email or roll number";
            }
            return null;
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. PASSWORD FIELD
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
            color: const Color(0xFF334155),
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
              size: 19,
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
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.8),
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
  // 7. SIGN IN PRIMARY ACTION
  // ===========================================================================
  Widget _buildSignInButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.30),
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
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Sign in to StudentApp",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 8. INSTITUTION SSO BUTTON
  // ===========================================================================
  Widget _buildSsoButton() {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBD5E1)),
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
                  color: Color(0xFF334155),
                ),
                const SizedBox(width: 8),
                Text(
                  "Sign in with Student SSO",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
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
// BLUEPRINT GRID PAINTER FOR DESKTOP SHOWCASE
// =============================================================================
class _BlueprintDarkGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const double step = 28.0;

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
