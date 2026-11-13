import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PROJECT & INNOVATION: PROJECT HUB SCREEN
// Replicates the exact designs and functionality from the reference screens:
// 1. Hero blueprint grid banner with watermark & badges (PROJECT & INNOVATION, MVP)
// 2. Desk Pill: "Faculty Mentorship & Milestone Evaluation Desk" + Search bar
// 3. Filter tabs: "My Mentored Projects 5" vs "All College Projects 6"
// 4. Project Cards with full lifecycle stepper (10 stages: Idea to Portfolio)
// 5. AI Project Review Board nested card with 5 metrics & Faculty Remarks
// 6. Review & Approve interactive evaluation dialog (5 sliders, remarks, milestone sign-off)
// 7. Delete Project confirmation modal dialog
// 8. Repository, Documentation, Live Demo, and Team Pool click events
// =============================================================================

class FacultyProjectHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyProjectHubScreen({super.key, this.onBack});

  @override
  State<FacultyProjectHubScreen> createState() =>
      _FacultyProjectHubScreenState();
}

enum ProjectFilterTab { myMentored, allCollege }

class ProjectLifecycleStageItem {
  final String name;
  final bool isDone;
  final bool isActive;
  final bool isGold;

  const ProjectLifecycleStageItem({
    required this.name,
    this.isDone = false,
    this.isActive = false,
    this.isGold = false,
  });

  ProjectLifecycleStageItem copyWith({
    String? name,
    bool? isDone,
    bool? isActive,
    bool? isGold,
  }) {
    return ProjectLifecycleStageItem(
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
      isActive: isActive ?? this.isActive,
      isGold: isGold ?? this.isGold,
    );
  }
}

class ProjectHubModel {
  final String id;
  String title;
  String domain;
  String mentor;
  bool isAssignedToYou;
  bool inPortfolio;
  String currentStageBadge;
  String teamLead;
  String teamMembers;
  int completionPercentage;
  List<ProjectLifecycleStageItem> stages;
  bool isMilestoneApproved;
  bool hasScores;
  int architectureScore;
  int documentationScore;
  int codeQualityScore;
  int testingScore;
  int innovationScore;
  String facultyRemarks;
  String repoUrl;
  String docUrl;
  String demoUrl;

  ProjectHubModel({
    required this.id,
    required this.title,
    required this.domain,
    required this.mentor,
    required this.isAssignedToYou,
    required this.inPortfolio,
    required this.currentStageBadge,
    required this.teamLead,
    required this.teamMembers,
    required this.completionPercentage,
    required this.stages,
    required this.isMilestoneApproved,
    required this.hasScores,
    required this.architectureScore,
    required this.documentationScore,
    required this.codeQualityScore,
    required this.testingScore,
    required this.innovationScore,
    required this.facultyRemarks,
    this.repoUrl = "https://github.com/colossusiq/project-repo",
    this.docUrl = "https://docs.colossusiq.edu/projects/srs",
    this.demoUrl = "https://demo.colossusiq.edu/instance",
  });
}

