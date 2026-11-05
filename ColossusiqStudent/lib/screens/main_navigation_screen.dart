import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/app_colors.dart';
import '../core/widgets/portal_header.dart';
import '../core/widgets/portal_bottom_nav.dart';
import '../core/services/auth_session_service.dart';

// Core Student Tab Screens
import 'home/student_home_screen.dart';
import 'courses/courses_screen.dart';
import 'notes/class_notes_screen.dart';
import 'assignments/assignments_screen.dart';
import 'profile/profile_screen.dart';

// Overview Modules
import 'overview/student_fees_screen.dart';
import 'overview/notice_board_screen.dart';

// Student Success & Mentorship
import 'mentor/mentor_chat_screen.dart';
import 'mentor/ai_study_twin_screen.dart';
import 'mentor/ai_study_planner_screen.dart';
import 'mentor/daily_routine_screen.dart';
import 'mentor/academic_tracker_screen.dart';
import 'mentor/skill_graph_screen.dart';
import 'mentor/mission_planner_screen.dart';
import 'assessments/assessments_screen.dart';
import 'certificates/certificates_screen.dart';
import 'profile/digital_student_passport_screen.dart';
import 'certification/my_quizzes_screen.dart';

// Career Modules
import 'career/career_modules.dart';
import 'placement/placement_screen.dart';
import 'placement_modules/job_matching_screen.dart';

// Assessment Modules
import 'assessment/assessment_modules.dart';

// Academics & Innovation Modules
import 'academics/academic_calendar_screen.dart';
import 'communication/communication_modules.dart';
import 'innovation/innovation_modules.dart';
import 'campus_modules/campus_modules.dart';
import 'department/department_portal_screen.dart';

