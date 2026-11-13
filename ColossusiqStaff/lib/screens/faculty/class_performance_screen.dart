import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// FACULTY: CLASS PERFORMANCE SCREEN
// Exactly matches Screenshots 3, 4, & 5:
// - Blueprint grid hero banner with watermark & badges (FACULTY, MVP)
// - Class Diagnostics Control Strip (Class selector, assessment filter, Export CSV, + Schedule Remedial)
// - 6 Stat Metric Cards (Class Average, At-Risk, Topic Mastery, Avg Attendance, Distinction, Active Remedials)
// - Tab Bar (Overview & Visualizations, Topic-Wise Mastery (5), Student Diagnostics, etc.)
// - Tab 1: AI Diagnostic Summary + 4 Visual Analytics Charts (Topic Mastery vs Benchmark, Trend, Distribution Curve, Cohort Health)
// - Tab 2: Topic-Wise Mastery Unit Cards with Misconceptions, Remedial Strategies & Action buttons
// =============================================================================

class ClassPerformanceScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ClassPerformanceScreen({super.key, this.onBack});

  @override
  State<ClassPerformanceScreen> createState() => _ClassPerformanceScreenState();
}

class _ClassPerformanceScreenState extends State<ClassPerformanceScreen> {
  int _selectedTab = 0;
  String _selectedClass = '[CS3492] DBMS · CSE-A · Sem 5 (64 students)';
  String _selectedAssessment = 'All Term Assessments';
  String _studentFilter = 'All (64)';
  String _studentSearchQuery = '';
  final Set<int> _completedRemedials = {};
  final Set<int> _adoptedRecommendations = {};

  final List<String> _classes = [
    '[CS3492] DBMS · CSE-A · Sem 5 (64 students)',
    '[CS3492] DBMS · CSE-B · Sem 5 (62 students)',
    '[CS3492L] DBMS Lab · AI&DS · Sem 5 (58 students)',
  ];

  final List<String> _assessments = [
    'All Term Assessments',
    'Unit Test 1 (Units 1 & 2)',
    'Mid-Term Assessment',
    'Quiz 1 & 2 Average',
  ];

  late List<Map<String, dynamic>> _remedials;

  @override
  void initState() {
    super.initState();
    _remedials = [
      {
        'id': 1,
        'status': 'Scheduled',
        'statusColor': const Color(0xFF2563EB),
        'statusBg': const Color(0xFFEFF6FF),
        'title':
            'Unit 3: Normalization & Functional Dependencies · Remedial Lecture',
        'date': '2026-10-16',
        'time': '16:00 - 17:00',
        'venue': 'Seminar Hall 2 / LH-204',
        'target': '8 students',
        'notes':
            'Focus on 3NF vs BCNF loss-less decomposition algorithms and canonical cover calculations.',
        'enrolled': 'Aakash R, Abishek K, Kiruthika N, Mithun S',
        'hasStartNow': true,
      },
      {
        'id': 2,
        'status': 'In Progress',
        'statusColor': const Color(0xFFD97706),
        'statusBg': const Color(0xFFFEF3C7),
        'title':
            'Unit 5: NoSQL & Distributed Consistency · Targeted Practice Worksheet',
        'date': '2026-10-18',
        'time': 'Online Canvas',
        'venue': 'LMS Portal Worksheet',
        'target': '12 students',
        'notes':
            'Assigned CAP theorem tradeoffs quiz and MongoDB replication architecture problems.',
        'enrolled': 'Lokesh Kumar, Mohamed Farooq, Praveen Raj, Rohit Verma',
        'hasStartNow': false,
      },
    ];
  }

