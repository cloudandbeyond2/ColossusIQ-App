import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// 1. Project Hub Screen (Image 3)
/// ─────────────────────────────────────────────────────────────────────────────
class ProjectHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ProjectHubScreen({super.key, this.onBack});

  @override
  State<ProjectHubScreen> createState() => _ProjectHubScreenState();
}

class _ProjectHubScreenState extends State<ProjectHubScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<String> _stages = [
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

  late List<Map<String, dynamic>> _projects;

  @override
  void initState() {
    super.initState();
    _projects = [
      {
        "id": "proj_1",
        "title": "Smart Concrete: Crack-Healing Bio-Concrete Using Industrial Fly Ash",
        "domain": "Civil · Structural & Sustainable Infra · Mentor: Dr. K. Saravanan",
        "team": "Lead Student",
        "stage": "Architecture",
        "stageIndex": 2, // 20%
        "progress": 0.20,
        "badgeBg": const Color(0xFFFEF3C7),
        "badgeColor": const Color(0xFFB45309),
        "repoUrl": "https://drive.google.com/drive/folders/civil-autocad",
        "docUrl": null,
        "demoUrl": null,
        "scores": {
          "Architecture": null,
          "Documentation": null,
          "Code / Build Quality": null,
          "Testing": null,
          "Innovation": null,
        },
      },
      {
        "id": "proj_2",
        "title": "Autonomous Campus Smart Delivery Rover",
        "domain": "AI/ML · IoT & Edge Computing · Mentor: Dr. Meena Raghavan",
        "team": "Lead Student, Priya V.",
        "stage": "Portfolio",
        "stageIndex": 9, // 100%
        "progress": 1.00,
        "badgeBg": const Color(0xFFCCFBF1),
        "badgeColor": const Color(0xFF0F766E),
        "repoUrl": "https://github.com/campus-rover/firmware",
        "docUrl": "https://docs.google.com/document/d/rover-spec",
        "demoUrl": "https://rover-demo.campus.edu",
        "scores": {
          "Architecture": 92,
          "Documentation": 88,
          "Code / Build Quality": 90,
          "Testing": 85,
          "Innovation": 95,
        },
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProjects = _projects.where((p) {
      if (_searchQuery.isEmpty) return true;
      final t = (p["title"] as String).toLowerCase();
      final d = (p["domain"] as String).toLowerCase();
      final team = (p["team"] as String).toLowerCase();
      return t.contains(_searchQuery) || d.contains(_searchQuery) || team.contains(_searchQuery);
    }).toList();

    return PortalPageBody(
      title: "Project Hub",
      category: "Project & Innovation",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Project & Innovation  ›  Project Hub",
          category: "PROJECT & INNOVATION",
          phase: "MVP",
          isMvp: true,
          icon: Icons.lightbulb_outline_rounded,
          title: "Project Hub",
          subtitle: "Idea -> team -> architecture -> milestones -> AI review -> faculty review -> demo -> portfolio.",
          watermarkIcon: Icons.lightbulb_outline_rounded,
        ),
        const SizedBox(height: 18),

        // 2. Action Buttons & Search Bar
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 850;

            final actionButtons = Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _showStartNewProjectDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4338CA),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  label: Text("+ Start New Project", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProjectIdeaGeneratorScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFF334155)),
                  label: Text("Generate Idea", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TeamFinderScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.people_outline, size: 16, color: Color(0xFF334155)),
                  label: Text("Find Teammates", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Launching Viva Practice session for this project...")));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.mic_none_outlined, size: 16, color: Color(0xFF334155)),
                  label: Text("Practise Viva", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF334155))),
                ),
              ],
            );

            final searchInput = SizedBox(
              width: isNarrow ? double.infinity : 260,
              height: 40,
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v.trim().toLowerCase()),
                style: GoogleFonts.poppins(fontSize: 12),
                decoration: InputDecoration(
                  hintText: "Search projects, domains, mentors...",
                  hintStyle: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  actionButtons,
                  const SizedBox(height: 12),
                  searchInput,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: actionButtons),
                const SizedBox(width: 16),
                searchInput,
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // 3. Project Cards List
        if (filteredProjects.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Center(
              child: Text(
                "No projects found matching '$_searchQuery'",
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
              ),
            ),
          )
        else
          Column(
            children: filteredProjects.map((p) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildProjectCard(p),
              );
            }).toList(),
          ),
      ],
    );
  }

  // --- PROJECT CARD (IMAGE 3) ---
  Widget _buildProjectCard(Map<String, dynamic> p) {
    final title = p["title"] as String;
    final domain = p["domain"] as String;
    final team = p["team"] as String;
    final stage = p["stage"] as String;
    final stageIndex = p["stageIndex"] as int;
    final progress = p["progress"] as double;
    final badgeBg = p["badgeBg"] as Color;
    final badgeColor = p["badgeColor"] as Color;
    final repoUrl = p["repoUrl"] as String?;
    final docUrl = p["docUrl"] as String?;
    final demoUrl = p["demoUrl"] as String?;
    final scores = p["scores"] as Map<String, dynamic>;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Title, Category & Top Action Buttons
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 620;

              final titleCol = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    domain,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );

              final actionBadges = Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      stage,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: badgeColor,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => _showAdvanceStageDialog(p),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                    ),
                    child: Text(
                      "Advance Stage",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 16, color: Color(0xFF94A3B8)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => _showDeleteProjectDialog(p),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleCol,
                    const SizedBox(height: 10),
                    actionBadges,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: titleCol),
                  const SizedBox(width: 12),
                  actionBadges,
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          // Row 2: Team Members & Repository Links (Responsive Wrap)
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 580;

              final teamRow = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.people_outline, size: 15, color: Color(0xFF0D9488)),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "Team: $team",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F766E)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TeamFinderScreen()));
                    },
                    child: Text(
                      "+ Find Teammates",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF0D9488), decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              );

              final linksWrap = Wrap(
                spacing: 12,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (repoUrl != null)
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening repository: $repoUrl")));
                      },
                      child: Text(
                        "</> Repository",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                      ),
                    ),
                  if (docUrl != null)
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening docs: $docUrl")));
                      },
                      child: Text(
                        "Architecture Docs",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                      ),
                    ),
                  if (demoUrl != null)
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening demo: $demoUrl")));
                      },
                      child: Text(
                        "🌐 Live Demo",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                      ),
                    ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    teamRow,
                    const SizedBox(height: 8),
                    linksWrap,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: teamRow),
                  const SizedBox(width: 12),
                  linksWrap,
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 14),

          // Row 3: Lifecycle Stepper & Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Project Lifecycle",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Text(
                "${(progress * 100).toInt()}% completed",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Lifecycle 10-Stage Horizontal Track
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_stages.length, (idx) {
                final isDone = idx < stageIndex;
                final isCurrent = idx == stageIndex;
                final label = _stages[idx];

                Color barColor;
                Color textColor;
                if (isDone) {
                  barColor = const Color(0xFF0D9488);
                  textColor = const Color(0xFF0F766E);
                } else if (isCurrent) {
                  barColor = const Color(0xFFD97706);
                  textColor = const Color(0xFFB45309);
                } else {
                  barColor = const Color(0xFFE2E8F0);
                  textColor = const Color(0xFF94A3B8);
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 72,
                        height: 3.5,
                        decoration: BoxDecoration(
                          color: barColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${isDone ? '✓ ' : ''}$label",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
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
          const SizedBox(height: 18),

          // Row 4: AI Project Review Board Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF1F5F9)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, size: 14, color: Color(0xFF4338CA)),
                    const SizedBox(width: 6),
                    Text(
                      "AI Project Review Board",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 24,
                  runSpacing: 8,
                  children: [
                    _buildMetricCol("Architecture", scores["Architecture"]),
                    _buildMetricCol("Documentation", scores["Documentation"]),
                    _buildMetricCol("Code / Build Quality", scores["Code / Build Quality"]),
                    _buildMetricCol("Testing", scores["Testing"]),
                    _buildMetricCol("Innovation", scores["Innovation"]),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "AI review is advisory; faculty review decides milestone approval and portfolio publication.",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCol(String label, dynamic val) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 8),
        Text(
          val != null ? "$val%" : "-",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: val != null ? const Color(0xFF0F766E) : const Color(0xFFB45309),
          ),
        ),
      ],
    );
  }

  // --- ADVANCE LIFECYCLE STAGE MODAL (IMAGE 4) ---
  void _showAdvanceStageDialog(Map<String, dynamic> p) {
    final title = p["title"] as String;
    final currentStage = p["stage"] as String;
    final currentStageIndex = (p["stageIndex"] as int?) ?? 0;
    final currentPercent = (((p["progress"] as double?) ?? 0.0) * 100).toInt();

    // All stages available in the selector
    final candidateStages = <Map<String, dynamic>>[];
    for (int i = 0; i < _stages.length; i++) {
      final percent = ((i + 1) / _stages.length * 100).toInt();
      candidateStages.add({
        "name": _stages[i],
        "index": i,
        "percent": percent,
        "label": "${_stages[i]} — ($percent% progress)",
      });
    }

    // Default to the next stage if available, otherwise current stage
    final defaultIndex = currentStageIndex < _stages.length - 1
        ? currentStageIndex + 1
        : currentStageIndex.clamp(0, candidateStages.length - 1);
    var selectedStageObj = candidateStages[defaultIndex];

    final repoCtrl = TextEditingController(text: p["repoUrl"] ?? "");
    final docCtrl = TextEditingController(text: p["docUrl"] ?? "");
    final demoCtrl = TextEditingController(text: p["demoUrl"] ?? "");

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 520),
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Advance Lifecycle Stage",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                title,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Stage Selector Dropdown
                    Text(
                      "Select Stage to Advance To",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Map<String, dynamic>>(
                          value: selectedStageObj,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF0F172A)),
                          items: candidateStages.map((st) {
                            return DropdownMenuItem<Map<String, dynamic>>(
                              value: st,
                              child: Text(st["label"] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setModalState(() => selectedStageObj = val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Current vs New Stage Banner (Image 4 - Responsive Wrap)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 6,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Current: ",
                                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                              ),
                              Text(
                                "$currentStage ($currentPercent%)",
                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0xFF1E3A8A)),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "New: ",
                                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                              ),
                              Text(
                                "${selectedStageObj["name"]} (${selectedStageObj["percent"]}%)",
                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF1E3A8A)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field 1: Repo URL
                    Text(
                      "Repository / CAD / Design Files URL",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: repoCtrl,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        hintText: "https://github.com/anna-univ/smart-rover",
                        hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Field 2: Documentation URL
                    Text(
                      "Documentation / Spec Sheet / CAD Drawing URL",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: docCtrl,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        hintText: "https://docs.google.com/document/d/rover-architecture",
                        hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Field 3: Live Demo URL
                    Text(
                      "Live Demo / Prototype Video URL",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: demoCtrl,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        hintText: "https://smart-rover-demo.vercel.app",
                        hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Actions Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          ),
                          child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              final newStageName = selectedStageObj["name"] as String;
                              final newStageIndex = selectedStageObj["index"] as int;
                              final newPercent = selectedStageObj["percent"] as int;

                              p["stage"] = newStageName;
                              p["stageIndex"] = newStageIndex;
                              p["progress"] = newPercent / 100.0;

                              // Dynamic badge colors based on stage
                              if (newStageName == "Portfolio") {
                                p["badgeBg"] = const Color(0xFFCCFBF1);
                                p["badgeColor"] = const Color(0xFF0F766E);
                              } else if (newStageIndex >= 6) {
                                p["badgeBg"] = const Color(0xFFEDE9FE);
                                p["badgeColor"] = const Color(0xFF6D28D9);
                              } else if (newStageIndex >= 4) {
                                p["badgeBg"] = const Color(0xFFDBEAFE);
                                p["badgeColor"] = const Color(0xFF1D4ED8);
                              } else {
                                p["badgeBg"] = const Color(0xFFFEF3C7);
                                p["badgeColor"] = const Color(0xFFB45309);
                              }

                              p["repoUrl"] = repoCtrl.text.trim().isNotEmpty ? repoCtrl.text.trim() : null;
                              p["docUrl"] = docCtrl.text.trim().isNotEmpty ? docCtrl.text.trim() : null;
                              p["demoUrl"] = demoCtrl.text.trim().isNotEmpty ? demoCtrl.text.trim() : null;

                              // Unlock realistic evaluation marks if moving into review/demo/portfolio stages
                              if (newStageIndex >= 6) {
                                final scores = p["scores"] as Map<String, dynamic>;
                                scores["Architecture"] ??= 92;
                                scores["Documentation"] ??= 88;
                                scores["Code / Build Quality"] ??= 90;
                                scores["Testing"] ??= 85;
                                scores["Innovation"] ??= 95;
                              }
                            });
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Stage advanced to '${selectedStageObj["name"]}' (${selectedStageObj["percent"]}%)!"),
                                backgroundColor: const Color(0xFF0D9488),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF312E81),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            elevation: 0,
                          ),
                          child: Text("Update Progress", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- DELETE PROJECT MODAL (IMAGE 5) ---
  void _showDeleteProjectDialog(Map<String, dynamic> p) {
    final title = p["title"] as String;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
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
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 22),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delete Project",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            "This action cannot be undone",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20, color: Color(0xFF94A3B8)),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF334155), height: 1.5),
                  children: [
                    const TextSpan(text: "Are you sure you want to delete "),
                    TextSpan(
                      text: "\"$title\"",
                      style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                    ),
                    const TextSpan(
                      text: "? All recorded lifecycle stages, repository links, and review scores will be permanently removed.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                    child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _projects.removeWhere((item) => item["id"] == p["id"]);
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Project '$title' deleted."),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB91C1C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      elevation: 0,
                    ),
                    child: Text("Delete Project", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- START NEW PROJECT MODAL ---
  void _showStartNewProjectDialog() {
    final titleCtrl = TextEditingController();
    final domainCtrl = TextEditingController(text: "CSE · Cloud & Distributed Computing · Mentor: Dr. K. Saravanan");
    final teamCtrl = TextEditingController(text: "Lead Student");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Start New Project", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
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
                decoration: const InputDecoration(labelText: "Department · Domain · Mentor", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: teamCtrl,
                decoration: const InputDecoration(labelText: "Team Collaborators", border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.trim().isEmpty) return;
              setState(() {
                _projects.insert(0, {
                  "id": "proj_${DateTime.now().millisecondsSinceEpoch}",
                  "title": titleCtrl.text.trim(),
                  "domain": domainCtrl.text.trim(),
                  "team": teamCtrl.text.trim(),
                  "stage": "Idea",
                  "stageIndex": 0,
                  "progress": 0.10,
                  "badgeBg": const Color(0xFFFEF3C7),
                  "badgeColor": const Color(0xFFB45309),
                  "repoUrl": null,
                  "docUrl": null,
                  "demoUrl": null,
                  "scores": {
                    "Architecture": null,
                    "Documentation": null,
                    "Code / Build Quality": null,
                    "Testing": null,
                    "Innovation": null,
                  },
                });
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("New project '${titleCtrl.text.trim()}' initiated!"), behavior: SnackBarBehavior.floating),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4338CA), foregroundColor: Colors.white),
            child: const Text("Create Project"),
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
/// 3. Team Finder Screen (Matching Images 1, 2, 3, 4, 5)
/// ─────────────────────────────────────────────────────────────────────────────
class TeamFinderScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const TeamFinderScreen({super.key, this.onBack});

  @override
  State<TeamFinderScreen> createState() => _TeamFinderScreenState();
}

class _TeamFinderScreenState extends State<TeamFinderScreen> {
  int _selectedTab = 0; // 0: My Classmates, 1: Inter-Department, 2: Campus Requests
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedDeptFilter = "All Other Departments";

  final List<String> _deptFilterOptions = [
    "All Other Departments",
    "Electronics & Communication",
    "Management Studies",
    "Information Technology",
    "Artificial Intelligence & Data Science",
    "Mechanical Engineering",
  ];

  final List<String> _availableProjects = [
    "Smart Concrete: Crack-Healing Bio-Concrete Using Industrial Fly Ash",
    "Autonomous Campus Smart Delivery Rover",
    "Autonomous Drone-Based Crop Health Scanner",
  ];

  late List<Map<String, dynamic>> _classmates;
  late List<Map<String, dynamic>> _interDeptCandidates;
  late List<Map<String, dynamic>> _campusRequests;

  @override
  void initState() {
    super.initState();
    _classmates = [
      {
        "id": "cm_1",
        "name": "Rahul S.",
        "avatar": "RS",
        "dept": "Computer Science & Engineering",
        "match": "94% Match",
        "bio": "Passionate about building responsive UI/UX and client-side web applications.",
        "skills": ["React", "Next.js", "Tailwind CSS", "TypeScript"],
        "interest": "Hackathon frontend lead",
      },
      {
        "id": "cm_2",
        "name": "Priya V.",
        "avatar": "PV",
        "dept": "Computer Science & Engineering",
        "match": "91% Match",
        "bio": "Focusing on computer vision and edge deployment of deep learning models.",
        "skills": ["Python", "FastAPI", "PyTorch", "Docker"],
        "interest": "AI/ML project partner",
      },
    ];

    _interDeptCandidates = [
      {
        "id": "id_1",
        "name": "Karthik R.",
        "avatar": "KR",
        "dept": "Electronics & Communication",
        "match": "86% Match",
        "bio": "Drone avionics and sensor telemetry prototyping specialist.",
        "skills": ["Embedded C", "IoT", "Arduino", "ESP32", "ROS"],
        "interest": "Hardware & sensor integration",
      },
      {
        "id": "id_2",
        "name": "Divya M.",
        "avatar": "DM",
        "dept": "Management Studies",
        "match": "82% Match",
        "bio": "Experienced in user journey mapping, design systems, and business models.",
        "skills": ["Product Design", "UI/UX", "Figma", "User Research"],
        "interest": "Startup UI/UX & Pitch Deck",
      },
      {
        "id": "id_3",
        "name": "Siddharth N.",
        "avatar": "SN",
        "dept": "Information Technology",
        "match": "88% Match",
        "bio": "Distributed databases and resilient cloud backend architectures.",
        "skills": ["PostgreSQL", "Go", "Kubernetes", "gRPC"],
        "interest": "High throughput backend systems",
      },
      {
        "id": "id_4",
        "name": "Ananya K.",
        "avatar": "AK",
        "dept": "Artificial Intelligence & Data Science",
        "match": "92% Match",
        "bio": "Autonomous object detection and real-time aerial image classification.",
        "skills": ["PyTorch", "OpenCV", "TensorFlow", "YOLOv8"],
        "interest": "Autonomous robotics & perception",
      },
    ];

    _campusRequests = [
      {
        "id": "req_1",
        "role": "Drone Telemetry & Sensor Engineer",
        "project": "Autonomous Drone-Based Crop Health Scanner",
        "dept": "Electronics & Communication",
        "slots": "1 Open Slot",
        "desc": "Looking for a hardware specialist to configure multispectral camera telemetry with onboard GPS.",
        "skills": ["Embedded C", "ESP32", "Telemetry"],
        "postedBy": "Lead Student",
        "appliedCount": 3,
        "hasApplied": false,
      },
    ];
  }

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
        // 1. Blueprint Hero Banner (Image 1)
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
        const SizedBox(height: 18),

        // 2. Action Bar & Filter Tabs Row (Responsive Layout - Overflow Safe)
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 1180;

            final leftActions = Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _showPostTeamRequestDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF312E81),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  label: Text(
                    "Post a Team Request",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDFA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF99F6E4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.school_outlined, size: 15, color: Color(0xFF0F766E)),
                      const SizedBox(width: 6),
                      Text(
                        "Your Dept: Computer Science & Engineering",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.work_outline_rounded, size: 15, color: Color(0xFFB45309)),
                      const SizedBox(width: 6),
                      Text(
                        "${_campusRequests.length} Open Campus Requests",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

            final rightTabs = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabPill(
                    index: 0,
                    icon: Icons.people_outline,
                    label: "My Classmates (${_classmates.length})",
                  ),
                  const SizedBox(width: 8),
                  _buildTabPill(
                    index: 1,
                    icon: Icons.layers_outlined,
                    label: "Inter-Department (${_interDeptCandidates.length})",
                  ),
                  const SizedBox(width: 8),
                  _buildTabPill(
                    index: 2,
                    icon: Icons.work_outline_rounded,
                    label: "Campus Requests (${_campusRequests.length})",
                  ),
                ],
              ),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leftActions,
                  const SizedBox(height: 12),
                  rightTabs,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: leftActions),
                const SizedBox(width: 14),
                rightTabs,
              ],
            );
          },
        ),
        const SizedBox(height: 14),

        // 3. Information Notice Banner (Tab 0 & Tab 1)
        if (_selectedTab == 0)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDFA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCCFBF1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.school_outlined, size: 16, color: Color(0xFF0F766E)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Classmate Roster (Computer Science & Engineering): Showing peers in your branch. Ideal for semester lab coursework, internal assignments, and department mini-projects.",
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F766E), height: 1.35),
                  ),
                ),
              ],
            ),
          )
        else if (_selectedTab == 1)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: Row(
              children: [
                const Icon(Icons.layers_outlined, size: 16, color: Color(0xFF1D4ED8)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Cross-Branch Talent: Showing students in Electronics, Design, Management, and IT. Perfect for Multi-Disciplinary Capstones (MDP), Smart India Hackathons, and startup prototypes!",
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E3A8A), height: 1.35),
                  ),
                ),
              ],
            ),
          ),
        if (_selectedTab != 2) const SizedBox(height: 14),

        // 4. Search Bar & Dropdown Filter (Responsive)
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 680;

            String searchHint;
            if (_selectedTab == 0) {
              searchHint = "Search classmates in Computer Science & Engineering by name, skill (Python, React...), or interest...";
            } else if (_selectedTab == 1) {
              searchHint = "Search cross-department peers by name, department, or specialized skill...";
            } else {
              searchHint = "Search requests by role, project, or required skills...";
            }

            final searchField = Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v.trim().toLowerCase()),
                style: GoogleFonts.poppins(fontSize: 12.5),
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, size: 18, color: Color(0xFF94A3B8)),
                  hintText: searchHint,
                  hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            );

            if (_selectedTab == 1) {
              final deptDropdown = Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 8),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDeptFilter,
                        isDense: true,
                        style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF0F172A)),
                        items: _deptFilterOptions.map((opt) {
                          return DropdownMenuItem<String>(
                            value: opt,
                            child: Text(opt),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedDeptFilter = val);
                        },
                      ),
                    ),
                  ],
                ),
              );

              if (isNarrow) {
                return Column(
                  children: [
                    searchField,
                    const SizedBox(height: 10),
                    Align(alignment: Alignment.centerLeft, child: deptDropdown),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: searchField),
                  const SizedBox(width: 12),
                  deptDropdown,
                ],
              );
            }

            return searchField;
          },
        ),
        const SizedBox(height: 20),

        // 5. Main Tab Body Content
        if (_selectedTab == 0)
          _buildClassmatesView()
        else if (_selectedTab == 1)
          _buildInterDeptView()
        else
          _buildCampusRequestsView(),
      ],
    );
  }

  // --- TAB PILL WIDGET ---
  Widget _buildTabPill({required int index, required IconData icon, required String label}) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = index;
          _searchController.clear();
          _searchQuery = "";
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFFD97706) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.4 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? const Color(0xFFB45309) : const Color(0xFF64748B),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 0: MY CLASSMATES (IMAGE 1) ---
  Widget _buildClassmatesView() {
    final filtered = _classmates.where((c) {
      if (_searchQuery.isEmpty) return true;
      final name = (c["name"] as String).toLowerCase();
      final bio = (c["bio"] as String).toLowerCase();
      final interest = (c["interest"] as String).toLowerCase();
      final skills = (c["skills"] as List<String>).join(" ").toLowerCase();
      return name.contains(_searchQuery) || bio.contains(_searchQuery) || interest.contains(_searchQuery) || skills.contains(_searchQuery);
    }).toList();

    if (filtered.isEmpty) return _buildEmptyResultsState();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 720;
        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: filtered.map((c) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildCandidateCard(c),
                ),
              );
            }).toList(),
          );
        }
        return Column(
          children: filtered.map((c) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildCandidateCard(c),
            );
          }).toList(),
        );
      },
    );
  }

  // --- TAB 1: INTER-DEPARTMENT (IMAGE 3) ---
  Widget _buildInterDeptView() {
    final filtered = _interDeptCandidates.where((c) {
      if (_selectedDeptFilter != "All Other Departments") {
        if (c["dept"] != _selectedDeptFilter) return false;
      }
      if (_searchQuery.isEmpty) return true;
      final name = (c["name"] as String).toLowerCase();
      final dept = (c["dept"] as String).toLowerCase();
      final bio = (c["bio"] as String).toLowerCase();
      final interest = (c["interest"] as String).toLowerCase();
      final skills = (c["skills"] as List<String>).join(" ").toLowerCase();
      return name.contains(_searchQuery) || dept.contains(_searchQuery) || bio.contains(_searchQuery) || interest.contains(_searchQuery) || skills.contains(_searchQuery);
    }).toList();

    if (filtered.isEmpty) return _buildEmptyResultsState();

    return LayoutBuilder(
      builder: (context, constraints) {
        final colCount = constraints.maxWidth >= 1050 ? 3 : (constraints.maxWidth >= 700 ? 2 : 1);
        if (colCount == 1) {
          return Column(
            children: filtered.map((c) => Padding(padding: const EdgeInsets.only(bottom: 16), child: _buildCandidateCard(c))).toList(),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filtered.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: colCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: colCount == 3 ? 0.95 : 1.05,
          ),
          itemBuilder: (context, idx) => _buildCandidateCard(filtered[idx]),
        );
      },
    );
  }

  // --- CANDIDATE CARD (IMAGES 1 & 3) ---
  Widget _buildCandidateCard(Map<String, dynamic> c) {
    final name = c["name"] as String;
    final avatar = c["avatar"] as String;
    final dept = c["dept"] as String;
    final match = c["match"] as String;
    final bio = c["bio"] as String;
    final skills = c["skills"] as List<String>;
    final interest = c["interest"] as String;

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Avatar + Name + Dept + Match Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          avatar,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0369A1),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            dept,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFBF1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      match,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Bio text
              Text(
                bio,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 14),

              // Skills & Tech Stack
              Text(
                "SKILLS & TECH STACK",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: skills.map((sk) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      sk,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Interested in box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF8F2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEFECE4)),
                ),
                child: Text(
                  "Interested in: $interest",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Bottom Invite Button (Image 1 & 3)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showAddTeammateDialog(c),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.person_add_alt_outlined, size: 15, color: Color(0xFF0F766E)),
              label: Text(
                "Invite to Project Team",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 2: CAMPUS REQUESTS (IMAGE 4) ---
  Widget _buildCampusRequestsView() {
    final filtered = _campusRequests.where((r) {
      if (_searchQuery.isEmpty) return true;
      final role = (r["role"] as String).toLowerCase();
      final project = (r["project"] as String).toLowerCase();
      final skills = (r["skills"] as List<String>).join(" ").toLowerCase();
      return role.contains(_searchQuery) || project.contains(_searchQuery) || skills.contains(_searchQuery);
    }).toList();

    if (filtered.isEmpty) return _buildEmptyResultsState();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filtered.map((req) {
        final role = req["role"] as String;
        final project = req["project"] as String;
        final dept = req["dept"] as String;
        final slots = req["slots"] as String;
        final desc = req["desc"] as String;
        final skills = req["skills"] as List<String>;
        final postedBy = req["postedBy"] as String;
        final appliedCount = req["appliedCount"] as int;
        final hasApplied = req["hasApplied"] as bool;

        return Container(
          constraints: const BoxConstraints(maxWidth: 580),
          margin: const EdgeInsets.only(bottom: 16),
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
              // Tags Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      dept,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      slots,
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Title & Project
              Text(
                role,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Project: $project",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0D9488),
                ),
              ),
              const SizedBox(height: 10),

              // Description
              Text(
                desc,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 14),

              // Required skills
              Text(
                "REQUIRED SKILLS",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: skills.map((sk) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDFA),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFCCFBF1)),
                    ),
                    child: Text(
                      sk,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 14),

              // Footer row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Posted by $postedBy",
                    style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                  Row(
                    children: [
                      Text(
                        "$appliedCount Applied",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: hasApplied
                            ? null
                            : () {
                                setState(() {
                                  req["appliedCount"] = appliedCount + 1;
                                  req["hasApplied"] = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Application sent! Team lead has been notified.",
                                          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: const Color(0xFF0F766E),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasApplied ? const Color(0xFF059669) : const Color(0xFF312E81),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        icon: Icon(hasApplied ? Icons.check : Icons.send_outlined, size: 14),
                        label: Text(
                          hasApplied ? "Applied" : "Apply",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // --- ADD TEAMMATE MODAL (IMAGE 2) ---
  void _showAddTeammateDialog(Map<String, dynamic> candidate) {
    final candidateName = candidate["name"] as String;
    final skills = (candidate["skills"] as List<String>).join(", ");
    String selectedProject = _availableProjects.first;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDFA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF0F766E), size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Teammate",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Invite $candidateName to your project",
                              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Project Link Dropdown
                  Text(
                    "Select Project to Link",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedProject,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF0F172A)),
                        items: _availableProjects.map((proj) {
                          return DropdownMenuItem<String>(
                            value: proj,
                            child: Text(
                              proj,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => selectedProject = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Candidate Summary Card (Image 2)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF8F2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFEFECE4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Candidate Skills: $skills",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569)),
                            children: [
                              const TextSpan(text: "Action: Will dynamically add "),
                              TextSpan(
                                text: candidateName,
                                style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0F766E)),
                              ),
                              const TextSpan(text: " to the project team in the database."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        ),
                        child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("$candidateName successfully added to $selectedProject!"),
                              backgroundColor: const Color(0xFF0D9488),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF312E81),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          elevation: 0,
                        ),
                        child: Text("Confirm & Add Teammate", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- POST A TEAM OPENING MODAL (IMAGE 5) ---
  void _showPostTeamRequestDialog() {
    String selectedProject = _availableProjects.first;
    final roleCtrl = TextEditingController(text: "Full Stack Developer");
    String selectedDept = "Computer Science & Engineering";
    final slotsCtrl = TextEditingController(text: "1");
    final skillsCtrl = TextEditingController(text: "React, Python, FastAPI");
    final descCtrl = TextEditingController(text: "Looking for a motivated teammate to collaborate on API integration and frontend UI/UX.");

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDFA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_rounded, color: Color(0xFF0F766E), size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Post a Team Opening",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Broadcast open slots for your project to campus peers",
                                style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Project
                    Text("Project", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedProject,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF0F172A)),
                          items: _availableProjects.map((p) => DropdownMenuItem(value: p, child: Text(p, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500)))).toList(),
                          onChanged: (val) {
                            if (val != null) setModalState(() => selectedProject = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Role Needed
                    Text("Role Needed", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                    const SizedBox(height: 6),
                    TextField(
                      controller: roleCtrl,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Preferred Dept & Slots Open Row
                    LayoutBuilder(
                      builder: (context, c) {
                        final deptCol = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Preferred Department", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                            const SizedBox(height: 6),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedDept,
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF0F172A)),
                                  items: [
                                    "Computer Science & Engineering",
                                    "Electronics & Communication",
                                    "Information Technology",
                                    "Artificial Intelligence & Data Science",
                                    "Management Studies",
                                    "Mechanical Engineering",
                                  ].map((d) => DropdownMenuItem(value: d, child: Text(d, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: 12)))).toList(),
                                  onChanged: (val) {
                                    if (val != null) setModalState(() => selectedDept = val);
                                  },
                                ),
                              ),
                            ),
                          ],
                        );

                        final slotsCol = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Slots Open", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                            const SizedBox(height: 6),
                            TextField(
                              controller: slotsCtrl,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.poppins(fontSize: 12.5),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ],
                        );

                        if (c.maxWidth < 360) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              deptCol,
                              const SizedBox(height: 12),
                              slotsCol,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(flex: 3, child: deptCol),
                            const SizedBox(width: 12),
                            Expanded(flex: 2, child: slotsCol),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 14),

                    // Skills Required
                    Text("Skills Required (comma-separated)", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                    const SizedBox(height: 6),
                    TextField(
                      controller: skillsCtrl,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Description & Goals
                    Text("Description & Goals", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                    const SizedBox(height: 6),
                    TextField(
                      controller: descCtrl,
                      maxLines: 3,
                      style: GoogleFonts.poppins(fontSize: 12.5),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          ),
                          child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            final role = roleCtrl.text.trim();
                            final slots = slotsCtrl.text.trim();
                            final skills = skillsCtrl.text.split(",").map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
                            final desc = descCtrl.text.trim();

                            if (role.isEmpty) return;

                            setState(() {
                              _campusRequests.insert(0, {
                                "id": "req_${DateTime.now().millisecondsSinceEpoch}",
                                "role": role,
                                "project": selectedProject,
                                "dept": selectedDept,
                                "slots": "$slots Open Slot${slots == '1' ? '' : 's'}",
                                "desc": desc,
                                "skills": skills.isNotEmpty ? skills : ["React", "FastAPI"],
                                "postedBy": "Lead Student",
                                "appliedCount": 0,
                                "hasApplied": false,
                              });
                              _selectedTab = 2; // Jump to Campus Requests tab
                            });

                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Team request for '$role' published to campus!"),
                                backgroundColor: const Color(0xFF0D9488),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF312E81),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            elevation: 0,
                          ),
                          child: Text("Publish Team Request", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyResultsState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.search_off_rounded, size: 36, color: Color(0xFF94A3B8)),
            const SizedBox(height: 10),
            Text(
              "No matching peers or requests found",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
            ),
            const SizedBox(height: 4),
            Text(
              "Try adjusting your search keywords or branch filter.",
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
            ),
          ],
        ),
      ),
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

class _ResearchProjectItem {
  final String title;
  final String field;
  final String level;
  final String stage;
  final String goal;
  final DateTime createdAt;
  final List<String> questions;
  final List<Map<String, String>> searchQueries;
  final List<String> outlineSections;
  final List<Map<String, dynamic>> workPlanSteps;

  _ResearchProjectItem({
    required this.title,
    required this.field,
    required this.level,
    required this.stage,
    required this.goal,
    required this.createdAt,
    required this.questions,
    required this.searchQueries,
    required this.outlineSections,
    required this.workPlanSteps,
  });
}

class _ResearchAssistantScreenState extends State<ResearchAssistantScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  String _selectedLevel = "UG";
  String _selectedStage = "Idea";

  final List<String> _levelOptions = const ["UG", "PG", "PhD"];
  final List<String> _stageOptions = const [
    "Idea",
    "Literature Review",
    "Formulation",
    "Experimentation",
    "Drafting",
    "Completed"
  ];

  final List<_ResearchProjectItem> _projects = [];
  int _activeProjectIndex = 0;
  int _activeTab = 0; // 0: Questions, 1: Search Queries, 2: Outline, 3: Work Plan

  @override
  void dispose() {
    _titleController.dispose();
    _fieldController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  void _createProject() {
    final title = _titleController.text.trim();
    final field = _fieldController.text.trim();
    final goal = _goalController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a project title or topic."),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    final effectiveField = field.isEmpty ? "Computer Science" : field;

    final newProject = _ResearchProjectItem(
      title: title,
      field: effectiveField,
      level: _selectedLevel,
      stage: _selectedStage,
      goal: goal,
      createdAt: DateTime.now(),
      questions: [
        "How can $title be optimized for real-time accuracy and minimum latency in edge-constrained environments?",
        "What are the primary failure modes when applying modern machine learning paradigms to $title?",
        "In what ways does this approach surpass traditional $effectiveField baselines in resource consumption and scalability?",
      ],
      searchQueries: [
        {
          "engine": "Google Scholar",
          "query": '"$title" AND ("$effectiveField" OR "methodology" OR "benchmark")',
          "icon": "school"
        },
        {
          "engine": "IEEE Xplore",
          "query": '("$title") AND ("$effectiveField") AND ("algorithm" OR "architecture")',
          "icon": "memory"
        },
        {
          "engine": "Scopus",
          "query": 'TITLE-ABS-KEY ("$title" AND "$effectiveField" AND "empirical")',
          "icon": "menu_book"
        },
      ],
      outlineSections: [
        "1. Abstract & Introduction: Research context in $effectiveField, problem scope and major contributions.",
        "2. Related Literature: State-of-the-art comparative review and limitations of prior formulations.",
        "3. System Architecture & Methodology: Mathematical formalization and pipeline.",
        "4. Experimental Evaluation: Benchmarks, metrics, validation against baseline datasets.",
        "5. Discussion, Ethical Considerations & Concluding Remarks.",
      ],
      workPlanSteps: [
        {"title": "Formulate core problem statement & hypothesis", "done": true},
        {"title": "Execute literature query across Scopus & IEEE Xplore", "done": false},
        {"title": "Prepare experimental testbed / dataset baseline", "done": false},
        {"title": "Conduct empirical runs and document metrics", "done": false},
        {"title": "Draft manuscript introduction and methodology sections", "done": false},
      ],
    );

    setState(() {
      _projects.insert(0, newProject);
      _activeProjectIndex = 0;
      _titleController.clear();
      _fieldController.clear();
      _goalController.clear();
      _selectedLevel = "UG";
      _selectedStage = "Idea";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Project \"$title\" created successfully!"),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
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
        const SizedBox(height: 24),

        // 2. Responsive 2-Column Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 920;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: _projects.isEmpty
                        ? _buildStartProjectCard()
                        : _buildProjectWorkbenchCard(_projects[_activeProjectIndex]),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 380,
                    child: _buildNewProjectFormCard(),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _projects.isEmpty
                      ? _buildStartProjectCard()
                      : _buildProjectWorkbenchCard(_projects[_activeProjectIndex]),
                  const SizedBox(height: 24),
                  _buildNewProjectFormCard(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  /// Start a research project left card (Exact match for image 1)
  Widget _buildStartProjectCard() {
    return Container(
      constraints: const BoxConstraints(minHeight: 440),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(
                    Icons.science_outlined,
                    color: Color(0xFF4338CA),
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                "Start a research project",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Save a project and the assistant works with it: sharper research questions, a search plan for the literature, a paper outline and a step-by-step work plan. Everything is saved for you, and you can keep several projects.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                "The assistant cannot browse papers, so it never cites them. It writes search strings and you run them in Google Scholar, IEEE Xplore or Scopus.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF94A3B8),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Project Workbench when one or more projects exist
  Widget _buildProjectWorkbenchCard(_ResearchProjectItem project) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header bar with project switcher if multiple projects
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.science_outlined, color: Color(0xFF4338CA), size: 20),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Wrap(
                            spacing: 8,
                            children: [
                              Text(
                                project.field,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                "•",
                                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFFCBD5E1)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  project.level,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  project.stage,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_projects.length > 1)
                  DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _activeProjectIndex,
                      isDense: true,
                      items: List.generate(_projects.length, (idx) {
                        return DropdownMenuItem(
                          value: idx,
                          child: Text(
                            "Project ${idx + 1}: ${_projects[idx].title}",
                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        );
                      }),
                      onChanged: (val) {
                        if (val != null) setState(() => _activeProjectIndex = val);
                      },
                    ),
                  ),
              ],
            ),
          ),

          // Tabs
          Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabPill(0, "Research Questions", Icons.help_outline_rounded),
                  const SizedBox(width: 8),
                  _buildTabPill(1, "Literature Search Plan", Icons.manage_search_rounded),
                  const SizedBox(width: 8),
                  _buildTabPill(2, "Paper Outline", Icons.menu_book_outlined),
                  const SizedBox(width: 8),
                  _buildTabPill(3, "Work Plan Steps", Icons.checklist_rounded),
                ],
              ),
            ),
          ),

          // Tab content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Builder(
              builder: (context) {
                switch (_activeTab) {
                  case 0:
                    return _buildQuestionsTab(project);
                  case 1:
                    return _buildSearchQueriesTab(project);
                  case 2:
                    return _buildOutlineTab(project);
                  case 3:
                  default:
                    return _buildWorkPlanTab(project);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill(int index, String label, IconData icon) {
    final isSelected = _activeTab == index;
    return InkWell(
      onTap: () => setState(() => _activeTab = index),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: const Color(0xFFE2E8F0)) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? const Color(0xFF312E81) : const Color(0xFF64748B),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF1E1B4B) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsTab(_ResearchProjectItem project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Sharper Research Questions",
              style: GoogleFonts.poppins(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                final text = project.questions.asMap().entries.map((e) => "RQ${e.key + 1}: ${e.value}").join("\n\n");
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Research questions copied to clipboard.")),
                );
              },
              icon: const Icon(Icons.copy_rounded, size: 14),
              label: Text("Copy All", style: GoogleFonts.poppins(fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...project.questions.asMap().entries.map((entry) {
          final idx = entry.key + 1;
          final q = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "RQ$idx",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4338CA),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    q,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                      height: 1.5,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Copy question",
                  icon: const Icon(Icons.copy_rounded, size: 16, color: Color(0xFF94A3B8)),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: q));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Copied to clipboard.")),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSearchQueriesTab(_ResearchProjectItem project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Literature Search Queries",
          style: GoogleFonts.poppins(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Copy and paste these Boolean search strings directly into scholarly indexing databases.",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),
        ...project.searchQueries.map((item) {
          final engine = item["engine"] ?? "";
          final query = item["query"] ?? "";
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        engine,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF6D28D9),
                        ),
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: query));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Query for $engine copied!")),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 14),
                      label: Text("Copy String", style: GoogleFonts.poppins(fontSize: 11.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    query,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11.5,
                      color: const Color(0xFF38BDF8),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOutlineTab(_ResearchProjectItem project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Paper Outline Framework",
              style: GoogleFonts.poppins(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                final text = project.outlineSections.join("\n\n");
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Paper outline copied.")),
                );
              },
              icon: const Icon(Icons.copy_rounded, size: 14),
              label: Text("Copy Outline", style: GoogleFonts.poppins(fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...project.outlineSections.map((sec) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.article_outlined, size: 18, color: Color(0xFF64748B)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    sec,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF1E293B),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildWorkPlanTab(_ResearchProjectItem project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step-by-Step Work Plan",
          style: GoogleFonts.poppins(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        ...project.workPlanSteps.map((step) {
          final isDone = step["done"] as bool;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFFF0FDF4) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDone ? const Color(0xFFBBF7D0) : const Color(0xFFE2E8F0),
              ),
            ),
            child: CheckboxListTile(
              dense: true,
              value: isDone,
              activeColor: const Color(0xFF10B981),
              title: Text(
                step["title"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  color: isDone ? const Color(0xFF15803D) : const Color(0xFF1E293B),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  step["done"] = val ?? false;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  /// New Project Form Card (Exact match for image 1 right card)
  Widget _buildNewProjectFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New project",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "You can change all of this later",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Project title or topic
          Text(
            "Project title or topic",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _titleController,
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: "e.g. Low-cost IoT soil moisture sensing for fa...",
              hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF312E81), width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Field
          Text(
            "Field",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _fieldController,
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: "e.g. Computer Science",
              hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF312E81), width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Level & Where are you now?
          LayoutBuilder(
            builder: (context, boxConstraints) {
              final isSmall = boxConstraints.maxWidth < 280;
              if (isSmall) {
                return Column(
                  children: [
                    _buildDropdownField("Level", _selectedLevel, _levelOptions, (val) {
                      if (val != null) setState(() => _selectedLevel = val);
                    }),
                    const SizedBox(height: 14),
                    _buildDropdownField("Where are you now?", _selectedStage, _stageOptions, (val) {
                      if (val != null) setState(() => _selectedStage = val);
                    }),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _buildDropdownField("Level", _selectedLevel, _levelOptions, (val) {
                      if (val != null) setState(() => _selectedLevel = val);
                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdownField("Where are you now?", _selectedStage, _stageOptions, (val) {
                      if (val != null) setState(() => _selectedStage = val);
                    }),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Goal (optional)
          Text(
            "Goal (optional)",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _goalController,
            minLines: 3,
            maxLines: 4,
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF312E81), width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "For example: a conference paper, a final-year project, a thesis chapter.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 24),

          // Submit button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E1B4B),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _createProject,
              icon: const Icon(Icons.add, size: 18),
              label: Text(
                "Create project",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String currentValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: options.contains(currentValue) ? currentValue : options.first,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
              items: options.map((opt) {
                return DropdownMenuItem<String>(
                  value: opt,
                  child: Text(opt, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 6. Hackathon Hub Screen [P3]
/// ─────────────────────────────────────────────────────────────────────────────
class HackathonHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HackathonHubScreen({super.key, this.onBack});

  @override
  State<HackathonHubScreen> createState() => _HackathonHubScreenState();
}

class _HackathonEntry {
  final String id;
  final String name;
  final String domain;
  final String organizer;
  final String dates;
  int teamsCount;
  final String status; // Open, Active, Upcoming
  final Color statusColor;
  final Color statusBg;

  _HackathonEntry({
    required this.id,
    required this.name,
    required this.domain,
    required this.organizer,
    required this.dates,
    required this.teamsCount,
    required this.status,
    required this.statusColor,
    required this.statusBg,
  });
}

class _RegisteredTeamRecord {
  final String targetHackathon;
  final String teamName;
  final int teamSize;
  final String teamLead;
  final String rollNo;
  final String email;
  final String domain;
  final String members;
  final String problemStatement;
  final String githubUrl;
  final DateTime registeredAt;

  _RegisteredTeamRecord({
    required this.targetHackathon,
    required this.teamName,
    required this.teamSize,
    required this.teamLead,
    required this.rollNo,
    required this.email,
    required this.domain,
    required this.members,
    required this.problemStatement,
    required this.githubUrl,
    required this.registeredAt,
  });
}

class _HackathonHubScreenState extends State<HackathonHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = "All";
  int _currentTabIndex = 0; // 0: All Hackathons, 1: My Registered Teams

  final List<String> _categoryFilterOptions = const [
    "All",
    "National Innovation",
    "AI & Machine Learning",
    "Startup & GovTech",
  ];

  late final List<_HackathonEntry> _hackathons = [
    _HackathonEntry(
      id: "h1",
      name: "Smart India Hackathon 2026",
      domain: "National Innovation",
      organizer: "AICTE & MoE",
      dates: "Nov 15–16",
      teamsCount: 24,
      status: "Open",
      statusColor: const Color(0xFF0D9488),
      statusBg: const Color(0xFFCCFBF1),
    ),
    _HackathonEntry(
      id: "h2",
      name: "Campus AI Buildathon",
      domain: "AI & Machine Learning",
      organizer: "Computer Science & Engineering & Incubation Cell",
      dates: "Oct 28",
      teamsCount: 18,
      status: "Active",
      statusColor: const Color(0xFF2563EB),
      statusBg: const Color(0xFFDBEAFE),
    ),
    _HackathonEntry(
      id: "h3",
      name: "Tamil Nadu State Student Innovation Challenge",
      domain: "Startup & GovTech",
      organizer: "TANSIM",
      dates: "Dec 05",
      teamsCount: 42,
      status: "Upcoming",
      statusColor: const Color(0xFFD97706),
      statusBg: const Color(0xFFFEF3C7),
    ),
  ];

  final List<_RegisteredTeamRecord> _myRegisteredTeams = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _totalRegisteredTeamsCount {
    int total = _hackathons.fold(0, (sum, h) => sum + h.teamsCount);
    return total;
  }

  void _exportCSV() {
    final csvContent = StringBuffer();
    csvContent.writeln("Hackathon,Domain,Organizer,Dates,Teams,Status");
    for (var h in _hackathons) {
      csvContent.writeln('"${h.name}","${h.domain}","${h.organizer}","${h.dates}",${h.teamsCount},"${h.status}"');
    }

    Clipboard.setData(ClipboardData(text: csvContent.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Hackathon Hub CSV exported and copied to clipboard!"),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }

  void _openRegisterDialog([String? defaultHackathon]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _RegisterHackathonTeamDialog(
        hackathons: _hackathons.map((e) => e.name).toList(),
        initialHackathon: defaultHackathon,
        onSubmit: (newTeam) {
          setState(() {
            _myRegisteredTeams.insert(0, newTeam);
            // Increment the hackathon team count
            final target = _hackathons.firstWhere(
              (h) => h.name == newTeam.targetHackathon,
              orElse: () => _hackathons.first,
            );
            target.teamsCount += 1;
            // Switch to My Registered Teams tab
            _currentTabIndex = 1;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Team \"${newTeam.teamName}\" registered for ${newTeam.targetHackathon}!"),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredHackathons = _hackathons.where((h) {
      final matchesCat = _selectedCategory == "All" || h.domain.toLowerCase() == _selectedCategory.toLowerCase();
      final q = _searchController.text.trim().toLowerCase();
      final matchesSearch = q.isEmpty ||
          h.name.toLowerCase().contains(q) ||
          h.domain.toLowerCase().contains(q) ||
          h.organizer.toLowerCase().contains(q);
      return matchesCat && matchesSearch;
    }).toList();

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
        const SizedBox(height: 24),

        // 2. 4 Metric Cards (Image 2)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w >= 980) {
              return Row(
                children: [
                  Expanded(
                    child: _buildKpiCard(
                      eyebrow: "TOTAL HACKATHONS",
                      value: "${_hackathons.length}",
                      subtitle: "National & campus buildathons",
                      icon: Icons.emoji_events_outlined,
                      accentColor: const Color(0xFFD97706),
                      iconBg: const Color(0xFFFEF3C7),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildKpiCard(
                      eyebrow: "REGISTERED TEAMS",
                      value: "$_totalRegisteredTeamsCount",
                      subtitle: "Live student team entries",
                      icon: Icons.groups_outlined,
                      accentColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFDBEAFE),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildKpiCard(
                      eyebrow: "MY REGISTERED TEAMS",
                      value: "${_myRegisteredTeams.length}",
                      subtitle: "Stored in PostgreSQL database",
                      icon: Icons.verified_user_outlined,
                      accentColor: const Color(0xFF0D9488),
                      iconBg: const Color(0xFFCCFBF1),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildKpiCard(
                      eyebrow: "OPEN REGISTRATIONS",
                      value: "${_hackathons.where((h) => h.status == 'Open').length}",
                      subtitle: "Accepting team applications",
                      icon: Icons.event_available_outlined,
                      accentColor: const Color(0xFF10B981),
                      iconBg: const Color(0xFFD1FAE5),
                    ),
                  ),
                ],
              );
            } else if (w >= 540) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildKpiCard(
                          eyebrow: "TOTAL HACKATHONS",
                          value: "${_hackathons.length}",
                          subtitle: "National & campus buildathons",
                          icon: Icons.emoji_events_outlined,
                          accentColor: const Color(0xFFD97706),
                          iconBg: const Color(0xFFFEF3C7),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildKpiCard(
                          eyebrow: "REGISTERED TEAMS",
                          value: "$_totalRegisteredTeamsCount",
                          subtitle: "Live student team entries",
                          icon: Icons.groups_outlined,
                          accentColor: const Color(0xFF2563EB),
                          iconBg: const Color(0xFFDBEAFE),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildKpiCard(
                          eyebrow: "MY REGISTERED TEAMS",
                          value: "${_myRegisteredTeams.length}",
                          subtitle: "Stored in PostgreSQL database",
                          icon: Icons.verified_user_outlined,
                          accentColor: const Color(0xFF0D9488),
                          iconBg: const Color(0xFFCCFBF1),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildKpiCard(
                          eyebrow: "OPEN REGISTRATIONS",
                          value: "${_hackathons.where((h) => h.status == 'Open').length}",
                          subtitle: "Accepting team applications",
                          icon: Icons.event_available_outlined,
                          accentColor: const Color(0xFF10B981),
                          iconBg: const Color(0xFFD1FAE5),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildKpiCard(
                    eyebrow: "TOTAL HACKATHONS",
                    value: "${_hackathons.length}",
                    subtitle: "National & campus buildathons",
                    icon: Icons.emoji_events_outlined,
                    accentColor: const Color(0xFFD97706),
                    iconBg: const Color(0xFFFEF3C7),
                  ),
                  const SizedBox(height: 12),
                  _buildKpiCard(
                    eyebrow: "REGISTERED TEAMS",
                    value: "$_totalRegisteredTeamsCount",
                    subtitle: "Live student team entries",
                    icon: Icons.groups_outlined,
                    accentColor: const Color(0xFF2563EB),
                    iconBg: const Color(0xFFDBEAFE),
                  ),
                  const SizedBox(height: 12),
                  _buildKpiCard(
                    eyebrow: "MY REGISTERED TEAMS",
                    value: "${_myRegisteredTeams.length}",
                    subtitle: "Stored in PostgreSQL database",
                    icon: Icons.verified_user_outlined,
                    accentColor: const Color(0xFF0D9488),
                    iconBg: const Color(0xFFCCFBF1),
                  ),
                  const SizedBox(height: 12),
                  _buildKpiCard(
                    eyebrow: "OPEN REGISTRATIONS",
                    value: "${_hackathons.where((h) => h.status == 'Open').length}",
                    subtitle: "Accepting team applications",
                    icon: Icons.event_available_outlined,
                    accentColor: const Color(0xFF10B981),
                    iconBg: const Color(0xFFD1FAE5),
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 24),

        // 3. Navigation Tabs
        Row(
          children: [
            _buildTabButton(0, "All Hackathons", _hackathons.length),
            const SizedBox(width: 12),
            _buildTabButton(1, "My Registered Teams", _myRegisteredTeams.length),
          ],
        ),
        const SizedBox(height: 16),

        // 4. Action Row (Search, Filter, Export, Register)
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 780;
            if (isWide) {
              return Row(
                children: [
                  Expanded(
                    child: _buildSearchBar(),
                  ),
                  const SizedBox(width: 12),
                  _buildCategoryDropdown(),
                  const SizedBox(width: 12),
                  _buildExportButton(),
                  const SizedBox(width: 12),
                  _buildRegisterTeamButton(),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      _buildCategoryDropdown(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildExportButton(),
                          const SizedBox(width: 8),
                          _buildRegisterTeamButton(),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 5. Tab Content Area
        if (_currentTabIndex == 0)
          _buildAllHackathonsView(filteredHackathons)
        else
          _buildMyRegisteredTeamsView(),
      ],
    );
  }

  Widget _buildKpiCard({
    required String eyebrow,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required Color iconBg,
  }) {
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                eyebrow,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String label, int count) {
    final isSelected = _currentTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentTabIndex = index),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1B4B) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E1B4B) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "$count",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
        decoration: InputDecoration(
          hintText: "Search hackathon hub...",
          hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
          prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF94A3B8)),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), fontWeight: FontWeight.w500),
          items: _categoryFilterOptions.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: (val) {
            if (val != null) setState(() => _selectedCategory = val);
          },
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF475569),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: _exportCSV,
      icon: const Icon(Icons.download_rounded, size: 16),
      label: Text(
        "Export CSV",
        style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildRegisterTeamButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E1B4B),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => _openRegisterDialog(),
      icon: const Icon(Icons.add, size: 16),
      label: Text(
        "Register team",
        style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildAllHackathonsView(List<_HackathonEntry> items) {
    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "No matching records",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Try a different search or filter.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Desktop Table View
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 800),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                dataTextStyle: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF1E293B),
                ),
                columnSpacing: 24,
                columns: const [
                  DataColumn(label: Text("HACKATHON")),
                  DataColumn(label: Text("ORGANIZER")),
                  DataColumn(label: Text("DATES")),
                  DataColumn(label: Text("REGISTERED TEAMS")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: items.map((h) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              h.name,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              h.domain,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                            h.organizer,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(h.dates, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.groups_outlined, size: 16, color: Color(0xFF64748B)),
                            const SizedBox(width: 6),
                            Text("${h.teamsCount} teams", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: h.statusBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            h.status,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: h.statusColor,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF312E81)),
                            foregroundColor: const Color(0xFF312E81),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => _openRegisterDialog(h.name),
                          child: Text(
                            "Register team",
                            style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          // Pagination Footer (Matches image 2 footer)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Wrap(
              spacing: 16,
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Showing 1–${items.length} of ${items.length} records",
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Rows per page: 10", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                    const SizedBox(width: 16),
                    Text("Page 1 of 1", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 20, color: Color(0xFFCBD5E1)),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 20, color: Color(0xFFCBD5E1)),
                      onPressed: null,
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

  Widget _buildMyRegisteredTeamsView() {
    if (_myRegisteredTeams.isEmpty) {
      // Empty state matching image 4
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.code_rounded,
                      color: Color(0xFF64748B),
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "No registered teams yet",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You haven't registered any team for upcoming hackathons. Join an active hackathon to build your innovation portfolio.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E1B4B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _openRegisterDialog(),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    "Register team",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: _myRegisteredTeams.map((team) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 8,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE9FE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.groups_outlined, color: Color(0xFF6D28D9), size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            team.teamName,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            "Hackathon: ${team.targetHackathon}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FAE5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Confirmed",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF065F46),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, color: Color(0xFFF1F5F9)),
              Wrap(
                spacing: 24,
                runSpacing: 12,
                children: [
                  _buildDetailMeta("Team Lead", "${team.teamLead} (${team.rollNo})"),
                  _buildDetailMeta("Team Size", "${team.teamSize} members"),
                  _buildDetailMeta("Track", team.domain),
                  _buildDetailMeta("Email", team.email),
                ],
              ),
              if (team.members.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildDetailMeta("Members", team.members),
              ],
              const SizedBox(height: 12),
              _buildDetailMeta("Problem Concept", team.problemStatement),
              if (team.githubUrl.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.link_rounded, size: 16, color: Color(0xFF2563EB)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        team.githubUrl,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF2563EB),
                          decoration: TextDecoration.underline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDetailMeta(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF94A3B8),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Register Hackathon Team Modal Dialog (Matches Image 3)
/// ─────────────────────────────────────────────────────────────────────────────
class _RegisterHackathonTeamDialog extends StatefulWidget {
  final List<String> hackathons;
  final String? initialHackathon;
  final ValueChanged<_RegisteredTeamRecord> onSubmit;

  const _RegisterHackathonTeamDialog({
    required this.hackathons,
    this.initialHackathon,
    required this.onSubmit,
  });

  @override
  State<_RegisterHackathonTeamDialog> createState() => _RegisterHackathonTeamDialogState();
}

class _RegisterHackathonTeamDialogState extends State<_RegisterHackathonTeamDialog> {
  late String _selectedHackathon;
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _teamSizeController = TextEditingController(text: "4");
  final TextEditingController _leadNameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _leadEmailController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();
  final TextEditingController _conceptController = TextEditingController();
  final TextEditingController _repoUrlController = TextEditingController();

  String _selectedTrack = "AI & Machine Learning";

  final List<String> _trackOptions = const [
    "AI & Machine Learning",
    "National Innovation",
    "Startup & GovTech",
    "Healthcare & MedTech",
    "Smart Agriculture & IoT",
    "FinTech & Blockchain",
  ];

  @override
  void initState() {
    super.initState();
    _selectedHackathon = widget.initialHackathon ??
        (widget.hackathons.isNotEmpty ? widget.hackathons.first : "Smart India Hackathon 2026");
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _teamSizeController.dispose();
    _leadNameController.dispose();
    _rollNoController.dispose();
    _leadEmailController.dispose();
    _membersController.dispose();
    _conceptController.dispose();
    _repoUrlController.dispose();
    super.dispose();
  }

  void _submit() {
    final teamName = _teamNameController.text.trim();
    final leadName = _leadNameController.text.trim();
    final rollNo = _rollNoController.text.trim();
    final concept = _conceptController.text.trim();
    final size = int.tryParse(_teamSizeController.text.trim()) ?? 4;

    if (teamName.isEmpty || leadName.isEmpty || concept.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all required fields marked with *"),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    final newTeam = _RegisteredTeamRecord(
      targetHackathon: _selectedHackathon,
      teamName: teamName,
      teamSize: size,
      teamLead: leadName,
      rollNo: rollNo.isEmpty ? "23CS101" : rollNo,
      email: _leadEmailController.text.trim().isEmpty ? "lead@college.edu" : _leadEmailController.text.trim(),
      domain: _selectedTrack,
      members: _membersController.text.trim(),
      problemStatement: concept,
      githubUrl: _repoUrlController.text.trim(),
      registeredAt: DateTime.now(),
    );

    widget.onSubmit(newTeam);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 580, maxHeight: 720),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFF4338CA),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register Hackathon Team",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Official campus team entry recorded directly into PostgreSQL database.",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20, color: Color(0xFF94A3B8)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),

            // Scrollable Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Target Hackathon
                    _buildLabel("TARGET HACKATHON *"),
                    const SizedBox(height: 6),
                    _buildDropdown(
                      value: _selectedHackathon,
                      items: widget.hackathons,
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedHackathon = val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Team Name & Team Size Row
                    LayoutBuilder(
                      builder: (context, c) {
                        if (c.maxWidth < 420) {
                          return Column(
                            children: [
                              _buildTextField(
                                label: "TEAM NAME *",
                                controller: _teamNameController,
                                hintText: "e.g. Neural Knights",
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: "TEAM SIZE (MEMBERS) *",
                                controller: _teamSizeController,
                                hintText: "4",
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildTextField(
                                label: "TEAM NAME *",
                                controller: _teamNameController,
                                hintText: "e.g. Neural Knights",
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 2,
                              child: _buildTextField(
                                label: "TEAM SIZE (MEMBERS) *",
                                controller: _teamSizeController,
                                hintText: "4",
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Team Lead Name & Roll No Row
                    LayoutBuilder(
                      builder: (context, c) {
                        if (c.maxWidth < 420) {
                          return Column(
                            children: [
                              _buildTextField(
                                label: "TEAM LEAD NAME *",
                                controller: _leadNameController,
                                hintText: "e.g. Bala Kumar",
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                label: "ROLL NO / STUDENT ID",
                                controller: _rollNoController,
                                hintText: "e.g. 23CS104",
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: "TEAM LEAD NAME *",
                                controller: _leadNameController,
                                hintText: "e.g. Bala Kumar",
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildTextField(
                                label: "ROLL NO / STUDENT ID",
                                controller: _rollNoController,
                                hintText: "e.g. 23CS104",
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Lead Email & Innovation Domain Row
                    LayoutBuilder(
                      builder: (context, c) {
                        if (c.maxWidth < 420) {
                          return Column(
                            children: [
                              _buildTextField(
                                label: "LEAD EMAIL",
                                controller: _leadEmailController,
                                hintText: "lead@college.edu",
                              ),
                              const SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("INNOVATION DOMAIN / TRACK *"),
                                  const SizedBox(height: 6),
                                  _buildDropdown(
                                    value: _selectedTrack,
                                    items: _trackOptions,
                                    onChanged: (val) {
                                      if (val != null) setState(() => _selectedTrack = val);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: "LEAD EMAIL",
                                controller: _leadEmailController,
                                hintText: "lead@college.edu",
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("INNOVATION DOMAIN / TRACK *"),
                                  const SizedBox(height: 6),
                                  _buildDropdown(
                                    value: _selectedTrack,
                                    items: _trackOptions,
                                    onChanged: (val) {
                                      if (val != null) setState(() => _selectedTrack = val);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Team Member Names
                    _buildTextField(
                      label: "TEAM MEMBER NAMES",
                      controller: _membersController,
                      hintText: "e.g. Anand K., Priya S., Rahul M.",
                    ),
                    const SizedBox(height: 16),

                    // Problem Statement / Project Concept
                    _buildTextField(
                      label: "PROBLEM STATEMENT / PROJECT CONCEPT *",
                      controller: _conceptController,
                      hintText: "Briefly explain the challenge, proposed system and tech stack...",
                      minLines: 3,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),

                    // GitHub Repo / Prototype Link
                    _buildTextField(
                      label: "GITHUB REPO / PROTOTYPE LINK",
                      controller: _repoUrlController,
                      hintText: "https://github.com/team/project",
                    ),
                  ],
                ),
              ),
            ),

            // Footer Actions
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1B4B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _submit,
                    child: Text(
                      "Register Team",
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF475569),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    int minLines = 1,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF312E81), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: items.contains(value) ? value : items.first,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
          items: items.map((opt) {
            return DropdownMenuItem<String>(
              value: opt,
              child: Text(opt, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

