import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// DAILY ROUTINE SCREEN
// Matches Image 1 (media_1793779269669_5f6a00aa.jpg)
// and Image 2 (media_1793779281265_24173072.png)
// =============================================================================

class DailyRoutineScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const DailyRoutineScreen({super.key, this.onBack});

  static const List<Map<String, dynamic>> _todayItems = [
    {
      "time": "06:30",
      "title": "Morning fitness / wellness walk",
      "category": "Wellness",
      "lineColor": Color(0xFF0D9488),
      "badgeBg": Color(0xFFE6F4EA),
      "badgeFg": Color(0xFF0D9488),
    },
    {
      "time": "09:00",
      "title": "Advanced Java — Theory & Concept Map",
      "category": "Class",
      "lineColor": Color(0xFF1E2865),
      "badgeBg": Color(0xFFEEF2FF),
      "badgeFg": Color(0xFF4338CA),
    },
    {
      "time": "11:00",
      "title": "CS3492 — Problem Solving & Worked Examples",
      "category": "Class",
      "lineColor": Color(0xFF1E2865),
      "badgeBg": Color(0xFFEEF2FF),
      "badgeFg": Color(0xFF4338CA),
    },
    {
      "time": "13:00",
      "title": "Lunch & campus break",
      "category": "Break",
      "lineColor": Color(0xFF94A3B8),
      "badgeBg": Color(0xFFF1F5F9),
      "badgeFg": Color(0xFF475569),
    },
    {
      "time": "14:00",
      "title": "CSE105 — Laboratory & Hands-on Implementation",
      "category": "Lab",
      "lineColor": Color(0xFF0284C7),
      "badgeBg": Color(0xFFE0F2FE),
      "badgeFg": Color(0xFF0284C7),
    },
    {
      "time": "17:00",
      "title": "Coding Club & Innovation Project Hub",
      "category": "Club",
      "lineColor": Color(0xFFD97706),
      "badgeBg": Color(0xFFFEF3C7),
      "badgeFg": Color(0xFFD97706),
    },
    {
      "time": "19:00",
      "title": "Placement Aptitude & AI Mock Interview Drill",
      "category": "Career",
      "lineColor": Color(0xFFEA580C),
      "badgeBg": Color(0xFFFFEDD5),
      "badgeFg": Color(0xFFEA580C),
    },
    {
      "time": "21:00",
      "title": "Focused Revision: Advanced Java core units (25 min)",
      "category": "Revision",
      "lineColor": Color(0xFF4F46E5),
      "badgeBg": Color(0xFFE0E7FF),
      "badgeFg": Color(0xFF3730A3),
    },
  ];

  static const List<Map<String, dynamic>> _tomorrowItems = [
    {
      "time": "09:00",
      "title": "CS3492 — Case Studies & Analysis",
      "category": "Class",
      "lineColor": Color(0xFF1E2865),
      "badgeBg": Color(0xFFEEF2FF),
      "badgeFg": Color(0xFF4338CA),
    },
    {
      "time": "11:00",
      "title": "Advanced Java — Assessment & Tutorial Discussion",
      "category": "Class",
      "lineColor": Color(0xFF1E2865),
      "badgeBg": Color(0xFFEEF2FF),
      "badgeFg": Color(0xFF4338CA),
    },
    {
      "time": "14:30",
      "title": "Department Seminar & Research Paper Review",
      "category": "Academics",
      "lineColor": Color(0xFF0284C7),
      "badgeBg": Color(0xFFE0F2FE),
      "badgeFg": Color(0xFF0284C7),
    },
    {
      "time": "16:30",
      "title": "Sports Practice & Inter-College Trial",
      "category": "Sports",
      "lineColor": Color(0xFF059669),
      "badgeBg": Color(0xFFD1FAE5),
      "badgeFg": Color(0xFF059669),
    },
    {
      "time": "20:00",
      "title": "Adaptive Mock Test: CS3492",
      "category": "Assessment",
      "lineColor": Color(0xFFDC2626),
      "badgeBg": Color(0xFFFEE2E2),
      "badgeFg": Color(0xFFDC2626),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Daily Routine",
      category: "Student Success",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Student Success  ›  Daily Routine",
          category: "STUDENT SUCCESS",
          phase: "Phase 3",
          icon: Icons.calendar_today_rounded,
          title: "Daily Routine",
          subtitle:
              "Classes, study, projects, exercise and clubs combined into one realistic daily schedule.",
          watermarkIcon: Icons.calendar_month_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Main Section: Today Schedule + Sync Info Cards
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 960;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: _buildDayCard("Today", _todayItems),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: const [
                        _SyncInfoBox(
                          text:
                              "Planner automatically syncs with your department timetable and upcoming examination calendar.",
                        ),
                        SizedBox(height: 16),
                        _SyncInfoBox(
                          text:
                              "Spaced revision blocks are scheduled when memory retention is highest (morning & evening).",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDayCard("Today", _todayItems),
                  const SizedBox(height: 16),
                  const _SyncInfoBox(
                    text:
                        "Planner automatically syncs with your department timetable and upcoming examination calendar.",
                  ),
                  const SizedBox(height: 12),
                  const _SyncInfoBox(
                    text:
                        "Spaced revision blocks are scheduled when memory retention is highest (morning & evening).",
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 24),

        // 3. Tomorrow Section
        _buildDayCard("Tomorrow", _tomorrowItems),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildDayCard(String dayTitle, List<Map<String, dynamic>> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dayTitle,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => _buildScheduleRow(item)),
        ],
      ),
    );
  }

  Widget _buildScheduleRow(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // Time label
          SizedBox(
            width: 55,
            child: Text(
              item["time"] as String,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),

          // Colored vertical line indicator
          Container(
            width: 3.5,
            height: 22,
            decoration: BoxDecoration(
              color: item["lineColor"] as Color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 14),

          // Title
          Expanded(
            child: Text(
              item["title"] as String,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Category badge pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
            decoration: BoxDecoration(
              color: item["badgeBg"] as Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item["category"] as String,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: item["badgeFg"] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Info Callout Box Widget
// -----------------------------------------------------------------------------
class _SyncInfoBox extends StatelessWidget {
  final String text;
  const _SyncInfoBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: Color(0xFF1E3A8A),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF1E3A8A),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

