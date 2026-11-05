import '../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';
import '../../core/widgets/responsive_search_bar.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// 1. Project Hub Screen (Image 3)
/// ─────────────────────────────────────────────────────────────────────────────
class ProjectHubScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const ProjectHubScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Project Hub",
      category: "Project & Innovation",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Project & Innovation  ›  Project Hub",
          category: "PROJECT & INNOVATION",
          phase: "MVP",
          isMvp: true,
          icon: Icons.lightbulb_outline_rounded,
          title: "Project Hub",
          subtitle: "Idea → team → architecture → milestones → AI review → faculty review → demo → portfolio.",
          watermarkIcon: Icons.lightbulb_outline_rounded,
        ),
        const SizedBox(height: 18),

        // 2. Action Buttons Row (Image 3)
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProjectIdeaGeneratorScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              icon: const Icon(Icons.lightbulb_outline, size: 16, color: Colors.white),
              label: Text("Generate a new idea", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TeamFinderScreen()));
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.people_outline, size: 16, color: Color(0xFF334155)),
              label: Text("Find teammates", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
            ),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Launching Viva Practice session for this project...")));
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.mic_none_outlined, size: 16, color: Color(0xFF334155)),
              label: Text("Practise viva", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 3. Project 1 Card: Smart Campus AI
        _buildProjectCard(
          context: context,
          title: "Smart Campus AI",
          stageBadge: "AI Review",
          domain: "AI/ML · IoT · Mentor: Dr. Meena Raghavan",
          team: "Anand Kumar, Divya Raman, Karthik Iyer",
          activeStageIndex: 6, // 0-indexed: 6 is 'AI Review'
          scores: {
            "Architecture": 82,
            "Documentation": 64,
            "Code Quality": 76,
            "Testing": 58,
            "Innovation": 88,
          },
        ),
        const SizedBox(height: 20),

        // 4. Project 2 Card: AgriSoil Sense
        _buildProjectCard(
          context: context,
          title: "AgriSoil Sense — low-cost soil health kit",
          stageBadge: "Architecture",
          domain: "AgriTech · Embedded · Mentor: Prof. R. Balaji",
          team: "Anand Kumar, Sanjay Rao",
          activeStageIndex: 2, // 2 is 'Architecture'
          scores: {
            "Architecture": 60,
            "Documentation": 40,
            "Code Quality": null,
            "Testing": null,
            "Innovation": 79,
          },
        ),
      ],
    );
  }

  Widget _buildProjectCard({
    required BuildContext context,
    required String title,
    required String stageBadge,
    required String domain,
    required String team,
    required int activeStageIndex,
    required Map<String, int?> scores,
  }) {
    const stages = [
      "Idea",
      "Team Formation",
      "Architecture",
      "Milestones",
      "Implementation",
      "Testing",
      "AI Review",
      "Faculty Review",
      "Demo",
      "Portfolio",
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  stageBadge,
                  style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFFB45309)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(domain, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
          const SizedBox(height: 8),

          // Team Row
          Row(
            children: [
              const Icon(Icons.person_outline, size: 15, color: Color(0xFF94A3B8)),
              const SizedBox(width: 6),
              Text(team, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569))),
            ],
          ),
          const SizedBox(height: 16),

          // Stepper pipeline horizontal track
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(stages.length, (idx) {
                final isDone = idx < activeStageIndex;
                final isCurrent = idx == activeStageIndex;
                final label = stages[idx];

                Color textColor;
                Color barColor;
                if (isDone) {
                  textColor = const Color(0xFF0F766E);
                  barColor = const Color(0xFF0F766E);
                } else if (isCurrent) {
                  textColor = const Color(0xFFB45309);
                  barColor = const Color(0xFFD97706);
                } else {
                  textColor = const Color(0xFF94A3B8);
                  barColor = const Color(0xFFE2E8F0);
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 76,
                        height: 4,
                        decoration: BoxDecoration(
                          color: barColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${isDone ? '✓ ' : ''}$label",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: isCurrent ? FontWeight.w700 : (isDone ? FontWeight.w500 : FontWeight.w400),
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),

          // Review Board
          Text(
            "AI Project Review Board",
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
          ),
          const SizedBox(height: 12),

          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 12,
                children: scores.entries.map((e) {
                  final metric = e.key;
                  final val = e.value;

                  Color barColor;
                  if (val == null) {
                    barColor = const Color(0xFFE2E8F0);
                  } else if (val >= 75) {
                    barColor = const Color(0xFF0F766E);
                  } else if (val >= 50) {
                    barColor = AppColors.primaryBlue;
                  } else {
                    barColor = const Color(0xFFD97706);
                  }

                  return SizedBox(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(metric, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                            Text(
                              val != null ? "$val" : "—",
                              style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: val != null ? (val / 100).clamp(0.0, 1.0) : 0.0,
                            minHeight: 5,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation(barColor),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            "AI review is advisory; faculty review decides milestone approval.",
            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => _showProjectDetailsDialog(context, title, stageBadge, domain, team, scores),
                icon: const Icon(Icons.visibility_outlined, size: 13),
                label: const Text("View Details"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF0F766E),
                  textStyle: GoogleFonts.poppins(fontSize: 11.5),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () => _showEditProjectDialog(context, title, stageBadge, domain, team),
                icon: const Icon(Icons.edit_outlined, size: 13),
                label: const Text("Edit Project"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  foregroundColor: const Color(0xFF4338CA),
                  textStyle: GoogleFonts.poppins(fontSize: 11.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showProjectDetailsDialog(
    BuildContext context,
    String title,
    String stageBadge,
    String domain,
    String team,
    Map<String, int?> scores,
  ) {
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
              child: const Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text(domain, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Milestone", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(stageBadge, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(6)),
                        child: Text("Active Hub", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFFB45309))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text("Team Members: $team", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
                const SizedBox(height: 10),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 10),
                Text("Milestone Rubric Scores", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 6),
                for (final entry in scores.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569))),
                        Text(entry.value != null ? "${entry.value}%" : "Pending",
                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: entry.value != null ? const Color(0xFF059669) : const Color(0xFF94A3B8))),
                      ],
                    ),
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
              _showEditProjectDialog(context, title, stageBadge, domain, team);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit Project"),
          ),
        ],
      ),
    );
  }

  void _showEditProjectDialog(
    BuildContext context,
    String title,
    String stageBadge,
    String domain,
    String team,
  ) {
    final titleCtrl = TextEditingController(text: title);
    final domainCtrl = TextEditingController(text: domain);
    final teamCtrl = TextEditingController(text: team);
    final repoCtrl = TextEditingController(text: "https://github.com/anandkumar/${title.toLowerCase().replaceAll(' ', '-')}");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Project Workspace", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Project Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: domainCtrl,
                  decoration: const InputDecoration(labelText: "Domain & Mentor", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: teamCtrl,
                  decoration: const InputDecoration(labelText: "Collaborators", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: repoCtrl,
                  decoration: const InputDecoration(labelText: "Repository / Documentation Link", border: OutlineInputBorder()),
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
                  content: Text("Project '${titleCtrl.text}' changes saved!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 2. Project Idea Generator Screen (Image 4)
/// ─────────────────────────────────────────────────────────────────────────────
class ProjectIdeaGeneratorScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ProjectIdeaGeneratorScreen({super.key, this.onBack});

  @override
  State<ProjectIdeaGeneratorScreen> createState() => _ProjectIdeaGeneratorScreenState();
}

class _ProjectIdeaGeneratorScreenState extends State<ProjectIdeaGeneratorScreen> {
  String _department = "CSE";
  String _category = "AI/ML";
  final TextEditingController _skillsController = TextEditingController(text: "Python, React, Arduino...");
  final TextEditingController _budgetController = TextEditingController(text: "5000");
  final TextEditingController _teamSizeController = TextEditingController(text: "3");
  bool _isGenerating = false;
  bool _hasGenerated = false;

  @override
  void dispose() {
    _skillsController.dispose();
    _budgetController.dispose();
    _teamSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Project Idea Generator",
      category: "Project & Innovation",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Project & Innovation  ›  Project Idea Generator",
          category: "PROJECT & INNOVATION",
          phase: "MVP",
          isMvp: true,
          icon: Icons.auto_awesome,
          title: "Project Idea Generator",
          subtitle: "Enter department, skills, interests, budget and team size — get feasible project concepts.",
          watermarkIcon: Icons.auto_awesome,
        ),
        const SizedBox(height: 20),

        // 2. Responsive 2-Column: Inputs + Output
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 320, child: _buildInputsCard()),
                  const SizedBox(width: 20),
                  Expanded(child: _buildOutputCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildInputsCard(),
                const SizedBox(height: 20),
                _buildOutputCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildInputsCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Inputs",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
          ),
          const SizedBox(height: 2),
          Text(
            "Project Mentor",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 18),

          // Department
          Text("Department", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _department,
                isExpanded: true,
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                items: const [
                  DropdownMenuItem(value: "CSE", child: Text("CSE")),
                  DropdownMenuItem(value: "ECE", child: Text("ECE")),
                  DropdownMenuItem(value: "IT", child: Text("IT")),
                  DropdownMenuItem(value: "MECH", child: Text("MECH")),
                  DropdownMenuItem(value: "CIVIL", child: Text("CIVIL")),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _department = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Category
          Text("Category", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _category,
                isExpanded: true,
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                items: const [
                  DropdownMenuItem(value: "AI/ML", child: Text("AI/ML")),
                  DropdownMenuItem(value: "IoT", child: Text("IoT")),
                  DropdownMenuItem(value: "Web3", child: Text("Web3")),
                  DropdownMenuItem(value: "Cybersecurity", child: Text("Cybersecurity")),
                  DropdownMenuItem(value: "Cloud", child: Text("Cloud")),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _category = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Your skills
          Text("Your skills", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          TextField(
            controller: _skillsController,
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
          const SizedBox(height: 14),

          // Budget
          Text("Budget (₹)", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
          const SizedBox(height: 14),

          // Team size
          Text("Team size", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          TextField(
            controller: _teamSizeController,
            keyboardType: TextInputType.number,
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
          const SizedBox(height: 20),

          // CTA Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isGenerating
                  ? null
                  : () async {
                      setState(() => _isGenerating = true);
                      await Future.delayed(const Duration(milliseconds: 700));
                      setState(() {
                        _isGenerating = false;
                        _hasGenerated = true;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF283675),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              icon: _isGenerating
                  ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.auto_awesome, size: 16, color: Colors.white),
              label: Text(
                _isGenerating ? "Generating..." : "Generate project ideas",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputCard() {
    return Container(
      constraints: const BoxConstraints(minHeight: 340),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Output",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
          ),
          const SizedBox(height: 16),

          if (!_hasGenerated)
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _LightBlueprintGridPainter(),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Nothing generated yet",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Fill in the inputs and generate. Output is a draft for you to review\nand edit.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8), height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else ...[
            _generatedIdeaCard(
              "Smart Grid Load Balancing with Edge AI",
              "IoT sensors + Reinforcement Learning on Raspberry Pi 5 to prevent transformer surges.",
              "Feasibility: 92% · Patent Potential",
              "Hardware / ML · Est. ₹4,500",
            ),
            const SizedBox(height: 12),
            _generatedIdeaCard(
              "Federated Healthcare Diagnostic Records",
              "HIPAA compliant encrypted smart contracts with Zero-Knowledge verification for diagnostic records.",
              "Feasibility: 85% · High Industry Demand",
              "Web3 / Health · Est. ₹2,000",
            ),
          ],
        ],
      ),
    );
  }

  Widget _generatedIdeaCard(String title, String desc, String badge, String meta) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              badge,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF059669),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569), height: 1.4),
          ),
          const SizedBox(height: 8),
          Text(
            meta,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4338CA),
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 3. Team Finder Screen (Image 5)
/// ─────────────────────────────────────────────────────────────────────────────
class TeamFinderScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const TeamFinderScreen({super.key, this.onBack});

  @override
  State<TeamFinderScreen> createState() => _TeamFinderScreenState();
}

class _TeamFinderScreenState extends State<TeamFinderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Team Finder",
      category: "Project & Innovation",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Project & Innovation  ›  Team Finder",
          category: "PROJECT & INNOVATION",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.groups_outlined,
          title: "Team Finder",
          subtitle: "Discover teammates by skills, department, interests and competition goals.",
          watermarkIcon: Icons.groups_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Search & Filter Bar (Image 5)
        // 2. Responsive Search & Action Bar
        ResponsiveSearchBar(
          controller: _searchController,
          hintText: "Search team finder...",
          filterValue: _filter,
          filterOptions: const ["All", "CSE", "ECE", "Hackathons"],
          onFilterChanged: (val) {
            if (val != null) setState(() => _filter = val);
          },
          actionLabel: "Post a team request",
          onActionPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post a team request form opened.")));
          },
        ),
        const SizedBox(height: 20),

        // 3. Light Blueprint Grid Empty State (Image 5)
        Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LightBlueprintGridPainter(),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No matching records",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Try a different search or filter.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Light Blueprint Grid Painter for empty states
class _LightBlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    const step = 20.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 4. Startup Idea Hub Screen [P2] (Image 1)
/// ─────────────────────────────────────────────────────────────────────────────
class StartupIdeaHubScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const StartupIdeaHubScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Startup Idea Hub",
      category: "Project & Innovation",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Project & Innovation  ›  Startup Idea Hub",
          category: "PROJECT & INNOVATION",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.rocket_launch_rounded,
          title: "Startup Idea Hub",
          subtitle: "Problem discovery, business model, market analysis, pitch and MVP planning.",
          watermarkIcon: Icons.rocket_launch_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Responsive 2-Column Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildAgriSoilTimelineCard(),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 320,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildProgressCard(),
                        const SizedBox(height: 16),
                        _buildAdvisoryNotice(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAgriSoilTimelineCard(),
                  const SizedBox(height: 20),
                  _buildProgressCard(),
                  const SizedBox(height: 16),
                  _buildAdvisoryNotice(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  /// AgriSoil Sense 11-stage vertical timeline card
  Widget _buildAgriSoilTimelineCard() {
    final stages = [
      _StartupStage(
        title: "Idea",
        desc: "Low-cost soil health kit for small farmers",
        isDone: true,
      ),
      _StartupStage(
        title: "Problem validation",
        desc: "32 farmer interviews in 4 villages",
        tag: "78% test soil less than once a year",
        isDone: true,
      ),
      _StartupStage(
        title: "Market analysis",
        desc: "TAM / SAM / SOM and competitors",
        isDone: true,
      ),
      _StartupStage(
        title: "Customer persona",
        desc: "Small-holder farmer, 2-5 acres",
        isDone: true,
      ),
      _StartupStage(
        title: "Business model",
        desc: "Kit + subscription via FPOs",
        isCurrent: true,
      ),
      _StartupStage(
        title: "MVP",
        desc: "Sensor prototype + Tamil voice app",
      ),
      _StartupStage(
        title: "Mentor",
        desc: "Assigned: agri-tech alumnus",
      ),
      _StartupStage(
        title: "Prototype",
        desc: "Field test with 10 farmers",
      ),
      _StartupStage(
        title: "Pitch deck",
        desc: "10-slide deck for angels/incubator",
      ),
      _StartupStage(
        title: "Legal & IP",
        desc: "Provisional patent filing and IP assignment",
      ),
      _StartupStage(
        title: "Launch & Incubation",
        desc: "Colossus Incubation Centre seed round",
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AgriSoil Sense",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "4 of 11 stages complete",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 24),

          // Timeline items
          ...List.generate(stages.length, (index) {
            final stage = stages[index];
            final isLast = index == stages.length - 1;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Indicator Column
                  SizedBox(
                    width: 32,
                    child: Column(
                      children: [
                        // Node Icon
                        if (stage.isDone)
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0F766E),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            ),
                          )
                        else if (stage.isCurrent)
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD97706),
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.auto_awesome,
                                size: 14,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFCBD5E1),
                                width: 2,
                              ),
                            ),
                          ),

                        // Connector Line
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: stage.isDone
                                  ? const Color(0xFF0F766E)
                                  : const Color(0xFFE2E8F0),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Stage Content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                stage.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 13.5,
                                  fontWeight: stage.isCurrent
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              if (stage.isCurrent) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF3C7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Current",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFD97706),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            stage.desc,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          if (stage.tag != null) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Text(
                                stage.tag!,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Right Card 1: Overall progress
  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
            "36%",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.36,
              minHeight: 8,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0F766E)),
            ),
          ),
        ],
      ),
    );
  }

  /// Right Card 2: Advisory notice
  Widget _buildAdvisoryNotice() {
    return Container(
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
            Icons.info_outline,
            size: 18,
            color: Color(0xFF1D4ED8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Each stage can be supported by an AI agent, but stage approvals are made by your mentor or faculty.",
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

class _StartupStage {
  final String title;
  final String desc;
  final String? tag;
  final bool isDone;
  final bool isCurrent;

  _StartupStage({
    required this.title,
    required this.desc,
    this.tag,
    this.isDone = false,
    this.isCurrent = false,
  });
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 5. Research Assistant Screen [P2] (Image 2)
/// ─────────────────────────────────────────────────────────────────────────────
class ResearchAssistantScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ResearchAssistantScreen({super.key, this.onBack});

  @override
  State<ResearchAssistantScreen> createState() => _ResearchAssistantScreenState();
}

class _ResearchAssistantScreenState extends State<ResearchAssistantScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void _sendMessage([String? text]) {
    final query = text ?? _msgController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": query});
      _messages.add({
        "sender": "agent",
        "text":
            "Analyzing academic literature and drafting paper outline for: \"$query\"...\n\nVerified sources from IEEE Xplore, ACM Digital Library and arXiv have been synthesized."
      });
    });
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Research Assistant",
      category: "Project & Innovation",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Project & Innovation  ›  Research Assistant",
          category: "PROJECT & INNOVATION",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.science_outlined,
          title: "Research Assistant",
          subtitle: "Research questions, literature discovery and comparison, planning and academic writing.",
          watermarkIcon: Icons.science_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Responsive 2-Column Chat & Sidebar
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildChatCard(),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 320,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildAgentSidebarCard(),
                        const SizedBox(height: 16),
                        _buildInstitutionSourceNotice(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildChatCard(),
                  const SizedBox(height: 20),
                  _buildAgentSidebarCard(),
                  const SizedBox(height: 16),
                  _buildInstitutionSourceNotice(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  /// Main Chat Card
  Widget _buildChatCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Context bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.hub_outlined, size: 14, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Text(
                      "CONTEXT",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
                _contextChip("Field: Computer Science"),
                _contextChip("Level: UG"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Agent initial greeting
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.smart_toy_rounded,
                          size: 18,
                          color: Color(0xFFE5B84A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Research Agent",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(14),
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              ),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              "I can help you frame research questions, find and compare literature, and plan your paper. I will flag when a claim needs a verified source.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF334155),
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Prompt Starters
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    _promptStarter(
                      Icons.lightbulb_outline,
                      "Research questions on IoT for agriculture",
                    ),
                    _promptStarter(
                      Icons.menu_book_outlined,
                      "Compare approaches to handwriting OCR",
                    ),
                    _promptStarter(
                      Icons.trending_up_rounded,
                      "Outline an IEEE conference paper",
                    ),
                  ],
                ),

                // Dynamic message thread
                if (_messages.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  ..._messages.map((m) {
                    final isUser = m["sender"] == "user";
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 520),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isUser ? AppColors.primaryBlue : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isUser ? Colors.transparent : const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            m["text"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: isUser ? Colors.white : const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
                const SizedBox(height: 36),

                // Message input box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          onSubmitted: _sendMessage,
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                          decoration: InputDecoration(
                            hintText: "Message Research Agent...",
                            hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _sendMessage(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFF818CF8),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.near_me_rounded, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Enter to send · Shift+Enter for a new line · Don't share passwords or personal IDs",
                        style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "0/2000",
                      style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
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

  Widget _contextChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569)),
      ),
    );
  }

  Widget _promptStarter(IconData icon, String text) {
    return InkWell(
      onTap: () => _sendMessage(text),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 14, color: const Color(0xFF475569)),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF334155),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Right Card 1: Agent details
  Widget _buildAgentSidebarCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AGENT",
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Research Agent",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Research questions, literature discovery and comparison, academic writing.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  /// Right Card 2: Institution source notice
  Widget _buildInstitutionSourceNotice() {
    return Container(
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
            Icons.info_outline,
            size: 18,
            color: Color(0xFF1D4ED8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF1E3A8A),
                  height: 1.45,
                ),
                children: const [
                  TextSpan(text: "Answers marked "),
                  TextSpan(
                    text: "Institution source",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        " come from approved documents. Everything else is a general AI explanation — verify before relying on it.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 6. Hackathon Hub Screen [P3] (Image 3)
/// ─────────────────────────────────────────────────────────────────────────────
class HackathonHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HackathonHubScreen({super.key, this.onBack});

  @override
  State<HackathonHubScreen> createState() => _HackathonHubScreenState();
}

class _HackathonHubScreenState extends State<HackathonHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Hackathon Hub",
      category: "Project & Innovation",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Project & Innovation  ›  Hackathon Hub",
          category: "PROJECT & INNOVATION",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.code_rounded,
          title: "Hackathon Hub",
          subtitle: "Upcoming hackathons, teams, problem statements and results.",
          watermarkIcon: Icons.code_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Responsive Search & Action Bar (Image 2)
        ResponsiveSearchBar(
          controller: _searchController,
          hintText: "Search hackathon hub...",
          filterValue: _filter,
          filterOptions: const ["All", "Active", "Completed"],
          onFilterChanged: (val) {
            if (val != null) setState(() => _filter = val);
          },
          actionLabel: "Create hackathon",
          onActionPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Create hackathon modal opened.")),
            );
          },
        ),
        const SizedBox(height: 20),

        // 3. Light Blueprint Grid Empty State (Image 3)
        Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LightBlueprintGridPainter(),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No matching records",
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Try a different search or filter.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


