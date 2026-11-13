import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PROJECT & INNOVATION: RESEARCH ASSISTANT SCREEN
// Replicates the exact designs and functionality from the reference screens:
// 1. Hero blueprint banner (PROJECT & INNOVATION, Phase 2, flask icon & watermark)
// 2. Left sidebar: "Your projects" with project cards, stage pills, tools used counter, and "+ New"
// 3. Right workspace:
//    - Project header card with Title, Department, Target Grant/Journal, Edit & Delete actions,
//      and interactive Stage dropdown
//    - Tool navigation tabs: Research questions, Literature search, Paper outline, Work plan, Ask the assistant
//    - Tab 1: Research questions with "Angle to focus on", "Write again", 5 detailed question cards, and "Copy all questions"
//    - Tab 2: Literature search plan with query cards (Google Scholar, Semantic Scholar, IEEE Xplore, arXiv, Copy),
//      and 3 guide cards (Where to look, What to keep, Reading tips)
//    - Tab 3: Paper outline with section breakdown cards (Introduction, Background, System Architecture, etc.)
//    - Tab 4: Work plan with milestone timeline and deliverables
//    - Tab 5: Ask the assistant interactive AI research copilot Q&A
//    - Bottom Notes scratch space with live character counter (e.g. 4 / 4000) and "Save notes"
// =============================================================================

class FacultyResearchAssistantScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyResearchAssistantScreen({super.key, this.onBack});

  @override
  State<FacultyResearchAssistantScreen> createState() =>
      _FacultyResearchAssistantScreenState();
}

class ResearchProjectItem {
  final String id;
  String title;
  String department;
  String level;
  String targetGrantOrJournal;
  String stage;
  int toolsUsedCount;
  int totalToolsCount;
  String notes;
  List<ResearchQuestionItem> questions;
  List<LiteratureSearchQuery> searchQueries;
  List<OutlineSectionItem> outlineSections;
  List<WorkPlanStepItem> workPlanSteps;

  ResearchProjectItem({
    required this.id,
    required this.title,
    required this.department,
    required this.level,
    required this.targetGrantOrJournal,
    required this.stage,
    required this.toolsUsedCount,
    this.totalToolsCount = 4,
    required this.notes,
    required this.questions,
    required this.searchQueries,
    required this.outlineSections,
    required this.workPlanSteps,
  });
}

class WorkPlanStepItem {
  final String title;
  final int weeks;
  final List<String> bulletPoints;
  bool isCompleted;

  WorkPlanStepItem({
    required this.title,
    required this.weeks,
    required this.bulletPoints,
    this.isCompleted = false,
  });
}

class ResearchQuestionItem {
  final int number;
  final String question;
  final String whyItMatters;
  final String howToTestIt;

  const ResearchQuestionItem({
    required this.number,
    required this.question,
    required this.whyItMatters,
    required this.howToTestIt,
  });
}

class LiteratureSearchQuery {
  final String title;
  final String query;

  const LiteratureSearchQuery({
    required this.title,
    required this.query,
  });
}

class OutlineSectionItem {
  final String title;
  final List<String> bulletPoints;

  const OutlineSectionItem({
    required this.title,
    required this.bulletPoints,
  });
}