// Auth Screen
import 'auth/login_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  Widget? _activeSubScreen;
  String? _activeSubScreenTitle;
  Widget? _activeSubScreenBadge;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController _drawerController;
  late final Animation<double> _slideAnimation;
  bool _isDrawerOpen = false;

  final Map<String, bool> _expandedSections = {
    "OVERVIEW": true,
    "STUDENT SUCCESS": true,
    "ACADEMICS": true,
    "ASSESSMENT": true,
    "AI COURSE & CERTIFICATION": true,
    "CAREER": true,
    "COMMUNICATION & SKILLS": true,
    "PROJECT & INNOVATION": true,
    "CAMPUS LIFE": true,
    "DEPARTMENT": true,
    "PLACEMENT": true,
  };

  String _userRole = "Student";
  String _userName = "Anand R";
  String _userDesignation = "22CS104 · B.E. Computer Science";
  String _userCollege = "Anna Institute of Technology";
  final GlobalKey _avatarKey = GlobalKey();

  String get _avatarInitials {
    final trimmed = _userName.trim();
    if (trimmed.isEmpty) return "AR";
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts[0].substring(0, math.min(2, parts[0].length)).toUpperCase();
    }
    return (parts[0][0] + parts.last[0]).toUpperCase();
  }

  Future<void> _loadUserSession() async {
    final role = await AuthSessionService.getRole();
    final name = await AuthSessionService.getName();
    final desig = await AuthSessionService.getDesignation();
    final col = await AuthSessionService.getCollege();
    if (mounted) {
      setState(() {
        _userRole = role;
        _userName = name;
        _userDesignation = desig;
        _userCollege = col;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserSession();
    _drawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      reverseDuration: const Duration(milliseconds: 240),
    );

    _slideAnimation = CurvedAnimation(
      parent: _drawerController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  void _openDrawer() {
    if (!_isDrawerOpen) {
      _drawerController.forward();
      setState(() => _isDrawerOpen = true);
    }
  }

  void _closeDrawer() {
    if (_isDrawerOpen) {
      _drawerController.reverse();
      setState(() => _isDrawerOpen = false);
    }
  }

  void _toggleDrawer() {
    if (_isDrawerOpen) {
      _closeDrawer();
    } else {
      _openDrawer();
    }
  }

  void _showNotificationSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications_active_outlined,
                    color: AppColors.brand),
                const SizedBox(width: 8),
                Text(
                  "Recent Student Alerts",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildNotificationItem(
              "New Class Summary Available",
              "Dr. Meena shared ACID Properties notes with infographic handout.",
              "10 mins ago",
            ),
            _buildNotificationItem(
              "Upcoming IA-II Exam",
              "DBMS examination timetable confirmed for next Monday.",
              "2 hours ago",
            ),
            _buildNotificationItem(
              "Placement Drive Registration",
              "Freshworks 2026 campus hiring opens this Friday.",
              "Yesterday",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String desc, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: AppColors.brand,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  desc,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: AppColors.ink2,
                  ),
                ),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: AppColors.ink3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openSubScreen(Widget screen, {String? title, Widget? badge}) {
    if (_isDrawerOpen) {
      _closeDrawer();
    }
    setState(() {
      _activeSubScreen = screen;
      _activeSubScreenTitle = title;
      _activeSubScreenBadge = badge;
    });
  }

  void _closeSubScreen() {
    setState(() {
      _activeSubScreen = null;
      _activeSubScreenTitle = null;
      _activeSubScreenBadge = null;
    });
  }

  void _switchTab(int index) {
    if (_isDrawerOpen) {
      _closeDrawer();
    }
    setState(() {
      _activeSubScreen = null;
      _activeSubScreenTitle = null;
      _activeSubScreenBadge = null;
      _currentIndex = index;
    });
  }

  void _confirmAndSignOut() {
    if (_isDrawerOpen) {
      _closeDrawer();
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Sign Out",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColors.ink,
          ),
        ),
        content: Text(
          "Are you sure you want to sign out of StudentApp?",
          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.ink2),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppColors.ink3,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await AuthSessionService.signOut();
              if (!mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen(wasSignedOut: true)),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB42318),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: Text(
              "Sign Out",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProfilePopup(BuildContext context) {
    if (_isDrawerOpen) {
      _closeDrawer();
    }

    final RenderBox? box = _avatarKey.currentContext?.findRenderObject() as RenderBox?;
    Offset? avatarOffset;
    Size? avatarSize;
    if (box != null && box.hasSize) {
      avatarOffset = box.localToGlobal(Offset.zero);
      avatarSize = box.size;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;

    final double top = (avatarOffset != null && avatarSize != null)
        ? avatarOffset.dy + avatarSize.height + 8
        : (topPadding + 84);

    final double right = (avatarOffset != null && avatarSize != null)
        ? (screenWidth - (avatarOffset.dx + avatarSize.width)).clamp(12.0, screenWidth - 230)
        : 18.0;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Profile Popup",
      barrierColor: Colors.black.withValues(alpha: 0.15),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (ctx, anim1, anim2) {
        return Stack(
          children: [
            Positioned(
              top: top,
              right: right,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _userDesignation,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6F7F3),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "MFA verified · Student",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0D9488),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFF1F5F9),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _confirmAndSignOut();
                        },
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout_rounded,
                                color: Color(0xFFDC2626),
                                size: 19,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Sign out",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFDC2626),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (ctx, anim, secondaryAnim, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            alignment: Alignment.topRight,
            child: child,
          ),
        );
      },
    );
  }

  String get _currentSubtitle {
    if (_activeSubScreenTitle != null) {
      return _activeSubScreenTitle!;
    }
    switch (_currentIndex) {
      case 0:
        return "StudentApp · Scholar Indigo";
      case 1:
        return "Course Catalog";
      case 2:
        return "Class Notes";
      case 3:
        return "Assignments & Homework";
      case 4:
        return "Profile & Settings";
      default:
        return "StudentApp";
    }
  }

  Widget _buildBodyContent() {
    if (_activeSubScreen != null) {
      return _activeSubScreen!;
    }
    return IndexedStack(
      index: _currentIndex.clamp(0, 4),
      children: [
        StudentHomeScreen(onNavigateTab: _switchTab),
        const CoursesScreen(),
        ClassNotesScreen(onBack: () => _switchTab(0)),
        const AssignmentsScreen(),
        ProfileScreen(
          onOpenSubScreen: (screen, {title, badge}) =>
              _openSubScreen(screen, title: title, badge: badge),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth >= 1024;
    final drawerHeight = (screenHeight * 0.88).clamp(360.0, 840.0);
    final drawerWidth = isDesktop
        ? math.min(screenWidth * 0.65, 680.0)
        : (screenWidth >= 700 ? math.min(screenWidth * 0.85, 620.0) : screenWidth);
    final horizontalOffset = (screenWidth - drawerWidth) / 2;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedBuilder(
          animation: _drawerController,
          builder: (context, _) {
            final double progress = _slideAnimation.value;
            final double bottomOffset = -drawerHeight * (1.0 - progress);

            return Stack(
              children: [
                // 1. Full-screen Main Screen
                Positioned.fill(
                  child: Scaffold(
                    key: _scaffoldKey,
                    extendBody: true,
                    resizeToAvoidBottomInset: false,
                    backgroundColor: AppColors.bg,
                    appBar: PortalHeader(
                      title: "ColossusIQ",
                      subtitle: _currentSubtitle,
                      avatarInitials: _avatarInitials,
                      avatarKey: _avatarKey,
                      badge: _activeSubScreenBadge,
                      onBack: _activeSubScreen != null
                          ? _closeSubScreen
                          : (_currentIndex != 0 ? () => _switchTab(0) : null),
                      onMenuTap: _toggleDrawer,
                      onNotificationTap: _showNotificationSheet,
                      onProfileTap: () => _showProfilePopup(context),
                    ),
                    body: PopScope(
                      canPop: !_isDrawerOpen && _activeSubScreen == null && _currentIndex == 0,
                      onPopInvokedWithResult: (didPop, _) {
                        if (!didPop) {
                          if (_isDrawerOpen) {
                            _closeDrawer();
                          } else if (_activeSubScreen != null) {
                            _closeSubScreen();
                          } else if (_currentIndex != 0) {
                            _switchTab(0);
                          }
                        }
                      },
                      child: _buildBodyContent(),
                    ),
                    bottomNavigationBar: PortalBottomNav(
                      currentIndex: _activeSubScreen != null ? -1 : _currentIndex,
                      onTap: _switchTab,
                    ),
                  ),
                ),

                // 2. Backdrop Scrim
                if (progress > 0.001)
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _closeDrawer,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.50 * progress),
                      ),
                    ),
                  ),

                // 3. Bottom Slide-in Animated Drawer
                if (progress > 0.001)
                  Positioned(
                    left: horizontalOffset,
                    right: horizontalOffset,
                    bottom: bottomOffset,
                    height: drawerHeight,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.primaryDelta != null && details.primaryDelta! > 7) {
                          _closeDrawer();
                        }
                      },
                      child: _buildStudentDrawerContent(drawerWidth),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSquareDrawerWrapper({
    required Widget child,
    required double drawerWidth,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Container(
      width: drawerWidth,
      height: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 1.2,
          ),
          left: BorderSide(
            color: borderColor,
            width: 0.8,
          ),
          right: BorderSide(
            color: borderColor,
            width: 0.8,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 30,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 4),
                  width: 42,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentDrawerContent(double drawerWidth) {
    return _buildSquareDrawerWrapper(
      drawerWidth: drawerWidth,
      backgroundColor: const Color(0xFF13193A),
      borderColor: const Color(0xFF202A54),
      child: Column(
        children: [
          // Header: Brand & OS Title
          Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 8, 12),
            decoration: const BoxDecoration(
              color: Color(0xFF111736),
              border: Border(
                bottom: BorderSide(color: Color(0xFF202A54), width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF253060),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5A93C), width: 1.5),
                  ),
                  child: const Center(
                    child: Icon(Icons.school_rounded, color: Colors.white, size: 17),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ColossusIQ.ai",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "STUDENTAPP",
                        style: GoogleFonts.poppins(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF7E8EA6),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _closeDrawer,
                  icon: const Icon(Icons.close_rounded, color: Color(0xFF8B9BB4), size: 18),
                  splashRadius: 16,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  tooltip: "Close Menu",
                ),
              ],
            ),
          ),

          // Student ID Profile Card
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1B2349),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF2A3668),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5A93C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.account_balance_rounded,
                      color: Color(0xFF13193A),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userCollege.isNotEmpty ? _userCollege : "Anna Institute of Technology",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "$_userName · 22CS104 (CSE)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF8B9BB4),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _userRole.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFE5A93C),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Student Navigation Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                // Home (Active by default)
                _drawerItem(
                  icon: Icons.home_rounded,
                  title: "Home",
                  isActive: _activeSubScreen == null && _currentIndex == 0,
                  onTap: () => _switchTab(0),
                ),

                // 1. OVERVIEW
                _drawerSectionHeader("OVERVIEW"),
                if (_expandedSections["OVERVIEW"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.payment_outlined,
                    title: "Fees & Payments",
                    isActive: _activeSubScreenTitle == "Fees & Payments",
                    onTap: () => _openSubScreen(
                      StudentFeesScreen(onBack: _closeSubScreen),
                      title: "Fees & Payments",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.campaign_outlined,
                    title: "Notice Board",
                    isActive: _activeSubScreenTitle == "Notice Board",
                    onTap: () => _openSubScreen(
                      NoticeBoardScreen(onBack: _closeSubScreen),
                      title: "Notice Board",
                    ),
                  ),
                ],

                // 2. STUDENT SUCCESS
                _drawerSectionHeader("STUDENT SUCCESS"),
                if (_expandedSections["STUDENT SUCCESS"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.smart_toy_outlined,
                    title: "AI Mentor",
                    isActive: _activeSubScreenTitle == "AI Mentor",
                    onTap: () => _openSubScreen(
                      MentorChatScreen(onBack: _closeSubScreen),
                      title: "AI Mentor",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.calendar_month_outlined,
                    title: "AI Study Planner",
                    isActive: _activeSubScreenTitle == "AI Study Planner",
                    onTap: () => _openSubScreen(
                      AiStudyPlannerScreen(onBack: _closeSubScreen),
                      title: "AI Study Planner",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.schedule_outlined,
                    title: "Daily Routine",
                    isActive: _activeSubScreenTitle == "Daily Routine",
                    onTap: () => _openSubScreen(
                      DailyRoutineScreen(onBack: _closeSubScreen),
                      title: "Daily Routine",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.trending_up_rounded,
                    title: "Academic Tracker",
                    isActive: _activeSubScreenTitle == "Academic Tracker",
                    onTap: () => _openSubScreen(
                      AcademicTrackerScreen(onBack: _closeSubScreen),
                      title: "Academic Tracker",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.hub_outlined,
                    title: "Skill Graph",
                    isActive: _activeSubScreenTitle == "Skill Graph",
                    onTap: () => _openSubScreen(
                      SkillGraphScreen(onBack: _closeSubScreen),
                      title: "Skill Graph",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.track_changes_outlined,
                    title: "Mission Planner",
                    isActive: _activeSubScreenTitle == "Mission Planner",
                    onTap: () => _openSubScreen(
                      MissionPlannerScreen(onBack: _closeSubScreen),
                      title: "Mission Planner",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.psychology_outlined,
                    title: "AI Study Twin",
                    isActive: _activeSubScreenTitle == "AI Study Twin",
                    onTap: () => _openSubScreen(
                      AiStudyTwinScreen(onBack: _closeSubScreen),
                      title: "AI Study Twin",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.badge_outlined,
                    title: "Digital Student Passport",
                    isActive: _activeSubScreenTitle == "Digital Student Passport",
                    onTap: () => _openSubScreen(
                      DigitalStudentPassportScreen(onBack: _closeSubScreen),
                      title: "Digital Student Passport",
                    ),
                  ),
                ],

                // 3. ACADEMICS
                _drawerSectionHeader("ACADEMICS"),
                if (_expandedSections["ACADEMICS"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.menu_book_rounded,
                    title: "My Courses",
                    isActive: _activeSubScreen == null && _currentIndex == 1,
                    onTap: () => _switchTab(1),
                  ),
                  _drawerItem(
                    icon: Icons.notes_rounded,
                    title: "Class Notes",
                    isActive: _activeSubScreen == null && _currentIndex == 2,
                    onTap: () => _switchTab(2),
                  ),
                  _drawerItem(
                    icon: Icons.event_note_outlined,
                    title: "Academic Calendar",
                    isActive: _activeSubScreenTitle == "Academic Calendar",
                    onTap: () => _openSubScreen(
                      AcademicCalendarScreen(onBack: _closeSubScreen),
                      title: "Academic Calendar",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.assignment_outlined,
                    title: "Assignments",
                    isActive: _activeSubScreen == null && _currentIndex == 3,
                    onTap: () => _switchTab(3),
                  ),
                  _drawerItem(
                    icon: Icons.description_outlined,
                    title: "Document AI",
                    isActive: _activeSubScreenTitle == "Document AI",
                    onTap: () => _openSubScreen(
                      ExamPrepScreen(onBack: _closeSubScreen),
                      title: "Document AI",
                    ),
                  ),
                ],

                // 4. ASSESSMENT
                _drawerSectionHeader("ASSESSMENT"),
                if (_expandedSections["ASSESSMENT"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.assignment_turned_in_outlined,
                    title: "Mock Tests",
                    isActive: _activeSubScreenTitle == "Mock Tests",
                    onTap: () => _openSubScreen(
                      AssessmentsScreen(onBack: _closeSubScreen),
                      title: "Mock Tests",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.fact_check_outlined,
                    title: "Exam Preparation",
                    isActive: _activeSubScreenTitle == "Exam Preparation",
                    onTap: () => _openSubScreen(
                      ExamPrepScreen(onBack: _closeSubScreen),
                      title: "Exam Preparation",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.draw_outlined,
                    title: "Handwritten Evaluation",
                    isActive: _activeSubScreenTitle == "Handwritten Evaluation",
                    onTap: () => _openSubScreen(
                      HandwrittenEvaluationScreen(onBack: _closeSubScreen),
                      title: "Handwritten Evaluation",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.mic_none_outlined,
                    title: "Viva Simulator",
                    isActive: _activeSubScreenTitle == "Viva Simulator",
                    onTap: () => _openSubScreen(
                      VivaSimulatorScreen(onBack: _closeSubScreen),
                      title: "Viva Simulator",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.emoji_events_outlined,
                    title: "Competitive Exams",
                    isActive: _activeSubScreenTitle == "Competitive Exams",
                    onTap: () => _openSubScreen(
                      CompetitiveExamsScreen(onBack: _closeSubScreen),
                      title: "Competitive Exams",
                    ),
                  ),
                ],

                // 5. AI COURSE & CERTIFICATION
                _drawerSectionHeader("AI COURSE & CERTIFICATION"),
                if (_expandedSections["AI COURSE & CERTIFICATION"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.assignment_late_outlined,
                    title: "My Quizzes",
                    isActive: _activeSubScreenTitle == "My Quizzes",
                    onTap: () => _openSubScreen(
                      MyQuizzesScreen(onBack: _closeSubScreen),
                      title: "My Quizzes",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.badge_outlined,
                    title: "My Certificates",
                    isActive: _activeSubScreenTitle == "My Certificates",
                    onTap: () => _openSubScreen(
                      CertificatesScreen(onBack: _closeSubScreen),
                      title: "My Certificates",
                    ),
                  ),
                ],

                // 6. CAREER
                _drawerSectionHeader("CAREER"),
                if (_expandedSections["CAREER"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.explore_outlined,
                    title: "Career Planner & Twin",
                    isActive: _activeSubScreenTitle == "Career Planner & Twin",
                    onTap: () => _openSubScreen(
                      CareerPlannerScreen(onBack: _closeSubScreen),
                      title: "Career Planner & Twin",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.description_outlined,
                    title: "Resume Builder",
                    isActive: _activeSubScreenTitle == "Resume Builder",
                    onTap: () => _openSubScreen(
                      ResumeBuilderScreen(onBack: _closeSubScreen),
                      title: "Resume Builder",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.work_outline_rounded,
                    title: "Job Preparation",
                    isActive: _activeSubScreenTitle == "Job Preparation",
                    onTap: () => _openSubScreen(
                      JobPrepScreen(onBack: _closeSubScreen),
                      title: "Job Preparation",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.mic_external_on_outlined,
                    title: "AI Mock Interview",
                    isActive: _activeSubScreenTitle == "AI Mock Interview",
                    onTap: () => _openSubScreen(
                      MockInterviewScreen(onBack: _closeSubScreen),
                      title: "AI Mock Interview",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.storefront_outlined,
                    title: "Opportunity Marketplace",
                    isActive: _activeSubScreenTitle == "Opportunity Marketplace",
                    onTap: () => _openSubScreen(
                      OpportunityMarketplaceScreen(onBack: _closeSubScreen),
                      title: "Opportunity Marketplace",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.speed_outlined,
                    title: "Career Readiness",
                    isActive: _activeSubScreenTitle == "Career Readiness",
                    onTap: () => _openSubScreen(
                      CareerReadinessScreen(onBack: _closeSubScreen),
                      title: "Career Readiness",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.track_changes_outlined,
                    title: "Placement Readiness",
                    isActive: _activeSubScreenTitle == "Placement Readiness",
                    onTap: () => _openSubScreen(
                      PlacementScreen(onBack: _closeSubScreen),
                      title: "Placement Readiness",
                    ),
                  ),
                ],

                // 7. COMMUNICATION & SKILLS
                _drawerSectionHeader("COMMUNICATION & SKILLS"),
                if (_expandedSections["COMMUNICATION & SKILLS"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: "Communication Lab",
                    isActive: _activeSubScreenTitle == "Communication Lab",
                    onTap: () => _openSubScreen(
                      CommunicationLabScreen(onBack: _closeSubScreen),
                      title: "Communication Lab",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.groups_outlined,
                    title: "GD & Debate Simulator",
                    isActive: _activeSubScreenTitle == "GD & Debate Simulator",
                    onTap: () => _openSubScreen(
                      GdSimulatorScreen(onBack: _closeSubScreen),
                      title: "GD & Debate Simulator",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.translate_rounded,
                    title: "Language Learning",
                    isActive: _activeSubScreenTitle == "Language Learning",
                    onTap: () => _openSubScreen(
                      LanguageLearningScreen(onBack: _closeSubScreen),
                      title: "Language Learning",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.settings_suggest_outlined,
                    title: "Certification Roadmap",
                    isActive: _activeSubScreenTitle == "Certification Roadmap",
                    onTap: () => _openSubScreen(
                      CertificationRoadmapScreen(onBack: _closeSubScreen),
                      title: "Certification Roadmap",
                    ),
                  ),
                ],

                // 8. PROJECT & INNOVATION
                _drawerSectionHeader("PROJECT & INNOVATION"),
                if (_expandedSections["PROJECT & INNOVATION"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.lightbulb_outline_rounded,
                    title: "Project Hub",
                    isActive: _activeSubScreenTitle == "Project Hub",
                    onTap: () => _openSubScreen(
                      ProjectHubScreen(onBack: _closeSubScreen),
                      title: "Project Hub",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "Project Idea Generator",
                    isActive: _activeSubScreenTitle == "Project Idea Generator",
                    onTap: () => _openSubScreen(
                      ProjectIdeaGeneratorScreen(onBack: _closeSubScreen),
                      title: "Project Idea Generator",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.group_add_outlined,
                    title: "Team Finder",
                    isActive: _activeSubScreenTitle == "Team Finder",
                    onTap: () => _openSubScreen(
                      TeamFinderScreen(onBack: _closeSubScreen),
                      title: "Team Finder",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.rocket_launch_outlined,
                    title: "Startup Idea Hub",
                    isActive: _activeSubScreenTitle == "Startup Idea Hub",
                    onTap: () => _openSubScreen(
                      StartupIdeaHubScreen(onBack: _closeSubScreen),
                      title: "Startup Idea Hub",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.science_outlined,
                    title: "Research Assistant",
                    isActive: _activeSubScreenTitle == "Research Assistant",
                    onTap: () => _openSubScreen(
                      ResearchAssistantScreen(onBack: _closeSubScreen),
                      title: "Research Assistant",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.code_rounded,
                    title: "Hackathon Hub",
                    isActive: _activeSubScreenTitle == "Hackathon Hub",
                    onTap: () => _openSubScreen(
                      HackathonHubScreen(onBack: _closeSubScreen),
                      title: "Hackathon Hub",
                    ),
                  ),
                ],

                // 9. CAMPUS LIFE
                _drawerSectionHeader("CAMPUS LIFE"),
                if (_expandedSections["CAMPUS LIFE"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.celebration_outlined,
                    title: "Campus Events",
                    isActive: _activeSubScreenTitle == "Campus Events",
                    onTap: () => _openSubScreen(
                      CampusEventsScreen(onBack: _closeSubScreen),
                      title: "Campus Events",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.flag_outlined,
                    title: "Clubs",
                    isActive: _activeSubScreenTitle == "Clubs",
                    onTap: () => _openSubScreen(
                      ClubsScreen(onBack: _closeSubScreen),
                      title: "Clubs",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.sports_soccer_outlined,
                    title: "Sports",
                    isActive: _activeSubScreenTitle == "Sports",
                    onTap: () => _openSubScreen(
                      SportsScreen(onBack: _closeSubScreen),
                      title: "Sports",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.school_outlined,
                    title: "Campus Assistant",
                    isActive: _activeSubScreenTitle == "Campus Assistant",
                    onTap: () => _openSubScreen(
                      CampusAssistantScreen(onBack: _closeSubScreen),
                      title: "Campus Assistant",
                    ),
                  ),
                  _drawerItem(
                    icon: Icons.lan_outlined,
                    title: "Alumni Network",
                    isActive: _activeSubScreenTitle == "Alumni Network",
                    onTap: () => _openSubScreen(
                      AlumniNetworkScreen(onBack: _closeSubScreen),
                      title: "Alumni Network",
                    ),
                  ),
                ],

                // 10. DEPARTMENT
                _drawerSectionHeader("DEPARTMENT"),
                if (_expandedSections["DEPARTMENT"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.layers_outlined,
                    title: "Department Portal",
                    isActive: _activeSubScreenTitle == "Department Portal",
                    onTap: () => _openSubScreen(
                      DepartmentPortalScreen(onBack: _closeSubScreen),
                      title: "Department Portal",
                    ),
                  ),
                ],

                // 11. PLACEMENT
                _drawerSectionHeader("PLACEMENT"),
                if (_expandedSections["PLACEMENT"] ?? true) ...[
                  _drawerItem(
                    icon: Icons.handshake_outlined,
                    title: "Job Matching",
                    isActive: _activeSubScreenTitle == "Job Matching",
                    onTap: () => _openSubScreen(
                      JobMatchingScreen(onBack: _closeSubScreen),
                      title: "Job Matching",
                    ),
                  ),
                ],

                const Divider(color: Color(0xFF202A54), height: 20, indent: 12, endIndent: 12),
                _drawerItem(
                  icon: Icons.logout_rounded,
                  title: "Sign Out",
                  onTap: _confirmAndSignOut,
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerSectionHeader(String title) {
    final isExpanded = _expandedSections[title] ?? true;
    return InkWell(
      onTap: () {
        setState(() {
          _expandedSections[title] = !isExpanded;
        });
      },
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF7E8EA6),
                letterSpacing: 0.8,
              ),
            ),
            Icon(
              isExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
              color: const Color(0xFF7E8EA6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool? isActive,
  }) {
    final active = isActive ??
        (_activeSubScreen != null && _activeSubScreenTitle == title);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _closeDrawer();
            onTap();
          },
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: active ? const Color(0xFF1E2858) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: active
                  ? Border.all(
                      color: const Color(0xFFE5A93C).withValues(alpha: 0.6),
                      width: 1.2,
                    )
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.5),
            child: Row(
              children: [
                if (active)
                  Container(
                    width: 3.5,
                    height: 18,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5A93C),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                Icon(
                  icon,
                  size: 19,
                  color: active ? const Color(0xFFE5A93C) : const Color(0xFF8B9BB4),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                      color: active ? Colors.white : const Color(0xFFCBD5E1),
                    ),
                  ),
                ),
                if (active)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    margin: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5A93C).withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFE5A93C).withValues(alpha: 0.6),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "Active",
                      style: GoogleFonts.poppins(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE5A93C),
                      ),
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
