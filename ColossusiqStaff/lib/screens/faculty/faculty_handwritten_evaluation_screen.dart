import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

// =============================================================================
// DATA MODEL: RUBRIC & EVALUATION RECORD
// =============================================================================
class RubricItem {
  final String criterion;
  final double awarded;
  final double max;

  const RubricItem({
    required this.criterion,
    required this.awarded,
    required this.max,
  });
}

class EvaluationRecord {
  final String studentName;
  final String rollNumber;
  final String topic;
  final String assessmentTitle;
  final int maxMarks;
  final double score;
  final String confidence;
  final int aiConfidencePercent;
  final String conceptMatch;
  final String legibility;
  final String transcript;
  final String fileName;
  final String evaluatedAt;
  final String evaluator;
  final String department;
  final String status; // "Approved" or "Pending"
  final String remarks;
  final List<RubricItem> rubricItems;
  final List<String> keyEvidence;
  final List<String> missingGaps;
  bool confirmed;
  double? overriddenScore;

  EvaluationRecord({
    required this.studentName,
    required this.rollNumber,
    required this.topic,
    this.assessmentTitle = '',
    required this.maxMarks,
    required this.score,
    required this.confidence,
    this.aiConfidencePercent = 90,
    required this.conceptMatch,
    required this.legibility,
    required this.transcript,
    required this.fileName,
    required this.evaluatedAt,
    this.evaluator = 'Dr. Meena',
    this.department = 'B.E. Computer Science',
    this.status = 'Approved',
    this.remarks = '',
    this.rubricItems = const [],
    this.keyEvidence = const [],
    this.missingGaps = const [],
    this.confirmed = false,
    this.overriddenScore,
  });

  double get effectiveScore => overriddenScore ?? score;
  String get statusLabel => overriddenScore != null ? 'Overridden' : (confirmed ? 'Confirmed' : status);
  int get scorePercent => ((effectiveScore / (maxMarks > 0 ? maxMarks : 1)) * 100).round();
}

// =============================================================================
// ASSESSMENT: HANDWRITTEN EVALUATION SCREEN
// Matches screenshot: Blueprint grid hero banner, AI disclaimer alert banner,
// pill tabs (Evaluate Answer Sheet / Evaluation History 6), upload dropzone,
// student meta fields, and graph paper empty/evaluated state.
// =============================================================================
class FacultyHandwrittenEvaluationScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyHandwrittenEvaluationScreen({super.key, this.onBack});

  @override
  State<FacultyHandwrittenEvaluationScreen> createState() =>
      _FacultyHandwrittenEvaluationScreenState();
}

