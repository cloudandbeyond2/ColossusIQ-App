import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_progress.dart';
import '../../data/mock_data.dart';
import '../../data/models/student_model.dart';

class StudentHomeScreen extends StatelessWidget {
  final Function(int)? onNavigateTab;

  const StudentHomeScreen({super.key, this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final data = MockData.studentDashboard;
    final now = DateTime.now();
    final hour = now.hour;
    final greeting = hour < 12
        ? "Good morning"
        : hour < 17
            ? "Good afternoon"
            : "Good evening";

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 95),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Welcome & AI Mentor Hero Card
            _buildHeroAiBanner(context, data, greeting),
            const SizedBox(height: 18),

            // 3 Quick KPI Stat Badges
            _buildQuickStats(data),
            const SizedBox(height: 18),

            // 3 Readiness Progress Cards (Academic, Skills, Career)
            _buildReadinessRow(context, data),
            const SizedBox(height: 20),

            // Today's Timetable Card
            _buildTodaySchedule(context, data),
            const SizedBox(height: 20),

            // Active Project & Upcoming Grid
            _buildProjectAndUpcoming(context, data),
            const SizedBox(height: 20),

            // Weak Topics To Fix Card
            _buildWeakTopics(context, data),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroAiBanner(
      BuildContext context, StudentDashboardData data, String greeting) {
    final dateStr = DateFormat("EEEE, d MMMM").format(DateTime.now());

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08172033),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateStr,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  "$greeting, ${data.name} 👋",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const AppBadge(
                label: "CSE · Sem 5",
                tone: BadgeTone.brand,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // AI Mentor callout container
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.veryLightBlue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryBlue.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryBlue),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "AI Academic Advisor · ${data.priorities} high priorities",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        "AI Verified",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  data.aiRecommendation,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    height: 1.45,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          // Action Buttons
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => onNavigateTab?.call(1), // Courses
                icon: const Icon(Icons.play_circle_outline, size: 18),
                label: const Text("Continue Learning"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => onNavigateTab?.call(4), // AI Mentor
                icon: const Icon(Icons.chat_bubble_outline, size: 16),
                label: const Text("Talk to AI Mentor"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: const BorderSide(color: AppColors.primaryBlue),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(StudentDashboardData data) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            label: "Streak",
            value: "${data.streak} days",
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.emoji_events_rounded,
            label: "Experience",
            value: "${data.xp} XP",
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.calendar_today_rounded,
            label: "Exam in",
            value: "${data.examCountdown.days} days",
          ),
        ),
      ],
    );
  }

  Widget _buildReadinessRow(BuildContext context, StudentDashboardData data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // Academic Card
            AppCard(
              title: "Academic Readiness",
              subtitle: "IA marks & syllabus completion",
              action: const AppBadge(label: "Sem 5", tone: BadgeTone.brand),
              child: Column(
                children: [
                  _MeterRow(
                    label: "Semester progress",
                    value: data.semesterProgress,
                    color: AppColors.brand,
                  ),
                  const SizedBox(height: 12),
                  _MeterRow(
                    label: "Exam readiness",
                    value: data.examReadiness,
                    color: AppColors.toneForScore(data.examReadiness),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Skills Card
            AppCard(
              title: "Skills Profile",
              subtitle: "Department skill graph",
              action: const AppBadge(label: "Technical", tone: BadgeTone.teal),
              child: Column(
                children: [
                  _MeterRow(
                    label: "Technical skills",
                    value: data.technicalSkills,
                    color: AppColors.teal,
                  ),
                  const SizedBox(height: 10),
                  _MeterRow(
                    label: "Communication",
                    value: data.communicationSkills,
                    color: AppColors.sky,
                  ),
                  const SizedBox(height: 10),
                  _MeterRow(
                    label: "Mock interview",
                    value: data.interviewSkills,
                    color: AppColors.toneForScore(data.interviewSkills),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Career Readiness Card
            AppCard(
              title: "Placement Readiness",
              subtitle: "Eligibility for recruitment season",
              action: AppBadge(
                label: "${data.careerReadiness}/100",
                tone: BadgeTone.gold,
              ),
              onTap: () => onNavigateTab?.call(3), // Placement tab
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MeterRow(
                    label: "Overall readiness",
                    value: data.careerReadiness,
                    color: AppColors.gold,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Target: 70+ for Tier-1 IT companies · Tap to view breakdown",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: AppColors.ink3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodaySchedule(BuildContext context, StudentDashboardData data) {
    return AppCard(
      title: "Today's Routine",
      subtitle: "Synced from timetable and AI study planner",
      action: const AppBadge(label: "Timetable", tone: BadgeTone.neutral),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.today.length,
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = data.today[index];
          Color kindColor;
          switch (item.kind) {
            case 'class':
              kindColor = AppColors.brand;
              break;
            case 'project':
              kindColor = AppColors.gold;
              break;
            case 'study':
              kindColor = AppColors.sky;
              break;
            default:
              kindColor = AppColors.teal;
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.line),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 72,
                  child: Text(
                    item.time,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink2,
                    ),
                  ),
                ),
                Container(
                  width: 3.5,
                  height: 32,
                  decoration: BoxDecoration(
                    color: kindColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.ink,
                        ),
                      ),
                      if (item.room.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.room,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.ink3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectAndUpcoming(
      BuildContext context, StudentDashboardData data) {
    return Column(
      children: [
        // Capstone Project Card
        AppCard(
          title: "Active Capstone Project",
          action: const AppBadge(label: "AI Review Ready", tone: BadgeTone.gold),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.projectName,
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: AppLinearProgress(
                      value: data.projectProgress.toDouble(),
                      color: AppColors.gold,
                      height: 8,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "${data.projectProgress}%",
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Milestone 3 of 5 completed",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 12, color: AppColors.ink3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "Project Hub",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brand,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_rounded,
                            size: 14, color: AppColors.brand),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Upcoming Deadlines Card
        AppCard(
          title: "Upcoming Deadlines",
          subtitle: "Examinations, assignments & hackathons",
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.upcoming.length,
            separatorBuilder: (_, index) =>
                const Divider(color: AppColors.line, height: 16),
            itemBuilder: (context, index) {
              final item = data.upcoming[index];
              return InkWell(
                onTap: () => _showDeadlineDetailsDialog(context, item),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.surface2,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.when,
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            color: AppColors.ink2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        icon: const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF0F766E)),
                        onPressed: () => _showDeadlineDetailsDialog(context, item),
                        tooltip: "View Details",
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF4338CA)),
                        onPressed: () => _showEditDeadlineDialog(context, item),
                        tooltip: "Edit Reminder",
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeakTopics(BuildContext context, StudentDashboardData data) {
    return AppCard(
      title: "Weak Topics to Fix",
      subtitle:
          "Exam in ${data.examCountdown.days} days · ${data.examCountdown.syllabusCovered}% syllabus covered",
      action: ElevatedButton(
        onPressed: () => onNavigateTab?.call(2), // Assessments tab
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brand,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          minimumSize: const Size(0, 32),
        ),
        child: const Text(
          "Take Test",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
      child: Column(
        children: data.weakTopics.map((w) {
          final tone = AppColors.toneForScore(w.mastery);
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.gps_fixed, size: 14, color: AppColors.rose),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        w.subject,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink3,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${w.mastery}% mastery",
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: tone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  w.topic,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                AppLinearProgress(
                  value: w.mastery.toDouble(),
                  color: tone,
                  height: 6,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showDeadlineDetailsDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.alarm_on_rounded, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text("Scheduled: ${item.when}", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.event_outlined, size: 16, color: Color(0xFF2563EB)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text("Due Timeline: ${item.when}", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Academic Milestone Notes", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "High priority deadline synced from University examination schedule and faculty course submissions.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditDeadlineDialog(context, item);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit Reminder"),
          ),
        ],
      ),
    );
  }

  void _showEditDeadlineDialog(BuildContext context, dynamic item) {
    final titleCtrl = TextEditingController(text: item.title);
    final whenCtrl = TextEditingController(text: item.when);
    final notesCtrl = TextEditingController(text: "Set priority reminder 24 hours prior to deadline.");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Deadline Reminder", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Deadline Event", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: whenCtrl,
                  decoration: const InputDecoration(labelText: "Due Timeline", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Personal Reminder Notes", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Reminder for '${item.title}' updated!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: Text("Save Reminder", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06172033),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 16, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MeterRow extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _MeterRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.ink2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "$value%",
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AppLinearProgress(
          value: value.toDouble(),
          color: color,
          height: 6,
        ),
      ],
    );
  }
}
