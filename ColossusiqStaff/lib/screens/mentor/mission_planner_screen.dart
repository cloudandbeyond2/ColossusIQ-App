import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// MISSION PLANNER SCREEN
// Matches Image 1 (media_1793783426290_bc89effd.jpg) & Image 2 (media_1793783437538_a6df3ceb.png)
// =============================================================================

class MissionPlannerScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const MissionPlannerScreen({super.key, this.onBack});

  @override
  State<MissionPlannerScreen> createState() => _MissionPlannerScreenState();
}

class _MissionPlannerScreenState extends State<MissionPlannerScreen> {
  final TextEditingController _goalController =
      TextEditingController(text: "Software Engineer");
  final TextEditingController _hoursController =
      TextEditingController(text: "6");
  final TextEditingController _notesController = TextEditingController();

  late List<_RoadmapStage> _stages;

  @override
  void initState() {
    super.initState();
    _initDefaultStages();
  }

  void _initDefaultStages() {
    _stages = [
      _RoadmapStage(
        stageNumber: 1,
        title: "Next 4 weeks",
        period: "Weeks 1 to 4",
        badge: "Current",
        isCurrent: true,
        subtitle:
            "Close your biggest gaps first and get ready for CSE101 Internal Assessment II (9 days away).",
        tasks: [
          _RoadmapTask(
            "Week 1: raise Design & Analysis Methodology (CSE101) from 4% to at least 29% with one revision session and one practice set",
          ),
          _RoadmapTask(
            "Week 2: raise Design & Analysis Methodology (AID101) from 9% to at least 34% with one revision session and one practice set",
          ),
          _RoadmapTask(
            "Week 3: finish your revision plan for CSE101 Internal Assessment II and take one timed mock test",
          ),
          _RoadmapTask(
            "Week 4: keep attendance at 75% or more in every subject",
          ),
          _RoadmapTask(
            "Study about 6 hours a week and track it in the Study Planner",
          ),
        ],
      ),
      _RoadmapStage(
        stageNumber: 2,
        title: "This semester (Sem 3)",
        period: "Sem 3",
        subtitle:
            "Strengthen your marks and build proof of skill alongside classes.",
        tasks: [
          _RoadmapTask("Lift your internal-marks average from 46 to 54"),
          _RoadmapTask(
            'Take your project "Smart Campus AI & Autonomous Attendance" from 68% to 98%',
          ),
          _RoadmapTask(
            "Earn one certificate that supports your goal: Software Engineer",
          ),
          _RoadmapTask(
            "Take at least two more mock tests and review every mistake",
          ),
        ],
      ),
      _RoadmapStage(
        stageNumber: 3,
        title: "Build skills and a portfolio",
        period: "Sem 4 to 6",
        subtitle:
            "Learn what Software Engineer actually requires and show it in real work.",
        tasks: [
          _RoadmapTask(
            "List the five core skills for Software Engineer and rate yourself honestly",
          ),
          _RoadmapTask(
            "Finish one course or certificate in your weakest skill",
          ),
          _RoadmapTask(
            "Complete a project and publish it with a clear write-up",
          ),
          _RoadmapTask("Join one club, competition or hackathon"),
        ],
      ),
      _RoadmapStage(
        stageNumber: 4,
        title: "Internship and capstone",
        period: "Sem 7",
        subtitle: "Get real-world experience and a strong final project.",
        tasks: [
          _RoadmapTask(
            "Apply to at least 10 internships or industry projects for Software Engineer",
          ),
          _RoadmapTask(
            "Complete an internship, industry project or capstone with a working demo",
          ),
          _RoadmapTask("Ask a mentor or supervisor for feedback and a reference"),
        ],
      ),
      _RoadmapStage(
        stageNumber: 5,
        title: "Applications and interviews",
        period: "Sem 8",
        subtitle: "Prepare and apply for your next step: Software Engineer.",
        tasks: [
          _RoadmapTask("Reach a placement readiness score of 75 or more"),
          _RoadmapTask(
            "Complete at least five mock interviews and act on the feedback",
          ),
          _RoadmapTask("Update your resume and get it checked"),
          _RoadmapTask(
            "Apply to the companies, programmes or exams that lead to Software Engineer",
          ),
        ],
      ),
      _RoadmapStage(
        stageNumber: 6,
        title: "Goal: Software Engineer",
        period: "After graduation",
        subtitle: "You are working in, or accepted for, Software Engineer.",
        tasks: [
          _RoadmapTask(
            "An offer, admission or role secured for Software Engineer",
          ),
          _RoadmapTask("A plan for your first six months in it"),
        ],
      ),
    ];
  }