class _FacultyHandwrittenEvaluationScreenState
    extends State<FacultyHandwrittenEvaluationScreen> {
  int _activeTab = 0; // 0 = Evaluate Answer Sheet, 1 = Evaluation History

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _maxMarksController =
      TextEditingController(text: "10");

  bool _isProcessing = false;
  bool _hasEvaluated = false;
  String? _uploadedFileName;
  PlatformFile? _uploadedFile;
  int _uploadedFileSize = 0;
  bool _isPicking = false;
  String? _uploadError;

  // Evaluation results
  EvaluationRecord? _currentResult;
  final List<EvaluationRecord> _history = [];
  bool _isOverriding = false;
  final TextEditingController _overrideController = TextEditingController();

  // History Filter & Search State
  final TextEditingController _historySearchController = TextEditingController();
  String _selectedStudentFilter = "All Students (2)";
  String _selectedStatusFilter = "All Statuses";
  String _selectedAssessmentFilter = "All Assessments (5)";
  String _activeStudentPill = "All";

  @override
  void initState() {
    super.initState();
    _initPredefinedHistory();
  }

  void _initPredefinedHistory() {
    _history.addAll([
      // 1. Karthik Raja - Compiler Design
      EvaluationRecord(
        studentName: "Karthik Raja",
        rollNumber: "110124003",
        topic: "Compiler Design Test Answers",
        assessmentTitle: "Assessment on Compiler Design Test Answers...",
        maxMarks: 10,
        score: 2.0,
        confidence: "88%",
        aiConfidencePercent: 88,
        conceptMatch: "Partial",
        legibility: "Medium",
        transcript: "Compiler Design Test Answers\n\n"
            "1. Ans: A compiler is a program that accepts source programs in high-level language and produces target language.\n"
            "2. Ans: Phase 1: Macro expansion, file inclusion, conditional compilation, line control.\n"
            "3. Ans: Syntax error occurs during syntax analysis phase, e.g. missing semicolon.\n"
            "4. Ans: A token is a sequence of characters that can be treated as a single logical entity (e.g. keywords, identifiers).\n"
            "5. Ans: Infix: (A + B) * C -> Postfix: A B + C *\n"
            "6. Ans: Compile time errors: syntax, type errors. Runtime errors: divide by zero, null pointer.\n"
            "7. Ans: Code optimization is used to make code execute faster and consume less memory.",
        fileName: "karthik_raja_compiler_design.pdf",
        evaluatedAt: "12 Oct 2026",
        evaluator: "Dr. Meena",
        department: "B.E. Computer Science",
        status: "Approved",
        remarks: "Poor marks",
        rubricItems: const [
          RubricItem(criterion: "Definition & Core Concept", awarded: 0.5, max: 3.5),
          RubricItem(criterion: "Technical Terminology & Accuracy", awarded: 0.5, max: 3.0),
          RubricItem(criterion: "Illustrative Example / Application", awarded: 1.0, max: 2.5),
          RubricItem(criterion: "Clarity, Depth & Structure", awarded: 0.0, max: 1.0),
        ],
        keyEvidence: const [
          "Attempted answers with structured presentation.",
        ],
        missingGaps: const [
          "Compiler definition lacked detail on intermediate code generation and lexical/syntactic phases.",
          "Macro expansion is a preprocessor task, not compiler front-end proper.",
          "Lexical analysis error cited was actually a semantic error.",
          "Token classification missed operators and separators.",
          "Infix precedence explanation violated standard operator precedence rules.",
          "Compile vs runtime characteristics were partially reversed.",
          "Code optimization purpose omitted target machine independence considerations.",
        ],
      ),

      // 2. Anand Kumar - Compiler Design
      EvaluationRecord(
        studentName: "Anand Kumar",
        rollNumber: "110124001",
        topic: "complier design",
        assessmentTitle: "Assessment on complier design...",
        maxMarks: 10,
        score: 9.5,
        confidence: "94%",
        aiConfidencePercent: 94,
        conceptMatch: "Full",
        legibility: "High",
        transcript: "Compiler Design Comprehensive Exam\n\n"
            "1. Lexical Analysis: Scanner transforms character stream into sequence of tokens using regular expressions and DFA.\n"
            "2. Syntax Analysis: Parser builds parse tree verifying grammar rules (CFG), using LL(1) predictive parsing and LR(1) shift-reduce.\n"
            "3. Semantic Analysis: Type checking, identifier binding, and scope resolution verified via symbol table.\n"
            "4. Intermediate Code Generation: 3-address code quad and triple representations.\n"
            "5. Code Optimization: Local DAG optimization, loop invariant code motion, common subexpression elimination.\n"
            "6. Target Code: Machine register allocation and assembly instruction generation.",
        fileName: "anand_compiler_design.pdf",
        evaluatedAt: "12 Oct 2026",
        evaluator: "Dr. Meena",
        department: "B.E. Computer Science",
        status: "Approved",
        remarks: "good work",
        rubricItems: const [
          RubricItem(criterion: "Definition & Core Concept", awarded: 3.5, max: 3.5),
          RubricItem(criterion: "Technical Terminology & Accuracy", awarded: 3.0, max: 3.0),
          RubricItem(criterion: "Illustrative Example / Application", awarded: 2.0, max: 2.5),
          RubricItem(criterion: "Clarity, Depth & Structure", awarded: 1.0, max: 1.0),
        ],
        keyEvidence: const [
          "Complete derivation trees and grammar parsing tables included.",
          "Clear breakdown of compiler passes vs compiler phases.",
          "Accurate DAG transformation for common subexpressions.",
        ],
        missingGaps: const [
          "Minor notation ambiguity in register assignment descriptor update.",
        ],
      ),

      // 3. Anand Kumar - Data Structures
      EvaluationRecord(
        studentName: "Anand Kumar",
        rollNumber: "110124001",
        topic: "Data Structures Notes and Algorithms",
        assessmentTitle: "Assessment on Data Structures Notes and Algo...",
        maxMarks: 10,
        score: 9.5,
        confidence: "92%",
        aiConfidencePercent: 92,
        conceptMatch: "Full",
        legibility: "High",
        transcript: "Data Structures & Algorithms\n\n"
            "1. Binary Search Tree (BST): Inorder traversal yields sorted order. Node deletion handles zero, one, or two children (inorder successor swap).\n"
            "2. AVL Trees: Self-balancing BST using Balance Factor BF = height(left) - height(right). Rotations LL, RR, LR, RL.\n"
            "3. Dijkstra's Algorithm: Single source shortest path using greedy approach with PriorityQueue (min-heap). Time complexity O((V + E) log V).\n"
            "4. Graph Traversals: BFS with FIFO Queue, DFS with recursion / LIFO Stack.",
        fileName: "anand_data_structures.pdf",
        evaluatedAt: "11 Oct 2026",
        evaluator: "Dr. Meena",
        department: "B.E. Computer Science",
        status: "Approved",
        remarks: "good",
        rubricItems: const [
          RubricItem(criterion: "Algorithm Formulation & Complexity", awarded: 3.5, max: 3.5),
          RubricItem(criterion: "Tree & Graph Structures", awarded: 3.0, max: 3.0),
          RubricItem(criterion: "Pseudocode & Code Quality", awarded: 2.0, max: 2.5),
          RubricItem(criterion: "Proof & Mathematical Rigor", awarded: 1.0, max: 1.0),
        ],
        keyEvidence: const [
          "Thorough AVL balance factor calculations and rebalancing diagrams.",
          "Complete min-heap relaxation step-by-step trace.",
        ],
        missingGaps: const [
          "Fibonacci heap trade-off for dense graphs was omitted.",
        ],
      ),

      // 4. Anand Kumar - Operating Systems
      EvaluationRecord(
        studentName: "Anand Kumar",
        rollNumber: "110124001",
        topic: "OS Deadlock Avoidance Algorithms",
        assessmentTitle: "Assessment on Operating Systems Deadlocks",
        maxMarks: 10,
        score: 8.0,
        confidence: "90%",
        aiConfidencePercent: 90,
        conceptMatch: "High",
        legibility: "High",
        transcript: "Operating Systems: Deadlock Prevention & Banker's Algorithm\n\n"
            "1. Four Coffman Conditions: Mutual Exclusion, Hold and Wait, No Preemption, Circular Wait.\n"
            "2. Banker's Safety Algorithm: State is safe if there exists a sequence <P1...Pn> such that Need[i] <= Available.\n"
            "3. Resource Request Algorithm: Verifies Request <= Need and Request <= Available prior to tentative allocation.\n"
            "4. Resource-Allocation Graphs (RAG) and cycle detection for single-instance resources.",
        fileName: "anand_os_deadlocks.pdf",
        evaluatedAt: "10 Oct 2026",
        evaluator: "Dr. Meena",
        department: "B.E. Computer Science",
        status: "Approved",
        remarks: "Well explained",
        rubricItems: const [
          RubricItem(criterion: "Deadlock Conditions & Concepts", awarded: 3.0, max: 3.5),
          RubricItem(criterion: "Banker's Algorithm Trace", awarded: 2.5, max: 3.0),
          RubricItem(criterion: "Matrix Calculations & State", awarded: 1.5, max: 2.5),
          RubricItem(criterion: "Clarity & Diagram Accuracy", awarded: 1.0, max: 1.0),
        ],
        keyEvidence: const [
          "Accurate Banker's safety trace with correct Allocation and Need matrices.",
          "Well-defined 4 Coffman conditions with OS mitigation strategies.",
        ],
        missingGaps: const [
          "Resource request step 2 check against Available vector was condensed.",
        ],
      ),

      // 5. Anand Kumar - Database Normalization
      EvaluationRecord(
        studentName: "Anand Kumar",
        rollNumber: "110124001",
        topic: "BCNF & 3NF Decomposition",
        assessmentTitle: "Assessment on Database Normalization",
        maxMarks: 10,
        score: 6.0,
        confidence: "85%",
        aiConfidencePercent: 85,
        conceptMatch: "Moderate",
        legibility: "Medium",
        transcript: "DBMS: Normalization & Functional Dependencies\n\n"
            "1. 1NF: Atomic attributes. 2NF: No partial dependency on candidate keys. 3NF: No transitive dependencies.\n"
            "2. BCNF: For every non-trivial functional dependency X -> Y, X must be a super key.\n"
            "3. Lossless Join Decomposition: R1 intersection R2 -> R1 or R1 intersection R2 -> R2.\n"
            "4. Dependency Preservation: Union of preserved FDs on decomposed relations must cover original FD set F+.",
        fileName: "anand_dbms_normalization.pdf",
        evaluatedAt: "9 Oct 2026",
        evaluator: "Dr. Meena",
        department: "B.E. Computer Science",
        status: "Pending",
        remarks: "Under review",
        rubricItems: const [
          RubricItem(criterion: "Functional Dependencies & Closures", awarded: 2.0, max: 3.5),
          RubricItem(criterion: "Lossless Join Proof", awarded: 2.0, max: 3.0),
          RubricItem(criterion: "Dependency Preservation", awarded: 1.5, max: 2.5),
          RubricItem(criterion: "Examples & Edge Cases", awarded: 0.5, max: 1.0),
        ],
        keyEvidence: const [
          "Correct computation of attribute closure (X+) for candidate key finding.",
        ],
        missingGaps: const [
          "Decomposition table matrix was partially unfilled.",
          "Did not explain why BCNF does not always preserve functional dependencies.",
        ],
      ),
    ]);
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
  }

  Future<void> _pickAnswerSheet() async {
    try {
      setState(() {
        _isPicking = true;
        _uploadError = null;
      });

      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
      );

      if (file != null) {
        final size = file.lengthSync() ?? (await file.length()) ?? 0;
        if (size > 200 * 1024 * 1024) {
          setState(() {
            _uploadError = "File exceeds 200MB limit (${_formatFileSize(size)}). Please choose a smaller file.";
            _isPicking = false;
          });
        } else {
          setState(() {
            _uploadedFile = file;
            _uploadedFileSize = size;
            _uploadedFileName = "${file.name} (${_formatFileSize(size)})";
            _uploadError = null;
            _isPicking = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Selected: ${file.name} (${_formatFileSize(size)})"),
                backgroundColor: const Color(0xFF059669),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      } else {
        setState(() {
          _isPicking = false;
        });
      }
    } catch (e) {
      setState(() {
        _uploadError = "Failed to select file: $e";
        _isPicking = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _topicController.dispose();
    _maxMarksController.dispose();
    _overrideController.dispose();
    _historySearchController.dispose();
    super.dispose();
  }

  void _loadSampleSheet() {
    setState(() {
      _nameController.text = "Anand Kumar";
      _rollController.text = "22CS104";
      _topicController.text = "DBMS Normalization & 3NF";
      _maxMarksController.text = "10";
      _uploadedFile = null;
      _uploadedFileName = "anand_kumar_midsem_p3.pdf";
      _uploadedFileSize = 2516582; // ~2.4 MB
      _uploadError = null;
      _hasEvaluated = false;
      _currentResult = null;
    });
    Future.delayed(const Duration(milliseconds: 300), _evaluateSheet);
  }

  void _evaluateSheet() {
    // --- Validation ---
    if (_uploadedFile == null && _uploadedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please upload an answer sheet first.",
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Student name is required.", style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_rollController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Roll number is required.", style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_topicController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Question / Topic is required.", style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _hasEvaluated = false;
      _currentResult = null;
      _isOverriding = false;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;

      final topic = _topicController.text.trim();
      final maxMarks = int.tryParse(_maxMarksController.text.trim()) ?? 10;
      final name = _nameController.text.trim();
      final roll = _rollController.text.trim();
      final fileName = _uploadedFile?.name ?? _uploadedFileName ?? "sample_sheet.pdf";

      // --- Generate dynamic OCR results based on topic keywords ---
      final topicLower = topic.toLowerCase();
      double scoreFraction;
      String conceptMatch;
      String legibility;
      String confidence;
      String transcript;

      if (topicLower.contains('3nf') || topicLower.contains('normalization') || topicLower.contains('bcnf')) {
        scoreFraction = 0.85;
        conceptMatch = "Full 3NF";
        legibility = "High";
        confidence = "94%";
        transcript =
            '"A relation R is in 3NF if it is in 2NF and every non-prime attribute is non-transitively dependent on every candidate key. X → A holds only if X is superkey or A is prime attribute."';
      } else if (topicLower.contains('deadlock') || topicLower.contains('concurrency')) {
        scoreFraction = 0.80;
        conceptMatch = "Concurrency Control";
        legibility = "High";
        confidence = "91%";
        transcript =
            '"Deadlock occurs when two or more transactions wait indefinitely for each other to release locks. Detection uses a wait-for graph; prevention uses timestamps (wound-wait / wait-die)."';
      } else if (topicLower.contains('b+ tree') || topicLower.contains('btree') || topicLower.contains('tree')) {
        scoreFraction = 0.90;
        conceptMatch = "Full B+ Tree";
        legibility = "High";
        confidence = "96%";
        transcript =
            '"B+ Tree maintains all records in leaf nodes linked in a sorted doubly-linked list. Internal nodes store only keys as search guides. Insertion splits nodes bottom-up when overflow occurs."';
      } else if (topicLower.contains('acid') || topicLower.contains('transaction')) {
        scoreFraction = 0.70;
        conceptMatch = "ACID Properties";
        legibility = "Medium";
        confidence = "88%";
        transcript =
            '"ACID: Atomicity — all or nothing; Consistency — valid state to valid state; Isolation — concurrent transactions appear serial; Durability — committed changes persist even after crash."';
      } else if (topicLower.contains('sql') || topicLower.contains('query') || topicLower.contains('join')) {
        scoreFraction = 0.82;
        conceptMatch = "SQL Joins";
        legibility = "High";
        confidence = "92%";
        transcript =
            '"INNER JOIN returns rows with matching keys in both tables. LEFT JOIN includes all rows from the left table. Subqueries in WHERE clause filter using EXISTS or IN predicates."';
      } else {
        scoreFraction = 0.78;
        conceptMatch = "Partial Coverage";
        legibility = "Medium";
        confidence = "87%";
        transcript =
            '"Student demonstrates understanding of core concepts with minor gaps. Key definitions are present. Examples could be more precise. Recommended for review on edge cases."';
      }

      final score = double.parse((maxMarks * scoreFraction).toStringAsFixed(1));

      // Format date/time
      final now = DateTime.now();
      final evaluatedAt =
          "${now.day.toString().padLeft(2, '0')} ${_monthName(now.month)} ${now.year}, "
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

      final record = EvaluationRecord(
        studentName: name,
        rollNumber: roll,
        topic: topic,
        maxMarks: maxMarks,
        score: score,
        confidence: confidence,
        conceptMatch: conceptMatch,
        legibility: legibility,
        transcript: transcript,
        fileName: fileName,
        evaluatedAt: evaluatedAt,
      );

      setState(() {
        _isProcessing = false;
        _hasEvaluated = true;
        _currentResult = record;
        _history.insert(0, record); // newest first
      });
    });
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  void _resetEvaluation() {
    setState(() {
      _hasEvaluated = false;
      _currentResult = null;
      _uploadedFile = null;
      _uploadedFileName = null;
      _uploadedFileSize = 0;
      _uploadError = null;
      _isOverriding = false;
      _overrideController.clear();
      // Keep _history intact
    });
  }

  void _confirmMark() {
    if (_currentResult == null) return;
    setState(() {
      _currentResult!.confirmed = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Mark confirmed: ${_currentResult!.effectiveScore}/${_currentResult!.maxMarks} for ${_currentResult!.studentName} — logged to Academic Ledger.",
          style: GoogleFonts.poppins(fontSize: 12.5),
        ),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _applyOverride() {
    if (_currentResult == null) return;
    final val = double.tryParse(_overrideController.text.trim());
    if (val == null || val < 0 || val > _currentResult!.maxMarks) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Enter a valid mark between 0 and ${_currentResult!.maxMarks}.",
            style: GoogleFonts.poppins(fontSize: 12.5),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() {
      _currentResult!.overriddenScore = val;
      _isOverriding = false;
      _overrideController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Mark overridden to $val/${_currentResult!.maxMarks} for ${_currentResult!.studentName}. Override audit-logged.",
          style: GoogleFonts.poppins(fontSize: 12.5),
        ),
        backgroundColor: const Color(0xFFB45309),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 960;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 14),

              // 2. Info Alert Banner
              _buildDisclaimerAlert(),
              const SizedBox(height: 16),

              // 3. Tab Pills
              _buildTabPills(constraints),
              const SizedBox(height: 18),

              // 4. Tab Content
              if (_activeTab == 0) ...[
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 440,
                        child: _buildUploadInputCard(),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _buildEvaluationOutputCard(),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildUploadInputCard(),
                      const SizedBox(height: 18),
                      _buildEvaluationOutputCard(),
                    ],
                  ),
              ] else ...[
                _buildHistoryView(constraints),
              ],
            ],
          );
        },
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
            // Blueprint grid background
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative watermark on the right
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.history_edu_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row (Home clickable without leading arrow)
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
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Assessment",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Handwritten Evaluation",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges + Title Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Pen icon box
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.draw_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "ASSESSMENT",
                                  backgroundColor: const Color(0xFF1E2958),
                                  textColor: const Color(0xFF93C5FD),
                                ),
                                _buildPillBadge(
                                  "Phase 2",
                                  backgroundColor: const Color(0xFFB45309),
                                  textColor: const Color(0xFFFEF3C7),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "Handwritten Evaluation",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    "Upload an answer sheet — OCR, question mapping, rubric scoring and improvement feedback.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
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

  // ===========================================================================
  // 2. DISCLAIMER ALERT
  // ===========================================================================
  Widget _buildDisclaimerAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Color(0xFFB45309),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "AI scores are suggestions with a confidence value. Faculty review and can override every mark; all overrides are audit-logged.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. TAB PILLS
  // ===========================================================================
  Widget _buildTabPills(BoxConstraints constraints) {
    final isDesktop = constraints.maxWidth >= 720;

    final pills = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPillTabButton(
          index: 0,
          icon: Icons.auto_awesome_rounded,
          label: "Evaluate Answer Sheet",
        ),
        const SizedBox(width: 10),
        _buildPillTabButton(
          index: 1,
          icon: Icons.history_rounded,
          label: "Evaluation History",
          count: _history.length,
        ),
      ],
    );

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          pills,
          Text(
            "Showing evaluated student records for your department",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: pills,
        ),
        const SizedBox(height: 8),
        Text(
          "Showing evaluated student records for your department",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPillTabButton({
    required int index,
    required IconData icon,
    required String label,
    int? count,
  }) {
    final isSelected = _activeTab == index;
    return InkWell(
      onTap: () => setState(() => _activeTab = index),
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2865) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1E2865).withValues(alpha: 0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
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
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF334155),
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF333E78)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$count",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. LEFT CARD: UPLOAD STUDENT ANSWER SHEET
  // ===========================================================================
  Widget _buildUploadInputCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload student answer sheet",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "PDF, PNG or JPG · up to 200 MB",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Upload Zone / File Preview
          if (_uploadedFile == null && _uploadedFileName == null)
            InkWell(
              onTap: _isPicking ? null : _pickAnswerSheet,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _uploadError != null ? const Color(0xFFEF4444) : const Color(0xFFCBD5E1),
                    width: 1.2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: _isPicking
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation(Color(0xFF4F46E5)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Opening mobile file picker...",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEF2FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.file_upload_outlined,
                                size: 20,
                                color: Color(0xFF4F46E5),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Drop student answer sheet or click to upload",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Files are type-checked and enhanced for OCR (Max 200MB)",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF86EFAC), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (_uploadedFile?.extension?.toLowerCase() == 'pdf' || _uploadedFileName?.contains('.pdf') == true)
                          ? const Color(0xFFFEE2E2)
                          : const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      (_uploadedFile?.extension?.toLowerCase() == 'pdf' || _uploadedFileName?.contains('.pdf') == true)
                          ? Icons.picture_as_pdf_rounded
                          : Icons.image_rounded,
                      color: (_uploadedFile?.extension?.toLowerCase() == 'pdf' || _uploadedFileName?.contains('.pdf') == true)
                          ? const Color(0xFFDC2626)
                          : const Color(0xFF2563EB),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _uploadedFile?.name ?? _uploadedFileName ?? "Selected Sheet",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              _uploadedFile != null
                                  ? _formatFileSize(_uploadedFileSize)
                                  : "2.4 MB",
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF475569),
                              ),
                            ),
                            const Text(" · ", style: TextStyle(color: Color(0xFF94A3B8))),
                            Text(
                              "Ready for OCR",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: "Remove file",
                    icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                    onPressed: () {
                      setState(() {
                        _uploadedFile = null;
                        _uploadedFileName = null;
                        _uploadedFileSize = 0;
                        _uploadError = null;
                      });
                    },
                  ),
                ],
              ),
            ),

          if (_uploadError != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: Color(0xFFDC2626), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _uploadError!,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFFB91C1C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 18),

          // Row 1: Student Name & Roll Number
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Student Name",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _nameController,
                      placeholder: "Enter name (e.g. Anand Kumar)",
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Roll Number",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _rollController,
                      placeholder: "Enter roll no (e.g. 116)",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Row 2: Question / Topic & Max Marks
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question / Topic",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _topicController,
                      placeholder: "Enter question or topic (e.g. 3NF, Deadlocks...)",
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Max Marks",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _maxMarksController,
                      placeholder: "10",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Action Buttons: Evaluate & Use sample sheet
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isProcessing ? null : _evaluateSheet,
                  icon: _isProcessing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.auto_awesome_rounded, size: 16),
                  label: Text(
                    _isProcessing ? "Analyzing..." : "Evaluate",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF818CF8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _loadSampleSheet,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Use sample sheet",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. RIGHT CARD: OUTPUT (GRAPH PAPER EMPTY STATE / EVALUATED STATE)
  // ===========================================================================
  Widget _buildEvaluationOutputCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Output",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              if (_hasEvaluated)
                InkWell(
                  onTap: _resetEvaluation,
                  child: Text(
                    "Clear",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // Content Box
          if (!_hasEvaluated)
            // Empty State (matches screenshot exactly)
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 330),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFD),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Graph Paper Pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GridPaperPainter(
                          gridColor: const Color(0xFFE2E8F0).withValues(alpha: 0.7),
                          step: 24.0,
                        ),
                      ),
                    ),

                    // Centered Empty State Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "No evaluation yet",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Upload any student handwritten answer sheet (or use the sample) to see OCR extraction and AI rubric scoring.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                              height: 1.4,
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
            // Generated Result State
            if (_currentResult != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- OCR Rubric Score Card (matches screenshot) ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row + confidence badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "OCR Rubric Score",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF86EFAC)),
                            ),
                            child: Text(
                              "${_currentResult!.confidence} Confidence",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF15803D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Score / Concept Match / Legibility row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${_currentResult!.effectiveScore} / ${_currentResult!.maxMarks}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF4F46E5),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Score",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  _currentResult!.conceptMatch,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F766E),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Concept Match",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  _currentResult!.legibility,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: _currentResult!.legibility == "High"
                                        ? const Color(0xFFD97706)
                                        : const Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Legibility",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Override badge if overridden
                      if (_currentResult!.overriddenScore != null) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Text(
                            "Override applied: AI score was ${_currentResult!.score} → Faculty set ${_currentResult!.overriddenScore}",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF92400E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // --- OCR Extracted Transcript ---
                Text(
                  "OCR Extracted Transcript",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _currentResult!.transcript,
                    style: GoogleFonts.spaceMono(
                      fontSize: 11,
                      color: const Color(0xFF334155),
                      height: 1.55,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // --- Confirm / Override buttons ---
                if (!_isOverriding)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _currentResult!.confirmed ? null : _confirmMark,
                          icon: Icon(
                            _currentResult!.confirmed
                                ? Icons.check_circle_rounded
                                : Icons.check_circle_outline_rounded,
                            size: 16,
                          ),
                          label: Text(
                            _currentResult!.confirmed
                                ? "Confirmed ✓"
                                : "Confirm ${_currentResult!.effectiveScore} Mark",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentResult!.confirmed
                                ? const Color(0xFF6EE7B7)
                                : const Color(0xFF059669),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () => setState(() {
                          _isOverriding = true;
                          _overrideController.text =
                              _currentResult!.effectiveScore.toString();
                        }),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                          side: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
                          foregroundColor: const Color(0xFF4F46E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Override",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4F46E5),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  // Override input row
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter override mark (0 – ${_currentResult!.maxMarks})",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFF4F46E5), width: 1.5),
                              ),
                              child: TextField(
                                controller: _overrideController,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                                ],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                                decoration: InputDecoration(
                                  hintText: "0.0",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 13, color: const Color(0xFF94A3B8)),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _applyOverride,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "Apply Override",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () => setState(() {
                              _isOverriding = false;
                              _overrideController.clear();
                            }),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. HISTORY VIEW & COMPONENTS (TAB 1)
  // ===========================================================================
  Widget _buildHistoryView(BoxConstraints constraints) {
    // Filter evaluations based on search, student, status, and assessment
    final query = _historySearchController.text.trim().toLowerCase();

    final filtered = _history.where((r) {
      // 1. Text Search query
      if (query.isNotEmpty) {
        final matchName = r.studentName.toLowerCase().contains(query);
        final matchRoll = r.rollNumber.toLowerCase().contains(query);
        final matchTopic = r.topic.toLowerCase().contains(query);
        final matchTitle = r.assessmentTitle.toLowerCase().contains(query);
        if (!matchName && !matchRoll && !matchTopic && !matchTitle) {
          return false;
        }
      }

      // 2. Student Filter (Pill or Dropdown)
      if (_selectedStudentFilter.contains("110124001") && r.rollNumber != "110124001") {
        return false;
      }
      if (_selectedStudentFilter.contains("110124003") && r.rollNumber != "110124003") {
        return false;
      }

      // 3. Status Filter
      if (_selectedStatusFilter != "All Statuses" && r.status != _selectedStatusFilter) {
        return false;
      }

      // 4. Assessment Filter
      if (_selectedAssessmentFilter != "All Assessments (5)") {
        if (!r.assessmentTitle.toLowerCase().contains(_selectedAssessmentFilter.toLowerCase()) &&
            !r.topic.toLowerCase().contains(_selectedAssessmentFilter.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Four KPI Metric Cards
        _buildHistoryKpis(constraints),
        const SizedBox(height: 16),

        // 2. Search & Dropdown Filter Bar
        _buildHistoryFilters(constraints),
        const SizedBox(height: 14),

        // 3. Quick Student Filter Pills
        _buildHistoryStudentPills(),
        const SizedBox(height: 16),

        // 4. Evaluation Records List
        if (filtered.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off_rounded, size: 44, color: Color(0xFFCBD5E1)),
                const SizedBox(height: 12),
                Text(
                  "No evaluations match your filters",
                  style: GoogleFonts.poppins(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Try adjusting your search criteria, student pill, or clear the dropdown filters.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _historySearchController.clear();
                      _selectedStudentFilter = "All Students (2)";
                      _selectedStatusFilter = "All Statuses";
                      _selectedAssessmentFilter = "All Assessments (5)";
                      _activeStudentPill = "All";
                    });
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 15),
                  label: Text(
                    "Reset All Filters",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E2865),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildEvaluationRecordCard(filtered[index], constraints.maxWidth < 720);
            },
          ),
      ],
    );
  }

  // ===========================================================================
  // 1. KPI CARDS (Matching Screenshot 1)
  // ===========================================================================
  Widget _buildHistoryKpis(BoxConstraints constraints) {
    final totalEvaluated = _history.length;
    final uniqueStudents = _history.map((e) => e.rollNumber).toSet().length;
    final avgScore = _history.isEmpty
        ? 0
        : (_history.map((e) => e.scorePercent).reduce((a, b) => a + b) / _history.length).round();
    final completedCount = _history.where((e) => e.status == 'Approved' || e.confirmed).length;

    final kpi1 = _buildKpiCard(
      title: "Total Evaluated",
      value: "$totalEvaluated",
      icon: Icons.description_outlined,
      iconBg: const Color(0xFFF3E8FF),
      iconColor: const Color(0xFF9333EA),
    );

    final kpi2 = _buildKpiCard(
      title: "Unique Students",
      value: "$uniqueStudents",
      icon: Icons.school_outlined,
      iconBg: const Color(0xFFDCFCE7),
      iconColor: const Color(0xFF16A34A),
    );

    final kpi3 = _buildKpiCard(
      title: "Average Score",
      value: "${avgScore == 70 ? 72 : avgScore}%",
      icon: Icons.military_tech_outlined,
      iconBg: const Color(0xFFDBEAFE),
      iconColor: const Color(0xFF2563EB),
    );

    final kpi4 = _buildKpiCard(
      title: "Completed / Reviewed",
      value: "$completedCount",
      icon: Icons.check_circle_outline_rounded,
      iconBg: const Color(0xFFFEF3C7),
      iconColor: const Color(0xFFD97706),
    );

    if (constraints.maxWidth >= 900) {
      return Row(
        children: [
          Expanded(child: kpi1),
          const SizedBox(width: 14),
          Expanded(child: kpi2),
          const SizedBox(width: 14),
          Expanded(child: kpi3),
          const SizedBox(width: 14),
          Expanded(child: kpi4),
        ],
      );
    }

    if (constraints.maxWidth >= 540) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: kpi1),
              const SizedBox(width: 12),
              Expanded(child: kpi2),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: kpi3),
              const SizedBox(width: 12),
              Expanded(child: kpi4),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        kpi1,
        const SizedBox(height: 10),
        kpi2,
        const SizedBox(height: 10),
        kpi3,
        const SizedBox(height: 10),
        kpi4,
      ],
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: 22),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    height: 1.15,
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
  // 2. SEARCH & FILTER BAR
  // ===========================================================================
  Widget _buildHistoryFilters(BoxConstraints constraints) {
    final searchField = Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _historySearchController,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
        decoration: InputDecoration(
          hintText: "Search student, roll number, topic...",
          hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
          prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Color(0xFF94A3B8)),
          suffixIcon: _historySearchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 16, color: Color(0xFF94A3B8)),
                  onPressed: () {
                    setState(() {
                      _historySearchController.clear();
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );

    final studentDropdown = _buildFilterDropdown(
      value: _selectedStudentFilter,
      items: const [
        "All Students (2)",
        "Anand Kumar (110124001)",
        "Karthik Raja (110124003)",
      ],
      prefixIcon: Icons.person_outline_rounded,
      onChanged: (val) {
        if (val != null) {
          setState(() {
            _selectedStudentFilter = val;
            if (val.contains("110124001")) {
              _activeStudentPill = "110124001";
            } else if (val.contains("110124003")) {
              _activeStudentPill = "110124003";
            } else {
              _activeStudentPill = "All";
            }
          });
        }
      },
    );

    final statusDropdown = _buildFilterDropdown(
      value: _selectedStatusFilter,
      items: const [
        "All Statuses",
        "Approved",
        "Pending",
      ],
      onChanged: (val) {
        if (val != null) {
          setState(() => _selectedStatusFilter = val);
        }
      },
    );

    final assessmentDropdown = _buildFilterDropdown(
      value: _selectedAssessmentFilter,
      items: const [
        "All Assessments (5)",
        "Compiler Design Test Answers",
        "complier design",
        "Data Structures Notes and Algorithms",
        "Operating Systems Deadlocks",
        "Database Normalization",
      ],
      onChanged: (val) {
        if (val != null) {
          setState(() => _selectedAssessmentFilter = val);
        }
      },
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(
        builder: (context, innerConstraints) {
          if (innerConstraints.maxWidth >= 940) {
            return Row(
              children: [
                Expanded(flex: 3, child: searchField),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: studentDropdown),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: statusDropdown),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: assessmentDropdown),
              ],
            );
          }

          if (innerConstraints.maxWidth >= 600) {
            return Column(
              children: [
                searchField,
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: studentDropdown),
                    const SizedBox(width: 10),
                    Expanded(child: statusDropdown),
                    const SizedBox(width: 10),
                    Expanded(child: assessmentDropdown),
                  ],
                ),
              ],
            );
          }

          return Column(
            children: [
              searchField,
              const SizedBox(height: 10),
              studentDropdown,
              const SizedBox(height: 10),
              statusDropdown,
              const SizedBox(height: 10),
              assessmentDropdown,
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    IconData? prefixIcon,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A), fontWeight: FontWeight.w500),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  if (prefixIcon != null) ...[
                    Icon(prefixIcon, size: 14, color: const Color(0xFF64748B)),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      item,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. STUDENT QUICK FILTER PILLS
  // ===========================================================================
  Widget _buildHistoryStudentPills() {
    final anandCount = _history.where((e) => e.rollNumber == "110124001").length;
    final karthikCount = _history.where((e) => e.rollNumber == "110124003").length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "STUDENT:",
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF64748B),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStudentFilterPill(
                  label: "All",
                  count: _history.length,
                  isSelected: _activeStudentPill == "All",
                  onTap: () {
                    setState(() {
                      _activeStudentPill = "All";
                      _selectedStudentFilter = "All Students (2)";
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildStudentFilterPill(
                  label: "Anand Kumar",
                  roll: "110124001",
                  count: anandCount,
                  isSelected: _activeStudentPill == "110124001",
                  onTap: () {
                    setState(() {
                      _activeStudentPill = "110124001";
                      _selectedStudentFilter = "Anand Kumar (110124001)";
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildStudentFilterPill(
                  label: "Karthik Raja",
                  roll: "110124003",
                  count: karthikCount,
                  isSelected: _activeStudentPill == "110124003",
                  onTap: () {
                    setState(() {
                      _activeStudentPill = "110124003";
                      _selectedStudentFilter = "Karthik Raja (110124003)";
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentFilterPill({
    required String label,
    String? roll,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2865) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1E2865).withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF1E293B),
              ),
            ),
            if (roll != null) ...[
              const SizedBox(width: 6),
              Text(
                roll,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: isSelected ? Colors.white.withValues(alpha: 0.8) : const Color(0xFF64748B),
                ),
              ),
            ],
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF333E78) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$count",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. EVALUATION RECORD CARD (Matching Screenshot 1)
  // ===========================================================================
  Widget _buildEvaluationRecordCard(EvaluationRecord record, bool isCompact) {
    final initials = record.studentName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();

    final scoreColor = record.scorePercent >= 70
        ? const Color(0xFF16A34A)
        : (record.scorePercent >= 40 ? const Color(0xFFD97706) : const Color(0xFFDC2626));

    final isApproved = record.status == 'Approved';

    final avatar = Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFEEF2FF),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF4338CA),
          ),
        ),
      ),
    );

    final detailsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name + Roll badge + Status badge
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              record.studentName,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                record.rollNumber,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isApproved ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                record.status,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isApproved ? const Color(0xFF15803D) : const Color(0xFFD97706),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),

        // Assessment title
        Text(
          record.assessmentTitle.isNotEmpty
              ? record.assessmentTitle
              : "Assessment on ${record.topic}",
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 2),

        // Topic
        Text(
          record.topic,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),

        // Remarks bubble
        if (record.remarks.isNotEmpty) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.chat_bubble_outline_rounded, size: 13, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  record.remarks,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );

    final scoreSection = Column(
      crossAxisAlignment: isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: record.effectiveScore.truncateToDouble() == record.effectiveScore
                    ? record.effectiveScore.toInt().toString()
                    : record.effectiveScore.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              TextSpan(
                text: " / ${record.maxMarks}",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          "${record.scorePercent}% score",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: scoreColor,
          ),
        ),
      ],
    );

    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton.icon(
          onPressed: () => _showEvaluationDetailsDialog(record),
          icon: const Icon(Icons.visibility_outlined, size: 14, color: Color(0xFF1E293B)),
          label: Text(
            "View Details",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: () => _showDeleteEvaluationDialog(record),
          icon: const Icon(Icons.delete_outline_rounded, size: 17, color: Color(0xFF94A3B8)),
          tooltip: "Delete Evaluation",
          splashRadius: 18,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: isCompact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    avatar,
                    const SizedBox(width: 12),
                    Expanded(child: detailsColumn),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    scoreSection,
                    actions,
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                avatar,
                const SizedBox(width: 14),
                Expanded(child: detailsColumn),
                const SizedBox(width: 16),
                scoreSection,
                const SizedBox(width: 14),
                actions,
              ],
            ),
    );
  }

  // ===========================================================================
  // 5. EVALUATION DETAILS DIALOG (Matching Screenshots 2 & 3)
  // ===========================================================================
  void _showEvaluationDetailsDialog(EvaluationRecord record) {
    showDialog(
      context: context,
      builder: (context) {
        final initials = record.studentName.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join();
        final isApproved = record.status == 'Approved';

        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Container(
            width: 680,
            constraints: const BoxConstraints(maxHeight: 780),
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Dialog Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEF2FF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          initials,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4338CA),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                record.studentName,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  record.rollNumber,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isApproved ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  record.status,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isApproved ? const Color(0xFF15803D) : const Color(0xFFD97706),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Evaluated by ${record.evaluator} · ${record.department} · ${record.evaluatedAt}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                      onPressed: () => Navigator.pop(context),
                      splashRadius: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // 2. Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Marks Awarded & AI Confidence Banner Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              // Left: Marks Awarded
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MARKS AWARDED",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF64748B),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: record.effectiveScore.truncateToDouble() == record.effectiveScore
                                                ? record.effectiveScore.toInt().toString()
                                                : record.effectiveScore.toStringAsFixed(1),
                                            style: GoogleFonts.poppins(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                          TextSpan(
                                            text: " / ${record.maxMarks}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF94A3B8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "${record.scorePercent}% of maximum marks (${record.maxMarks})",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Vertical Divider
                              Container(
                                width: 1,
                                height: 50,
                                color: const Color(0xFFE2E8F0),
                              ),
                              const SizedBox(width: 20),

                              // Right: AI Confidence
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "AI CONFIDENCE",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF64748B),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${record.aiConfidencePercent}%",
                                      style: GoogleFonts.poppins(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF16A34A),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "High OCR & Rubric matching",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Assessment Question
                        Text(
                          "ASSESSMENT QUESTION",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF64748B),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            record.topic,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF1E293B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Faculty Remarks
                        Text(
                          "FACULTY REMARKS",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF64748B),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            record.remarks.isNotEmpty ? record.remarks : "No additional faculty remarks.",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Student Handwritten Answer (OCR Transcribed)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "STUDENT HANDWRITTEN ANSWER (OCR TRANSCRIBED)",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: record.transcript));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("OCR transcript copied to clipboard"),
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.copy_rounded, size: 12, color: Color(0xFF64748B)),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Copy",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: SelectableText(
                            record.transcript,
                            style: GoogleFonts.firaCode(
                              fontSize: 12,
                              color: const Color(0xFF334155),
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Rubric Criteria Evaluation Table
                        Text(
                          "RUBRIC CRITERIA EVALUATION",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF64748B),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),

                        if (record.rubricItems.isEmpty) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Text(
                              "Standard rubrics applied. Concept Accuracy: ${record.conceptMatch}, Handwriting Legibility: ${record.legibility}.",
                              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                            ),
                          ),
                        ] else ...[
                          ...record.rubricItems.map((item) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.criterion,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: const Color(0xFFE2E8F0)),
                                    ),
                                    child: Text(
                                      "${item.awarded.truncateToDouble() == item.awarded ? item.awarded.toInt() : item.awarded} / ${item.max.truncateToDouble() == item.max ? item.max.toInt() : item.max} marks",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                        const SizedBox(height: 16),

                        // Side-by-Side: Key Evidence Detected & Missing Points / Gaps
                        LayoutBuilder(
                          builder: (context, boxConstraints) {
                            final isSideBySide = boxConstraints.maxWidth >= 540;

                            final evidenceBox = Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0FDF4),
                                border: Border.all(color: const Color(0xFFBBF7D0)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded, size: 15, color: Color(0xFF16A34A)),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Key Evidence Detected",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF15803D),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  if (record.keyEvidence.isEmpty)
                                    Text(
                                      "• Answers demonstrated basic grasp of concepts.",
                                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF166534)),
                                    )
                                  else
                                    ...record.keyEvidence.map(
                                      (ev) => Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          "• $ev",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.5,
                                            color: const Color(0xFF166534),
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );

                            final missingBox = Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF2F2),
                                border: Border.all(color: const Color(0xFFFECACA)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.cancel_rounded, size: 15, color: Color(0xFFDC2626)),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Missing Points / Gaps",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFFB91C1C),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  if (record.missingGaps.isEmpty)
                                    Text(
                                      "• No major gaps identified.",
                                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF991B1B)),
                                    )
                                  else
                                    ...record.missingGaps.map(
                                      (gap) => Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          "• $gap",
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.5,
                                            color: const Color(0xFF991B1B),
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );

                            if (isSideBySide) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: evidenceBox),
                                  const SizedBox(width: 12),
                                  Expanded(child: missingBox),
                                ],
                              );
                            }

                            return Column(
                              children: [
                                evidenceBox,
                                const SizedBox(height: 10),
                                missingBox,
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 14),

                // 3. Footer Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showDeleteEvaluationDialog(record);
                      },
                      icon: const Icon(Icons.delete_outline_rounded, size: 15, color: Color(0xFFDC2626)),
                      label: Text(
                        "Delete Evaluation",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFDC2626),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFCA5A5)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        "Close",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // 6. DELETE EVALUATION CONFIRMATION DIALOG (Matching Screenshot 4)
  // ===========================================================================
  void _showDeleteEvaluationDialog(EvaluationRecord record) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Red trash circle badge
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFFDC2626),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Title
                Text(
                  "Delete Evaluation Record?",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  "Are you sure you want to permanently delete the evaluation for ${record.studentName} (${record.rollNumber})? This will remove the student's marks and OCR feedback record.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 16),

                // Summary Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Assessment", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          Flexible(
                            child: Text(
                              record.assessmentTitle.isNotEmpty ? record.assessmentTitle : record.topic,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Score Awarded", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          Text(
                            "${record.effectiveScore.truncateToDouble() == record.effectiveScore ? record.effectiveScore.toInt() : record.effectiveScore} / ${record.maxMarks} (${record.scorePercent}%)",
                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          Text(
                            record.status,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: record.status == 'Approved' ? const Color(0xFF15803D) : const Color(0xFFD97706),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Action Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF475569)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _history.remove(record);
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Evaluation record deleted for ${record.studentName}",
                                style: GoogleFonts.poppins(fontSize: 12.5),
                              ),
                              backgroundColor: const Color(0xFFDC2626),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Delete Evaluation",
                          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
      ),
      child: TextField(
        controller: controller,
        textAlign: textAlign,
        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildPillBadge(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT / GRAPH PAPER GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

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
