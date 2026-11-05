import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// FACULTY: QUESTION PAPER GENERATOR SCREEN
// Exactly matches Screenshot 4:
// - Blueprint grid hero banner with watermark & badges (FACULTY, MVP)
// - Two-column split layout:
//     * Left Card (Inputs / Exam Agent): Course, Units, Total marks, Pattern, Generate question paper button
//     * Right Card (Output): Blueprint graph paper container with "Nothing generated yet" empty state
//       and interactive generated draft state
// =============================================================================

class QuestionPaperGeneratorScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const QuestionPaperGeneratorScreen({super.key, this.onBack});

  @override
  State<QuestionPaperGeneratorScreen> createState() =>
      _QuestionPaperGeneratorScreenState();
}

class _QuestionPaperGeneratorScreenState
    extends State<QuestionPaperGeneratorScreen> {
  final TextEditingController _courseController = TextEditingController(
      text: "CS3492 Database Management Systems");
  final TextEditingController _marksController =
      TextEditingController(text: "50");

  String _selectedUnits = "Units 1-2";
  final List<String> _unitOptions = [
    "Units 1-2",
    "Units 1-3",
    "Units 3-4",
    "Units 1-5 (Full Syllabus)",
  ];

  String _selectedPattern = "Part A (2 marks) + Part B (13 marks)";
  final List<String> _patternOptions = [
    "Part A (2 marks) + Part B (13 marks)",
    "Part A (2 marks) + Part B (16 marks)",
    "Comprehensive (Part A + B + Part C 15m Case Study)",
  ];

  bool _isGenerating = false;
  Map<String, dynamic>? _generatedPaper;

  void _generatePaper() {
    setState(() => _isGenerating = true);
    Future.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _generatedPaper = {
          "course": _courseController.text,
          "marks": _marksController.text,
          "units": _selectedUnits,
          "pattern": _selectedPattern,
          "partA": [
            {
              "q": "Define Candidate Key and Super Key with a suitable relation schema example.",
              "co": "CO1",
              "bt": "K2 (Understand)",
              "marks": "2",
            },
            {
              "q": "State Boyce-Codd Normal Form (BCNF) condition. How does it differ from 3NF?",
              "co": "CO2",
              "bt": "K2 (Understand)",
              "marks": "2",
            },
            {
              "q": "What are Insertion and Deletion anomalies in unnormalized tables?",
              "co": "CO1",
              "bt": "K1 (Remember)",
              "marks": "2",
            },
            {
              "q": "Explain the concept of Entity Integrity constraint and Referential Integrity.",
              "co": "CO1",
              "bt": "K2 (Understand)",
              "marks": "2",
            },
            {
              "q": "Compute the closure of attribute set {A, B} given functional dependencies F = {A->C, C->D}.",
              "co": "CO2",
              "bt": "K3 (Apply)",
              "marks": "2",
            },
          ],
          "partB": [
            {
              "q": "Consider relation R(A, B, C, D, E) with FDs: {A->BC, CD->E, B->D, E->A}. (i) Find all candidate keys. (ii) Determine the highest normal form of R. (iii) Decompose into 3NF if necessary.",
              "co": "CO2",
              "bt": "K4 (Analyze)",
              "marks": "13",
            },
            {
              "q": "Design an ER Diagram for a Multi-Specialty Hospital Management System including Doctors, Patients, Wards, and Appointments. Convert the ER diagram into relational schemas showing all constraints.",
              "co": "CO1",
              "bt": "K3 (Apply)",
              "marks": "13",
            },
            {
              "q": "Explain relational algebra operators (Select, Project, Cartesian Product, Natural Join and Division) with schema illustrations and corresponding SQL queries.",
              "co": "CO1",
              "bt": "K3 (Apply)",
              "marks": "14",
            },
          ],
        };
      });
    });
  }

  @override
  void dispose() {
    _courseController.dispose();
    _marksController.dispose();
    super.dispose();
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
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 920;
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 350, child: _buildInputsCard()),
                        const SizedBox(width: 20),
                        Expanded(child: _buildOutputCard()),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildInputsCard(),
                        const SizedBox(height: 20),
                        _buildOutputCard(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 4)
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
            // Watermark star/sparkle on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.auto_awesome_rounded,
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
                          'Question Paper Generator',
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
                          Icons.auto_awesome_rounded,
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
                              'Question Paper Generator',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Generate blueprint-aligned question papers mapped to course outcomes.',
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
  // LEFT COLUMN: INPUTS CARD (Screenshot 4)
  // ===========================================================================
  Widget _buildInputsCard() {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Inputs',
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Exam Agent',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Course input
          Text(
            'Course',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _courseController,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF1E293B),
              ),
              decoration: InputDecoration(
                hintText: 'e.g. CS3492 Database Management Systems',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Units dropdown
          Text(
            'Units',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedUnits,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF64748B),
                  size: 20,
                ),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
                items: _unitOptions
                    .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedUnits = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Total marks input
          Text(
            'Total marks',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _marksController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF1E293B),
              ),
              decoration: InputDecoration(
                hintText: 'e.g. 50',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Pattern dropdown
          Text(
            'Pattern',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedPattern,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF64748B),
                  size: 20,
                ),
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
                items: _patternOptions
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p, overflow: TextOverflow.ellipsis),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedPattern = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Generate Action Button
          SizedBox(
            height: 44,
            child: ElevatedButton.icon(
              onPressed: _isGenerating ? null : _generatePaper,
              icon: _isGenerating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.auto_awesome_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
              label: Text(
                _isGenerating ? 'Synthesizing paper...' : 'Generate question paper',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF38439E),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // RIGHT COLUMN: OUTPUT CARD (Screenshot 4)
  // ===========================================================================
  Widget _buildOutputCard() {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Output',
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              if (_generatedPaper != null)
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: _showExportPaperDialog,
                      icon: const Icon(Icons.file_download_outlined, size: 14),
                      label: Text(
                        'Download PDF',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF38439E),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: "Reset Output",
                      onPressed: () => setState(() => _generatedPaper = null),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),

          if (_generatedPaper == null)
            // Blueprint graph paper empty state (exact match to screenshot 4)
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  style: BorderStyle.solid,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _LightGraphPaperPainter(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Nothing generated yet',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Fill in the inputs and generate. Output is a draft for you to review and edit.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            // Formatted Question Paper Draft
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'ANNA INSTITUTE OF TECHNOLOGY',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          'INTERNAL ASSESSMENT TEST · ${_generatedPaper!['marks']} MARKS',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                        Text(
                          _generatedPaper!['course'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF38439E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFCBD5E1)),
                  const SizedBox(height: 8),

                  // Part A
                  Text(
                    'PART A — (5 x 2 = 10 Marks) · Answer ALL questions',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...(_generatedPaper!['partA'] as List<Map<String, String>>)
                      .asMap()
                      .entries
                      .map((entry) {
                    final i = entry.key + 1;
                    final q = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$i. ',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 12)),
                          Expanded(
                            child: Text(
                              q['q']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xFF334155)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '[${q['co']} · ${q['bt']}]',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFCBD5E1)),
                  const SizedBox(height: 8),

                  // Part B
                  Text(
                    'PART B — (3 x 13/14 = 40 Marks) · Answer ALL questions',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...(_generatedPaper!['partB'] as List<Map<String, String>>)
                      .asMap()
                      .entries
                      .map((entry) {
                    final i = entry.key + 6;
                    final q = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$i. ',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 12)),
                          Expanded(
                            child: Text(
                              q['q']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                  height: 1.4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '[${q['co']} · ${q['marks']}m]',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showExportPaperDialog() {
    if (_generatedPaper == null) return;
    bool includeKey = true;
    bool includeCoBtMatrix = true;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.print_rounded, color: Color(0xFF38439E), size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Export OBE Question Paper',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Ready for COE Exam Cell & Printing',
                                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx),
                            icon: const Icon(Icons.close, size: 20, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _generatedPaper!['course'],
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF38439E)),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Total Marks: ${_generatedPaper!['marks']} · Pattern: ${_generatedPaper!['pattern']}',
                              style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text('Include Bloom\'s Taxonomy & CO Mapping Matrix', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500)),
                        value: includeCoBtMatrix,
                        activeColor: const Color(0xFF38439E),
                        onChanged: (val) => setModalState(() => includeCoBtMatrix = val ?? true),
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text('Generate Answer Scheme & Marking Key', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500)),
                        value: includeKey,
                        activeColor: const Color(0xFF38439E),
                        onChanged: (val) => setModalState(() => includeKey = val ?? true),
                      ),
                      const SizedBox(height: 18),

                      Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 12.5)),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Exported Anna University OBE Question Paper (${_generatedPaper!['marks']}M) with answer scheme PDF!',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: const Color(0xFF10B981),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.file_download_outlined, size: 16),
                            label: Text('Download Document PDF', style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38439E),
                              foregroundColor: Colors.white,
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

// Light graph paper painter for empty state container
class _LightGraphPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.45)
      ..strokeWidth = 1.0;

    const double step = 20.0;

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
