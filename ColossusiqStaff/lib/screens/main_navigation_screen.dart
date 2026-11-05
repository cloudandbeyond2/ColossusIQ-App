import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/portal_header.dart';
import '../core/widgets/portal_bottom_nav.dart';
import 'home/student_home_screen.dart';
import 'courses/courses_screen.dart';
import 'notes/class_notes_screen.dart';
import 'placement/placement_screen.dart';
import 'mentor/mentor_chat_screen.dart';
import 'mentor/ai_study_planner_screen.dart';
import 'mentor/daily_routine_screen.dart';
import 'mentor/academic_tracker_screen.dart';
import 'mentor/skill_graph_screen.dart';
import 'mentor/mission_planner_screen.dart';
import 'assessments/assessments_screen.dart';
import 'certificates/certificates_screen.dart';
import 'assignments/assignments_screen.dart';
import 'profile/profile_screen.dart';

import 'assessment/assessment_modules.dart';
import 'certification/my_quizzes_screen.dart';
import 'career/career_modules.dart';
import 'communication/communication_modules.dart';
import 'innovation/innovation_modules.dart';
import 'campus_modules/campus_modules.dart';
import 'package:flutter/services.dart';
import 'department/department_portal_screen.dart';
import 'placement_modules/job_matching_screen.dart';
import 'auth/login_screen.dart';
import 'faculty/faculty_screens.dart';
import 'hod/hod_screens.dart';
import 'placement/placement_officer_screens.dart';
import 'incubation/incubation_screens.dart';
import 'principal/principal_screens.dart';
import '../core/services/auth_session_service.dart';

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
    "MAIN NAVIGATION": true,
    "MAIN": true,
    "OVERVIEW": true,
    "STUDENT SUCCESS": true,
    "UNIVERSITY": true,
    "ACADEMICS": true,
    "ASSESSMENT": true,
    "AI COURSE & CERTIFICATION": true,
    "COMMUNICATION & SKILLS": true,
    "PROJECT & INNOVATION": true,
    "CAMPUS LIFE": true,
    "FACULTY": true,
    "DEPARTMENT": true,
    "PLACEMENT": true,
    "STAFF & USERS": true,
    "INCUBATION": true,
    "ADMISSIONS": true,
    "COLLEGE WEBSITE": true,
    "PLATFORM": true,
    "INSTITUTION": true,
    "CAREER": true,
  };

  String _userRole = "Faculty";
  String _userName = "Dr. Meena Raghavan";
  String _userDesignation = "Asst. Professor, CSE";
  String _userCollege = "Anna Institute of Technology";
  final GlobalKey _avatarKey = GlobalKey();

  String get _avatarInitials {
    final trimmed = _userName.trim();
    if (trimmed.isEmpty) return "AK";
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts[0].substring(0, math.min(2, parts[0].length)).toUpperCase();
    }
    if ((parts[0].toLowerCase() == "dr." ||
            parts[0].toLowerCase() == "dr" ||
            parts[0].toLowerCase() == "prof." ||
            parts[0].toLowerCase() == "prof") &&
        parts.length >= 3) {
      return (parts[1][0] + parts.last[0]).toUpperCase();
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
              "Freshworks 2026 registration opens this Friday.",
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
          "Are you sure you want to sign out of the $_userRole Portal?",
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
                  width: 215,
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
                              _userRole,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
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
                                "MFA verified",
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
    if (_currentIndex == 0) {
      if (_userRole == "Principal") {
        return "Principal Portal · Higher-Education OS";
      }
      if (_userRole == "Incubation Head") {
        return "Incubation Portal · Higher-Education OS";
      }
      if (_userRole == "Placement Officer") {
        return "Placement Portal · Higher-Education OS";
      }
      if (_userRole == "HOD") {
        return "HOD Portal · Higher-Education OS";
      }
      if (_userRole == "Faculty") {
        return "Faculty Portal · Higher-Education OS";
      }
      return "StaffApp · Higher-Education OS";
    }
    switch (_currentIndex) {
      case 1:
        return _userRole == "Faculty" || _userRole == "HOD" || _userRole == "Principal"
            ? "Course Management"
            : "Course Catalog";
      case 2:
        return "Class Notes";
      case 3:
        return "Assignments & Homework";
      case 4:
        return "Profile & Settings";
      default:
        return "Higher-Education OS";
    }
  }

  Widget _buildHomeForRole() {
    if (_userRole == "Principal") {
      return PrincipalHomeScreen(
        onOpenSubScreen: (screen, {title, badge}) =>
            _openSubScreen(screen, title: title, badge: badge),
      );
    } else if (_userRole == "Incubation Head") {
      return IncubationHomeScreen(
        onOpenSubScreen: (screen, {title, badge}) =>
            _openSubScreen(screen, title: title, badge: badge),
      );
    } else if (_userRole == "Placement Officer") {
      return PlacementOfficerHomeScreen(
        onOpenSubScreen: (screen, {title, badge}) =>
            _openSubScreen(screen, title: title, badge: badge),
      );
    } else if (_userRole == "HOD") {
      return HodHomeScreen(
        onOpenSubScreen: (screen, {title, badge}) =>
            _openSubScreen(screen, title: title, badge: badge),
      );
    } else if (_userRole == "Faculty") {
      return FacultyHomeScreen(
        onOpenSubScreen: (screen, {title, badge}) =>
            _openSubScreen(screen, title: title, badge: badge),
      );
    }
    return StudentHomeScreen(
      onNavigateTab: _switchTab,
    );
  }

  Widget _buildCoursesForRole() {
    if (_userRole == "Faculty") {
      return CourseManagementScreen(
        onBack: () => _switchTab(0),
      );
    } else if (_userRole == "HOD") {
      return HodCourseManagementScreen(
        onBack: () => _switchTab(0),
      );
    } else if (_userRole == "Principal") {
      return PrincipalCourseManagementScreen(
        onBack: () => _switchTab(0),
      );
    }
    return const CoursesScreen();
  }

  Widget _buildNotesForRole() {
    return ClassNotesScreen(
      onBack: () => _switchTab(0),
    );
  }

  Widget _buildAssignmentsForRole() {
    if (_userRole == "Faculty" || _userRole == "HOD") {
      return FacultyAssignmentsScreen(
        onBack: () => _switchTab(0),
      );
    }
    return const AssignmentsScreen();
  }

  Widget _buildProfileForRole() {
    return ProfileScreen(
      onOpenSubScreen: (screen, {title, badge}) =>
          _openSubScreen(screen, title: title, badge: badge),
    );
  }

  Widget _buildBodyContent() {
    if (_activeSubScreen != null) {
      return _activeSubScreen!;
    }
    return IndexedStack(
      index: _currentIndex.clamp(0, 4),
      children: [
        _buildHomeForRole(),
        _buildCoursesForRole(),
        _buildNotesForRole(),
        _buildAssignmentsForRole(),
        _buildProfileForRole(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth >= 1024;
    // Bottom drawer height: 88% of screen height
    final drawerHeight = (screenHeight * 0.88).clamp(360.0, 840.0);
    // Responsive width: on desktop max 680px centered, on tablet max 620px, on mobile full width
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
            // Drawer slides up from the bottom: 0.0 when fully open, -drawerHeight when closed
            final double bottomOffset = -drawerHeight * (1.0 - progress);

            return Stack(
              children: [
                // 1. Full-screen Main Screen (clean, no horizontal shifts)
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

                // 2. Backdrop Scrim (Fades in smoothly, tap outside closes bottom drawer)
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
                      child: _userRole == "Principal"
                          ? _buildPrincipalDrawerContent(drawerWidth)
                          : _userRole == "Incubation Head"
                              ? _buildIncubationHeadDrawerContent(drawerWidth)
                              : _userRole == "Placement Officer"
                              ? _buildPlacementOfficerDrawerContent(drawerWidth)
                              : _userRole == "HOD"
                              ? _buildHodDrawerContent(drawerWidth)
                              : _userRole == "Faculty"
                                  ? _buildFacultyDrawerContent(drawerWidth)
                                  : _buildStudentDrawerContent(drawerWidth),
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
              // Grab handle indicator for bottom sheet
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
                        "CollossusIQ.ai",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "HIGHER-EDUCATION OS",
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

          // College Profile Card (Tamil Nadu Technical University / Student)
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
                        _userName.isNotEmpty && _userRole == "Student"
                            ? "$_userName · Tamil Nadu Technical Univ."
                            : (_userDesignation.isNotEmpty
                                ? _userDesignation
                                : "Tamil Nadu Technical University"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF8B9BB4),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "STUDENT",
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
                // Top Home Item (Active by default)
                _facultyDrawerItem(
                  icon: Icons.home_rounded,
                  title: "Home",
                  isActive: _activeSubScreen == null && _currentIndex == 0,
                  onTap: () => _switchTab(0),
                ),

                // 1. OVERVIEW
                _facultyDrawerSectionHeader("OVERVIEW"),
                if (_expandedSections["OVERVIEW"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.payment_outlined,
                    title: "Fees & Payments",
                    isActive: _activeSubScreenTitle == "Fees & Payments",
                    onTap: () => _openSubScreen(
                      PrincipalStudentFeesScreen(onBack: _closeSubScreen),
                      title: "Fees & Payments",
                    ),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("STUDENT SUCCESS"),
                if (_expandedSections["STUDENT SUCCESS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.smart_toy_outlined,
                    title: "AI Mentor",
                    isActive: _activeSubScreenTitle == "AI Mentor",
                    onTap: () => _openSubScreen(
                      MentorChatScreen(onBack: _closeSubScreen),
                      title: "AI Mentor",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.calendar_month_outlined,
                    title: "AI Study Planner",
                    isActive: _activeSubScreenTitle == "AI Study Planner",
                    onTap: () => _openSubScreen(
                      AiStudyPlannerScreen(onBack: _closeSubScreen),
                      title: "AI Study Planner",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.schedule_outlined,
                    title: "Daily Routine",
                    isActive: _activeSubScreenTitle == "Daily Routine",
                    onTap: () => _openSubScreen(
                      DailyRoutineScreen(onBack: _closeSubScreen),
                      title: "Daily Routine",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.trending_up_rounded,
                    title: "Academic Tracker",
                    isActive: _activeSubScreenTitle == "Academic Tracker",
                    onTap: () => _openSubScreen(
                      AcademicTrackerScreen(onBack: _closeSubScreen),
                      title: "Academic Tracker",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.hub_outlined,
                    title: "Skill Graph",
                    isActive: _activeSubScreenTitle == "Skill Graph",
                    onTap: () => _openSubScreen(
                      SkillGraphScreen(onBack: _closeSubScreen),
                      title: "Skill Graph",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.track_changes_outlined,
                    title: "Mission Planner",
                    isActive: _activeSubScreenTitle == "Mission Planner",
                    onTap: () => _openSubScreen(
                      MissionPlannerScreen(onBack: _closeSubScreen),
                      title: "Mission Planner",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.psychology_outlined,
                    title: "AI Study Twin",
                    isActive: _activeSubScreenTitle == "AI Study Twin",
                    onTap: () => _openSubScreen(
                      MentorChatScreen(onBack: _closeSubScreen),
                      title: "AI Study Twin",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.badge_outlined,
                    title: "Digital Student Passport",
                    isActive: _activeSubScreenTitle == "Digital Student Passport",
                    onTap: () => _openSubScreen(
                      CertificatesScreen(onBack: _closeSubScreen),
                      title: "Digital Student Passport",
                    ),
                  ),
                ],

                // 3. ACADEMICS
                _facultyDrawerSectionHeader("ACADEMICS"),
                if (_expandedSections["ACADEMICS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.menu_book_rounded,
                    title: "My Courses",
                    isActive: _activeSubScreen == null && _currentIndex == 1,
                    onTap: () => _switchTab(1),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.notes_rounded,
                    title: "Class Notes",
                    isActive: _activeSubScreen == null && _currentIndex == 2,
                    onTap: () => _switchTab(2),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.event_note_outlined,
                    title: "Academic Calendar",
                    isActive: _activeSubScreenTitle == "Academic Calendar",
                    onTap: () => _openSubScreen(
                      AcademicCalendarScreen(onBack: _closeSubScreen),
                      title: "Academic Calendar",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.assignment_outlined,
                    title: "Assignments",
                    isActive: _activeSubScreen == null && _currentIndex == 3,
                    onTap: () => _switchTab(3),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("ASSESSMENT"),
                if (_expandedSections["ASSESSMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.assignment_turned_in_outlined,
                    title: "Mock Tests",
                    isActive: _activeSubScreenTitle == "Mock Tests",
                    onTap: () => _openSubScreen(
                      AssessmentsScreen(onBack: _closeSubScreen),
                      title: "Mock Tests",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.fact_check_outlined,
                    title: "Exam Preparation",
                    isActive: _activeSubScreenTitle == "Exam Preparation",
                    onTap: () => _openSubScreen(
                      ExamPrepScreen(onBack: _closeSubScreen),
                      title: "Exam Preparation",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.draw_outlined,
                    title: "Handwritten Evaluation",
                    isActive: _activeSubScreenTitle == "Handwritten Evaluation",
                    onTap: () => _openSubScreen(
                      HandwrittenEvaluationScreen(onBack: _closeSubScreen),
                      title: "Handwritten Evaluation",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.mic_none_outlined,
                    title: "Viva Simulator",
                    isActive: _activeSubScreenTitle == "Viva Simulator",
                    onTap: () => _openSubScreen(
                      VivaSimulatorScreen(onBack: _closeSubScreen),
                      title: "Viva Simulator",
                    ),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("AI COURSE & CERTIFICATION"),
                if (_expandedSections["AI COURSE & CERTIFICATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.assignment_late_outlined,
                    title: "My Quizzes",
                    isActive: _activeSubScreenTitle == "My Quizzes",
                    onTap: () => _openSubScreen(
                      MyQuizzesScreen(onBack: _closeSubScreen),
                      title: "My Quizzes",
                    ),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("CAREER"),
                if (_expandedSections["CAREER"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.explore_outlined,
                    title: "Career Planner & Twin",
                    isActive: _activeSubScreenTitle == "Career Planner & Twin",
                    onTap: () => _openSubScreen(
                      CareerPlannerScreen(onBack: _closeSubScreen),
                      title: "Career Planner & Twin",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.description_outlined,
                    title: "Resume Builder",
                    isActive: _activeSubScreenTitle == "Resume Builder",
                    onTap: () => _openSubScreen(
                      ResumeBuilderScreen(onBack: _closeSubScreen),
                      title: "Resume Builder",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.work_outline_rounded,
                    title: "Job Preparation",
                    isActive: _activeSubScreenTitle == "Job Preparation",
                    onTap: () => _openSubScreen(
                      JobPrepScreen(onBack: _closeSubScreen),
                      title: "Job Preparation",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.mic_external_on_outlined,
                    title: "AI Mock Interview",
                    isActive: _activeSubScreenTitle == "AI Mock Interview",
                    onTap: () => _openSubScreen(
                      MockInterviewScreen(onBack: _closeSubScreen),
                      title: "AI Mock Interview",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.storefront_outlined,
                    title: "Opportunity Marketplace",
                    isActive: _activeSubScreenTitle == "Opportunity Marketplace",
                    onTap: () => _openSubScreen(
                      OpportunityMarketplaceScreen(onBack: _closeSubScreen),
                      title: "Opportunity Marketplace",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.speed_outlined,
                    title: "Career Readiness",
                    isActive: _activeSubScreenTitle == "Career Readiness",
                    onTap: () => _openSubScreen(
                      CareerReadinessScreen(onBack: _closeSubScreen),
                      title: "Career Readiness",
                    ),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("COMMUNICATION & SKILLS"),
                if (_expandedSections["COMMUNICATION & SKILLS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: "Communication Lab",
                    isActive: _activeSubScreenTitle == "Communication Lab",
                    onTap: () => _openSubScreen(
                      CommunicationLabScreen(onBack: _closeSubScreen),
                      title: "Communication Lab",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.groups_outlined,
                    title: "GD & Debate Simulator",
                    isActive: _activeSubScreenTitle == "GD & Debate Simulator",
                    onTap: () => _openSubScreen(
                      GdSimulatorScreen(onBack: _closeSubScreen),
                      title: "GD & Debate Simulator",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.translate_rounded,
                    title: "Language Learning",
                    isActive: _activeSubScreenTitle == "Language Learning",
                    onTap: () => _openSubScreen(
                      LanguageLearningScreen(onBack: _closeSubScreen),
                      title: "Language Learning",
                    ),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("PROJECT & INNOVATION"),
                if (_expandedSections["PROJECT & INNOVATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.lightbulb_outline_rounded,
                    title: "Project Hub",
                    isActive: _activeSubScreenTitle == "Project Hub",
                    onTap: () => _openSubScreen(
                      ProjectHubScreen(onBack: _closeSubScreen),
                      title: "Project Hub",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "Project Idea Generator",
                    isActive: _activeSubScreenTitle == "Project Idea Generator",
                    onTap: () => _openSubScreen(
                      ProjectIdeaGeneratorScreen(onBack: _closeSubScreen),
                      title: "Project Idea Generator",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.group_add_outlined,
                    title: "Team Finder",
                    isActive: _activeSubScreenTitle == "Team Finder",
                    onTap: () => _openSubScreen(
                      TeamFinderScreen(onBack: _closeSubScreen),
                      title: "Team Finder",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.rocket_launch_outlined,
                    title: "Startup Idea Hub",
                    isActive: _activeSubScreenTitle == "Startup Idea Hub",
                    onTap: () => _openSubScreen(
                      StartupIdeaHubScreen(onBack: _closeSubScreen),
                      title: "Startup Idea Hub",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.science_outlined,
                    title: "Research Assistant",
                    isActive: _activeSubScreenTitle == "Research Assistant",
                    onTap: () => _openSubScreen(
                      ResearchAssistantScreen(onBack: _closeSubScreen),
                      title: "Research Assistant",
                    ),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("CAMPUS LIFE"),
                if (_expandedSections["CAMPUS LIFE"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.celebration_outlined,
                    title: "Campus Events",
                    isActive: _activeSubScreenTitle == "Campus Events",
                    onTap: () => _openSubScreen(
                      CampusEventsScreen(onBack: _closeSubScreen),
                      title: "Campus Events",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.flag_outlined,
                    title: "Clubs",
                    isActive: _activeSubScreenTitle == "Clubs",
                    onTap: () => _openSubScreen(
                      ClubsScreen(onBack: _closeSubScreen),
                      title: "Clubs",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.sports_soccer_outlined,
                    title: "Sports",
                    isActive: _activeSubScreenTitle == "Sports",
                    onTap: () => _openSubScreen(
                      SportsScreen(onBack: _closeSubScreen),
                      title: "Sports",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.school_outlined,
                    title: "Campus Assistant",
                    isActive: _activeSubScreenTitle == "Campus Assistant",
                    onTap: () => _openSubScreen(
                      CampusAssistantScreen(onBack: _closeSubScreen),
                      title: "Campus Assistant",
                    ),
                  ),
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("DEPARTMENT"),
                if (_expandedSections["DEPARTMENT"] ?? true) ...[
                  _facultyDrawerItem(
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
                _facultyDrawerSectionHeader("PLACEMENT"),
                if (_expandedSections["PLACEMENT"] ?? true) ...[
                  _facultyDrawerItem(
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
                _facultyDrawerItem(
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

  Widget _buildFacultyDrawerContent(double drawerWidth) {
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
                        "CollossusIQ.ai",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "HIGHER-EDUCATION OS",
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

          // Scrollable Faculty Navigation Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Institution Card
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2349),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF253060), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5A93C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_rounded,
                            color: Color(0xFF111736),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _userCollege.length > 22
                                  ? "${_userCollege.substring(0, 20)}..."
                                  : _userCollege,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Tamil Nadu Technical Univer...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF8B9BB4),
                              ),
                            ),
                            Text(
                              "FACULTY",
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE5A93C),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Top: Home
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _closeDrawer();
                        setState(() {
                          _activeSubScreen = null;
                          _activeSubScreenTitle = null;
                          _activeSubScreenBadge = null;
                          _currentIndex = 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Color(0xFF222B55)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Border(
                                  left: BorderSide(color: Color(0xFFEAB308), width: 3.5),
                                )
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_rounded,
                              size: 19,
                              color: (_activeSubScreen == null && _currentIndex == 0)
                                  ? const Color(0xFFEAB308)
                                  : const Color(0xFF8B9BB4),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Home",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // 1. OVERVIEW
                _facultyDrawerSectionHeader("OVERVIEW"),
                if (_expandedSections["OVERVIEW"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.notifications_none_rounded,
                    title: "Notice Board",
                    onTap: () => _openSubScreen(
                      NoticeBoardScreen(onBack: _closeSubScreen),
                      title: "Notice Board",
                    ),
                  ),
                ],

                // 2. UNIVERSITY
                _facultyDrawerSectionHeader("UNIVERSITY"),
                if (_expandedSections["UNIVERSITY"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.layers_outlined,
                    title: "Curriculum Studio",
                    onTap: () => _openSubScreen(
                      CurriculumStudioScreen(onBack: _closeSubScreen),
                      title: "Curriculum Studio",
                    ),
                  ),
                ],

                // 3. ACADEMICS
                _facultyDrawerSectionHeader("ACADEMICS"),
                if (_expandedSections["ACADEMICS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.menu_book_rounded,
                    title: "Course Management",
                    onTap: () => _openSubScreen(
                      CourseManagementScreen(onBack: _closeSubScreen),
                      title: "Course Management",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.calendar_today_outlined,
                    title: "Academic Calendar",
                    onTap: () => _openSubScreen(
                      AcademicCalendarScreen(onBack: _closeSubScreen),
                      title: "Academic Calendar",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.assignment_outlined,
                    title: "Assignments",
                    onTap: () => _openSubScreen(
                      FacultyAssignmentsScreen(onBack: _closeSubScreen),
                      title: "Assignments",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.description_outlined,
                    title: "Document AI",
                    onTap: () => _openSubScreen(
                      DocumentAiScreen(onBack: _closeSubScreen),
                      title: "Document AI",
                    ),
                  ),
                ],

                // 4. ASSESSMENT
                _facultyDrawerSectionHeader("ASSESSMENT"),
                if (_expandedSections["ASSESSMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.draw_outlined,
                    title: "Handwritten Evaluation",
                    onTap: () => _openSubScreen(
                      FacultyHandwrittenEvaluationScreen(onBack: _closeSubScreen),
                      title: "Handwritten Evaluation",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "Exam Prep Studio",
                    onTap: () => _openSubScreen(
                      FacultyExamPrepScreen(onBack: _closeSubScreen),
                      title: "Exam Prep Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.article_outlined,
                    title: "Current Affairs Desk",
                    onTap: () => _openSubScreen(
                      CurrentAffairsDeskScreen(onBack: _closeSubScreen),
                      title: "Current Affairs Desk",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.storage_rounded,
                    title: "Question Bank",
                    onTap: () => _openSubScreen(
                      QuestionBankScreen(onBack: _closeSubScreen),
                      title: "Question Bank",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.fact_check_outlined,
                    title: "AI Evaluation Review",
                    onTap: () => _openSubScreen(
                      AiEvaluationReviewScreen(onBack: _closeSubScreen),
                      title: "AI Evaluation Review",
                    ),
                  ),
                ],

                // 5. AI COURSE & CERTIFICATION
                _facultyDrawerSectionHeader("AI COURSE & CERTIFICATION"),
                if (_expandedSections["AI COURSE & CERTIFICATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "AI Course Studio",
                    onTap: () => _openSubScreen(
                      AiCourseStudioScreen(onBack: _closeSubScreen),
                      title: "AI Course Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.quiz_outlined,
                    title: "AI Quiz Builder",
                    onTap: () => _openSubScreen(
                      AiQuizBuilderScreen(onBack: _closeSubScreen),
                      title: "AI Quiz Builder",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.military_tech_outlined,
                    title: "Issued Certificates",
                    isActive: _activeSubScreenTitle == "Issued Certificates",
                    onTap: () => _openSubScreen(
                      IssuedCertificatesScreen(onBack: _closeSubScreen),
                      title: "Issued Certificates",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.verified_outlined,
                    title: "Certificate Requests",
                    onTap: () => _openSubScreen(
                      CertificateRequestsScreen(onBack: _closeSubScreen),
                      title: "Certificate Requests",
                    ),
                  ),
                ],

                // 6. COMMUNICATION & SKILLS
                _facultyDrawerSectionHeader("COMMUNICATION & SKILLS"),
                if (_expandedSections["COMMUNICATION & SKILLS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.translate_rounded,
                    title: "Language Learning",
                    onTap: () => _openSubScreen(
                      FacultyLanguageLearningScreen(onBack: _closeSubScreen),
                      title: "Language Learning",
                    ),
                  ),
                ],

                // 7. PROJECT & INNOVATION
                _facultyDrawerSectionHeader("PROJECT & INNOVATION"),
                if (_expandedSections["PROJECT & INNOVATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.lightbulb_outline_rounded,
                    title: "Project Hub",
                    onTap: () => _openSubScreen(
                      FacultyProjectHubScreen(onBack: _closeSubScreen),
                      title: "Project Hub",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.science_outlined,
                    title: "Research Assistant",
                    onTap: () => _openSubScreen(
                      FacultyResearchAssistantScreen(onBack: _closeSubScreen),
                      title: "Research Assistant",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.assignment_turned_in_outlined,
                    title: "AI Project Review Board",
                    onTap: () => _openSubScreen(
                      AiProjectReviewBoardScreen(onBack: _closeSubScreen),
                      title: "AI Project Review Board",
                    ),
                  ),
                ],

                // 8. CAMPUS LIFE
                _facultyDrawerSectionHeader("CAMPUS LIFE"),
                if (_expandedSections["CAMPUS LIFE"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.celebration_outlined,
                    title: "Campus Events",
                    onTap: () => _openSubScreen(
                      FacultyCampusEventsScreen(onBack: _closeSubScreen),
                      title: "Campus Events",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    title: "AI Event Generator",
                    onTap: () => _openSubScreen(
                      AiEventGeneratorScreen(onBack: _closeSubScreen),
                      title: "AI Event Generator",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.star_outline_rounded,
                    title: "Experience Passport",
                    onTap: () => _openSubScreen(
                      FacultyExperiencePassportScreen(onBack: _closeSubScreen),
                      title: "Experience Passport",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.school_outlined,
                    title: "Campus Assistant",
                    onTap: () => _openSubScreen(
                      FacultyCampusAssistantScreen(onBack: _closeSubScreen),
                      title: "Campus Assistant",
                    ),
                  ),
                ],

                // 9. FACULTY
                _facultyDrawerSectionHeader("FACULTY"),
                if (_expandedSections["FACULTY"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.smart_toy_outlined,
                    title: "Faculty AI Copilot",
                    onTap: () => _openSubScreen(
                      FacultyAiCopilotScreen(onBack: _closeSubScreen),
                      title: "Faculty AI Copilot",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.explore_outlined,
                    title: "Course Roadmap",
                    onTap: () => _openSubScreen(
                      CourseRoadmapScreen(onBack: _closeSubScreen),
                      title: "Course Roadmap",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.school_outlined,
                    title: "My Classes",
                    onTap: () => _openSubScreen(
                      MyClassesScreen(onBack: _closeSubScreen),
                      title: "My Classes",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.groups_outlined,
                    title: "Students",
                    onTap: () => _openSubScreen(
                      FacultyStudentsScreen(onBack: _closeSubScreen),
                      title: "Students",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    title: "Question Paper Generator",
                    onTap: () => _openSubScreen(
                      QuestionPaperGeneratorScreen(onBack: _closeSubScreen),
                      title: "Question Paper Generator",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.cast_for_education_rounded,
                    title: "Teaching Studio",
                    onTap: () => _openSubScreen(
                      TeachingStudioScreen(onBack: _closeSubScreen),
                      title: "Teaching Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.military_tech_outlined,
                    title: "Faculty Skill Booster",
                    onTap: () => _openSubScreen(
                      FacultySkillBoosterScreen(onBack: _closeSubScreen),
                      title: "Faculty Skill Booster",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.insights_rounded,
                    title: "Class Performance",
                    onTap: () => _openSubScreen(
                      ClassPerformanceScreen(onBack: _closeSubScreen),
                      title: "Class Performance",
                    ),
                  ),
                ],

                // 10. DEPARTMENT
                _facultyDrawerSectionHeader("DEPARTMENT"),
                if (_expandedSections["DEPARTMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.warning_amber_rounded,
                    title: "Student Success & Early Warning",
                    onTap: () => _openSubScreen(
                      StudentSuccessEarlyWarningScreen(onBack: _closeSubScreen),
                      title: "Student Success & Early Warning",
                    ),
                  ),
                ],

                // 11. INSTITUTION
                _facultyDrawerSectionHeader("INSTITUTION"),
                if (_expandedSections["INSTITUTION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.gavel_rounded,
                    title: "Policy Assistant",
                    onTap: () => _openSubScreen(
                      PolicyAssistantScreen(onBack: _closeSubScreen),
                      title: "Policy Assistant",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.summarize_outlined,
                    title: "Reports",
                    isActive: _activeSubScreen != null &&
                        (_activeSubScreenTitle == "Department Reports" ||
                            _activeSubScreenTitle == "Reports"),
                    onTap: () => _openSubScreen(
                      FacultyReportsScreen(onBack: _closeSubScreen),
                      title: "Department Reports",
                    ),
                  ),
                ],

                const Divider(color: Color(0xFF202A54), height: 20, indent: 12, endIndent: 12),
                _facultyDrawerItem(
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

  Widget _buildHodDrawerContent(double drawerWidth) {
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
                        "CollossusIQ.ai",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "HIGHER-EDUCATION OS",
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

          // Scrollable HOD Navigation Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Institution Card
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2349),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF253060), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5A93C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_rounded,
                            color: Color(0xFF111736),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _userCollege.length > 22
                                  ? "${_userCollege.substring(0, 20)}..."
                                  : _userCollege,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Tamil Nadu Technical Univer...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF8B9BB4),
                              ),
                            ),
                            Text(
                              "HEAD OF DEPARTMENT",
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE5A93C),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Top: Home
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _closeDrawer();
                        setState(() {
                          _activeSubScreen = null;
                          _activeSubScreenTitle = null;
                          _activeSubScreenBadge = null;
                          _currentIndex = 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Color(0xFF222B55)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Border(
                                  left: BorderSide(color: Color(0xFFEAB308), width: 3.5),
                                )
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_rounded,
                              size: 19,
                              color: (_activeSubScreen == null && _currentIndex == 0)
                                  ? const Color(0xFFEAB308)
                                  : const Color(0xFF8B9BB4),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Home",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // 1. OVERVIEW
                _facultyDrawerSectionHeader("OVERVIEW"),
                if (_expandedSections["OVERVIEW"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.notifications_none_rounded,
                    title: "Notice Board",
                    onTap: () => _openSubScreen(
                      HodNoticeBoardScreen(onBack: _closeSubScreen),
                      title: "Notice Board",
                    ),
                  ),
                ],

                // 2. UNIVERSITY
                _facultyDrawerSectionHeader("UNIVERSITY"),
                if (_expandedSections["UNIVERSITY"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.layers_outlined,
                    title: "Curriculum Studio",
                    onTap: () => _openSubScreen(
                      HodCurriculumStudioScreen(onBack: _closeSubScreen),
                      title: "Curriculum Studio",
                    ),
                  ),
                ],

                // 3. ACADEMICS
                _facultyDrawerSectionHeader("ACADEMICS"),
                if (_expandedSections["ACADEMICS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.menu_book_rounded,
                    title: "Course Management",
                    onTap: () => _openSubScreen(
                      HodCourseManagementScreen(onBack: _closeSubScreen),
                      title: "Course Management",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.calendar_month_outlined,
                    title: "Academic Calendar",
                    onTap: () => _openSubScreen(
                      HodAcademicCalendarScreen(onBack: _closeSubScreen),
                      title: "Academic Calendar",
                    ),
                  ),
                ],

                // 4. ASSESSMENT
                _facultyDrawerSectionHeader("ASSESSMENT"),
                if (_expandedSections["ASSESSMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "Exam Prep Studio",
                    onTap: () => _openSubScreen(
                      HodExamPrepScreen(onBack: _closeSubScreen),
                      title: "Exam Prep Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.article_outlined,
                    title: "Current Affairs Desk",
                    onTap: () => _openSubScreen(
                      HodCurrentAffairsDeskScreen(onBack: _closeSubScreen),
                      title: "Current Affairs Desk",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.storage_rounded,
                    title: "Question Bank",
                    onTap: () => _openSubScreen(
                      HodQuestionBankScreen(onBack: _closeSubScreen),
                      title: "Question Bank",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.fact_check_outlined,
                    title: "AI Evaluation Review",
                    onTap: () => _openSubScreen(
                      HodAiEvaluationReviewScreen(onBack: _closeSubScreen),
                      title: "AI Evaluation Review",
                    ),
                  ),
                ],

                // 5. AI COURSE & CERTIFICATION
                _facultyDrawerSectionHeader("AI COURSE & CERTIFICATION"),
                if (_expandedSections["AI COURSE & CERTIFICATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "AI Course Studio",
                    onTap: () => _openSubScreen(
                      HodAiCourseStudioScreen(onBack: _closeSubScreen),
                      title: "AI Course Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.quiz_outlined,
                    title: "AI Quiz Builder",
                    onTap: () => _openSubScreen(
                      HodAiQuizBuilderScreen(onBack: _closeSubScreen),
                      title: "AI Quiz Builder",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.military_tech_outlined,
                    title: "Issued Certificates",
                    isActive: _activeSubScreenTitle == "Issued Certificates",
                    onTap: () => _openSubScreen(
                      HodIssuedCertificatesScreen(onBack: _closeSubScreen),
                      title: "Issued Certificates",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.verified_outlined,
                    title: "Certificate Requests",
                    onTap: () => _openSubScreen(
                      HodCertificateRequestsScreen(onBack: _closeSubScreen),
                      title: "Certificate Requests",
                    ),
                  ),
                ],

                // 6. PROJECT & INNOVATION
                _facultyDrawerSectionHeader("PROJECT & INNOVATION"),
                if (_expandedSections["PROJECT & INNOVATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.assignment_turned_in_outlined,
                    title: "AI Project Review Board",
                    onTap: () => _openSubScreen(
                      HodProjectReviewBoardScreen(onBack: _closeSubScreen),
                      title: "AI Project Review Board",
                    ),
                  ),
                ],

                // 7. CAMPUS LIFE
                _facultyDrawerSectionHeader("CAMPUS LIFE"),
                if (_expandedSections["CAMPUS LIFE"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.celebration_outlined,
                    title: "Campus Events",
                    onTap: () => _openSubScreen(
                      HodCampusEventsScreen(onBack: _closeSubScreen),
                      title: "Campus Events",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    title: "AI Event Generator",
                    onTap: () => _openSubScreen(
                      HodAiEventGeneratorScreen(onBack: _closeSubScreen),
                      title: "AI Event Generator",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.star_outline_rounded,
                    title: "Experience Passport",
                    onTap: () => _openSubScreen(
                      HodExperiencePassportScreen(onBack: _closeSubScreen),
                      title: "Experience Passport",
                    ),
                  ),
                ],

                // 8. FACULTY
                _facultyDrawerSectionHeader("FACULTY"),
                if (_expandedSections["FACULTY"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.explore_outlined,
                    title: "Course Roadmap",
                    onTap: () => _openSubScreen(
                      HodCourseRoadmapScreen(onBack: _closeSubScreen),
                      title: "Course Roadmap",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.groups_outlined,
                    title: "Students",
                    onTap: () => _openSubScreen(
                      HodStudentsScreen(onBack: _closeSubScreen),
                      title: "Students",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    title: "Question Paper Generator",
                    onTap: () => _openSubScreen(
                      HodQuestionPaperGeneratorScreen(onBack: _closeSubScreen),
                      title: "Question Paper Generator",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.cast_for_education_rounded,
                    title: "Teaching Studio",
                    onTap: () => _openSubScreen(
                      HodTeachingStudioScreen(onBack: _closeSubScreen),
                      title: "Teaching Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.military_tech_outlined,
                    title: "Faculty Skill Booster",
                    onTap: () => _openSubScreen(
                      HodFacultySkillBoosterScreen(onBack: _closeSubScreen),
                      title: "Faculty Skill Booster",
                    ),
                  ),
                ],

                // 9. DEPARTMENT
                _facultyDrawerSectionHeader("DEPARTMENT"),
                if (_expandedSections["DEPARTMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.people_alt_outlined,
                    title: "Faculty",
                    isActive: _activeSubScreen != null &&
                        (_activeSubScreenTitle == "Faculty Management" ||
                            _activeSubScreenTitle == "Faculty"),
                    onTap: () => _openSubScreen(
                      HodFacultyDirectoryScreen(onBack: _closeSubScreen),
                      title: "Faculty Management",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.insights_rounded,
                    title: "Academic Performance",
                    onTap: () => _openSubScreen(
                      HodAcademicPerformanceScreen(onBack: _closeSubScreen),
                      title: "Academic Performance",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.hub_outlined,
                    title: "Skill Intelligence",
                    onTap: () => _openSubScreen(
                      HodSkillIntelligenceScreen(onBack: _closeSubScreen),
                      title: "Skill Intelligence",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.layers_outlined,
                    title: "Department Portal",
                    onTap: () => _openSubScreen(
                      HodDepartmentPortalScreen(onBack: _closeSubScreen),
                      title: "Department Portal",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.warning_amber_rounded,
                    title: "Student Success & Early Warning",
                    onTap: () => _openSubScreen(
                      HodStudentSuccessEarlyWarningScreen(onBack: _closeSubScreen),
                      title: "Student Success & Early Warning",
                    ),
                  ),
                ],

                // 10. PLACEMENT
                _facultyDrawerSectionHeader("PLACEMENT"),
                if (_expandedSections["PLACEMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.track_changes_rounded,
                    title: "Placement Readiness Board",
                    onTap: () => _openSubScreen(
                      HodPlacementReadinessBoardScreen(onBack: _closeSubScreen),
                      title: "Placement Readiness Board",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.bar_chart_rounded,
                    title: "Placement Analytics",
                    onTap: () => _openSubScreen(
                      HodPlacementAnalyticsScreen(onBack: _closeSubScreen),
                      title: "Placement Analytics",
                    ),
                  ),
                ],

                // 11. STAFF & USERS
                _facultyDrawerSectionHeader("STAFF & USERS"),
                if (_expandedSections["STAFF & USERS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.badge_outlined,
                    title: "Staff Management",
                    onTap: () => _openSubScreen(
                      HodStaffManagementScreen(onBack: _closeSubScreen),
                      title: "Staff Management",
                    ),
                  ),
                ],

                // 12. INSTITUTION
                _facultyDrawerSectionHeader("INSTITUTION"),
                if (_expandedSections["INSTITUTION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.gavel_rounded,
                    title: "Policy Assistant",
                    onTap: () => _openSubScreen(
                      HodPolicyAssistantScreen(onBack: _closeSubScreen),
                      title: "Policy Assistant",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.summarize_outlined,
                    title: "Reports",
                    isActive: _activeSubScreen != null &&
                        (_activeSubScreenTitle == "Department Reports" ||
                            _activeSubScreenTitle == "Reports"),
                    onTap: () => _openSubScreen(
                      HodReportsScreen(onBack: _closeSubScreen),
                      title: "Department Reports",
                    ),
                  ),
                ],

                const Divider(color: Color(0xFF202A54), height: 20, indent: 12, endIndent: 12),
                _facultyDrawerItem(
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

  Widget _buildPlacementOfficerDrawerContent(double drawerWidth) {
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
                        "CollossusIQ.ai",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "HIGHER-EDUCATION OS",
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

          // Scrollable Placement Officer Navigation Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Institution Card
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2349),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF253060), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5A93C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_rounded,
                            color: Color(0xFF111736),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _userCollege.length > 22
                                  ? "${_userCollege.substring(0, 20)}..."
                                  : _userCollege,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Tamil Nadu Technical Univer...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF8B9BB4),
                              ),
                            ),
                            Text(
                              "PLACEMENT OFFICER",
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE5A93C),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Top: Home
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _closeDrawer();
                        setState(() {
                          _activeSubScreen = null;
                          _activeSubScreenTitle = null;
                          _activeSubScreenBadge = null;
                          _currentIndex = 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Color(0xFF222B55)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Border(
                                  left: BorderSide(color: Color(0xFFEAB308), width: 3.5),
                                )
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_rounded,
                              size: 19,
                              color: (_activeSubScreen == null && _currentIndex == 0)
                                  ? const Color(0xFFEAB308)
                                  : const Color(0xFF8B9BB4),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Home",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // 1. OVERVIEW
                _facultyDrawerSectionHeader("OVERVIEW"),
                if (_expandedSections["OVERVIEW"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.notifications_none_rounded,
                    title: "Notice Board",
                    onTap: () => _openSubScreen(
                      PlacementNoticeBoardScreen(onBack: _closeSubScreen),
                      title: "Notice Board",
                    ),
                  ),
                ],

                // 2. AI COURSE & CERTIFICATION
                _facultyDrawerSectionHeader("AI COURSE & CERTIFICATION"),
                if (_expandedSections["AI COURSE & CERTIFICATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.military_tech_outlined,
                    title: "Issued Certificates",
                    isActive: _activeSubScreenTitle == "Issued Certificates",
                    onTap: () => _openSubScreen(
                      PlacementIssuedCertificatesScreen(onBack: _closeSubScreen),
                      title: "Issued Certificates",
                    ),
                  ),
                ],

                // 3. CAMPUS LIFE
                _facultyDrawerSectionHeader("CAMPUS LIFE"),
                if (_expandedSections["CAMPUS LIFE"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.desktop_mac_rounded,
                    title: "Alumni Network",
                    onTap: () => _openSubScreen(
                      PlacementAlumniNetworkScreen(onBack: _closeSubScreen),
                      title: "Alumni Network",
                    ),
                  ),
                ],

                // 4. FACULTY
                _facultyDrawerSectionHeader("FACULTY"),
                if (_expandedSections["FACULTY"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.groups_outlined,
                    title: "Students",
                    onTap: () => _openSubScreen(
                      PlacementStudentsScreen(onBack: _closeSubScreen),
                      title: "Students",
                    ),
                  ),
                ],

                // 5. PLACEMENT
                _facultyDrawerSectionHeader("PLACEMENT"),
                if (_expandedSections["PLACEMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.track_changes_rounded,
                    title: "Placement Readiness Board",
                    onTap: () => _openSubScreen(
                      PlacementReadinessBoardScreen(onBack: _closeSubScreen),
                      title: "Placement Readiness Board",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.work_outline_rounded,
                    title: "Placement Drives",
                    onTap: () => _openSubScreen(
                      PlacementDrivesScreen(onBack: _closeSubScreen),
                      title: "Placement Drives",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.handshake_outlined,
                    title: "Job Matching",
                    onTap: () => _openSubScreen(
                      PlacementJobMatchingScreen(onBack: _closeSubScreen),
                      title: "Job Matching",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.apartment_rounded,
                    title: "Employers",
                    onTap: () => _openSubScreen(
                      EmployersScreen(onBack: _closeSubScreen),
                      title: "Employers",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.insights_rounded,
                    title: "Placement Analytics",
                    onTap: () => _openSubScreen(
                      PlacementAnalyticsScreen(onBack: _closeSubScreen),
                      title: "Placement Analytics",
                    ),
                  ),
                ],

                // 6. INSTITUTION
                _facultyDrawerSectionHeader("INSTITUTION"),
                if (_expandedSections["INSTITUTION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.summarize_outlined,
                    title: "Reports",
                    isActive: _activeSubScreen != null &&
                        (_activeSubScreenTitle == "Placement Reports" ||
                            _activeSubScreenTitle == "Reports"),
                    onTap: () => _openSubScreen(
                      PlacementReportsScreen(onBack: _closeSubScreen),
                      title: "Placement Reports",
                    ),
                  ),
                ],

                const Divider(color: Color(0xFF202A54), height: 20, indent: 12, endIndent: 12),
                _facultyDrawerItem(
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

  Widget _buildIncubationHeadDrawerContent(double drawerWidth) {
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
                        "CollossusIQ.ai",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "HIGHER-EDUCATION OS",
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

          // Scrollable Incubation Head Navigation Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Institution Card
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2349),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF253060), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5A93C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_rounded,
                            color: Color(0xFF111736),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _userCollege.length > 22
                                  ? "${_userCollege.substring(0, 20)}..."
                                  : _userCollege,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Tamil Nadu Technical Univer...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF8B9BB4),
                              ),
                            ),
                            Text(
                              "INCUBATION HEAD",
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE5A93C),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Top: Home
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _closeDrawer();
                        setState(() {
                          _activeSubScreen = null;
                          _activeSubScreenTitle = null;
                          _activeSubScreenBadge = null;
                          _currentIndex = 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Color(0xFF222B55)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Border(
                                  left: BorderSide(color: Color(0xFFEAB308), width: 3.5),
                                )
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_rounded,
                              size: 19,
                              color: (_activeSubScreen == null && _currentIndex == 0)
                                  ? const Color(0xFFEAB308)
                                  : const Color(0xFF8B9BB4),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Home",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // 1. OVERVIEW
                _facultyDrawerSectionHeader("OVERVIEW"),
                if (_expandedSections["OVERVIEW"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.notifications_none_rounded,
                    title: "Notice Board",
                    onTap: () => _openSubScreen(
                      IncubationNoticeBoardScreen(onBack: _closeSubScreen),
                      title: "Notice Board",
                    ),
                  ),
                ],

                // 2. PROJECT & INNOVATION
                _facultyDrawerSectionHeader("PROJECT & INNOVATION"),
                if (_expandedSections["PROJECT & INNOVATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.code_rounded,
                    title: "Hackathon Hub",
                    onTap: () => _openSubScreen(
                      IncubationHackathonHubScreen(onBack: _closeSubScreen),
                      title: "Hackathon Hub",
                    ),
                  ),
                ],

                // 3. CAMPUS LIFE
                _facultyDrawerSectionHeader("CAMPUS LIFE"),
                if (_expandedSections["CAMPUS LIFE"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.desktop_mac_rounded,
                    title: "Alumni Network",
                    onTap: () => _openSubScreen(
                      IncubationAlumniNetworkScreen(onBack: _closeSubScreen),
                      title: "Alumni Network",
                    ),
                  ),
                ],

                // 4. INCUBATION
                _facultyDrawerSectionHeader("INCUBATION"),
                if (_expandedSections["INCUBATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.rocket_launch_outlined,
                    title: "Incubation Pipeline",
                    onTap: () => _openSubScreen(
                      IncubationPipelineScreen(onBack: _closeSubScreen),
                      title: "Incubation Pipeline",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.lightbulb_outline_rounded,
                    title: "Startups",
                    onTap: () => _openSubScreen(
                      StartupsScreen(onBack: _closeSubScreen),
                      title: "Startups",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.handshake_outlined,
                    title: "Mentor Network",
                    onTap: () => _openSubScreen(
                      IncubationMentorNetworkScreen(onBack: _closeSubScreen),
                      title: "Mentor Network",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.monetization_on_outlined,
                    title: "Funding Readiness",
                    onTap: () => _openSubScreen(
                      FundingReadinessScreen(onBack: _closeSubScreen),
                      title: "Funding Readiness",
                    ),
                  ),
                ],

                const Divider(color: Color(0xFF202A54), height: 20, indent: 12, endIndent: 12),
                _facultyDrawerItem(
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

  Widget _buildPrincipalDrawerContent(double drawerWidth) {
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
                        "CollossusIQ.ai",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        "HIGHER-EDUCATION OS",
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

          // Scrollable Principal Navigation Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Institution Card
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2349),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF253060), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5A93C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_rounded,
                            color: Color(0xFF111736),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _userCollege.length > 22
                                  ? "${_userCollege.substring(0, 20)}..."
                                  : _userCollege,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Tamil Nadu Technical Univer...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF8B9BB4),
                              ),
                            ),
                            Text(
                              "COLLEGE PRINCIPAL",
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE5A93C),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Top: Home
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _closeDrawer();
                        setState(() {
                          _activeSubScreen = null;
                          _activeSubScreenTitle = null;
                          _activeSubScreenBadge = null;
                          _currentIndex = 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Color(0xFF222B55)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: (_activeSubScreen == null && _currentIndex == 0)
                              ? const Border(
                                  left: BorderSide(color: Color(0xFFEAB308), width: 3.5),
                                )
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_rounded,
                              size: 19,
                              color: (_activeSubScreen == null && _currentIndex == 0)
                                  ? const Color(0xFFEAB308)
                                  : const Color(0xFF8B9BB4),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Home",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // 1. OVERVIEW
                _facultyDrawerSectionHeader("OVERVIEW"),
                if (_expandedSections["OVERVIEW"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.notifications_none_rounded,
                    title: "Notice Board",
                    onTap: () => _openSubScreen(
                      PrincipalNoticeBoardScreen(onBack: _closeSubScreen),
                      title: "Notice Board",
                    ),
                  ),
                ],

                // 2. UNIVERSITY
                _facultyDrawerSectionHeader("UNIVERSITY"),
                if (_expandedSections["UNIVERSITY"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.layers_outlined,
                    title: "Curriculum Studio",
                    onTap: () => _openSubScreen(
                      PrincipalCurriculumStudioScreen(onBack: _closeSubScreen),
                      title: "Curriculum Studio",
                    ),
                  ),
                ],

                // 3. ACADEMICS
                _facultyDrawerSectionHeader("ACADEMICS"),
                if (_expandedSections["ACADEMICS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.menu_book_rounded,
                    title: "Course Management",
                    onTap: () => _openSubScreen(
                      PrincipalCourseManagementScreen(onBack: _closeSubScreen),
                      title: "Course Management",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.calendar_month_outlined,
                    title: "Academic Calendar",
                    onTap: () => _openSubScreen(
                      PrincipalAcademicCalendarScreen(onBack: _closeSubScreen),
                      title: "Academic Calendar",
                    ),
                  ),
                ],

                // 4. ASSESSMENT
                _facultyDrawerSectionHeader("ASSESSMENT"),
                if (_expandedSections["ASSESSMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "Exam Prep Studio",
                    onTap: () => _openSubScreen(
                      PrincipalExamPrepScreen(onBack: _closeSubScreen),
                      title: "Exam Prep Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.article_outlined,
                    title: "Current Affairs Desk",
                    onTap: () => _openSubScreen(
                      PrincipalCurrentAffairsDeskScreen(onBack: _closeSubScreen),
                      title: "Current Affairs Desk",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.storage_rounded,
                    title: "Question Bank",
                    onTap: () => _openSubScreen(
                      PrincipalQuestionBankScreen(onBack: _closeSubScreen),
                      title: "Question Bank",
                    ),
                  ),
                ],

                // 5. AI COURSE & CERTIFICATION
                _facultyDrawerSectionHeader("AI COURSE & CERTIFICATION"),
                if (_expandedSections["AI COURSE & CERTIFICATION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_outlined,
                    title: "AI Course Studio",
                    onTap: () => _openSubScreen(
                      PrincipalAiCourseStudioScreen(onBack: _closeSubScreen),
                      title: "AI Course Studio",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.military_tech_outlined,
                    title: "Issued Certificates",
                    isActive: _activeSubScreenTitle == "Issued Certificates",
                    onTap: () => _openSubScreen(
                      PrincipalIssuedCertificatesScreen(onBack: _closeSubScreen),
                      title: "Issued Certificates",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.workspace_premium_outlined,
                    title: "Certificate Authority",
                    onTap: () => _openSubScreen(
                      PrincipalCertificateAuthorityScreen(onBack: _closeSubScreen),
                      title: "Certificate Authority",
                    ),
                  ),
                ],

                // 6. CAMPUS LIFE
                _facultyDrawerSectionHeader("CAMPUS LIFE"),
                if (_expandedSections["CAMPUS LIFE"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.celebration_outlined,
                    title: "Campus Events",
                    onTap: () => _openSubScreen(
                      PrincipalCampusEventsScreen(onBack: _closeSubScreen),
                      title: "Campus Events",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    title: "AI Event Generator",
                    onTap: () => _openSubScreen(
                      PrincipalAiEventGeneratorScreen(onBack: _closeSubScreen),
                      title: "AI Event Generator",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.flag_outlined,
                    title: "Clubs",
                    onTap: () => _openSubScreen(
                      PrincipalClubsScreen(onBack: _closeSubScreen),
                      title: "Clubs",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.sports_volleyball_outlined,
                    title: "Sports",
                    onTap: () => _openSubScreen(
                      PrincipalSportsScreen(onBack: _closeSubScreen),
                      title: "Sports",
                    ),
                  ),
                ],

                // 7. DEPARTMENT
                _facultyDrawerSectionHeader("DEPARTMENT"),
                if (_expandedSections["DEPARTMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.hub_outlined,
                    title: "Skill Intelligence",
                    onTap: () => _openSubScreen(
                      PrincipalSkillIntelligenceScreen(onBack: _closeSubScreen),
                      title: "Skill Intelligence",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.warning_amber_rounded,
                    title: "Student Success & Early Warning",
                    onTap: () => _openSubScreen(
                      PrincipalStudentSuccessEarlyWarningScreen(onBack: _closeSubScreen),
                      title: "Student Success & Early Warning",
                    ),
                  ),
                ],

                // 8. PLACEMENT
                _facultyDrawerSectionHeader("PLACEMENT"),
                if (_expandedSections["PLACEMENT"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.track_changes_rounded,
                    title: "Placement Readiness Board",
                    onTap: () => _openSubScreen(
                      PrincipalPlacementReadinessBoardScreen(onBack: _closeSubScreen),
                      title: "Placement Readiness Board",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.bar_chart_rounded,
                    title: "Placement Analytics",
                    onTap: () => _openSubScreen(
                      PrincipalPlacementAnalyticsScreen(onBack: _closeSubScreen),
                      title: "Placement Analytics",
                    ),
                  ),
                ],

                // 9. ADMISSIONS
                _facultyDrawerSectionHeader("ADMISSIONS"),
                if (_expandedSections["ADMISSIONS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.person_add_alt_outlined,
                    title: "Student Admissions",
                    onTap: () => _openSubScreen(
                      PrincipalStudentAdmissionsScreen(onBack: _closeSubScreen),
                      title: "Student Admissions",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.insights_rounded,
                    title: "Admission Insights",
                    onTap: () => _openSubScreen(
                      PrincipalAdmissionInsightsScreen(onBack: _closeSubScreen),
                      title: "Admission Insights",
                    ),
                  ),
                ],

                // 10. COLLEGE WEBSITE
                _facultyDrawerSectionHeader("COLLEGE WEBSITE"),
                if (_expandedSections["COLLEGE WEBSITE"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.school_outlined,
                    title: "College Website",
                    onTap: () => _openSubScreen(
                      PrincipalCollegeWebsiteScreen(onBack: _closeSubScreen),
                      title: "College Website",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.photo_library_outlined,
                    title: "Photo Gallery",
                    onTap: () => _openSubScreen(
                      PrincipalPhotoGalleryScreen(onBack: _closeSubScreen),
                      title: "Photo Gallery",
                    ),
                  ),
                ],

                // 11. STAFF & USERS
                _facultyDrawerSectionHeader("STAFF & USERS"),
                if (_expandedSections["STAFF & USERS"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.badge_outlined,
                    title: "Staff Management",
                    isActive: _activeSubScreenTitle == "Staff Management",
                    onTap: () => _openSubScreen(
                      PrincipalStaffManagementScreen(onBack: _closeSubScreen),
                      title: "Staff Management",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.vpn_key_outlined,
                    title: "Roles & Permissions",
                    isActive: _activeSubScreenTitle == "Roles & Permissions",
                    onTap: () => _openSubScreen(
                      PrincipalRolesPermissionsScreen(onBack: _closeSubScreen),
                      title: "Roles & Permissions",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.manage_accounts_outlined,
                    title: "User Management",
                    isActive: _activeSubScreenTitle == "User Management",
                    onTap: () => _openSubScreen(
                      PrincipalUserManagementScreen(onBack: _closeSubScreen),
                      title: "User Management",
                    ),
                  ),
                ],

                // 12. INSTITUTION
                _facultyDrawerSectionHeader("INSTITUTION"),
                if (_expandedSections["INSTITUTION"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Student Fees",
                    isActive: _activeSubScreenTitle == "Student Fees",
                    onTap: () => _openSubScreen(
                      PrincipalStudentFeesScreen(onBack: _closeSubScreen),
                      title: "Student Fees",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.apartment_rounded,
                    title: "Departments",
                    isActive: _activeSubScreenTitle == "Departments",
                    onTap: () => _openSubScreen(
                      PrincipalDepartmentsScreen(onBack: _closeSubScreen),
                      title: "Departments",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.analytics_outlined,
                    title: "Analytics & BI",
                    isActive: _activeSubScreenTitle == "Analytics & BI",
                    onTap: () => _openSubScreen(
                      PrincipalAnalyticsBiScreen(onBack: _closeSubScreen),
                      title: "Analytics & BI",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.storage_rounded,
                    title: "Institutional Knowledge (RAG)",
                    isActive: _activeSubScreenTitle == "Institutional Knowledge (RAG)",
                    onTap: () => _openSubScreen(
                      PrincipalInstitutionalKnowledgeScreen(onBack: _closeSubScreen),
                      title: "Institutional Knowledge (RAG)",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.gavel_rounded,
                    title: "Policy Assistant",
                    isActive: _activeSubScreenTitle == "Policy Assistant",
                    onTap: () => _openSubScreen(
                      PrincipalPolicyAssistantScreen(onBack: _closeSubScreen),
                      title: "Policy Assistant",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.summarize_outlined,
                    title: "Reports",
                    isActive: _activeSubScreenTitle == "Reports",
                    onTap: () => _openSubScreen(
                      PrincipalReportsScreen(onBack: _closeSubScreen),
                      title: "Reports",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.verified_outlined,
                    title: "NAAC Accreditation Readiness",
                    isActive: _activeSubScreenTitle == "NAAC Accreditation Readiness",
                    onTap: () => _openSubScreen(
                      PrincipalNaacAccreditationScreen(onBack: _closeSubScreen),
                      title: "NAAC Accreditation Readiness",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.verified_user_outlined,
                    title: "AICTE Compliance",
                    isActive: _activeSubScreenTitle == "AICTE Compliance",
                    onTap: () => _openSubScreen(
                      PrincipalAicteComplianceScreen(onBack: _closeSubScreen),
                      title: "AICTE Compliance",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.palette_outlined,
                    title: "Branding & White Label",
                    isActive: _activeSubScreenTitle == "Branding & White Label",
                    onTap: () => _openSubScreen(
                      PrincipalBrandingScreen(onBack: _closeSubScreen),
                      title: "Branding & White Label",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.notifications_active_outlined,
                    title: "Notification Rules",
                    isActive: _activeSubScreenTitle == "Notification Rules",
                    onTap: () => _openSubScreen(
                      PrincipalNotificationRulesScreen(onBack: _closeSubScreen),
                      title: "Notification Rules",
                    ),
                  ),
                ],

                // 13. PLATFORM
                _facultyDrawerSectionHeader("PLATFORM"),
                if (_expandedSections["PLATFORM"] ?? true) ...[
                  _facultyDrawerItem(
                    icon: Icons.electrical_services_outlined,
                    title: "Integrations & Setup",
                    isActive: _activeSubScreenTitle == "Integrations & Setup",
                    onTap: () => _openSubScreen(
                      PrincipalIntegrationsScreen(onBack: _closeSubScreen),
                      title: "Integrations & Setup",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.memory_rounded,
                    title: "Agent Store",
                    isActive: _activeSubScreenTitle == "Agent Store",
                    onTap: () => _openSubScreen(
                      PrincipalAgentStoreScreen(onBack: _closeSubScreen),
                      title: "Agent Store",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.receipt_long_outlined,
                    title: "Audit Log",
                    isActive: _activeSubScreenTitle == "Audit Log",
                    onTap: () => _openSubScreen(
                      PrincipalAuditLogScreen(onBack: _closeSubScreen),
                      title: "Audit Log",
                    ),
                  ),
                  _facultyDrawerItem(
                    icon: Icons.security_rounded,
                    title: "Security Settings",
                    isActive: _activeSubScreenTitle == "Security Settings",
                    onTap: () => _openSubScreen(
                      PrincipalSecuritySettingsScreen(onBack: _closeSubScreen),
                      title: "Security Settings",
                    ),
                  ),
                ],

                const Divider(color: Color(0xFF202A54), height: 20, indent: 12, endIndent: 12),
                _facultyDrawerItem(
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

  Widget _facultyDrawerSectionHeader(String title) {
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

  Widget _facultyDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool? isActive,
  }) {
    final active = isActive ??
        (_activeSubScreen != null &&
            (_activeSubScreenTitle == title ||
                (_activeSubScreenTitle != null &&
                    (_activeSubScreenTitle!.toLowerCase() == title.toLowerCase() ||
                        title.toLowerCase().contains(_activeSubScreenTitle!.toLowerCase()) ||
                        _activeSubScreenTitle!.toLowerCase().contains(title.toLowerCase()))) ||
                (title == "Reports" &&
                    (_activeSubScreenTitle?.contains("Reports") ?? false)) ||
                (title == "Faculty" &&
                    (_activeSubScreenTitle?.contains("Faculty") ?? false))));

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
