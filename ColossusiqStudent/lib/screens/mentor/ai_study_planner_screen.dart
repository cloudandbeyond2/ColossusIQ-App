import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// STUDENT: AI STUDY PLANNER SCREEN
// Matches Image 1 (media_1793778757162_edf4ed0d.jpg)
// and Image 2 (media_1793778772264_2d212664.jpg)
// =============================================================================

class AiStudyPlannerScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiStudyPlannerScreen({super.key, this.onBack});

  @override
  State<AiStudyPlannerScreen> createState() => _AiStudyPlannerScreenState();
}

class _AiStudyPlannerScreenState extends State<AiStudyPlannerScreen> {
  // Exam window inputs
  final TextEditingController _daysCtrl = TextEditingController(text: "9");
  final TextEditingController _hoursCtrl = TextEditingController(text: "3");
  String _selectedStudyMode = "Deep learning";

  // Subjects in left card
  late List<Map<String, dynamic>> _subjects;

  // Days and tasks in right card
  late List<Map<String, dynamic>> _planDays;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    _subjects = [
      {
        "id": "1",
        "code": "Advanced Java",
        "name": "Advanced Java",
        "weakest": "Core Principles & Architecture",
        "mastery": "0%",
        "selected": false,
      },
      {
        "id": "2",
        "code": "CS3492",
        "name": "Cloud Computing & Vir...",
        "weakest": "Core Principles & Architecture",
        "mastery": "0%",
        "selected": false,
      },
      {
        "id": "3",
        "code": "CSE105",
        "name": "Data base System Appli...",
        "weakest": "Core Principles & Architecture",
        "mastery": "0%",
        "selected": false,
      },
      {
        "id": "4",
        "code": "CSE101",
        "name": "Database Management ...",
        "weakest": "Applications & Optimization",
        "mastery": "3%",
        "selected": false,
      },
      {
        "id": "5",
        "code": "DBMS",
        "name": "DBMS",
        "weakest": "Applications & Optimization",
        "mastery": "3%",
        "selected": true, // Selected in reference screenshot
      },
      {
        "id": "6",
        "code": "CSE107",
        "name": "Emerging Technologies",
        "weakest": "Case Studies & Modern Tren...",
        "mastery": "19%",
        "selected": false,
      },
      {
        "id": "7",
        "code": "CS201",
        "name": "Object-Oriented Progra...",
        "weakest": "Core Principles & Architecture",
        "mastery": "0%",
        "selected": false,
      },
      {
        "id": "8",
        "code": "CSE102",
        "name": "Operating Systems",
        "weakest": "Core Principles & Architecture",
        "mastery": "0%",
        "selected": false,
      },
      {
        "id": "9",
        "code": "python",
        "name": "python",
        "weakest": "Core Principles & Architecture",
        "mastery": "0%",
        "selected": false,
      },
      {
        "id": "10",
        "code": "CSE106",
        "name": "Web Technologies",
        "weakest": "Applications & Optimization",
        "mastery": "3%",
        "selected": false,
      },
    ];