  // ===========================================================================
  // MODAL 1: AI REMEDIAL STUDY GUIDE & WORKSHEET (Unit 1) (Screenshots 1 & 2)
  // Matches screenshots: Overview, Core Concepts, Misconceptions, Worked Example, Formative Questions, Faculty Tips
  // ===========================================================================
  void _showStudyGuideAndWorksheetDialog(BuildContext context, {String? unitTitle}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Row: Sparkles Icon, Title, Copy Button, Close Button
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome_rounded, size: 20, color: Color(0xFF2E2A72)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'AI Remedial Study Guide & Worksheet (Unit 1)',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Clipboard.setData(const ClipboardData(
                            text: "AI Remedial Study Guide & Worksheet (Unit 1)\n\n"
                                "AI Ethics, Bias, and Governance Fundamentals & Principles\n"
                                "This remedial reinforcement module addresses core conceptual pitfalls in AI Ethics, Bias, and Governance Fundamentals & Principles...",
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Remedial Study Guide & Worksheet copied to clipboard!',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: const Color(0xFF0F766E),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy_rounded, size: 14, color: Color(0xFF475569)),
                        label: Text(
                          'Copy',
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: Color(0xFFF1F5F9)),

                  // Unit Title & Subtitle Description
                  Text(
                    'AI Ethics, Bias, and Governance Fundamentals & Principles',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This remedial reinforcement module addresses core conceptual pitfalls in AI Ethics, Bias, and Governance Fundamentals & Principles. Tailored specifically for learners struggling with abstract decomposition and procedural formulations, it emphasizes algorithmic clarity and visual verification techniques.',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      height: 1.5,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Section 1: Core Concepts & Visual Heuristics
                  Text(
                    'Core Concepts & Visual Heuristics',
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildStudyBeigeCard(
                    title: 'Foundational Invariants & Properties',
                    body: 'Ensure students memorize the non-negotiable axioms underlying AI Ethics, Bias, and Governance Fundamentals & Principles. When analyzing problems, always verify the minimal cover before jumping into decomposition.',
                    analogy: 'Analogy: Like inspecting load-bearing pillars of a building before renovating internal partition walls.',
                  ),
                  const SizedBox(height: 10),
                  _buildStudyBeigeCard(
                    title: 'Step-by-Step Validation Heuristic',
                    body: 'Break the resolution into 3 micro-steps: (1) Identify LHS closure, (2) Test dependency preservation, (3) Confirm lossless join property using the Chase algorithm tableau.',
                    analogy: 'Analogy: A flight pre-flight checklist: skipping one sub-check leads to data anomalies in production.',
                  ),
                  const SizedBox(height: 10),
                  _buildStudyBeigeCard(
                    title: 'Boundary & Edge Case Testing',
                    body: 'Always test with relations where primary keys are composite or where transitive functional dependencies masquerade as direct keys.',
                    analogy: 'Analogy: Stress-testing a bridge with maximum simulated traffic rather than average conditions.',
                  ),
                  const SizedBox(height: 20),

                  // Section 2: Common Misconceptions & Corrections
                  Text(
                    'Common Misconceptions & Corrections',
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFB91C1C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildMisconceptionCard(
                    pitfall: 'Pitfall: Assuming 3NF implies BCNF or that every decomposition retains all dependencies.',
                    correction: 'Correction: BCNF is strictly stronger than 3NF. Dependency preservation is guaranteed in 3NF synthesis but may require extra relations in BCNF.',
                  ),
                  const SizedBox(height: 10),
                  _buildMisconceptionCard(
                    pitfall: 'Pitfall: Calculating attribute closure without recursively checking implied transitive derivations.',
                    correction: 'Correction: Attribute closure X+ must be iteratively expanded until no new attributes can be appended.',
                  ),
                  const SizedBox(height: 20),

                  // Section 3: Worked Diagnostic Example
                  Text(
                    'Worked Diagnostic Example',
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF8F1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFF1E6D0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Given relation R(A, B, C, D) with FDs { A → B, B → C, C → D }. Decompose into BCNF and evaluate whether dependency preservation holds.',
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '1. Step 1: Compute candidate key for R: A+ = {A, B, C, D}. Hence A is the only candidate key.\n'
                          '2. Step 2: Check FDs: B → C and C → D violate BCNF since B and C are not superkeys.\n'
                          '3. Step 3: Decompose R using B → C: R1(B, C), R2(A, B, D).\n'
                          '4. Step 4: Decompose R2 using C → D: FD C → D is lost without synthesis check.\n'
                          '5. Step 5: Conclude: BCNF achieved, but check if original FD set can be recovered without joining.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            height: 1.6,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE9FE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Key Takeaway: When decomposing for BCNF, always verify if a 3NF lossless synthesis would be preferable for write-heavy transaction workloads.',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4338CA),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Section 4: Formative Practice Questions
                  Text(
                    'Formative Practice Questions',
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildQuestionCard(
                    qNum: 'Question 1',
                    badge: 'Easy',
                    badgeBg: const Color(0xFFDCFCE7),
                    badgeText: const Color(0xFF15803D),
                    question: 'State the formal definition of 3NF in terms of superkeys and prime attributes.',
                    hint: 'Consider the condition for each FD X -> Y: either X is a superkey, or Y is prime.',
                    answer: 'A relation R is in 3NF if for every non-trivial FD X -> Y, either X is a superkey of R or every attribute in Y is a prime attribute (part of some candidate key).',
                  ),
                  const SizedBox(height: 12),
                  _buildQuestionCard(
                    qNum: 'Question 2',
                    badge: 'Medium',
                    badgeBg: const Color(0xFFFEF3C7),
                    badgeText: const Color(0xFFD97706),
                    question: 'Find the minimal canonical cover for F = { A -> BC, B -> C, A -> B, AB -> C }.',
                    hint: 'Decompose RHS, eliminate redundant FDs, and check extraneous LHS attributes.',
                    answer: 'Minimal cover: { A -> B, B -> C }. AB -> C is redundant, and A -> BC is decomposed into A -> B and A -> C (where A -> C is transitive via B).',
                  ),
                  const SizedBox(height: 12),
                  _buildQuestionCard(
                    qNum: 'Question 3',
                    badge: 'Challenging',
                    badgeBg: const Color(0xFFFEE2E2),
                    badgeText: const Color(0xFFDC2626),
                    question: 'Why does the Chase algorithm prove a decomposition is lossless? Explain using a tableau matrix.',
                    hint: 'Look for a row consisting entirely of unsubscripted symbols (a1, a2, ... an).',
                    answer: 'The Chase algorithm iteratively replaces subscripted symbols with unsubscripted symbols according to given FDs. If any row becomes all unsubscripted symbols, the join of the decomposed relations is mathematically guaranteed to recover the original relation without spurious tuples.',
                  ),
                  const SizedBox(height: 20),

                  // Section 5: Pedagogical Tips for Faculty
                  Container(
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
                          'Pedagogical Tips for Faculty',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Dedicate the first 15 minutes of the remedial session entirely to live student-driven problem solving on the whiteboard rather than lecturing slides.\n'
                          '• Pair each student scoring <50% with a student who scored 80%+ on Assessment 1 as a peer study buddy for this worksheet.\n'
                          '• Administer the 3-question formative quiz at the end of the session to immediately verify comprehension before students leave.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            height: 1.6,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bottom Action Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E2A72),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: Text(
                          'Done',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
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

  Widget _buildStudyBeigeCard({required String title, required String body, required String analogy}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFDE68A)),
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
          const SizedBox(height: 4),
          Text(
            body,
            style: GoogleFonts.poppins(
              fontSize: 12,
              height: 1.5,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            analogy,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF0F766E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMisconceptionCard({required String pitfall, required String correction}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pitfall,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFB91C1C),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            correction,
            style: GoogleFonts.poppins(
              fontSize: 12,
              height: 1.45,
              color: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard({
    required String qNum,
    required String badge,
    required Color badgeBg,
    required Color badgeText,
    required String question,
    required String hint,
    required String answer,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                qNum,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: badgeText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            question,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            hint,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFBBF7D0)),
            ),
            child: RichText(
              text: TextSpan(
                text: 'Correct Answer: ',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF15803D),
                ),
                children: [
                  TextSpan(
                    text: answer,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF166534),
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

  // ===========================================================================
  // MODAL 2: SCHEDULE REMEDIAL INTERVENTION (Screenshots 3 & 4)
  // Matches screenshots: Course, Topic, Strategy dropdown, Date, Time Slot, Venue, Cohort, Notes
  // ===========================================================================
  void _showScheduleRemedialDialog(
    BuildContext context, {
    String? studentName,
    String? topic,
    String? strategy,
  }) {
    final topicCtrl = TextEditingController(
      text: topic ??
          (studentName != null
              ? 'Remedial Mentoring: None identified'
              : 'Unit 1: AI Ethics, Bias, and Governance Fundamentals & Principles'),
    );
    String selectedStrategy = strategy ??
        (studentName != null ? '1-on-1 Mentoring' : 'Remedial Lecture');
    DateTime selectedDate = DateTime(2026, 11, 14);
    final timeCtrl = TextEditingController(text: '16:00 - 17:00');
    final venueCtrl = TextEditingController(text: 'LH-204 / Seminar Hall');
    final cohortCtrl = TextEditingController(text: studentName ?? '');
    final notesCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 18, color: Color(0xFF2E2A72)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Schedule Remedial Intervention',
                              style: GoogleFonts.poppins(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx),
                            icon: const Icon(Icons.close_rounded,
                                size: 18, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Target Course & Section (Readonly)
                      _buildDialogFieldLabel('Target Course & Section'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          'AID102 · AI&DS-A · Term 1',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Remedial Topic / Concept *
                      _buildDialogFieldLabel('Remedial Topic / Concept *'),
                      TextField(
                        controller: topicCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _dialogInputDec(),
                      ),
                      const SizedBox(height: 14),

                      // Pedagogical Strategy * & Session Date *
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDialogFieldLabel('Pedagogical Strategy *'),
                                Container(
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color(0xFFCBD5E1)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedStrategy,
                                      isExpanded: true,
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF64748B)),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.5, color: const Color(0xFF1E293B)),
                                      items: [
                                        'Remedial Lecture',
                                        '1-on-1 Mentoring',
                                        'Peer Study Group',
                                        'Practical Lab Session',
                                        'Problem Solving Clinic',
                                      ].map((s) => DropdownMenuItem(value: s, child: Text(s, overflow: TextOverflow.ellipsis))).toList(),
                                      onChanged: (val) {
                                        if (val != null) setModalState(() => selectedStrategy = val);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDialogFieldLabel('Session Date *'),
                                InkWell(
                                  onTap: () async {
                                    final d = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime(2026, 1, 1),
                                      lastDate: DateTime(2027, 12, 31),
                                    );
                                    if (d != null) setModalState(() => selectedDate = d);
                                  },
                                  child: Container(
                                    height: 44,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFCBD5E1)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                                        ),
                                        const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Time Slot * & Venue / Platform *
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDialogFieldLabel('Time Slot *'),
                                TextField(
                                  controller: timeCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _dialogInputDec(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDialogFieldLabel('Venue / Platform *'),
                                TextField(
                                  controller: venueCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _dialogInputDec(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Target Student Cohort
                      _buildDialogFieldLabel(studentName != null
                          ? 'Target Student Cohort (1 students)'
                          : 'Target Student Cohort (All At-Risk students)'),
                      TextField(
                        controller: cohortCtrl,
                        maxLines: 2,
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: _dialogInputDec(
                          hint: 'Comma-separated student names or leave blank to assign all at-risk students',
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Faculty Pedagogical Notes
                      _buildDialogFieldLabel('Faculty Pedagogical Notes'),
                      TextField(
                        controller: notesCtrl,
                        maxLines: 2,
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: _dialogInputDec(
                          hint: 'Focus areas, practice problems, or prerequisite topics to review...',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Footer Actions: Cancel & Confirm Schedule
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              final topicText = topicCtrl.text.trim();
                              if (topicText.isEmpty) return;

                              setState(() {
                                _remedials.insert(0, {
                                  'id': DateTime.now().millisecondsSinceEpoch,
                                  'status': 'Scheduled',
                                  'statusColor': const Color(0xFF2563EB),
                                  'statusBg': const Color(0xFFEFF6FF),
                                  'title': '$topicText · $selectedStrategy',
                                  'date': '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
                                  'time': timeCtrl.text.trim(),
                                  'venue': venueCtrl.text.trim(),
                                  'target': cohortCtrl.text.trim().isNotEmpty
                                      ? cohortCtrl.text.trim()
                                      : 'All At-Risk students',
                                  'notes': notesCtrl.text.trim().isNotEmpty
                                      ? notesCtrl.text.trim()
                                      : 'Targeted pedagogical remedial session.',
                                  'enrolled': cohortCtrl.text.trim().isNotEmpty
                                      ? cohortCtrl.text.trim()
                                      : 'At-risk student cohort',
                                  'hasStartNow': true,
                                });
                              });

                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Remedial Intervention scheduled successfully!',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: const Color(0xFF1E2865),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
                            label: Text(
                              'Confirm Schedule',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E2A72),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

  // ===========================================================================
  // MODAL 3: STUDENT DIAGNOSTIC PROFILE (Screenshot 5)
  // Matches screenshot: Name, Roll, Normal/At-risk badge, 2 stat cards, weak areas, status, assign button
  // ===========================================================================
  void _showStudentDiagnosticProfileDialog(BuildContext context, Map<String, dynamic> student) {
    showDialog(
      context: context,
      builder: (ctx) {
        final isRisk = (student['risk'] as String? ?? '').toLowerCase().contains('risk');
        final scoreStr = (student['score'] as String? ?? '68%').replaceAll('%', '');
        final attStr = (student['attendance'] as String? ?? '92%').replaceAll('%', '');
        final scoreVal = ((double.tryParse(scoreStr) ?? 68) / 100).clamp(0.0, 1.0);
        final attVal = ((double.tryParse(attStr) ?? 92) / 100).clamp(0.0, 1.0);

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    children: [
                      const Icon(Icons.school_outlined, size: 18, color: Color(0xFF2E2A72)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Student Diagnostic Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded, size: 18, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Student Beige Card (matching Image 5)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              student['name'] as String? ?? 'Anand Kumar',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: isRisk ? const Color(0xFFFEE2E2) : const Color(0xFFE6FFFA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                student['risk'] as String? ?? 'Normal',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isRisk ? const Color(0xFFDC2626) : const Color(0xFF0D9488),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Roll No: ${student['roll'] ?? '110124001'}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          student['section'] as String? ?? 'CSE-A',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Two Metric Cards (Academic Score Average & Attendance Ratio)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Academic Score Average',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                student['score'] as String? ?? '68%',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: scoreVal,
                                  minHeight: 5,
                                  backgroundColor: const Color(0xFFF1F5F9),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attendance Ratio',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                student['attendance'] as String? ?? '92%',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: attVal,
                                  minHeight: 5,
                                  backgroundColor: const Color(0xFFF1F5F9),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Identified Weak Areas & Struggle Topics
                  Text(
                    'Identified Weak Areas & Struggle Topics:',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      student['weakTopics'] as String? ?? 'None identified',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Remedial Action Status
                  Text(
                    'Remedial Action Status:',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      text: 'Current state: ',
                      style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569)),
                      children: [
                        TextSpan(
                          text: student['remedial'] as String? ?? 'Resolved',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Actions: Close & + Assign Remedial Intervention
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(
                          'Close',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _showScheduleRemedialDialog(
                            context,
                            studentName: student['name'] as String?,
                            topic: 'Remedial Mentoring: ${student['weakTopics']}',
                            strategy: '1-on-1 Mentoring',
                          );
                        },
                        icon: const Icon(Icons.add, size: 15),
                        label: Text(
                          'Assign Remedial Intervention',
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E2A72),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

  Widget _buildDialogFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  InputDecoration _dialogInputDec({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2E2A72), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      isDense: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 18),
              _buildControlStrip(),
              const SizedBox(height: 18),
              _buildStatMetricCards(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 18),
              if (_selectedTab == 0)
                _buildOverviewTab()
              else if (_selectedTab == 1)
                _buildTopicWiseMasteryTab()
              else if (_selectedTab == 2)
                _buildStudentDiagnosticsTab()
              else if (_selectedTab == 3)
                _buildRemedialTrackerTab()
              else
                _buildAiRecommendationsTab(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 3)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF222B68),
            Color(0xFF38439E),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Watermark bar chart curve on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.insights_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Faculty',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Class Performance',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.insights_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E2548),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'FACULTY',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: const Color(0xFF93C5FD),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F766E),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'MVP',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Class Performance',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Topic-wise mastery, remedial recommendations and at-risk signals for your classes.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.85),
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

  // ===========================================================================
  // CONTROL STRIP (Screenshot 3)
  // ===========================================================================
  Widget _buildControlStrip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 900;

          final titleSection = Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  size: 18,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Class Performance Diagnostics',
                          style: GoogleFonts.poppins(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Live',
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2563EB),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Dr. Meena Raghavan · Associate Professor · Computer Science & Engineering',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          );

          final controlsSection = Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Class:',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155)),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth < 450
                      ? (constraints.maxWidth - 20).clamp(180.0, 320.0)
                      : 330,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedClass,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w500,
                      ),
                      items: _classes
                          .map((c) => DropdownMenuItem(
                                value: c,
                                child: Text(c, overflow: TextOverflow.ellipsis),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedClass = val);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAssessment,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF0F172A),
                      fontWeight: FontWeight.w500,
                    ),
                    items: _assessments
                        .map((a) => DropdownMenuItem(
                              value: a,
                              child: Text(a, overflow: TextOverflow.ellipsis),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedAssessment = val);
                      }
                    },
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Exported class diagnostic report as CSV',
                        style: GoogleFonts.poppins(),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.file_download_outlined, size: 14),
                label: Text(
                  'Export CSV',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showScheduleRemedialDialog(context),
                icon: const Icon(Icons.add, size: 14),
                label: Text(
                  'Schedule Remedial',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Refreshed class diagnostics.',
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                color: const Color(0xFF64748B),
                tooltip: "Refresh Diagnostics",
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleSection,
                const SizedBox(height: 12),
                controlsSection,
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: titleSection),
                const SizedBox(width: 14),
                controlsSection,
              ],
            );
          }
        },
      ),
    );
  }

  // ===========================================================================
  // 6 STAT METRIC CARDS (Screenshot 3)
  // ===========================================================================
  Widget _buildStatMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1050
            ? 6
            : (constraints.maxWidth >= 650
                ? 3
                : (constraints.maxWidth >= 420 ? 2 : 1));
        final ratio = constraints.maxWidth >= 1050
            ? 2.1
            : (constraints.maxWidth >= 650
                ? 1.9
                : (constraints.maxWidth >= 420 ? 1.45 : 2.5));
        return GridView.count(
          crossAxisCount: count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: ratio,
          children: [
            _buildMetricTile(
              title: 'Class Average',
              value: '68%',
              subtext: '↗ +3.2% vs baseline',
              subtextColor: const Color(0xFF10B981),
              icon: Icons.trending_up_rounded,
              iconColor: const Color(0xFF10B981),
              iconBg: const Color(0xFFDCFCE7),
            ),
            _buildMetricTile(
              title: 'At-Risk Students',
              value: '23',
              subtext: 'Score < 50% or Att. < 75%',
              subtextColor: const Color(0xFF64748B),
              icon: Icons.warning_amber_rounded,
              iconColor: const Color(0xFFDC2626),
              iconBg: const Color(0xFFFEE2E2),
            ),
            _buildMetricTile(
              title: 'Topic Mastery',
              value: '60%',
              subtext: 'Target: 75% benchmark',
              subtextColor: const Color(0xFF64748B),
              icon: Icons.radar_rounded,
              iconColor: const Color(0xFF38439E),
              iconBg: const Color(0xFFEFF6FF),
            ),
            _buildMetricTile(
              title: 'Avg Attendance',
              value: '88%',
              subtext: 'Room LH-204',
              subtextColor: const Color(0xFF64748B),
              icon: Icons.groups_outlined,
              iconColor: const Color(0xFF0284C7),
              iconBg: const Color(0xFFF0F9FF),
            ),
            _buildMetricTile(
              title: 'Distinction Tier',
              value: '4',
              subtext: 'Score >= 85% & Att. > 90%',
              subtextColor: const Color(0xFF64748B),
              icon: Icons.workspace_premium_outlined,
              iconColor: const Color(0xFFD97706),
              iconBg: const Color(0xFFFEF3C7),
            ),
            _buildMetricTile(
              title: 'Active Remedials',
              value: '${_remedials.length}',
              subtext: 'Underway & scheduled',
              subtextColor: const Color(0xFF64748B),
              icon: Icons.access_time_rounded,
              iconColor: const Color(0xFF0F766E),
              iconBg: const Color(0xFFCCFBF1),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required String subtext,
    required Color subtextColor,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 14, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          Text(
            subtext,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              color: subtextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB BAR (Screenshot 3 & 4)
  // ===========================================================================
  Widget _buildTabBar() {
    final tabs = [
      'Overview & Visualizations',
      'Topic-Wise Mastery (5)',
      'Student Diagnostics (64)',
      'Remedial Tracker (${_remedials.length})',
      'AI Recommendations (4)',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isSelected = _selectedTab == i;
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => setState(() => _selectedTab = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                child: Row(
                  children: [
                    if (i == 0)
                      const Icon(Icons.bar_chart_rounded, size: 16)
                    else if (i == 1)
                      const Icon(Icons.menu_book_rounded, size: 16)
                    else if (i == 2)
                      const Icon(Icons.people_outline_rounded, size: 16)
                    else if (i == 3)
                      const Icon(Icons.calendar_today_outlined, size: 16)
                    else
                      const Icon(Icons.auto_awesome_rounded, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      tabs[i],
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFF64748B),
                      ),
                    ),
                    if (i == 2) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '23 at-risk',
                          style: GoogleFonts.poppins(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFDC2626),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // TAB 0: OVERVIEW & VISUALIZATIONS (Screenshot 4)
  // ===========================================================================
  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // AI Diagnostic Summary Strip (Screenshot 4)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 680;
              final iconAndContent = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      size: 18,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Diagnostic Summary for CSE-A · Sem 5 (CS3492)',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF475569),
                              height: 1.45,
                            ),
                            children: const [
                              TextSpan(
                                  text:
                                      'Class demonstrates strong conceptual foundation in '),
                              TextSpan(
                                text:
                                    'ER Model & Relational Algebra (78% mastery)',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F766E),
                                ),
                              ),
                              TextSpan(
                                  text:
                                      '. However, a significant gap of '),
                              TextSpan(
                                text: '29% below benchmark',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFDC2626),
                                ),
                              ),
                              TextSpan(
                                  text:
                                      ' is observed in Normalization & Functional Dependencies. Immediate remedial intervention is recommended before the final exam.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final recBtn = OutlinedButton(
                onPressed: () => setState(() => _selectedTab = 4),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1E2865),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View AI Recommendations',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right_rounded, size: 16),
                  ],
                ),
              );

              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: iconAndContent),
                    const SizedBox(width: 14),
                    recBtn,
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    iconAndContent,
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: recBtn,
                    ),
                  ],
                );
              }
            },
          ),
        ),
        const SizedBox(height: 18),

        // 4 Visual Charts Grid (2x2 Grid)
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;
            if (isDesktop) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildTopicMasteryChartCard()),
                      const SizedBox(width: 18),
                      Expanded(child: _buildTrendLineChartCard()),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildScoreDistributionCurveCard()),
                      const SizedBox(width: 18),
                      Expanded(child: _buildCohortHealthCard()),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildTopicMasteryChartCard(),
                  const SizedBox(height: 18),
                  _buildTrendLineChartCard(),
                  const SizedBox(height: 18),
                  _buildScoreDistributionCurveCard(),
                  const SizedBox(height: 18),
                  _buildCohortHealthCard(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  // Chart 1: Topic Mastery vs Benchmark (75%)
  Widget _buildTopicMasteryChartCard() {
    final units = [
      {'name': 'Unit 1', 'mastery': 78, 'target': 75},
      {'name': 'Unit 2', 'mastery': 82, 'target': 75},
      {'name': 'Unit 3', 'mastery': 46, 'target': 75},
      {'name': 'Unit 4', 'mastery': 58, 'target': 75},
      {'name': 'Unit 5', 'mastery': 36, 'target': 75},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      height: 310,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class Topic Mastery vs Benchmark (75%)',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: units.map((u) {
                final masteryH = (u['mastery'] as int) * 1.8;
                final targetH = (u['target'] as int) * 1.8;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 18,
                          height: masteryH,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2865),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 18,
                          height: targetH,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD97706),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      u['name'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E2865),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text('Mastery',
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: const Color(0xFF64748B))),
              const SizedBox(width: 16),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text('Target',
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: const Color(0xFF64748B))),
            ],
          ),
        ],
      ),
    );
  }

  // Chart 2: Assessment Performance Trend
  Widget _buildTrendLineChartCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 310,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assessment Performance Trend',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: CustomPaint(
              size: Size.infinite,
              painter: _PerformanceTrendLinePainter(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Unit Test 1 (U1 & U2)',
                  style: GoogleFonts.poppins(
                      fontSize: 10.5, color: const Color(0xFF64748B))),
              Text('Quiz 1',
                  style: GoogleFonts.poppins(
                      fontSize: 10.5, color: const Color(0xFF64748B))),
              Text('Unit Test 2 (U3 & U4)',
                  style: GoogleFonts.poppins(
                      fontSize: 10.5, color: const Color(0xFF64748B))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E2865),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text('Average',
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: const Color(0xFF64748B))),
              const SizedBox(width: 16),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text('PassRate',
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: const Color(0xFF64748B))),
            ],
          ),
        ],
      ),
    );
  }

  // Chart 3: Class Score Distribution Curve
  Widget _buildScoreDistributionCurveCard() {
    final dist = [
      {'range': '< 50%', 'count': 0, 'height': 2.0},
      {'range': '50% - 64%', 'count': 21, 'height': 150.0},
      {'range': '65% - 79%', 'count': 19, 'height': 135.0},
      {'range': '80% - 100%', 'count': 24, 'height': 175.0},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      height: 310,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class Score Distribution Curve',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: dist.map((d) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 38,
                      height: d['height'] as double,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2865),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      d['range'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Chart 4: Score Distribution & Cohort Health
  Widget _buildCohortHealthCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 310,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Score Distribution & Cohort Health',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Breakdown of 64 enrolled students across mastery thresholds:',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          _buildHealthRow('At-Risk / Needs Remedial (< 50%)', '0 students (0%)',
              0.0, const Color(0xFFDC2626)),
          const SizedBox(height: 8),
          _buildHealthRow(
              'Borderline / Needs Practice (50% - 64%)',
              '21 students (33%)',
              0.33,
              const Color(0xFFD97706)),
          const SizedBox(height: 8),
          _buildHealthRow('Proficient / Satisfactory (65% - 79%)',
              '19 students (30%)', 0.30, const Color(0xFF2563EB)),
          const SizedBox(height: 8),
          _buildHealthRow('High Mastery / Distinction (80% - 100%)',
              '24 students (38%)', 0.38, const Color(0xFF10B981)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF92400E),
                  height: 1.35,
                ),
                children: const [
                  TextSpan(
                    text: 'Pedagogical Recommendation: ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                      text:
                          'Pair the 4 distinction students with the 23 at-risk learners for peer problem-solving sessions.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthRow(
      String label, String count, double progress, Color barColor) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: barColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF334155),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF475569),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 1: TOPIC-WISE MASTERY (5) (Screenshot 5)
  // ===========================================================================
  Widget _buildTopicWiseMasteryTab() {
    final unitData = [
      {
        'title': 'UNIT 1 · ER Model & Relational Algebra',
        'status': 'Mastered',
        'statusColor': const Color(0xFF10B981),
        'statusBg': const Color(0xFFDCFCE7),
        'tested': 'Tested across 20 questions · Avg errors per student: 0.9',
        'percent': '78%',
        'percentVal': 0.78,
        'barColor': const Color(0xFF10B981),
        'misconceptions': [
          'Cardinality mapping constraints in complex relationship sets (M:N vs 1:N)',
          'Distinction between weak entity identifying relationships and standard foreign keys',
        ],
        'strategy':
            'Hands-on ER diagram schema mapping exercises with peer code-review.',
      },
      {
        'title': 'UNIT 2 · SQL Queries & Joins',
        'status': 'Mastered',
        'statusColor': const Color(0xFF10B981),
        'statusBg': const Color(0xFFDCFCE7),
        'tested': 'Tested across 25 questions · Avg errors per student: 0.9',
        'percent': '82%',
        'percentVal': 0.82,
        'barColor': const Color(0xFF10B981),
        'misconceptions': [
          'Correlated subqueries vs JOIN optimization execution paths',
          'GROUP BY aggregation constraints when filtering non-aggregated columns',
        ],
        'strategy':
            'Live SQL playground query execution plan walkthrough with visual syntax breakdown.',
      },
      {
        'title': 'UNIT 3 · Normalization & Functional Dependencies',
        'status': 'Critical Need',
        'statusColor': const Color(0xFFDC2626),
        'statusBg': const Color(0xFFFEE2E2),
        'tested': 'Tested across 30 questions · Avg errors per student: 4.8',
        'percent': '46%',
        'percentVal': 0.46,
        'barColor': const Color(0xFFDC2626),
        'misconceptions': [
          'Identifying minimal canonical cover for complex functional dependency sets',
          'Lossless-join vs dependency-preservation verification during BCNF decomposition',
        ],
        'strategy':
            'Interactive decomposition matrix workshop with step-by-step algorithmic flowchart.',
      },
      {
        'title': 'UNIT 4 · Transaction Processing & ACID',
        'status': 'Needs Reinforcement',
        'statusColor': const Color(0xFFD97706),
        'statusBg': const Color(0xFFFEF3C7),
        'tested': 'Tested across 35 questions · Avg errors per student: 2.6',
        'percent': '58%',
        'percentVal': 0.58,
        'barColor': const Color(0xFFD97706),
        'misconceptions': [
          'Serializability schedule graphs and cycle detection logic',
          'Two-phase locking protocol (2PL) vs timestamp ordering concurrency',
        ],
        'strategy':
            'Chalkboard live conflict serializability drill and deadlock graph simulation.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Syllabus Unit Mastery & Bottleneck Identification',
          style: GoogleFonts.poppins(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Evaluated from continuous assessments, quizzes, and homework problem sets.',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),
        ...unitData.map((u) => _buildUnitCard(u)),
      ],
    );
  }

  Widget _buildUnitCard(Map<String, dynamic> u) {
    final misconceptions = u['misconceptions'] as List<String>;

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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header Row
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 850;

              final titleSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isDesktop
                              ? (constraints.maxWidth - 280).clamp(180.0, double.infinity)
                              : constraints.maxWidth,
                        ),
                        child: Text(
                          u['title'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                          softWrap: true,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: u['statusBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          u['status'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: u['statusColor'] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    u['tested'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );

              final actionSection = Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: isDesktop ? WrapAlignment.end : WrapAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: isDesktop
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        u['percent'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        'Benchmark: 75%',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _showStudyGuideAndWorksheetDialog(
                        context,
                        unitTitle: u['title'] as String?),
                    icon: const Icon(Icons.auto_awesome_rounded, size: 14),
                    label: Text(
                      'AI Remedial Plan',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showScheduleRemedialDialog(
                        context,
                        topic: u['title'] as String?,
                        strategy: 'Remedial Lecture'),
                    icon: const Icon(Icons.add, size: 14),
                    label: Text(
                      'Schedule Class',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2865),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              );

              if (isDesktop) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: titleSection),
                    const SizedBox(width: 14),
                    actionSection,
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleSection,
                    const SizedBox(height: 12),
                    actionSection,
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 10),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: u['percentVal'] as double,
              minHeight: 5,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(u['barColor'] as Color),
            ),
          ),
          const SizedBox(height: 14),

          // Identified Misconceptions & Strategy (Screenshot 5)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF9F6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF1EFEA)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 650;
                final misconceptionsWidget = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Identified Misconceptions:',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...misconceptions.map((m) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '• $m',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF475569),
                            height: 1.35,
                          ),
                        ),
                      );
                    }),
                  ],
                );

                final strategyWidget = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended Remedial Strategy:',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      u['strategy'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF475569),
                        height: 1.35,
                      ),
                    ),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      misconceptionsWidget,
                      const SizedBox(height: 10),
                      strategyWidget,
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: misconceptionsWidget),
                      const SizedBox(width: 18),
                      Expanded(child: strategyWidget),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: STUDENT DIAGNOSTICS (64) (Screenshot 1)
  // ===========================================================================
  Widget _buildStudentDiagnosticsTab() {
    final students = [
      {
        'name': 'Anand Kumar',
        'email': 'anand.kumar@campus.edu',
        'roll': '110124001',
        'section': 'CSE-A',
        'score': '68%',
        'scoreColor': const Color(0xFF0F766E),
        'scoreBg': const Color(0xFFCCFBF1),
        'attendance': '92%',
        'attColor': const Color(0xFF2563EB),
        'attBg': const Color(0xFFEFF6FF),
        'risk': 'Normal',
        'riskColor': const Color(0xFF0F766E),
        'riskBg': const Color(0xFFCCFBF1),
        'weakTopics': 'None identified',
        'remedial': 'Resolved',
        'remedialColor': const Color(0xFF0F766E),
        'remedialBg': const Color(0xFFCCFBF1),
        'isAtRisk': false,
        'isLowMastery': false,
        'isLowAtt': false,
        'isDistinction': false,
      },
      {
        'name': 'Aaditya Raj',
        'email': 'aadityaraj.22cs001@campus.edu',
        'roll': '22CS001',
        'score': '50%',
        'scoreColor': const Color(0xFFD97706),
        'scoreBg': const Color(0xFFFEF3C7),
        'attendance': '98%',
        'attColor': const Color(0xFF10B981),
        'attBg': const Color(0xFFDCFCE7),
        'risk': 'Normal',
        'riskColor': const Color(0xFF2563EB),
        'riskBg': const Color(0xFFEFF6FF),
        'weakTopics': 'Unit 3, Unit 4',
        'remedial': 'Resolved',
        'remedialColor': const Color(0xFF0F766E),
        'remedialBg': const Color(0xFFCCFBF1),
        'isAtRisk': false,
        'isLowMastery': true,
        'isLowAtt': false,
        'isDistinction': false,
      },
      {
        'name': 'Abinaya S',
        'email': 'abinayas.22cs002@campus.edu',
        'roll': '22CS002',
        'score': '63%',
        'scoreColor': const Color(0xFFD97706),
        'scoreBg': const Color(0xFFFEF3C7),
        'attendance': '81%',
        'attColor': const Color(0xFF10B981),
        'attBg': const Color(0xFFDCFCE7),
        'risk': 'Normal',
        'riskColor': const Color(0xFF2563EB),
        'riskBg': const Color(0xFFEFF6FF),
        'weakTopics': 'Unit 4',
        'remedial': 'Resolved',
        'remedialColor': const Color(0xFF0F766E),
        'remedialBg': const Color(0xFFCCFBF1),
        'isAtRisk': false,
        'isLowMastery': false,
        'isLowAtt': false,
        'isDistinction': false,
      },
      {
        'name': 'Adarsh Nair',
        'email': 'adarshnair.22cs003@campus.edu',
        'roll': '22CS003',
        'score': '76%',
        'scoreColor': const Color(0xFF10B981),
        'scoreBg': const Color(0xFFDCFCE7),
        'attendance': '64%',
        'attColor': const Color(0xFFDC2626),
        'attBg': const Color(0xFFFEE2E2),
        'risk': 'Attendance Warning',
        'riskColor': const Color(0xFFD97706),
        'riskBg': const Color(0xFFFEF3C7),
        'weakTopics': 'None identified',
        'remedial': 'Action Needed',
        'remedialColor': const Color(0xFFDC2626),
        'remedialBg': const Color(0xFFFEE2E2),
        'isAtRisk': true,
        'isLowMastery': false,
        'isLowAtt': true,
        'isDistinction': false,
      },
      {
        'name': 'Aishwarya R',
        'email': 'aishwaryar.22cs004@campus.edu',
        'roll': '22CS004',
        'score': '89%',
        'scoreColor': const Color(0xFF10B981),
        'scoreBg': const Color(0xFFDCFCE7),
        'attendance': '83%',
        'attColor': const Color(0xFF10B981),
        'attBg': const Color(0xFFDCFCE7),
        'risk': 'Normal',
        'riskColor': const Color(0xFF2563EB),
        'riskBg': const Color(0xFFEFF6FF),
        'weakTopics': 'None identified',
        'remedial': 'Resolved',
        'remedialColor': const Color(0xFF0F766E),
        'remedialBg': const Color(0xFFCCFBF1),
        'isAtRisk': false,
        'isLowMastery': false,
        'isLowAtt': false,
        'isDistinction': true,
      },
      {
        'name': 'Akash V',
        'email': 'akashv.22cs005@campus.edu',
        'roll': '22CS005',
        'score': '54%',
        'scoreColor': const Color(0xFFD97706),
        'scoreBg': const Color(0xFFFEF3C7),
        'attendance': '66%',
        'attColor': const Color(0xFFDC2626),
        'attBg': const Color(0xFFFEE2E2),
        'risk': 'Attendance Warning',
        'riskColor': const Color(0xFFD97706),
        'riskBg': const Color(0xFFFEF3C7),
        'weakTopics': 'Unit 4',
        'remedial': 'Action Needed',
        'remedialColor': const Color(0xFFDC2626),
        'remedialBg': const Color(0xFFFEE2E2),
        'isAtRisk': true,
        'isLowMastery': false,
        'isLowAtt': true,
        'isDistinction': false,
      },
      {
        'name': 'Anandhakumar K',
        'email': 'anandhakumar.22cs006@campus.edu',
        'roll': '22CS006',
        'score': '67%',
        'scoreColor': const Color(0xFFD97706),
        'scoreBg': const Color(0xFFFEF3C7),
        'attendance': '85%',
        'attColor': const Color(0xFF10B981),
        'attBg': const Color(0xFFDCFCE7),
        'risk': 'Normal',
        'riskColor': const Color(0xFF2563EB),
        'riskBg': const Color(0xFFEFF6FF),
        'weakTopics': 'None identified',
        'remedial': 'Resolved',
        'remedialColor': const Color(0xFF0F766E),
        'remedialBg': const Color(0xFFCCFBF1),
        'isAtRisk': false,
        'isLowMastery': false,
        'isLowAtt': false,
        'isDistinction': false,
      },
      {
        'name': 'Ananya Iyer',
        'email': 'ananyaiyer.22cs007@campus.edu',
        'roll': '22CS007',
        'score': '80%',
        'scoreColor': const Color(0xFF10B981),
        'scoreBg': const Color(0xFFDCFCE7),
        'attendance': '68%',
        'attColor': const Color(0xFFDC2626),
        'attBg': const Color(0xFFFEE2E2),
        'risk': 'Attendance Warning',
        'riskColor': const Color(0xFFD97706),
        'riskBg': const Color(0xFFFEF3C7),
        'weakTopics': 'None identified',
        'remedial': 'Action Needed',
        'remedialColor': const Color(0xFFDC2626),
        'remedialBg': const Color(0xFFFEE2E2),
        'isAtRisk': true,
        'isLowMastery': false,
        'isLowAtt': true,
        'isDistinction': false,
      },
      {
        'name': 'Anitha M',
        'email': 'anitham.22cs008@campus.edu',
        'roll': '22CS008',
        'score': '93%',
        'scoreColor': const Color(0xFF10B981),
        'scoreBg': const Color(0xFFDCFCE7),
        'attendance': '87%',
        'attColor': const Color(0xFF10B981),
        'attBg': const Color(0xFFDCFCE7),
        'risk': 'Normal',
        'riskColor': const Color(0xFF2563EB),
        'riskBg': const Color(0xFFEFF6FF),
        'weakTopics': 'None identified',
        'remedial': 'Resolved',
        'remedialColor': const Color(0xFF0F766E),
        'remedialBg': const Color(0xFFCCFBF1),
        'isAtRisk': false,
        'isLowMastery': false,
        'isLowAtt': false,
        'isDistinction': true,
      },
      {
        'name': 'Arun Prasath',
        'email': 'arunprasath.22cs009@campus.edu',
        'roll': '22CS009',
        'score': '58%',
        'scoreColor': const Color(0xFFD97706),
        'scoreBg': const Color(0xFFFEF3C7),
        'attendance': '70%',
        'attColor': const Color(0xFFDC2626),
        'attBg': const Color(0xFFFEE2E2),
        'risk': 'Attendance Warning',
        'riskColor': const Color(0xFFD97706),
        'riskBg': const Color(0xFFFEF3C7),
        'weakTopics': 'Unit 5',
        'remedial': 'Action Needed',
        'remedialColor': const Color(0xFFDC2626),
        'remedialBg': const Color(0xFFFEE2E2),
        'isAtRisk': true,
        'isLowMastery': false,
        'isLowAtt': true,
        'isDistinction': false,
      },
      {
        'name': 'Balamurugan P',
        'email': 'balamuruganp.22cs010@campus.edu',
        'roll': '22CS010',
        'score': '71%',
        'scoreColor': const Color(0xFF10B981),
        'scoreBg': const Color(0xFFDCFCE7),
        'attendance': '89%',
        'attColor': const Color(0xFF10B981),
        'attBg': const Color(0xFFDCFCE7),
        'risk': 'Normal',
        'riskColor': const Color(0xFF2563EB),
        'riskBg': const Color(0xFFEFF6FF),
        'weakTopics': 'None identified',
        'remedial': 'Resolved',
        'remedialColor': const Color(0xFF0F766E),
        'remedialBg': const Color(0xFFCCFBF1),
        'isAtRisk': false,
        'isLowMastery': false,
        'isLowAtt': false,
        'isDistinction': false,
      },
    ];

    final filteredStudents = students.where((s) {
      final name = (s['name'] as String).toLowerCase();
      final roll = (s['roll'] as String).toLowerCase();
      final q = _studentSearchQuery.toLowerCase();
      if (q.isNotEmpty && !name.contains(q) && !roll.contains(q)) return false;

      if (_studentFilter == 'At-Risk (23)') return s['isAtRisk'] == true;
      if (_studentFilter == 'Low Mastery (<50%)') return s['isLowMastery'] == true;
      if (_studentFilter == 'Attendance (<75%)') return s['isLowAtt'] == true;
      if (_studentFilter == 'Distinction (4)') return s['isDistinction'] == true;
      return true;
    }).toList();

    final filterOptions = [
      'All (64)',
      'At-Risk (23)',
      'Low Mastery (<50%)',
      'Attendance (<75%)',
      'Distinction (4)',
    ];

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Search & Filter Bar (Screenshot 1)
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 800;

                final searchField = Container(
                  constraints: BoxConstraints(
                    maxWidth: isNarrow ? double.infinity : 420,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    onChanged: (val) => setState(() => _studentSearchQuery = val),
                    style: GoogleFonts.poppins(fontSize: 12.5),
                    decoration: InputDecoration(
                      hintText: 'Search student by name or roll number...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      prefixIcon: const Icon(Icons.search_rounded,
                          size: 18, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                );

                final filterPills = Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Filter:',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    ...filterOptions.map((f) {
                      final isSelected = _studentFilter == f;
                      return InkWell(
                        onTap: () => setState(() => _studentFilter = f),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF0F172A)
                                : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            f,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF475569),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      searchField,
                      const SizedBox(height: 12),
                      filterPills,
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: searchField),
                      const SizedBox(width: 16),
                      filterPills,
                    ],
                  );
                }
              },
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Data Table (Screenshot 1)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFFAF9F6)),
              dataRowMinHeight: 58,
              dataRowMaxHeight: 58,
              horizontalMargin: 20,
              columnSpacing: 26,
              columns: [
                DataColumn(
                  label: Text(
                    'Student Name',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Roll No',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Score Avg',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Attendance',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Risk Signal',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Weak Topic(s)',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Remedial Action',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
              rows: filteredStudents.map((s) {
                return DataRow(
                  cells: [
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            s['name'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            s['email'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Text(
                        s['roll'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: s['scoreBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: (s['scoreColor'] as Color).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          s['score'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: s['scoreColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: s['attBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: (s['attColor'] as Color).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          s['attendance'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: s['attColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: s['riskBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          s['risk'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: s['riskColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        s['weakTopics'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: s['remedialBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          s['remedial'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: s['remedialColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () =>
                                _showStudentDiagnosticProfileDialog(context, s),
                            child: Text(
                              'View Profile',
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          OutlinedButton(
                            onPressed: () => _showScheduleRemedialDialog(
                              context,
                              studentName: s['name'] as String?,
                              topic: 'Remedial Mentoring: ${s['weakTopics']}',
                              strategy: '1-on-1 Mentoring',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1E2865),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'Schedule 1-on-1',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 3: REMEDIAL TRACKER (2) (Screenshot 2)
  // ===========================================================================
  Widget _buildRemedialTrackerTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header Row (Screenshot 2)
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;

            final titleCol = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Remedial Action Plans & Interventions',
                  style: GoogleFonts.poppins(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Track scheduled booster sessions, 1-on-1 tutorials, and peer mentoring groups.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            );

            final addBtn = ElevatedButton.icon(
              onPressed: () => _showScheduleRemedialDialog(context),
              icon: const Icon(Icons.add, size: 14),
              label: Text(
                'Schedule New Remedial',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleCol,
                  const SizedBox(height: 10),
                  addBtn,
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: titleCol),
                  const SizedBox(width: 14),
                  addBtn,
                ],
              );
            }
          },
        ),
        const SizedBox(height: 16),

        // Remedial Cards (Screenshot 2)
        ..._remedials.map((r) {
          final id = r['id'] as int;
          final isCompleted = _completedRemedials.contains(id);

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isCompleted
                    ? const Color(0xFF86EFAC)
                    : const Color(0xFFE2E8F0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 850;

                final detailsCol = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? const Color(0xFFDCFCE7)
                                : r['statusBg'] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isCompleted ? 'Completed' : r['status'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: isCompleted
                                  ? const Color(0xFF10B981)
                                  : r['statusColor'] as Color,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isDesktop
                                ? (constraints.maxWidth - 280).clamp(180.0, double.infinity)
                                : constraints.maxWidth,
                          ),
                          child: Text(
                            r['title'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.calendar_today_outlined,
                                size: 13, color: Color(0xFF64748B)),
                            const SizedBox(width: 4),
                            Text(
                              r['date'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time_rounded,
                                size: 13, color: Color(0xFF64748B)),
                            const SizedBox(width: 4),
                            Text(
                              r['time'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Venue: ${r['venue']}',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          'Target: ${r['target']}',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Notes: ${r['notes']}',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Enrolled: ${r['enrolled']}',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final actionBtns = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          if (isCompleted) {
                            _completedRemedials.remove(id);
                          } else {
                            _completedRemedials.add(id);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isCompleted
                                  ? 'Remedial session marked pending'
                                  : 'Remedial session marked completed & logged to PostgreSQL!',
                              style: GoogleFonts.poppins(),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: Icon(
                        isCompleted
                            ? Icons.check_circle
                            : Icons.check_circle_outline_rounded,
                        size: 15,
                        color: const Color(0xFF0F766E),
                      ),
                      label: Text(
                        isCompleted ? 'Completed' : 'Mark Completed',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF86EFAC)),
                        backgroundColor: isCompleted
                            ? const Color(0xFFDCFCE7)
                            : Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    if (r['hasStartNow'] == true && !isCompleted) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Launching Smart Board Studio for ${r['title']}...',
                                  style: GoogleFonts.poppins()),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Text(
                          'Start Now',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E2865),
                          ),
                        ),
                      ),
                    ],
                  ],
                );

                if (isDesktop) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: detailsCol),
                      const SizedBox(width: 14),
                      actionBtns,
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      detailsCol,
                      const SizedBox(height: 12),
                      actionBtns,
                    ],
                  );
                }
              },
            ),
          );
        }),
      ],
    );
  }

  // ===========================================================================
  // TAB 4: AI RECOMMENDATIONS (4) (Screenshot 3)
  // ===========================================================================
  Widget _buildAiRecommendationsTab() {
    final recommendations = [
      {
        'id': 1,
        'title': 'Normalization & Functional Dependencies',
        'priority': 'High Priority',
        'priorityColor': const Color(0xFFDC2626),
        'priorityBg': const Color(0xFFFEE2E2),
        'target': '16 students with sub-60% mastery in Unit 3',
        'bottleneck':
            'Class mastery is at 46% (benchmark: 75%). Common pitfall: Identifying minimal canonical cover for complex functional dependency sets.',
        'action':
            'Organize a 45-minute interactive booster clinic focusing on Normalization & Functional Dependencies. Pair students with high-performing peers.',
        'jump': '+14% expected score jump',
      },
      {
        'id': 2,
        'title': 'Transaction Processing & ACID',
        'priority': 'Medium Priority',
        'priorityColor': const Color(0xFFD97706),
        'priorityBg': const Color(0xFFFEF3C7),
        'target': '19 students with sub-60% mastery in Unit 4',
        'bottleneck':
            'Class mastery is at 58% (benchmark: 75%). Common pitfall: Conflict serializability precedence graph cycle detection vs view serializability.',
        'action':
            'Organize a 45-minute interactive booster clinic focusing on Transaction Processing & ACID. Pair students with high-performing peers.',
        'jump': '+14% expected score jump',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Text(
          'AI Remedial Interventions & Pedagogical Strategies',
          style: GoogleFonts.poppins(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Actionable recommendations synthesized from student misconception patterns and test failures.',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        // 2-Card Layout (Screenshot 3)
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 840;

            final cardWidgets = recommendations.map((rec) {
              final id = rec['id'] as int;
              final isAdopted = _adoptedRecommendations.contains(id);

              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isAdopted
                        ? const Color(0xFF86EFAC)
                        : const Color(0xFFE2E8F0),
                  ),
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
                    // Top Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            size: 16,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            rec['title'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: rec['priorityBg'] as Color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            rec['priority'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: rec['priorityColor'] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Target Cohort
                    Text(
                      'Target Cohort: ${rec['target']}',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Observed Bottleneck
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF475569),
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Observed Bottleneck: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFDC2626),
                            ),
                          ),
                          TextSpan(text: rec['bottleneck'] as String),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Suggested Action Callout Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF9F6),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFF1EFEA)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suggested Pedagogical Action:',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            rec['action'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF475569),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Bottom Row: Expected Score Jump & Action Buttons
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          rec['jump'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F766E),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () =>
                                  _showStudyGuideAndWorksheetDialog(
                                context,
                                unitTitle: rec['title'] as String?,
                              ),
                              icon: const Icon(Icons.description_outlined,
                                  size: 14),
                              label: Text(
                                'Generate Worksheet',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF334155),
                                side: const BorderSide(
                                    color: Color(0xFFCBD5E1)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (isAdopted) {
                                    _adoptedRecommendations.remove(id);
                                  } else {
                                    _adoptedRecommendations.add(id);
                                  }
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isAdopted
                                          ? 'Action un-adopted'
                                          : 'Action adopted & added to Faculty Copilot Calendar!',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAdopted
                                    ? const Color(0xFF0F766E)
                                    : const Color(0xFF1E2865),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                isAdopted ? '✓ Adopted' : '+ Adopt Action',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList();

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cardWidgets[0]),
                  const SizedBox(width: 16),
                  Expanded(child: cardWidgets[1]),
                ],
              );
            } else {
              return Column(
                children: [
                  cardWidgets[0],
                  const SizedBox(height: 16),
                  cardWidgets[1],
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

// Background painter for blueprint grid in top banner
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const double step = 28.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Assessment Performance Trend Line Chart
class _PerformanceTrendLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    for (double i = 0.2; i <= 1.0; i += 0.2) {
      canvas.drawLine(
        Offset(0, size.height * i),
        Offset(size.width, size.height * i),
        gridPaint,
      );
    }

    // Average line (Navy)
    final avgPaint = Paint()
      ..color = const Color(0xFF1E2865)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final avgPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.65)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.45,
          size.width * 0.5, size.height * 0.48)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.60,
          size.width * 0.9, size.height * 0.52);

    canvas.drawPath(avgPath, avgPaint);

    // PassRate line (Gold)
    final passPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final passPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.42)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.22,
          size.width * 0.5, size.height * 0.28)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.35,
          size.width * 0.9, size.height * 0.25);

    canvas.drawPath(passPath, passPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
