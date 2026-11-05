import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

// =============================================================================
// DATA MODEL: EVALUATION RECORD
// =============================================================================
class EvaluationRecord {
  final String studentName;
  final String rollNumber;
  final String topic;
  final int maxMarks;
  final double score;
  final String confidence;
  final String conceptMatch;
  final String legibility;
  final String transcript;
  final String fileName;
  final String evaluatedAt;
  bool confirmed;
  double? overriddenScore;

  EvaluationRecord({
    required this.studentName,
    required this.rollNumber,
    required this.topic,
    required this.maxMarks,
    required this.score,
    required this.confidence,
    required this.conceptMatch,
    required this.legibility,
    required this.transcript,
    required this.fileName,
    required this.evaluatedAt,
    this.confirmed = false,
    this.overriddenScore,
  });

  double get effectiveScore => overriddenScore ?? score;
  String get statusLabel => overriddenScore != null ? 'Overridden' : (confirmed ? 'Confirmed' : 'Pending');
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
              _buildTabPills(),
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
                _buildHistoryCard(),
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
  Widget _buildTabPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
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
      ),
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
          color: isSelected ? const Color(0xFF141938) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF141938).withValues(alpha: 0.15),
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
                      ? Colors.white.withValues(alpha: 0.2)
                      : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$count",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF3B82F6),
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

  Widget _buildRubricItem(String title, String score, bool highConfidence) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF334155),
              ),
            ),
          ),
          Text(
            score,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: highConfidence ? const Color(0xFF15803D) : const Color(0xFFD97706),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. HISTORY CARD (FOR TAB 1)
  // ===========================================================================
  Widget _buildHistoryCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Evaluation History (${_history.length})",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              if (_history.isNotEmpty)
                TextButton.icon(
                  onPressed: () => setState(() => _activeTab = 0),
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: Text(
                    "New Evaluation",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4F46E5),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          if (_history.isEmpty)
            // Empty state
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.history_edu_rounded, size: 40, color: Color(0xFFCBD5E1)),
                  const SizedBox(height: 12),
                  Text(
                    "No evaluations yet",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Evaluate an answer sheet to see history here.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => setState(() => _activeTab = 0),
                    icon: const Icon(Icons.auto_awesome_rounded, size: 15),
                    label: Text(
                      "Go to Evaluate",
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141938),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _history.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
              itemBuilder: (context, index) {
                final record = _history[index];
                final isOverridden = record.overriddenScore != null;
                final isConfirmed = record.confirmed;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFEEF2FF),
                        radius: 20,
                        child: Text(
                          record.studentName.substring(0, 1).toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4F46E5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${record.studentName} (Roll: ${record.rollNumber})",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${record.topic} · ${record.evaluatedAt}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isOverridden
                                  ? const Color(0xFFFEF3C7)
                                  : const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isOverridden
                                    ? const Color(0xFFFDE68A)
                                    : const Color(0xFF86EFAC),
                              ),
                            ),
                            child: Text(
                              "${record.effectiveScore} / ${record.maxMarks}",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isOverridden
                                    ? const Color(0xFF92400E)
                                    : const Color(0xFF15803D),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: isConfirmed
                                  ? const Color(0xFFDCFCE7)
                                  : isOverridden
                                      ? const Color(0xFFFEF3C7)
                                      : const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              record.statusLabel,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isConfirmed
                                    ? const Color(0xFF15803D)
                                    : isOverridden
                                        ? const Color(0xFF92400E)
                                        : const Color(0xFF3B82F6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
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