    _planDays = [
      {
        "dayNum": 1,
        "dateStr": "Tue, 6 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t1",
            "title": "Deep dive into Case Studies & Modern Trends",
            "type": "Study",
            "subject": "DBMS",
            "hours": 3,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 2,
        "dateStr": "Wed, 7 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t2",
            "title": "Deep dive into Case Studies & Modern Trends",
            "type": "Study",
            "subject": "DBMS",
            "hours": 2,
            "done": false,
          },
          {
            "id": "t3",
            "title": "Deep dive into Applications & Optimization",
            "type": "Study",
            "subject": "DBMS",
            "hours": 1,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 3,
        "dateStr": "Thu, 8 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t4",
            "title": "Deep dive into Applications & Optimization",
            "type": "Study",
            "subject": "DBMS",
            "hours": 3,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 4,
        "dateStr": "Fri, 9 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t5",
            "title": "Deep dive into Advanced Implementations",
            "type": "Study",
            "subject": "DBMS",
            "hours": 3,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 5,
        "dateStr": "Sat, 10 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t6",
            "title": "Timed mock test: DBMS",
            "type": "Mock test",
            "subject": "DBMS",
            "hours": 2,
            "done": false,
          },
          {
            "id": "t7",
            "title": "Review mistakes and fix: Case Studies & Modern Trends",
            "type": "Study",
            "subject": "DBMS",
            "hours": 1,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 6,
        "dateStr": "Sun, 11 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t8",
            "title": "Deep dive into Advanced Implementations",
            "type": "Study",
            "subject": "DBMS",
            "hours": 1,
            "done": false,
          },
          {
            "id": "t9",
            "title": "Deep dive into Design & Analysis Methodology",
            "type": "Study",
            "subject": "DBMS",
            "hours": 2,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 7,
        "dateStr": "Mon, 12 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t10",
            "title": "Deep dive into Design & Analysis Methodology",
            "type": "Study",
            "subject": "DBMS",
            "hours": 1,
            "done": false,
          },
          {
            "id": "t11",
            "title": "Deep dive into Core Principles & Architecture",
            "type": "Study",
            "subject": "DBMS",
            "hours": 2,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 8,
        "dateStr": "Tue, 13 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t12",
            "title":
                "Quick revision of DBMS: Case Studies & Modern Trends, Applications & Optimization",
            "type": "Revision",
            "subject": "DBMS",
            "hours": 3,
            "done": false,
          },
        ],
      },
      {
        "dayNum": 9,
        "dateStr": "Wed, 14 Oct",
        "badge": "Catch up",
        "tasks": [
          {
            "id": "t13",
            "title":
                "Quick revision of DBMS: Case Studies & Modern Trends, Applications & Optimization",
            "type": "Revision",
            "subject": "DBMS",
            "hours": 3,
            "done": false,
          },
        ],
      },
    ];
  }

  @override
  void dispose() {
    _daysCtrl.dispose();
    _hoursCtrl.dispose();
    super.dispose();
  }

  int get _totalTasks {
    int count = 0;
    for (final day in _planDays) {
      count += (day["tasks"] as List).length;
    }
    return count;
  }

  int get _doneTasks {
    int count = 0;
    for (final day in _planDays) {
      for (final t in day["tasks"] as List<Map<String, dynamic>>) {
        if (t["done"] == true) count++;
      }
    }
    return count;
  }

  int get _doneHours {
    int hours = 0;
    for (final day in _planDays) {
      for (final t in day["tasks"] as List<Map<String, dynamic>>) {
        if (t["done"] == true) hours += (t["hours"] as int? ?? 0);
      }
    }
    return hours;
  }

  void _rebuildPlan() {
    final selectedSubjs = _subjects.where((s) => s["selected"] == true).toList();
    if (selectedSubjs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select at least one subject to include in your plan.",
              style: GoogleFonts.poppins()),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _initData();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text("AI study schedule generated successfully!",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          ],
        ),
        backgroundColor: const Color(0xFF2E3A8C),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearPlan() {
    setState(() {
      for (final day in _planDays) {
        for (final t in day["tasks"] as List<Map<String, dynamic>>) {
          t["done"] = false;
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Plan progress reset.", style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF475569),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "AI Study Planner",
      category: "Student Success",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Student Success  ›  AI Study Planner",
          category: "STUDENT SUCCESS",
          phase: "MVP",
          isMvp: true,
          icon: Icons.calendar_month_rounded,
          title: "AI Study Planner",
          subtitle:
              "Tell the planner your deadline — get a day-by-day schedule with revision slots and mock tests.",
          watermarkIcon: Icons.calendar_month_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Responsive 2-Column Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 960;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 320,
                    child: _buildExamWindowCard(),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildYourPlanCard(),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExamWindowCard(),
                  const SizedBox(height: 20),
                  _buildYourPlanCard(),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Left Column Card: Plan your exam window
  // ---------------------------------------------------------------------------
  Widget _buildExamWindowCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
            "Plan your exam window",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Built from your own subjects. Next: Advanced Java Internal Assessment II.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Days until exams + Hours / day inputs
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Days until exams",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: TextField(
                        controller: _daysCtrl,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hours / day",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: TextField(
                        controller: _hoursCtrl,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Subjects to include section
          Text(
            "Subjects to include",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),

          // Subjects list
          ..._subjects.map((s) => _buildSubjectRow(s)),

          const SizedBox(height: 18),

          // Study mode section
          Text(
            "Study mode",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedStudyMode,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                items: const [
                  DropdownMenuItem(value: "Deep learning", child: Text("Deep learning")),
                  DropdownMenuItem(value: "Cram / Revision", child: Text("Cram / Revision")),
                  DropdownMenuItem(value: "Mock test focus", child: Text("Mock test focus")),
                  DropdownMenuItem(value: "Balanced pace", child: Text("Balanced pace")),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedStudyMode = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Rebuild my plan button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: _rebuildPlan,
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: Text(
                "Rebuild my plan",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3A8C), // Royal blue matching screenshot
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Helper explanation text
          Text(
            "Weaker topics, based on your topic mastery, get more time and come first. Rebuilding replaces your current plan and progress.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectRow(Map<String, dynamic> s) {
    final bool isSelected = s["selected"] == true;
    final String mastery = s["mastery"] as String;
    final int masteryVal = int.tryParse(mastery.replaceAll('%', '')) ?? 0;

    return InkWell(
      onTap: () {
        setState(() {
          s["selected"] = !isSelected;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8FAFC) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.4 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0F172A) : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1),
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),

            // Subject Title & Weakest Topic
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${s["code"]} · ",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(
                          text: s["name"],
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "Weakest: ${s["weakest"]}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Mastery percentage pill badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: masteryVal > 10 ? const Color(0xFFFEF3C7) : const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                mastery,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: masteryVal > 10 ? const Color(0xFFD97706) : const Color(0xFFDC2626),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Right Column Card: Your plan
  // ---------------------------------------------------------------------------
  Widget _buildYourPlanCard() {
    final int done = _doneTasks;
    final int total = _totalTasks;
    final int doneH = _doneHours;
    final double progress = total > 0 ? (done / total).clamp(0.0, 1.0) : 0.0;

    return Container(
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
          // Header Row: Your plan title + Clear plan link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your plan",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "9 days from Tue, 6 Oct · 3h a day · Deep learning",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: _clearPlan,
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(
                    "Clear plan",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress Row: 0 of 13 tasks done | 0m / 27h
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$done of $total tasks done",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                ),
              ),
              Text(
                "${doneH}m / 27h",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Thin progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 3.5,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
            ),
          ),
          const SizedBox(height: 20),

          // Day Schedule Cards
          ..._planDays.map((d) => _buildDayCard(d)),
        ],
      ),
    );
  }

  Widget _buildDayCard(Map<String, dynamic> day) {
    final int dayNum = day["dayNum"] as int;
    final String dateStr = day["dateStr"] as String;
    final String badge = day["badge"] as String;
    final List<Map<String, dynamic>> tasks = (day["tasks"] as List).cast<Map<String, dynamic>>();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day Header
          Row(
            children: [
              Text(
                "Day $dayNum",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                dateStr,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFD97706),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Tasks in this day
          ...tasks.map((task) => _buildTaskRow(task)),
        ],
      ),
    );
  }

  Widget _buildTaskRow(Map<String, dynamic> task) {
    final bool isDone = task["done"] == true;
    final String type = task["type"] as String;
    final String subject = task["subject"] as String;
    final int hours = task["hours"] as int;

    // Type badge colors
    Color badgeBg;
    Color badgeFg;
    if (type == "Mock test") {
      badgeBg = const Color(0xFFFFEDD5);
      badgeFg = const Color(0xFFC2410C);
    } else if (type == "Revision") {
      badgeBg = const Color(0xFFE6F4EA);
      badgeFg = const Color(0xFF0D9488);
    } else {
      // Study
      badgeBg = const Color(0xFFEEF2FF);
      badgeFg = const Color(0xFF4F46E5);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            task["done"] = !isDone;
          });
        },
        borderRadius: BorderRadius.circular(6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Container(
              width: 17,
              height: 17,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFF0F172A) : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isDone ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1),
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),

            // Task title + Type Tag + Hours
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task["title"] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: isDone ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          type,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: badgeFg,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "$subject · ${hours}h",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