class _FacultyResearchAssistantScreenState
    extends State<FacultyResearchAssistantScreen> {
  late List<ResearchProjectItem> _projects;
  late String _selectedProjectId;

  int _selectedTabIndex = 0;
  final List<String> _tabs = [
    "Research questions",
    "Literature search",
    "Paper outline",
    "Work plan",
    "Ask the assistant",
  ];

  final TextEditingController _angleFocusController = TextEditingController();
  final TextEditingController _narrowSearchController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _askAssistantController = TextEditingController();

  final List<Map<String, String>> _assistantChatMessages = [
    {
      "sender": "ai",
      "text":
          "Hello! I am your AI Research Assistant. Ask me anything about methodology, formulating testable hypotheses, literature synthesis, DST grant compliance, or drafting LaTeX equations.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeProjects();
    _selectedProjectId = _projects[1].id; // Default to Wildfire Sentinel as shown in screenshot 1
    _loadProjectNotes();
  }

  void _initializeProjects() {
    _projects = [
      // 1. Federated Learning for Privacy-Preserving Smart Healthcare
      ResearchProjectItem(
        id: "proj-fl",
        title:
            "Federated Learning for Privacy-Preserving Smart Healthcare...",
        department: "Artificial Intelligence & Data Science · Faculty",
        level: "Faculty",
        targetGrantOrJournal:
            "IEEE Journal of Biomedical and Health Informatics & ICMR grant",
        stage: "Idea",
        toolsUsedCount: 4,
        notes: "Literature survey completed. Need to benchmark differential privacy epsilon parameters.",
        questions: [
          const ResearchQuestionItem(
            number: 1,
            question:
                "What privacy bounds exist when training federated CNN models on decentralized hospital EHR datasets?",
            whyItMatters:
                "HIPAA and DPDP regulations forbid raw telemetry transmission outside hospital servers.",
            howToTestIt:
                "Simulate non-IID patient cohort distributions and quantify gradient leakage under membership inference attacks.",
          ),
          const ResearchQuestionItem(
            number: 2,
            question:
                "How does asynchronous client aggregation impact converge latency compared to standard FedAvg?",
            whyItMatters:
                "Edge medical devices operate with varying battery and intermittent network latency.",
            howToTestIt:
                "Benchmark staleness-weighted gradient updates across 50 simulated hospital client nodes.",
          ),
        ],
        searchQueries: [
          const LiteratureSearchQuery(
            title: "Federated Learning Healthcare Overview",
            query:
                '"federated learning" AND ("healthcare" OR "EHR") AND ("differential privacy" OR "secure aggregation")',
          ),
        ],
        outlineSections: [
          const OutlineSectionItem(
            title: "Introduction",
            bulletPoints: [
              "Emergence of multi-center clinical studies and data sovereignty concerns.",
              "Shortcomings of centralized cloud aggregations for sensitive vitals.",
            ],
          ),
        ],
        workPlanSteps: _getDefaultWorkPlanSteps("Federated Learning Smart Healthcare"),
      ),

      // 2. Solar-Powered Edge-AI Wildfire Early Detection Sentinel
      ResearchProjectItem(
        id: "proj-wildfire",
        title: "Solar-Powered Edge-AI Wildfire Early Detection Sentinel",
        department: "Computer Science & IOT · Faculty",
        level: "Faculty",
        targetGrantOrJournal:
            "IEEE Internet of Things Journal paper & DST research grant",
        stage: "Idea",
        toolsUsedCount: 4,
        notes: "good",
        questions: [
          const ResearchQuestionItem(
            number: 1,
            question:
                "What does the existing work on Solar-Powered Edge-AI Wildfire Early Detection Sentinel in Computer Science & IOT already establish, and which gap is still open?",
            whyItMatters:
                "A question about the gap keeps the project from repeating published work.",
            howToTestIt:
                "Review 15–20 recent papers and tabulate what each shows, its method and its limits; the gap is what no row covers.",
          ),
          const ResearchQuestionItem(
            number: 2,
            question:
                "How can solar energy harvesting be dynamically balanced with Edge-AI inference workloads under dense forest canopy shade?",
            whyItMatters:
                "Energy neutrality directly determines multi-month unattended field deployment viability without battery replacement.",
            howToTestIt:
                "Simulate battery discharge curves under low-lux forest conditions with duty-cycle adaptive tensor inference.",
          ),
          const ResearchQuestionItem(
            number: 3,
            question:
                "How does a proposed approach to Solar-Powered Edge-AI Wildfire Early Detection Sentinel compare with a standard baseline on accuracy, cost or usability?",
            whyItMatters:
                "A baseline comparison gives the work a clear, checkable result.",
            howToTestIt:
                "Pick one accepted baseline and one or two measures, run both on the same data or cases, and report the difference with its uncertainty.",
          ),
          const ResearchQuestionItem(
            number: 4,
            question:
                "What practical limits (data, cost, skills, setting) affect using Solar-Powered Edge-AI Wildfire Early Detection Sentinel in Indian institutions or industry?",
            whyItMatters:
                "Context-specific limits often make the most useful contribution at UG and PG level.",
            howToTestIt:
                "Interview or survey a small sample of practitioners and compare their constraints with those assumed in published work.",
          ),
          const ResearchQuestionItem(
            number: 5,
            question:
                "What theory or model could explain the pattern seen in Solar-Powered Edge-AI Wildfire Early Detection Sentinel, and what would disprove it?",
            whyItMatters:
                "Doctoral and faculty research is expected to explain, not only to describe.",
            howToTestIt:
                "State the model's predictions in advance, then test them on data it was not fitted to.",
          ),
        ],
        searchQueries: [
          const LiteratureSearchQuery(
            title: "Wildfire AI IoT Overview",
            query:
                '"wildfire detection" AND ("artificial intelligence" OR "machine learning") AND ("internet of things" OR "IoT")',
          ),
          const LiteratureSearchQuery(
            title: "Edge AI Wildfire Detection",
            query:
                '("edge AI" OR "edge intelligence" OR "on-device AI") AND ("wildfire detection" OR "forest fire detection")',
          ),
          const LiteratureSearchQuery(
            title: "Solar Powered Edge IoT",
            query:
                '("solar powered IoT" OR "energy harvesting IoT") AND ("edge computing" OR "edge AI") AND "wireless sensor network"',
          ),
          const LiteratureSearchQuery(
            title: "Thermal Telemetry & Remote LoRaWAN",
            query:
                '"thermal imaging" AND "wildfire early warning" AND "LoRaWAN" AND "power consumption"',
          ),
        ],
        outlineSections: [
          const OutlineSectionItem(
            title: "Introduction",
            bulletPoints: [
              "Highlight the increasing global threat of wildfires, their devastating impact, and the critical need for early detection systems.",
              "Introduce the concept of leveraging IoT, Edge-AI, and renewable energy for autonomous and real-time environmental monitoring.",
              "Present the proposed Solar-Powered Edge-AI Wildfire Early Detection Sentinel system, emphasizing its key innovations and advantages.",
              "Outline the paper's structure and the specific contributions of this research to the field of IoT and wildfire management.",
            ],
          ),
          const OutlineSectionItem(
            title: "Background and Motivation",
            bulletPoints: [
              "Discuss the limitations of conventional wildfire detection methods, such as human patrols, watchtowers, and satellite imagery, particularly in remote or inaccessible areas.",
              "Explain the necessity for distributed, self-sustaining, and intelligent systems that can operate autonomously for extended periods.",
              "Detail the benefits of integrating Edge-AI for low-latency, on-device decision-making and solar power for energy independence in remote deployments.",
              "Identify the specific gaps in current approaches that this project aims to address, such as real-time local processing and energy-efficient communication.",
            ],
          ),
          const OutlineSectionItem(
            title: "System Architecture",
            bulletPoints: [
              "Provide a comprehensive overview of the sentinel node's architecture, detailing its core components: sensor array, Edge-AI processing unit, power management module, and communication interface.",
              "Illustrate the overall network topology, showing how individual sentinel nodes connect to a central monitoring station or gateway.",
              "Describe the data flow from raw sensor data acquisition, through edge processing and anomaly detection, to alert generation and transmission.",
            ],
          ),
        ],
        workPlanSteps: _getDefaultWorkPlanSteps("Solar-Powered Edge-AI Wildfire Early Detection Sentinel"),
      ),

      // 3. AI-driven microgrid energy management
      ResearchProjectItem(
        id: "proj-microgrid",
        title: "AI-driven microgrid energy manAI-driven microgrid energ...",
        department: "Electrical Engineering · Faculty",
        level: "Faculty",
        targetGrantOrJournal: "IEEE Transactions on Smart Grid & SERB grant",
        stage: "Method",
        toolsUsedCount: 2,
        notes: "Reinforcement learning reward function tuning in progress.",
        questions: [
          const ResearchQuestionItem(
            number: 1,
            question:
                "How does multi-agent deep Q-learning compare with model predictive control in handling sudden renewable solar volatility in islanded microgrids?",
            whyItMatters:
                "Prevents blackouts during rapid irradiance drops without diesel backup ramp latency.",
            howToTestIt:
                "Run standard IEEE 33-bus benchmark simulator with 1-second solar fluctuation dataset.",
          ),
        ],
        searchQueries: [
          const LiteratureSearchQuery(
            title: "Microgrid AI Energy Optimization",
            query:
                '"microgrid" AND ("reinforcement learning" OR "deep Q-network") AND ("renewable energy dispatch" OR "load balancing")',
          ),
        ],
        outlineSections: [
          const OutlineSectionItem(
            title: "Introduction",
            bulletPoints: [
              "Decentralization of power grids and microgrid resilience.",
              "Formulation of multi-objective dispatch under time-of-use tariffs.",
            ],
          ),
        ],
        workPlanSteps: _getDefaultWorkPlanSteps("AI-driven microgrid energy management"),
      ),

      // 4. Student Management System
      ResearchProjectItem(
        id: "proj-sms",
        title: "Student Management System",
        department: "Computer Science · UG",
        level: "UG",
        targetGrantOrJournal:
            "College Innovation Showcase & Academic Project Archive",
        stage: "Idea",
        toolsUsedCount: 1,
        notes: "Database ER diagram finalized.",
        questions: [
          const ResearchQuestionItem(
            number: 1,
            question:
                "What role-based access security model best balances ease of faculty grading with privacy of student transcripts?",
            whyItMatters:
                "Ensures compliance with institutional data governance and student anonymity during re-evaluations.",
            howToTestIt:
                "Conduct vulnerability testing and load test 1,000 concurrent attendance record submissions.",
          ),
        ],
        searchQueries: [
          const LiteratureSearchQuery(
            title: "Academic Management Web Architecture",
            query:
                '"student information system" AND ("role-based access control" OR "RBAC") AND "database scalability"',
          ),
        ],
        outlineSections: [
          const OutlineSectionItem(
            title: "System Overview",
            bulletPoints: [
              "Requirements gathering from college administration and examination cell.",
              "Database schema design and API authentication flow.",
            ],
          ),
        ],
        workPlanSteps: _getDefaultWorkPlanSteps("Student Management System"),
      ),
    ];
  }

  List<WorkPlanStepItem> _getDefaultWorkPlanSteps(String projectTitle) {
    return [
      WorkPlanStepItem(
        title: "Comprehensive Literature Review and System Architecture Design",
        weeks: 8,
        bulletPoints: [
          "Conduct a thorough review of existing solar-powered IoT systems, edge AI for environmental monitoring, and wildfire detection techniques to identify research gaps.",
          "Define the complete system architecture, including sensor suite (thermal, smoke, visual), edge computing platform, communication module, and power management unit.",
          "Select specific hardware components (e.g., microcontroller, AI accelerator, sensors, solar panel, battery) based on technical requirements, availability, and cost-effectiveness for prototype development.",
        ],
        isCompleted: false,
      ),
      WorkPlanStepItem(
        title: "Hardware Prototype Assembly and Basic Software Development",
        weeks: 10,
        bulletPoints: [
          "Assemble the selected hardware components, including the solar panel, battery, charge controller, edge device, and sensors, into a robust prototype unit.",
          "Develop initial firmware for sensor data acquisition, basic data preprocessing, and establishment of the communication link (e.g., LoRa or cellular).",
          "Implement and test the solar power harvesting and battery management system to ensure continuous and autonomous operation of the sentinel.",
        ],
        isCompleted: false,
      ),
      WorkPlanStepItem(
        title: "Edge AI Model Development and Integration",
        weeks: 12,
        bulletPoints: [
          "Curate or generate a comprehensive dataset of wildfire indicators (smoke, flame, heat signatures) suitable for training an edge AI model.",
          "Develop and train a lightweight deep learning model optimized for resource-constrained edge devices, focusing on high detection accuracy and low false-alarm rate.",
          "Optimize the system's performance, including AI model parameters, power management algorithms, and communication protocols, based on the test results.",
        ],
        isCompleted: false,
      ),
      WorkPlanStepItem(
        title: "DST Grant Proposal and Journal Manuscript Preparation",
        weeks: 8,
        bulletPoints: [
          "Prepare a detailed DST research grant proposal, outlining the project's objectives, methodology, expected outcomes, timeline, budget, and societal impact.",
          "Draft the initial manuscript for the IEEE Internet of Things Journal, presenting the system architecture, implementation details, experimental setup, and preliminary results.",
          "Conduct a thorough internal review of both the grant proposal and the manuscript for clarity, completeness, and adherence to respective submission guidelines.",
        ],
        isCompleted: false,
      ),
      WorkPlanStepItem(
        title: "Field Deployment and Long-Term Validation",
        weeks: 16,
        bulletPoints: [
          "Deploy multiple sentinel units in a representative outdoor environment (e.g., a designated forest area or large open campus) with necessary permissions.",
          "Monitor the system's performance, stability, and power autonomy over an extended period under varying environmental conditions.",
          "Collect real-world data to validate the AI model's effectiveness, identify potential issues, and gather insights for further improvements and future research directions.",
        ],
        isCompleted: false,
      ),
      WorkPlanStepItem(
        title: "Final Manuscript Revision, Camera-Ready Submission & Dissemination",
        weeks: 10,
        bulletPoints: [
          "Revise manuscript in response to peer reviewer comments from IEEE IoT Journal.",
          "Prepare open-source hardware schematics, firmware repository, and dataset archive.",
          "Present findings to DST project monitoring committee and institutional research forum.",
        ],
        isCompleted: false,
      ),
    ];
  }

  ResearchProjectItem get _currentProject {
    return _projects.firstWhere(
      (p) => p.id == _selectedProjectId,
      orElse: () => _projects.first,
    );
  }

  void _loadProjectNotes() {
    _notesController.text = _currentProject.notes;
  }

  @override
  void dispose() {
    _angleFocusController.dispose();
    _narrowSearchController.dispose();
    _notesController.dispose();
    _askAssistantController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // INTERACTION ACTIONS
  // ===========================================================================
  void _selectProject(String id) {
    setState(() {
      _selectedProjectId = id;
      _loadProjectNotes();
    });
  }

  void _saveNotes() {
    setState(() {
      _currentProject.notes = _notesController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Notes saved for ${_currentProject.title}!",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _copyQuestions() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Copied ${_currentProject.questions.length} research questions to clipboard!",
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _copySearchQuery(String query) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Copied search string to clipboard: $query",
          style: GoogleFonts.poppins(),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openAcademicSearch(String database, String query) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.open_in_new_rounded,
                color: Color(0xFF1E2865), size: 22),
            const SizedBox(width: 8),
            Text("Open $database",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Target search query in $database:",
                style: GoogleFonts.poppins(
                    fontSize: 12.5, color: const Color(0xFF64748B))),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                query,
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "In a live browser environment, this navigates to indexed papers matching your boolean query parameters.",
              style: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF334155)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel",
                style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Launching external research query on $database...",
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: const Color(0xFF0F766E),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
            ),
            child: Text("Launch Search",
                style: GoogleFonts.poppins(fontSize: 12.5)),
          ),
        ],
      ),
    );
  }

  void _triggerAIWriteAgain(String toolName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "AI is regenerating and fine-tuning $toolName with your latest focus angle...",
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openNewProjectDialog() {
    final titleCtrl = TextEditingController();
    final fieldCtrl =
        TextEditingController(text: "Computer Science & Engineering");
    final goalCtrl = TextEditingController();
    String levelVal = "Faculty";
    String stageVal = "Idea";

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(26, 22, 26, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row: "New research project" + Close icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New research project",
                        style: GoogleFonts.poppins(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: Color(0xFFF1F5F9), height: 1),
                  const SizedBox(height: 18),

                  // 1. Project title or topic
                  Text(
                    "Project title or topic",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: titleCtrl,
                    style: GoogleFonts.poppins(fontSize: 13),
                    decoration: InputDecoration(
                      hintText:
                          "e.g. Low-cost IoT soil moisture sensing for farms",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF3730A3)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Field
                  Text(
                    "Field",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: fieldCtrl,
                    style: GoogleFonts.poppins(fontSize: 13),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF3730A3)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Level & Where are you now? (Two columns)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 420;
                      final levelCol = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: levelVal,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFF64748B)),
                                items: [
                                  "Faculty",
                                  "PhD",
                                  "Postgraduate",
                                  "Undergraduate",
                                ]
                                    .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.5))))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    setModalState(() => levelVal = v);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      );

                      final stageCol = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Where are you now?",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: stageVal,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFF64748B)),
                                items: [
                                  "Idea",
                                  "Literature review",
                                  "Method",
                                  "Drafting",
                                  "Completed",
                                ]
                                    .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.5))))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    setModalState(() => stageVal = v);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      );

                      if (isNarrow) {
                        return Column(
                          children: [
                            levelCol,
                            const SizedBox(height: 12),
                            stageCol,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: levelCol),
                          const SizedBox(width: 14),
                          Expanded(child: stageCol),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // 4. Goal (optional)
                  Text(
                    "Goal (optional)",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: goalCtrl,
                      maxLines: 3,
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "For example: a conference paper, a final-year project, a thesis chapter.",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 5. Actions: Cancel and "+ Create project"
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
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          final title = titleCtrl.text.trim();
                          if (title.isEmpty) return;
                          final field = fieldCtrl.text.trim();
                          final goal = goalCtrl.text.trim();

                          final newProj = ResearchProjectItem(
                            id: "proj-${DateTime.now().millisecondsSinceEpoch}",
                            title: title,
                            department: "$field · $levelVal",
                            level: levelVal,
                            targetGrantOrJournal: goal.isNotEmpty
                                ? goal
                                : "IEEE Conference Paper & College Research Grant",
                            stage: stageVal,
                            toolsUsedCount: 1,
                            notes: "",
                            questions: [
                              ResearchQuestionItem(
                                number: 1,
                                question:
                                    "What does existing research in $title establish, and what fundamental limit remains unaddressed?",
                                whyItMatters:
                                    "Identifies concrete gap to prevent redundant experimental effort.",
                                howToTestIt:
                                    "Synthesize 10 benchmark publications across high-impact venues.",
                              ),
                            ],
                            searchQueries: [
                              LiteratureSearchQuery(
                                title: "$title Key Survey",
                                query:
                                    '"$title" AND ("architecture" OR "methodology") AND "review"',
                              ),
                            ],
                            outlineSections: [
                              const OutlineSectionItem(
                                title: "Introduction",
                                bulletPoints: [
                                  "Motivation and problem definition.",
                                  "Primary technical contributions.",
                                ],
                              ),
                            ],
                            workPlanSteps: _getDefaultWorkPlanSteps(title),
                          );

                          setState(() {
                            _projects.insert(0, newProj);
                            _selectedProjectId = newProj.id;
                            _loadProjectNotes();
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Research project \"${newProj.title}\" initialized!",
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: const Color(0xFF3730A3),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3730A3),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add_rounded, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "Create project",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
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
          ),
        ),
      ),
    );
  }

  void _openDeleteProjectDialog(ResearchProjectItem project) {
    if (_projects.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Cannot delete the only research project.",
            style: GoogleFonts.poppins(),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: Color(0xFFDC2626), size: 22),
                ),
                const SizedBox(height: 16),
                Text(
                  "Delete Research Project",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Are you sure you want to delete "${project.title}"? All generated literature plans, questions, and notes will be removed.',
                  style: GoogleFonts.poppins(
                      fontSize: 12.5, color: const Color(0xFF475569), height: 1.5),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text("Cancel",
                          style: GoogleFonts.poppins(color: const Color(0xFF475569))),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projects.removeWhere((p) => p.id == project.id);
                          _selectedProjectId = _projects.first.id;
                          _loadProjectNotes();
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
                      ),
                      child: Text("Delete",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // MAIN BUILD
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        children: [
          // 1. Hero Blueprint Banner
          _buildHeroBanner(),
          const SizedBox(height: 18),

          // 2. Main Two-Column Workspace (Left Sidebar + Right Tools)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 900;
              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProjectsSidebar(),
                    const SizedBox(height: 18),
                    _buildRightWorkspace(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Your projects (width 320)
                  SizedBox(
                    width: 320,
                    child: _buildProjectsSidebar(),
                  ),
                  const SizedBox(width: 18),

                  // Right Column: Active Project Details & Tool Tabs
                  Expanded(
                    child: _buildRightWorkspace(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // Matches Image 1
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
            // Watermark beaker / flask on right
            Positioned(
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.science_rounded,
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
                          "Research Assistant",
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
                        "Phase 2",
                        const Color(0xFFD97706),
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
                          Icons.science_rounded,
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
                              "Research Assistant",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Research questions, literature discovery and comparison, planning and academic writing.",
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
  // 2. LEFT SIDEBAR: "Your projects"
  // Matches Image 1 Left Column
  // ===========================================================================
  Widget _buildProjectsSidebar() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Your projects + 4 saved + "+ New" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your projects",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    "${_projects.length} saved",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _openNewProjectDialog,
                icon: const Icon(Icons.add_rounded, size: 15),
                label: Text(
                  "New",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Project Cards List
          ..._projects.map((project) {
            final isSelected = project.id == _selectedProjectId;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => _selectProject(project.id),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF8FAFC)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1E2865)
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.5 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFF1E2865)
                                  .withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.department,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),

                      // Bottom row: Stage pill + "4 of 4 tools used"
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: const Color(0xFFBFDBFE)),
                            ),
                            child: Text(
                              project.stage,
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${project.toolsUsedCount} of ${project.totalToolsCount} tools used",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. RIGHT WORKSPACE: ACTIVE PROJECT & TOOLS
  // ===========================================================================
  Widget _buildRightWorkspace() {
    final project = _currentProject;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Top Project Card
        _buildProjectHeaderCard(project),
        const SizedBox(height: 16),

        // 2. Navigation Tabs (Research questions, Literature search, etc.)
        _buildToolTabsBar(),
        const SizedBox(height: 16),

        // 3. Tab Content
        if (_selectedTabIndex == 0)
          _buildResearchQuestionsTab(project)
        else if (_selectedTabIndex == 1)
          _buildLiteratureSearchTab(project)
        else if (_selectedTabIndex == 2)
          _buildPaperOutlineTab(project)
        else if (_selectedTabIndex == 3)
          _buildWorkPlanTab(project)
        else
          _buildAskAssistantTab(project),

        const SizedBox(height: 20),

        // 4. Bottom Scratch Notes Card (Present across all tabs)
        _buildNotesScratchCard(project),
      ],
    );
  }

  // ===========================================================================
  // TOP PROJECT HEADER CARD (Image 1 top right)
  // ===========================================================================
  Widget _buildProjectHeaderCard(ResearchProjectItem project) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Department + Edit & Delete Actions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                    ),
                    const SizedBox(height: 3),
                    Text(
                      project.department,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      _showEditProjectModal(project);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: const Size(40, 32),
                    ),
                    child: Text(
                      "Edit",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _openDeleteProjectDialog(project),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: Color(0xFFDC2626),
                    ),
                    splashRadius: 18,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 32),
                    tooltip: "Delete project",
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Target Grant / Journal line
          Text(
            project.targetGrantOrJournal,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 14),

          // Stage dropdown & helper text
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Stage",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 34,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: project.stage,
                        icon: const Icon(Icons.arrow_drop_down_rounded,
                            color: Color(0xFF64748B), size: 20),
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                        items: [
                          "Idea",
                          "Literature review",
                          "Method",
                          "Drafting",
                          "Completed",
                        ]
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setState(() {
                              project.stage = v;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Project stage updated to $v!",
                                  style: GoogleFonts.poppins(),
                                ),
                                backgroundColor: const Color(0xFF1E2865),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Updating it makes the work plan skip what you have already done.",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditProjectModal(ResearchProjectItem project) {
    final titleCtrl = TextEditingController(text: project.title);
    final targetCtrl =
        TextEditingController(text: project.targetGrantOrJournal);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Project Details",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title",
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: titleCtrl,
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 14),
            Text("Target Journal / Grant",
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: targetCtrl,
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel",
                style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                project.title = titleCtrl.text.trim();
                project.targetGrantOrJournal = targetCtrl.text.trim();
              });
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
            ),
            child: Text("Save Changes",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TOOL NAVIGATION TABS BAR
  // Matches Image 1 tabs row
  // ===========================================================================
  Widget _buildToolTabsBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 18),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1E2865)
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  _tabs[index],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF0F172A)
                        : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // TAB 1: RESEARCH QUESTIONS
  // Matches Image 1 & 2
  // ===========================================================================
  Widget _buildResearchQuestionsTab(ResearchProjectItem project) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Research questions + "✨ Write again" button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Research questions",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Questions that could be answered by a feasible study, each with why it matters and how to test it.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _triggerAIWriteAgain("Research questions"),
                icon: const Icon(Icons.auto_awesome_rounded, size: 14),
                label: Text(
                  "Write again",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Angle to focus on (optional)
          Text(
            "Angle to focus on (optional)",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _angleFocusController,
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: InputDecoration(
                hintText:
                    "e.g. low-cost hardware, rural deployment, comparison with deep learning",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Template & generation timestamp metadata (Responsive Wrap)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Template",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
              Text(
                "Written Oct 9, 3:57 PM",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "·",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                "Built from your project's details.",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "With AI on, it is tailored further.",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Question Cards (5 detailed questions)
          ...project.questions.map((q) => _buildQuestionCard(q)),
          const SizedBox(height: 14),

          // "📋 Copy all questions" action
          InkWell(
            onTap: _copyQuestions,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.copy_rounded,
                      size: 15, color: Color(0xFF475569)),
                  const SizedBox(width: 6),
                  Text(
                    "Copy all questions",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(ResearchQuestionItem q) {
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
          Text(
            "${q.number}. ${q.question}",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Why it matters: ",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                TextSpan(
                  text: q.whyItMatters,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "How to test it: ",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                TextSpan(
                  text: q.howToTestIt,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: LITERATURE SEARCH
  // Matches Image 3 & 4
  // ===========================================================================
  Widget _buildLiteratureSearchTab(ResearchProjectItem project) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + "✨ Write again"
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Literature search plan",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Search strings to run in the real databases, where to look, and how to decide what to keep. It does not list papers: it cannot read them.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _triggerAIWriteAgain("Literature search plan"),
                icon: const Icon(Icons.auto_awesome_rounded, size: 14),
                label: Text(
                  "Write again",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Narrow the search (optional)
          Text(
            "Narrow the search (optional)",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _narrowSearchController,
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: InputDecoration(
                hintText: "e.g. LoRaWAN, transformer models, post-2020",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // AI-generated badge line (Responsive Wrap to prevent overflow)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 4,
            children: [
              const Icon(Icons.auto_awesome_rounded,
                  size: 13, color: Color(0xFFD97706)),
              Text(
                "AI-generated — verify important details",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "·",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                "Written Oct 9, 4:05 PM",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Blue Info Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.info_outline_rounded,
                      size: 16, color: Color(0xFF2563EB)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "This is a search plan, not a reading list. The assistant cannot see papers, so it has not cited any. Open the searches below, read the real abstracts and keep only what you can trace to a publisher.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF1E40AF),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Search String Cards
          ...project.searchQueries
              .map((item) => _buildSearchStringCard(item)),
          const SizedBox(height: 20),

          // 3 Guide Cards (Where to look, What to keep, Reading tips)
          _buildLiteratureGuideCards(),
        ],
      ),
    );
  }

  Widget _buildSearchStringCard(LiteratureSearchQuery item) {
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
          Text(
            item.title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),

          // Query box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              item.query,
              style: GoogleFonts.firaCode(
                fontSize: 12,
                color: const Color(0xFF334155),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Action Pills: Google Scholar, Semantic Scholar, IEEE Xplore, arXiv, Copy search
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSearchActionPill(
                    "Google Scholar ↗", () => _openAcademicSearch("Google Scholar", item.query)),
                const SizedBox(width: 8),
                _buildSearchActionPill(
                    "Semantic Scholar ↗", () => _openAcademicSearch("Semantic Scholar", item.query)),
                const SizedBox(width: 8),
                _buildSearchActionPill(
                    "IEEE Xplore ↗", () => _openAcademicSearch("IEEE Xplore", item.query)),
                const SizedBox(width: 8),
                _buildSearchActionPill(
                    "arXiv ↗", () => _openAcademicSearch("arXiv", item.query)),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _copySearchQuery(item.query),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.copy_rounded,
                            size: 12, color: Color(0xFF475569)),
                        const SizedBox(width: 5),
                        Text(
                          "Copy search",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchActionPill(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFCBD5E1)),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E2865),
          ),
        ),
      ),
    );
  }

  // 3 Guide Cards (Where to look, What to keep, Reading tips)
  Widget _buildLiteratureGuideCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 750;

        final card1 = _buildSingleGuideCard(
          "Where to look",
          [
            "IEEE Internet of Things Journal",
            "IEEE Transactions on Mobile Computing",
            "IEEE Sensors Journal",
            "ACM Transactions on Embedded Computing Systems",
            "International conferences on IoT, wireless sensor networks, or edge computing",
            "Journals specializing in environmental monitoring or remote sensing technologies",
          ],
        );

        final card2 = _buildSingleGuideCard(
          "What to keep",
          [
            "Papers proposing early wildfire detection systems leveraging AI/ML, particularly deep learning or novel neural network architectures.",
            "Research focusing on edge computing or on-device AI for resource-constrained IoT nodes.",
            "Studies addressing power efficiency, energy harvesting, or solar integration for remote IoT deployments.",
            "Articles presenting system architectures, prototypes, or experimental results for real-time environmental monitoring applications.",
          ],
        );

        final card3 = _buildSingleGuideCard(
          "Reading tips",
          [
            "Prioritize reading the abstract, introduction, and conclusion first to quickly determine the paper's core contribution and relevance to your project's specific components (solar, edge-AI, wildfire detection).",
            "Pay close attention to the \"Future Work\" sections in relevant papers to identify open research problems and potential areas for your novel contributions.",
            "Create a summary table for each highly relevant paper, noting its key methodology, proposed architecture, performance metrics, and any limitations or assumptions.",
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              card1,
              const SizedBox(height: 12),
              card2,
              const SizedBox(height: 12),
              card3,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: card1),
            const SizedBox(width: 12),
            Expanded(child: card2),
            const SizedBox(width: 12),
            Expanded(child: card3),
          ],
        );
      },
    );
  }

  Widget _buildSingleGuideCard(String title, List<String> bulletPoints) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          ...bulletPoints.map((pt) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF64748B))),
                    Expanded(
                      child: Text(
                        pt,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          height: 1.45,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 3: PAPER OUTLINE
  // Matches Image 5
  // ===========================================================================
  Widget _buildPaperOutlineTab(ResearchProjectItem project) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + "✨ Write again"
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Paper outline",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "A section-by-section outline for a paper on this project, with what to write in each part.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _triggerAIWriteAgain("Paper outline"),
                icon: const Icon(Icons.auto_awesome_rounded, size: 14),
                label: Text(
                  "Write again",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 4,
            children: [
              const Icon(Icons.auto_awesome_rounded,
                  size: 13, color: Color(0xFFD97706)),
              Text(
                "AI-generated — verify important details",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "·",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                "Written Oct 9, 4:23 PM",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Section Breakdown Cards
          ...project.outlineSections.map((sec) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sec.title,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...sec.bulletPoints.map((pt) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF64748B))),
                              Expanded(
                                child: Text(
                                  pt,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    height: 1.45,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 4: WORK PLAN
  // Matches Image 1 & 2
  // ===========================================================================
  Widget _buildWorkPlanTab(ResearchProjectItem project) {
    final completedSteps =
        project.workPlanSteps.where((s) => s.isCompleted).length;
    final totalSteps = project.workPlanSteps.length;
    final completedWeeks = project.workPlanSteps
        .where((s) => s.isCompleted)
        .fold(0, (sum, s) => sum + s.weeks);
    final totalWeeks =
        project.workPlanSteps.fold(0, (sum, s) => sum + s.weeks);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Work plan + "✨ Write again"
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Work plan",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "The steps from where you are now to submission, with weeks and tasks. Tick steps off as you finish them.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _triggerAIWriteAgain("Work plan"),
                icon: const Icon(Icons.auto_awesome_rounded, size: 14),
                label: Text(
                  "Write again",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // AI generated subtitle line (Responsive Wrap to prevent overflow)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 4,
            children: [
              const Icon(Icons.auto_awesome_rounded,
                  size: 13, color: Color(0xFFD97706)),
              Text(
                "AI-generated — verify important details",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "·",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                "Written Oct 9, 4:24 PM",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Counters row: "0 of 6 steps done" on left, "0 of 64 weeks" on right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$completedSteps of $totalSteps steps done",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              Text(
                "$completedWeeks of $totalWeeks weeks",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // The 6 Step Cards
          ...project.workPlanSteps.map((step) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: step.isCompleted
                      ? const Color(0xFFBBF7D0)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: step.isCompleted,
                          activeColor: const Color(0xFF1E2865),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (val) {
                            setState(() {
                              step.isCompleted = val ?? false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  step.isCompleted
                                      ? "Marked \"${step.title}\" as completed!"
                                      : "Marked \"${step.title}\" as in progress.",
                                  style: GoogleFonts.poppins(),
                                ),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Text(
                              step.title,
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: step.isCompleted
                                    ? const Color(0xFF64748B)
                                    : const Color(0xFF0F172A),
                                decoration: step.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${step.weeks} wk",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: step.bulletPoints.map((pt) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF64748B))),
                              Expanded(
                                child: Text(
                                  pt,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    height: 1.45,
                                    color: step.isCompleted
                                        ? const Color(0xFF94A3B8)
                                        : const Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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

  // ===========================================================================
  // TAB 5: ASK THE ASSISTANT (AI RESEARCH COPILOT)
  // Matches Image 3
  // ===========================================================================
  Widget _buildAskAssistantTab(ResearchProjectItem project) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Context Pill Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Icon(Icons.layers_outlined,
                    size: 14, color: Color(0xFF64748B)),
                const SizedBox(width: 5),
                Text(
                  "CONTEXT",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: const Color(0xFF475569),
                  ),
                ),
                const SizedBox(width: 8),
                _buildContextPill("Project: ${project.title}"),
                const SizedBox(width: 6),
                _buildContextPill(
                    "Field: ${project.department.split('·')[0].trim()}"),
                const SizedBox(width: 6),
                _buildContextPill("Level: ${project.level}"),
                const SizedBox(width: 6),
                _buildContextPill("Stage: ${project.stage}"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Assistant Welcome Bubble with Avatar
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E2865),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: Color(0xFFFBBF24),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Research Assistant",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        "I'm working with you on ${project.title} (${project.department.split('·')[0].trim()}, ${project.level}, ${project.stage.toLowerCase()} stage). I can sharpen research questions, plan your literature search, compare approaches and help structure your writing. I can't look up or cite papers, so check every source yourself.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          height: 1.5,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 3. 4 Quick-Action Prompt Cards (2x2 Grid)
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 620;

              final card1 = _buildPromptActionCard(
                Icons.lightbulb_outline_rounded,
                'Suggest research questions for "${project.title}"',
                () => _sendAssistantPromptWithText(
                    'Suggest research questions for "${project.title}"'),
              );

              final card2 = _buildPromptActionCard(
                Icons.menu_book_outlined,
                'How should I search the literature for this?',
                () => _sendAssistantPromptWithText(
                    'How should I search the literature for this?'),
              );

              final card3 = _buildPromptActionCard(
                Icons.trending_up_rounded,
                'Outline a conference paper for this project',
                () => _sendAssistantPromptWithText(
                    'Outline a conference paper for this project'),
              );

              final card4 = _buildPromptActionCard(
                Icons.work_outline_rounded,
                'What should I do next at the idea stage?',
                () => _sendAssistantPromptWithText(
                    'What should I do next at the idea stage?'),
              );

              if (isNarrow) {
                return Column(
                  children: [
                    card1,
                    const SizedBox(height: 10),
                    card2,
                    const SizedBox(height: 10),
                    card3,
                    const SizedBox(height: 10),
                    card4,
                  ],
                );
              }

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: card1),
                      const SizedBox(width: 12),
                      Expanded(child: card2),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: card3),
                      const SizedBox(width: 12),
                      Expanded(child: card4),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // 4. Conversation History (if messages exist beyond welcome)
          if (_assistantChatMessages.length > 1) ...[
            ..._assistantChatMessages.skip(1).map((msg) {
              final isUser = msg["sender"] == "user";
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  constraints: const BoxConstraints(maxWidth: 560),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isUser
                          ? const Color(0xFF1E2865)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    msg["text"] ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      height: 1.45,
                      color: isUser ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
          ],

          // 5. Message Input Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _askAssistantController,
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (val) => _sendAssistantPrompt(),
                    style: GoogleFonts.poppins(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: "Message Research Assistant...",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                InkWell(
                  onTap: _sendAssistantPrompt,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC7D2FE),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      size: 16,
                      color: Color(0xFF3730A3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Explanatory footnote and character counter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Enter to send · Shift+Enter for a new line · Don't share passwords or personal IDs",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${_askAssistantController.text.length}/2000",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContextPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _buildPromptActionCard(
      IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: const Color(0xFF475569)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendAssistantPromptWithText(String prompt) {
    setState(() {
      _assistantChatMessages.add({"sender": "user", "text": prompt});
      _assistantChatMessages.add({
        "sender": "ai",
        "text":
            "Analyzing '$prompt' for ${_currentProject.title}...\n\nHere is a structured guideline tailored to your current ${_currentProject.stage} stage:\n1. Begin by drafting 2 focused experimental objectives addressing power vs. edge latency.\n2. Ensure LoRa telemetry transmission packets remain under 51 bytes for regulatory compliance.\n3. Verify your literature synthesis contains at least 3 benchmark comparison baselines from IEEE Transactions.\n\nWould you like me to generate a tailored LaTeX section template or expand on any of these points?",
      });
    });
  }

  void _sendAssistantPrompt() {
    final text = _askAssistantController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _assistantChatMessages.add({"sender": "user", "text": text});
      _askAssistantController.clear();
      _assistantChatMessages.add({
        "sender": "ai",
        "text":
            "Analyzing '$text' in context of ${_currentProject.title}...\n\nRecommendation: When addressing this, ensure you cite recent work in ${_currentProject.targetGrantOrJournal}. Would you like me to generate formatted BibTeX citations or a tailored section draft?",
      });
    });
  }

  // ===========================================================================
  // BOTTOM SCRATCH NOTES CARD
  // Matches Image 2 & 4 Notes card
  // ===========================================================================
  Widget _buildNotesScratchCard(ResearchProjectItem project) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notes",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Your own scratch space for this project",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: TextField(
              controller: _notesController,
              maxLines: 4,
              maxLength: 4000,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF1E293B),
              ),
              decoration: InputDecoration(
                hintText: "Type any notes, references, or reminders...",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF94A3B8),
                ),
                contentPadding: const EdgeInsets.all(14),
                border: InputBorder.none,
                counterText: "", // We build custom bottom row counter
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Bottom row: "4 / 4000" counter + "Save notes" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${_notesController.text.length} / 4000",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              ElevatedButton(
                onPressed: _saveNotes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  foregroundColor: const Color(0xFF475569),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                child: Text(
                  "Save notes",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
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