  int get _totalMilestones =>
      _stages.fold(0, (sum, stage) => sum + stage.tasks.length);

  int get _completedMilestones => _stages.fold(
        0,
        (sum, stage) =>
            sum + stage.tasks.where((t) => t.isCompleted).length,
      );

  int get _progressPct => _totalMilestones == 0
      ? 0
      : ((_completedMilestones / _totalMilestones) * 100).round();

  int get _completedStages =>
      _stages.where((s) => s.tasks.every((t) => t.isCompleted)).length;

  void _rebuildRoadmap() {
    setState(() {
      _initDefaultStages();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Roadmap rebuilt for ${_goalController.text.trim()} (${_hoursController.text.trim()} h/week)!",
        ),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearRoadmap() {
    setState(() {
      for (var s in _stages) {
        for (var t in s.tasks) {
          t.isCompleted = false;
        }
      }
    });
  }

  @override
  void dispose() {
    _goalController.dispose();
    _hoursController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Mission Planner",
      category: "Student Success",
      onBack: widget.onBack ??
          (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner matching Image 1
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Student Success  ›  Mission Planner",
          category: "STUDENT SUCCESS",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.track_changes_rounded,
          title: "Mission Planner",
          subtitle:
              'Turn "where do I want to be after graduation?" into semester, monthly, weekly and daily plans.',
          watermarkIcon: Icons.track_changes_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Responsive 3-Column / Stacked Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 1020;
            final isTablet = constraints.maxWidth >= 720 && !isDesktop;

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Form Column (320px)
                  SizedBox(
                    width: 320,
                    child: _buildLeftFormSection(),
                  ),
                  const SizedBox(width: 20),

                  // Middle Timeline Column (Expanded)
                  Expanded(
                    child: _buildTimelineSection(),
                  ),
                  const SizedBox(width: 20),

                  // Right Progress & Focus Column (260px)
                  SizedBox(
                    width: 260,
                    child: _buildRightProgressSection(),
                  ),
                ],
              );
            } else if (isTablet) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildLeftFormSection()),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 280,
                        child: _buildRightProgressSection(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTimelineSection(),
                ],
              );
            } else {
              // Mobile View
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRightProgressSection(),
                  const SizedBox(height: 18),
                  _buildLeftFormSection(),
                  const SizedBox(height: 18),
                  _buildTimelineSection(),
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
  // Left Column: Where do you want to be? Form Card
  // ---------------------------------------------------------------------------
  Widget _buildLeftFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                "Where do you want to be?",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "B.E. Computer Science & Engineering · semester 3 of 8",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 18),

              // Field 1: Goal
              Text(
                "Your goal after graduation",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _goalController,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0F172A),
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF2E3A94), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Field 2: Hours per week
              Text(
                "Hours you can study per week",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _hoursController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0F172A),
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF2E3A94), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Field 3: Notes (optional)
              Text(
                "In your own words (optional)",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _notesController,
                maxLines: 3,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF0F172A),
                ),
                decoration: InputDecoration(
                  hintText: "What does success look like for you?",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF2E3A94), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Button: Rebuild my roadmap
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _rebuildRoadmap,
                  icon: const Icon(Icons.auto_awesome_rounded, size: 16),
                  label: Text(
                    "Rebuild my roadmap",
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3A94),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Text(
                "The roadmap uses your own marks, weakest topics, attendance, next exam and project. Rebuilding replaces your current roadmap and progress.",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Light blue info card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 18,
                color: Color(0xFF1D4ED8),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Each stage can be supported by an AI agent, but stage approvals are made by your mentor or faculty.",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF1E3A8A),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Middle Column: Roadmap Timeline Card
  // ---------------------------------------------------------------------------
  Widget _buildTimelineSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Roadmap to: ${_goalController.text.trim()}",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "$_completedStages of ${_stages.length} stages complete · ${_hoursController.text.trim()} h/week",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _clearRoadmap,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF475569),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Clear",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Timeline Stages
          ..._stages.asMap().entries.map((entry) {
            final idx = entry.key;
            final stage = entry.value;
            final isLast = idx == _stages.length - 1;

            return _buildStageTimelineItem(stage, isLast: isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildStageTimelineItem(_RoadmapStage stage, {required bool isLast}) {
    final isStageDone = stage.tasks.isNotEmpty && stage.tasks.every((t) => t.isCompleted);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Node & Connecting Line
          SizedBox(
            width: 32,
            child: Column(
              children: [
                // Node circle
                if (stage.isCurrent)
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
                    ),
                    child: const Icon(
                      Icons.track_changes_rounded,
                      size: 14,
                      color: Color(0xFFB45309),
                    ),
                  )
                else if (isStageDone)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFF16A34A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  )
                else
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
                    ),
                  ),

                // Connecting vertical line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Right Stage Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Period + Badge (Uses Wrap to prevent overflow on mobile)
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(
                        stage.title,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        stage.period,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      if (stage.badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            stage.badge!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    stage.subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF475569),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Tasks Checkbox List
                  ...stage.tasks.map((task) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            task.isCompleted = !task.isCompleted;
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2, right: 10),
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: BoxDecoration(
                                  color: task.isCompleted
                                      ? const Color(0xFF2E3A94)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: task.isCompleted
                                        ? const Color(0xFF2E3A94)
                                        : const Color(0xFFCBD5E1),
                                    width: 1.5,
                                  ),
                                ),
                                child: task.isCompleted
                                    ? const Icon(
                                        Icons.check_rounded,
                                        size: 13,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                task.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: task.isCompleted
                                      ? const Color(0xFF94A3B8)
                                      : const Color(0xFF334155),
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Right Column: Progress Card & Focus Next Card
  // ---------------------------------------------------------------------------
  Widget _buildRightProgressSection() {
    // Collect next 3 uncompleted tasks from stage 1
    final stage1Uncompleted = _stages.isNotEmpty
        ? _stages[0].tasks.where((t) => !t.isCompleted).take(3).toList()
        : <_RoadmapTask>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Overall Progress Card
        Container(
          width: double.infinity,
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
                "Overall progress",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "$_progressPct%",
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: _totalMilestones > 0
                      ? (_completedMilestones / _totalMilestones)
                      : 0.0,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFF1F5F9),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF2E3A94),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                "$_completedMilestones of $_totalMilestones milestones done",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 2. Focus Next Card
        Container(
          width: double.infinity,
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
                "Focus next",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 14),

              if (stage1Uncompleted.isEmpty)
                Text(
                  "All immediate focus tasks completed! Continue onto the next semester stages.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF15803D),
                    height: 1.45,
                  ),
                )
              else
                ...stage1Uncompleted.map((task) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      task.title,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF334155),
                        height: 1.45,
                      ),
                    ),
                  );
                }),

              const SizedBox(height: 8),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 10),
              Text(
                "Built from your records. With AI on, roadmaps are tailored further.",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Data Models
// -----------------------------------------------------------------------------
class _RoadmapStage {
  final int stageNumber;
  final String title;
  final String period;
  final String? badge;
  final bool isCurrent;
  final String subtitle;
  final List<_RoadmapTask> tasks;

  _RoadmapStage({
    required this.stageNumber,
    required this.title,
    required this.period,
    this.badge,
    this.isCurrent = false,
    required this.subtitle,
    required this.tasks,
  });
}

class _RoadmapTask {
  final String title;
  bool isCompleted;

  _RoadmapTask(this.title) : isCompleted = false;
}