class _FacultyProjectHubScreenState extends State<FacultyProjectHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  ProjectFilterTab _activeTab = ProjectFilterTab.myMentored;

  // Master list of college projects (5 mentored by Dr. Meena Raghavan + 1 from Civil Department)
  late List<ProjectHubModel> _projects;

  @override
  void initState() {
    super.initState();
    _initializeProjects();
  }

  void _initializeProjects() {
    final stages100 = [
      const ProjectLifecycleStageItem(name: "Idea", isDone: true),
      const ProjectLifecycleStageItem(name: "Team Formation", isDone: true),
      const ProjectLifecycleStageItem(name: "Architecture", isDone: true),
      const ProjectLifecycleStageItem(name: "Milestones", isDone: true),
      const ProjectLifecycleStageItem(name: "Implementation", isDone: true),
      const ProjectLifecycleStageItem(name: "Testing", isDone: true),
      const ProjectLifecycleStageItem(name: "AI Review", isDone: true),
      const ProjectLifecycleStageItem(name: "Faculty Review", isDone: true),
      const ProjectLifecycleStageItem(name: "Demo", isDone: true),
      const ProjectLifecycleStageItem(name: "Portfolio", isDone: false, isActive: false, isGold: true),
    ];

    _projects = [
      // 1. Autonomous Campus Smart Delivery Rover
      ProjectHubModel(
        id: "proj-1",
        title: "Autonomous Campus Smart Delivery Rover",
        domain: "AI/ML · IoT & Edge Computing · Mentor: Dr. Meena Raghavan",
        mentor: "Dr. Meena Raghavan",
        isAssignedToYou: true,
        inPortfolio: true,
        currentStageBadge: "Portfolio",
        teamLead: "Lead Student",
        teamMembers: "Priya V.",
        completionPercentage: 100,
        stages: List.from(stages100),
        isMilestoneApproved: true,
        hasScores: true,
        architectureScore: 98,
        documentationScore: 94,
        codeQualityScore: 90,
        testingScore: 94,
        innovationScore: 90,
        facultyRemarks: "Approved .. prepare for live demo",
      ),

      // 2. Smart Campus Real-Time Space & Energy Optimizer
      ProjectHubModel(
        id: "proj-2",
        title: "Smart Campus Real-Time Space & Energy Optimizer",
        domain: "AI/ML · Mentor: Dr. Meena Raghavan",
        mentor: "Dr. Meena Raghavan",
        isAssignedToYou: true,
        inPortfolio: true,
        currentStageBadge: "Portfolio",
        teamLead: "Lead Student (You)",
        teamMembers: "Rahul S., Priya V.",
        completionPercentage: 100,
        stages: List.from(stages100),
        isMilestoneApproved: true,
        hasScores: true,
        architectureScore: 75,
        documentationScore: 82,
        codeQualityScore: 75,
        testingScore: 84,
        innovationScore: 93,
        facultyRemarks: "ok good",
      ),

      // 3. Solar-Powered Edge-AI Wildfire Early Detection Sentinel
      ProjectHubModel(
        id: "proj-3",
        title: "Solar-Powered Edge-AI Wildfire Early Detection Sentinel",
        domain: "AI/ML · Computer Vision · Mentor: Dr. Meena Raghavan",
        mentor: "Dr. Meena Raghavan",
        isAssignedToYou: true,
        inPortfolio: true,
        currentStageBadge: "Portfolio",
        teamLead: "Lead Student",
        teamMembers: "Rahul S., Priya V.",
        completionPercentage: 100,
        stages: List.from(stages100),
        isMilestoneApproved: true,
        hasScores: true,
        architectureScore: 81,
        documentationScore: 81,
        codeQualityScore: 83,
        testingScore: 84,
        innovationScore: 86,
        facultyRemarks:
            "Edge-AI inference pipeline and LoRa telemetry architecture approved. Thermal vision sensor calibration demonstrates strong 84% test coverage. Ensure solar power harvesting battery failover tests and field latency figures are documented in the SRS report before the final campus hardware demonstration.",
      ),

      // 4. Automated Smart Irrigation & Soil Quality Assessment Drone
      ProjectHubModel(
        id: "proj-4",
        title: "Automated Smart Irrigation & Soil Quality Assessment Drone",
        domain: "AgriTech · Embedded · Mentor: Dr. Meena Raghavan",
        mentor: "Dr. Meena Raghavan",
        isAssignedToYou: true,
        inPortfolio: false,
        currentStageBadge: "Demo",
        teamLead: "Anand Kumar",
        teamMembers: "Kavitha M., Suresh K.",
        completionPercentage: 90,
        stages: [
          const ProjectLifecycleStageItem(name: "Idea", isDone: true),
          const ProjectLifecycleStageItem(name: "Team Formation", isDone: true),
          const ProjectLifecycleStageItem(name: "Architecture", isDone: true),
          const ProjectLifecycleStageItem(name: "Milestones", isDone: true),
          const ProjectLifecycleStageItem(name: "Implementation", isDone: true),
          const ProjectLifecycleStageItem(name: "Testing", isDone: true),
          const ProjectLifecycleStageItem(name: "AI Review", isDone: true),
          const ProjectLifecycleStageItem(name: "Faculty Review", isDone: true),
          const ProjectLifecycleStageItem(name: "Demo", isDone: false, isActive: true),
          const ProjectLifecycleStageItem(name: "Portfolio", isDone: false),
        ],
        isMilestoneApproved: true,
        hasScores: true,
        architectureScore: 88,
        documentationScore: 85,
        codeQualityScore: 82,
        testingScore: 80,
        innovationScore: 85,
        facultyRemarks:
            "Flight telemetry and multispectral soil indexing look consistent. Final field flight approval pending wind tunnel test validation.",
      ),

      // 5. Healthcare Wearable Telemetry & Fall Prediction System
      ProjectHubModel(
        id: "proj-5",
        title: "Healthcare Wearable Telemetry & Fall Prediction System",
        domain: "Biomedical · IoT · Mentor: Dr. Meena Raghavan",
        mentor: "Dr. Meena Raghavan",
        isAssignedToYou: true,
        inPortfolio: false,
        currentStageBadge: "Faculty Review",
        teamLead: "Divya Raman",
        teamMembers: "Karthik Iyer, Vignesh N.",
        completionPercentage: 80,
        stages: [
          const ProjectLifecycleStageItem(name: "Idea", isDone: true),
          const ProjectLifecycleStageItem(name: "Team Formation", isDone: true),
          const ProjectLifecycleStageItem(name: "Architecture", isDone: true),
          const ProjectLifecycleStageItem(name: "Milestones", isDone: true),
          const ProjectLifecycleStageItem(name: "Implementation", isDone: true),
          const ProjectLifecycleStageItem(name: "Testing", isDone: true),
          const ProjectLifecycleStageItem(name: "AI Review", isDone: true),
          const ProjectLifecycleStageItem(name: "Faculty Review", isDone: false, isActive: true),
          const ProjectLifecycleStageItem(name: "Demo", isDone: false),
          const ProjectLifecycleStageItem(name: "Portfolio", isDone: false),
        ],
        isMilestoneApproved: true,
        hasScores: true,
        architectureScore: 85,
        documentationScore: 80,
        codeQualityScore: 78,
        testingScore: 82,
        innovationScore: 88,
        facultyRemarks:
            "IMU accelerometer fall vector dataset verified. Complete edge battery benchmark report.",
      ),

      // 6. Smart Concrete: Crack-Healing Bio-Concrete (Civil Department)
      ProjectHubModel(
        id: "proj-6",
        title: "Smart Concrete: Crack-Healing Bio-Concrete Using Industrial Fly Ash",
        domain: "Civil · Structural & Sustainable Infra · Mentor: Dr. K. Saravanan",
        mentor: "Dr. K. Saravanan",
        isAssignedToYou: false,
        inPortfolio: false,
        currentStageBadge: "Architecture",
        teamLead: "Priya V.",
        teamMembers: "Lead Student, rahul s.",
        completionPercentage: 20,
        stages: [
          const ProjectLifecycleStageItem(name: "Idea", isDone: true),
          const ProjectLifecycleStageItem(name: "Team Formation", isDone: true),
          const ProjectLifecycleStageItem(name: "Architecture", isDone: false, isActive: true),
          const ProjectLifecycleStageItem(name: "Milestones", isDone: false),
          const ProjectLifecycleStageItem(name: "Implementation", isDone: false),
          const ProjectLifecycleStageItem(name: "Testing", isDone: false),
          const ProjectLifecycleStageItem(name: "AI Review", isDone: false),
          const ProjectLifecycleStageItem(name: "Faculty Review", isDone: false),
          const ProjectLifecycleStageItem(name: "Demo", isDone: false),
          const ProjectLifecycleStageItem(name: "Portfolio", isDone: false),
        ],
        isMilestoneApproved: false,
        hasScores: false,
        architectureScore: 0,
        documentationScore: 0,
        codeQualityScore: 0,
        testingScore: 0,
        innovationScore: 0,
        facultyRemarks: "Architecture stage under review",
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // FILTERING LOGIC
  // ===========================================================================
  List<ProjectHubModel> get _filteredProjects {
    return _projects.where((p) {
      if (_activeTab == ProjectFilterTab.myMentored && !p.isAssignedToYou) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesTitle = p.title.toLowerCase().contains(q);
        final matchesDomain = p.domain.toLowerCase().contains(q);
        final matchesMentor = p.mentor.toLowerCase().contains(q);
        final matchesTeam = p.teamLead.toLowerCase().contains(q) ||
            p.teamMembers.toLowerCase().contains(q);
        if (!matchesTitle && !matchesDomain && !matchesMentor && !matchesTeam) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  int get _myMentoredCount =>
      _projects.where((p) => p.isAssignedToYou).length;
  int get _allCollegeCount => _projects.length;

  // ===========================================================================
  // REVIEW & APPROVE MODAL DIALOG
  // Matches media_1794464628452_ef6ad5d0.png
  // ===========================================================================
  void _openReviewAndApproveDialog(ProjectHubModel project) {
    double archVal = project.hasScores ? project.architectureScore.toDouble() : 75.0;
    double docVal = project.hasScores ? project.documentationScore.toDouble() : 80.0;
    double codeVal = project.hasScores ? project.codeQualityScore.toDouble() : 75.0;
    double testVal = project.hasScores ? project.testingScore.toDouble() : 80.0;
    double innoVal = project.hasScores ? project.innovationScore.toDouble() : 85.0;
    final remarksController = TextEditingController(text: project.facultyRemarks);
    bool approveMilestone = project.isMilestoneApproved || true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Faculty Review & Milestone Evaluation",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${project.title} · Team: ${project.teamLead}, ${project.teamMembers}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx),
                            icon: const Icon(Icons.close_rounded,
                                color: Color(0xFF64748B), size: 22),
                            splashRadius: 20,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Scorecards Box (0–100)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Scorecards (0–100)",
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 14),

                            _buildSliderRow(
                              "Architecture / Design",
                              archVal,
                              (v) => setModalState(() => archVal = v),
                            ),
                            const SizedBox(height: 12),
                            _buildSliderRow(
                              "Documentation / Specs",
                              docVal,
                              (v) => setModalState(() => docVal = v),
                            ),
                            const SizedBox(height: 12),
                            _buildSliderRow(
                              "Code / Build Quality",
                              codeVal,
                              (v) => setModalState(() => codeVal = v),
                            ),
                            const SizedBox(height: 12),
                            _buildSliderRow(
                              "Testing & Validation",
                              testVal,
                              (v) => setModalState(() => testVal = v),
                            ),
                            const SizedBox(height: 12),
                            _buildSliderRow(
                              "Innovation",
                              innoVal,
                              (v) => setModalState(() => innoVal = v),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Faculty Remarks / Feedback
                      Text(
                        "Faculty Remarks / Feedback",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: TextField(
                          controller: remarksController,
                          maxLines: 4,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF1E293B),
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter milestone feedback, notes, and guidance...",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF94A3B8),
                            ),
                            contentPadding: const EdgeInsets.all(14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Checkbox: Approve milestone and unlock Demo stage
                      InkWell(
                        onTap: () {
                          setModalState(() {
                            approveMilestone = !approveMilestone;
                          });
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 22,
                              height: 22,
                              child: Checkbox(
                                value: approveMilestone,
                                activeColor: const Color(0xFF0F766E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (v) {
                                  setModalState(() {
                                    approveMilestone = v ?? true;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Approve milestone and unlock Demo stage",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Bottom Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                project.architectureScore = archVal.round();
                                project.documentationScore = docVal.round();
                                project.codeQualityScore = codeVal.round();
                                project.testingScore = testVal.round();
                                project.innovationScore = innoVal.round();
                                project.hasScores = true;
                                project.facultyRemarks = remarksController.text.trim().isEmpty
                                    ? "Approved by faculty mentor."
                                    : remarksController.text.trim();
                                project.isMilestoneApproved = approveMilestone;
                              });
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded,
                                          color: Colors.white, size: 20),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Review and milestone evaluation saved for ${project.title}!",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xFF0F766E),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD97706),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Submit Review & Sign-off",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSliderRow(
      String label, double value, ValueChanged<double> onChanged) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 420;
        final labelWidget = SizedBox(
          width: isNarrow ? double.infinity : 170,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF334155),
            ),
          ),
        );

        final sliderWidget = Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF1E2865),
              inactiveTrackColor: const Color(0xFFE2E8F0),
              thumbColor: const Color(0xFF1E2865),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              trackHeight: 4,
              overlayColor: const Color(0xFF1E2865).withValues(alpha: 0.12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: onChanged,
            ),
          ),
        );

        final numberWidget = Container(
          width: 38,
          alignment: Alignment.centerRight,
          child: Text(
            "${value.round()}",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget,
              Row(
                children: [
                  sliderWidget,
                  const SizedBox(width: 8),
                  numberWidget,
                ],
              ),
            ],
          );
        }

        return Row(
          children: [
            labelWidget,
            sliderWidget,
            const SizedBox(width: 8),
            numberWidget,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // DELETE PROJECT CONFIRMATION DIALOG
  // Matches media_1794464652708_2b2b3b2c.png
  // ===========================================================================
  void _openDeleteProjectDialog(ProjectHubModel project) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Red trash icon container
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFFDC2626),
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 18),

                  Text(
                    "Delete Project",
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "This action cannot be undone",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFDC2626),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    'Are you sure you want to delete "${project.title}"? All recorded lifecycle stages, repository links, and review scores will be permanently removed.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      height: 1.5,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 11),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _projects.removeWhere((p) => p.id == project.id);
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '"${project.title}" has been deleted.',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: const Color(0xFFDC2626),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Delete Project",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // INTERACTION SNACKBARS / DIALOGS FOR LINKS
  // ===========================================================================
  void _openRepoLink(ProjectHubModel project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.code_rounded, color: Color(0xFF1E2865), size: 22),
            const SizedBox(width: 8),
            Text("Repository & Code",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title,
                style: GoogleFonts.poppins(
                    fontSize: 13.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link_rounded, size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "${project.repoUrl}/${project.title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '-')}",
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: const Color(0xFF0F766E)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text("Files in repository:",
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text("• src/models/main_pipeline.py\n• docs/system_architecture.pdf\n• hardware/schematics.cad\n• README.md (verified)",
                style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569))),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Cloned repository URL to clipboard!",
                      style: GoogleFonts.poppins()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
            ),
            child: Text("Copy Git Link", style: GoogleFonts.poppins(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _openDocumentation(ProjectHubModel project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.description_outlined, color: Color(0xFF0F766E), size: 22),
            const SizedBox(width: 8),
            Text("Project Documentation",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title,
                style: GoogleFonts.poppins(
                    fontSize: 13.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Text(
              "Verified documents uploaded by team:\n"
              "1. SRS Software Requirements Specification (v2.1)\n"
              "2. Component Schematic & BOM (Bill of Materials)\n"
              "3. AI Model Accuracy & Edge Validation Benchmarks\n"
              "4. Faculty Mentorship Log & Phase 3 Sign-off Sheet",
              style: GoogleFonts.poppins(fontSize: 12, height: 1.5, color: const Color(0xFF334155)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Downloading complete project documentation bundle...",
                      style: GoogleFonts.poppins()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F766E),
              foregroundColor: Colors.white,
            ),
            child: Text("Download PDF Bundle", style: GoogleFonts.poppins(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _openLiveDemo(ProjectHubModel project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.language_rounded, color: Color(0xFF2563EB), size: 22),
            const SizedBox(width: 8),
            Text("Live Demo & Simulation",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title,
                style: GoogleFonts.poppins(
                    fontSize: 13.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.fiber_manual_record, color: Color(0xFF16A34A), size: 14),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Live demo environment is online and responding at port 8080 (Telemetry streaming active).",
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E40AF)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Launching interactive live demo portal...",
                      style: GoogleFonts.poppins()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
            ),
            child: Text("Open Sandbox", style: GoogleFonts.poppins(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _openTeamPool(ProjectHubModel project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.group_rounded, color: Color(0xFF0F766E), size: 22),
            const SizedBox(width: 8),
            Text("Team Pool & Contributors",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title,
                style: GoogleFonts.poppins(
                    fontSize: 13.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _buildTeamMemberTile(project.teamLead, "Team Lead / Architect", true),
            ...project.teamMembers.split(",").map((m) => _buildTeamMemberTile(m.trim(), "Contributor / Researcher", false)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Done", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Opening Teammate Matching desk...",
                      style: GoogleFonts.poppins()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F766E),
              foregroundColor: Colors.white,
            ),
            child: Text("+ Invite Contributor", style: GoogleFonts.poppins(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberTile(String name, String role, bool isLead) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: isLead ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : "U",
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isLead ? Colors.white : const Color(0xFF334155),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        fontSize: 12.5, fontWeight: FontWeight.w600)),
                Text(role,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          if (isLead)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text("LEAD",
                  style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF92400E))),
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // BUILD SCREEN
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProjects;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        children: [
          // 1. Hero Blueprint Banner
          _buildHeroBanner(),
          const SizedBox(height: 16),

          // 2. Desk Pill + Search Bar Row
          _buildDeskAndSearchRow(),
          const SizedBox(height: 16),

          // 3. Filter Tabs Row: "My Mentored Projects 5" vs "All College Projects 6"
          _buildFilterTabsRow(),
          const SizedBox(height: 16),

          // 4. Project Cards List
          if (filtered.isEmpty)
            _buildEmptyState()
          else
            ...filtered.map((project) => Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: _buildProjectCard(project),
                )),
        ],
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Project & Innovation",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Project Hub",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildPillBadge(
                        "PROJECT & INNOVATION",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "MVP",
                        const Color(0xFF0F766E),
                        Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Icon + Title + Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232F6E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: const Icon(
                          Icons.lightbulb_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Project Hub",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Idea -> team -> architecture -> milestones -> AI review -> faculty review -> demo -> portfolio.",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
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

  Widget _buildPillBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. DESK PILL + SEARCH BAR ROW
  // ===========================================================================
  Widget _buildDeskAndSearchRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620;
        final deskPill = _buildDeskPill();
        final searchInput = _buildSearchInput();

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              deskPill,
              const SizedBox(height: 10),
              searchInput,
            ],
          );
        }

        return Row(
          children: [
            deskPill,
            const Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320, minWidth: 220),
              child: searchInput,
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeskPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_outlined,
            size: 16,
            color: Color(0xFF0F766E),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              "Faculty Mentorship & Milestone Evaluation Desk",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val.trim();
          });
        },
        style: GoogleFonts.poppins(fontSize: 12.5),
        decoration: InputDecoration(
          hintText: "Search projects, domains, mentors...",
          hintStyle: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF94A3B8),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 18,
            color: Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 9),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. FILTER TABS ROW: "My Mentored Projects 5" vs "All College Projects 6"
  // ===========================================================================
  Widget _buildFilterTabsRow() {
    final labelText = _activeTab == ProjectFilterTab.myMentored
        ? "Showing $_myMentoredCount project(s) assigned to you as mentor"
        : "Showing $_allCollegeCount project(s) across all college departments";

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 740;

        final tabsWidget = Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // Tab 1: My Mentored Projects
            InkWell(
              onTap: () {
                setState(() {
                  _activeTab = ProjectFilterTab.myMentored;
                });
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: _activeTab == ProjectFilterTab.myMentored
                      ? const Color(0xFF1E2865)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _activeTab == ProjectFilterTab.myMentored
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      size: 14,
                      color: _activeTab == ProjectFilterTab.myMentored
                          ? Colors.white
                          : const Color(0xFF475569),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "My Mentored Projects",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _activeTab == ProjectFilterTab.myMentored
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: _activeTab == ProjectFilterTab.myMentored
                            ? const Color(0xFF141A46)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$_myMentoredCount",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _activeTab == ProjectFilterTab.myMentored
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tab 2: All College Projects
            InkWell(
              onTap: () {
                setState(() {
                  _activeTab = ProjectFilterTab.allCollege;
                });
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: _activeTab == ProjectFilterTab.allCollege
                      ? const Color(0xFF1E2865)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _activeTab == ProjectFilterTab.allCollege
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_balance_outlined,
                      size: 14,
                      color: _activeTab == ProjectFilterTab.allCollege
                          ? Colors.white
                          : const Color(0xFF475569),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "All College Projects",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _activeTab == ProjectFilterTab.allCollege
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: _activeTab == ProjectFilterTab.allCollege
                            ? const Color(0xFF141A46)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$_allCollegeCount",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _activeTab == ProjectFilterTab.allCollege
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

        final infoWidget = Text(
          labelText,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tabsWidget,
              const SizedBox(height: 8),
              infoWidget,
            ],
          );
        }

        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            tabsWidget,
            infoWidget,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 4. PROJECT CARD
  // ===========================================================================
  Widget _buildProjectCard(ProjectHubModel project) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title + Domain on Left, Badges + Review & Approve on Right
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 620;

              final titleSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: GoogleFonts.poppins(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    project.domain,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );

              final actionSection = Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Assigned to you badge (cyan pill)
                  if (project.isAssignedToYou)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person_outline_rounded,
                              size: 13, color: Color(0xFF0284C7)),
                          const SizedBox(width: 4),
                          Text(
                            "Assigned to You",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0284C7),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Stage badge (Portfolio / Architecture / Demo / etc.)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: project.inPortfolio
                          ? const Color(0xFFCCFBF1)
                          : const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      project.currentStageBadge,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: project.inPortfolio
                            ? const Color(0xFF0F766E)
                            : const Color(0xFF92400E),
                      ),
                    ),
                  ),

                  // Review & Approve amber button
                  ElevatedButton(
                    onPressed: () => _openReviewAndApproveDialog(project),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD97706),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Review & Approve",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // Delete trash icon
                  IconButton(
                    onPressed: () => _openDeleteProjectDialog(project),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: Color(0xFF94A3B8),
                    ),
                    splashRadius: 18,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    tooltip: "Delete Project",
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSection,
                    const SizedBox(height: 10),
                    actionSection,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: titleSection),
                  const SizedBox(width: 12),
                  actionSection,
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          // Team Row & Right Links (Responsive LayoutBuilder)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 640;

              final teamSection = Wrap(
                spacing: 6,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.people_outline_rounded,
                    size: 16,
                    color: Color(0xFF0F766E),
                  ),
                  Text(
                    "Team: ",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  Text(
                    "${project.teamLead}, ${project.teamMembers}",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  InkWell(
                    onTap: () => _openTeamPool(project),
                    borderRadius: BorderRadius.circular(4),
                    child: Text(
                      "+ Team Pool",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ],
              );

              final linksSection = Wrap(
                spacing: 12,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  InkWell(
                    onTap: () => _openRepoLink(project),
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.code_rounded,
                            size: 14, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text(
                          "Repository / Files",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _openDocumentation(project),
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.description_outlined,
                            size: 14, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text(
                          "Documentation",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _openLiveDemo(project),
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.language_rounded,
                            size: 14, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text(
                          "Live Demo",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    teamSection,
                    const SizedBox(height: 8),
                    linksSection,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: teamSection),
                  const SizedBox(width: 12),
                  linksSection,
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Project Lifecycle Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Project Lifecycle",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              Text(
                "${project.completionPercentage}% completed",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Lifecycle Horizontal Stepper (10 stages)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(project.stages.length, (index) {
                final st = project.stages[index];
                Color barColor = const Color(0xFFE2E8F0);
                if (st.isDone) {
                  barColor = const Color(0xFF0F766E);
                } else if (st.isGold) {
                  barColor = const Color(0xFFD97706);
                } else if (st.isActive) {
                  barColor = const Color(0xFFD97706);
                }

                return Container(
                  margin: const EdgeInsets.only(right: 14),
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (st.isDone)
                            const Text(
                              "✓ ",
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F766E),
                              ),
                            ),
                          Text(
                            st.name,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: (st.isDone || st.isActive || st.isGold)
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: st.isDone
                                  ? const Color(0xFF0F766E)
                                  : (st.isActive || st.isGold
                                      ? const Color(0xFFD97706)
                                      : const Color(0xFF94A3B8)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 18),

          // AI Project Review Board nested card
          _buildAIReviewBoard(project),
        ],
      ),
    );
  }

  // ===========================================================================
  // NESTED CARD: AI PROJECT REVIEW BOARD
  // ===========================================================================
  Widget _buildAIReviewBoard(ProjectHubModel project) {
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
          // Header: AI Review Board icon & title + Milestone Approved badge (Responsive Wrap to prevent overflow)
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    size: 15,
                    color: Color(0xFF1E2865),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "AI Project Review Board",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              if (project.isMilestoneApproved)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCFBF1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_rounded,
                          size: 13, color: Color(0xFF0F766E)),
                      const SizedBox(width: 4),
                      Text(
                        "Faculty Milestone Approved",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // 5 Score Breakdown Bars
          Wrap(
            spacing: 18,
            runSpacing: 12,
            children: [
              _buildReviewScoreBar("Architecture", project.architectureScore,
                  project.hasScores, const Color(0xFF0F766E)),
              _buildReviewScoreBar("Documentation", project.documentationScore,
                  project.hasScores, const Color(0xFF0F766E)),
              _buildReviewScoreBar("Code / Build Quality",
                  project.codeQualityScore, project.hasScores, const Color(0xFF0F766E)),
              _buildReviewScoreBar("Testing", project.testingScore,
                  project.hasScores, const Color(0xFF0F766E)),
              _buildReviewScoreBar("Innovation", project.innovationScore,
                  project.hasScores, const Color(0xFF0F766E)),
            ],
          ),
          const SizedBox(height: 14),

          // Faculty Remarks Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFBBF7D0)),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Faculty Remarks: ",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF166534),
                    ),
                  ),
                  TextSpan(
                    text: project.facultyRemarks,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF166534),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Text(
            "AI review is advisory; faculty review decides milestone approval and portfolio publication.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewScoreBar(
      String label, int score, bool hasScore, Color barColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF334155),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              hasScore ? "$score" : "-",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: 105,
          height: 4.5,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(2),
          ),
          child: hasScore
              ? FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (score.clamp(0, 100)) / 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(Icons.folder_open_rounded, size: 48, color: Color(0xFFCBD5E1)),
          const SizedBox(height: 12),
          Text(
            "No projects found",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Try searching with another keyword or switch the tab.",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
