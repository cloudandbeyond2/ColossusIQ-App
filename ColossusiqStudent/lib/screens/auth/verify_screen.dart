import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/auth_session_service.dart';
import '../main_navigation_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String email;
  final String role;
  final String name;
  final String designation;
  final String college;

  const VerifyScreen({
    super.key,
    this.email = "student1@ait.edu.in",
    this.role = "Student",
    this.name = "Anand R",
    this.designation = "22CS104 · B.E. Computer Science",
    this.college = "Anna Institute of Technology",
  });

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen>
    with TickerProviderStateMixin {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isLoading = false;
  String? _errorMessage;
  int _resendCountdown = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
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

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _resendCountdown = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _entranceController.dispose();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentCode =>
      _controllers.map((c) => c.text.trim()).join();

  void _onDigitChanged(int index, String value) {
    setState(() => _errorMessage = null);

    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < 6; i++) {
        if (i < digits.length) {
          _controllers[i].text = digits[i];
        }
      }
      final nextFocus = digits.length < 6 ? digits.length : 5;
      _focusNodes[nextFocus].requestFocus();

      if (digits.length >= 6) {
        _handleVerify();
      }
      return;
    }

    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        if (_currentCode.length == 6) {
          _handleVerify();
        }
      }
    }
  }

  void _handleVerify() {
    if (_currentCode.length < 6) {
      setState(() {
        _errorMessage = "Please enter the 6-digit verification code.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    Future.delayed(const Duration(milliseconds: 600), () async {
      if (!mounted) return;

      await AuthSessionService.saveUserSession(
        role: widget.role,
        name: widget.name,
        designation: widget.designation,
        email: widget.email,
        college: widget.college,
      );

      if (!mounted) return;

      setState(() => _isLoading = false);

      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainNavigationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 940;

          if (isDesktop) {
            return Row(
              children: [
                // 1. LEFT SECURITY SHOWCASE (Full Height Blueprint Experience)
                Expanded(
                  flex: 42,
                  child: _buildDesktopSecurityShowcase(),
                ),

                // 2. RIGHT VERIFICATION FORM PANEL
                Expanded(
                  flex: 58,
                  child: _buildVerificationPanel(),
                ),
              ],
            );
          }

          // Mobile / Tablet Full-Screen Flow
          return _buildVerificationPanel();
        },
      ),
    );
  }

  // ===========================================================================
  // 1. DESKTOP LEFT SECURITY SHOWCASE PANEL
  // ===========================================================================
  Widget _buildDesktopSecurityShowcase() {
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

          // Watermark Shield Icon
          Positioned(
            right: -20,
            bottom: -30,
            child: Opacity(
              opacity: 0.06,
              child: const Icon(
                Icons.verified_user_rounded,
                size: 340,
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand
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
                        Icons.shield_rounded,
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

                // Title
                Text(
                  "Multi-Factor\nAuthentication.",
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  "Zero-trust credential verification with hardware-backed encryption, protecting institutional records, grades and personal data.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFFCBD5E1),
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 32),

                // Active Session Info Card
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ACTIVE SECURITY CONTEXT",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF93C5FD),
                              letterSpacing: 0.6,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "TLS 1.3 Active",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF34D399),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Attempting sign-in as ${widget.role} (${widget.name})",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.college} · Secure Campus Node",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // Security Badges
                Row(
                  children: [
                    const Icon(Icons.verified_user_rounded, size: 15, color: Color(0xFF34D399)),
                    const SizedBox(width: 6),
                    Text(
                      "ISO 27001 Certified Handshake",
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
  // 2. RIGHT VERIFICATION PANEL (FULL SCREEN RESPONSIVE)
  // ===========================================================================
  Widget _buildVerificationPanel() {
    return Container(
      color: const Color(0xFFFBFBFD),
      child: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 19,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Text(
                      "MFA VERIFICATION",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D4ED8),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Shield Icon
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: const Color(0xFFBFDBFE)),
                              ),
                              child: const Icon(
                                Icons.shield_rounded,
                                color: Color(0xFF2563EB),
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Heading
                            Text(
                              "Two-Factor Verification",
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Subtitle
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: 13.5,
                                  color: const Color(0xFF64748B),
                                  height: 1.45,
                                ),
                                children: [
                                  const TextSpan(text: "Enter the 6-digit code sent to "),
                                  TextSpan(
                                    text: widget.email,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Verification Box Card
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // 6 PIN Input Boxes
                                  _buildPinInputBoxes(),
                                  const SizedBox(height: 18),

                                  // Error Message
                                  if (_errorMessage != null) ...[
                                    Text(
                                      _errorMessage!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0xFFDC2626),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],

                                  // Countdown Timer / Resend Row
                                  _buildCountdownRow(),
                                  const SizedBox(height: 22),

                                  // Verify Action Button
                                  _buildVerifyButton(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Footer Note
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.lock_rounded, size: 14, color: Color(0xFF10B981)),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Protected by ColossusIQ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. PIN INPUT BOXES
  // ===========================================================================
  Widget _buildPinInputBoxes() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final boxWidth = ((availableWidth - 40) / 6).clamp(38.0, 56.0);
        const boxHeight = 58.0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            final isFilled = _controllers[index].text.isNotEmpty;
            final isFocused = _focusNodes[index].hasFocus;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                color: isFocused ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isFocused
                      ? const Color(0xFF2563EB)
                      : isFilled
                          ? const Color(0xFF0F172A)
                          : const Color(0xFFCBD5E1),
                  width: isFocused ? 2.0 : (isFilled ? 1.6 : 1.2),
                ),
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withValues(alpha: 0.20),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: false,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) => _onDigitChanged(index, val),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  // ===========================================================================
  // 5. COUNTDOWN & RESEND
  // ===========================================================================
  Widget _buildCountdownRow() {
    if (_resendCountdown > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.access_time_rounded, size: 15, color: Color(0xFF94A3B8)),
          const SizedBox(width: 6),
          Text(
            "Resend code in 00:${_resendCountdown.toString().padLeft(2, '0')}",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive code? ",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
        InkWell(
          onTap: _startCountdown,
          child: Text(
            "Resend Code",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2563EB),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. VERIFY ACTION BUTTON
  // ===========================================================================
  Widget _buildVerifyButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.30),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _handleVerify,
          borderRadius: BorderRadius.circular(14),
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
                      const Icon(Icons.verified_rounded, size: 18, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        "Verify & Continue",
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
}

// =============================================================================
// BLUEPRINT GRID PAINTER
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
