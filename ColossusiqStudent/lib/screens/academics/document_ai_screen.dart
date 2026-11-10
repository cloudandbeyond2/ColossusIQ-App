import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// STUDENT ACADEMICS: DOCUMENT AI SCREEN
// Matches blueprint: Hero grid banner with ACADEMICS & Phase 2 badges,
// Inputs card with AI task dropdown and multiline textarea,
// and Output card with blueprint grid empty/generated state.
// =============================================================================
class DocumentAiScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const DocumentAiScreen({super.key, this.onBack});

  @override
  State<DocumentAiScreen> createState() => _DocumentAiScreenState();
}

class _DocumentAiScreenState extends State<DocumentAiScreen> {
  String _selectedTask = "Summarise";
  final TextEditingController _textController = TextEditingController();
  bool _isProcessing = false;
  bool _hasGenerated = false;

  final List<String> _aiTasks = [
    "Summarise",
    "Extract key concepts",
    "Generate flashcards",
    "Generate quiz questions",
    "Explain simply",
  ];

  // Generated contents
  String _generatedSummary = "";
  List<String> _keyTakeaways = [];
  List<Map<String, String>> _flashcards = [];
  List<Map<String, dynamic>> _quizQuestions = [];
  int? _selectedFlashcardIndex;
  final Map<int, int> _selectedAnswers = {};

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _processDocument() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      // Auto-fill realistic sample text for demonstration if empty
      _textController.text =
          "Database Normalization is the process of structuring a relational database in accordance with a series of normal forms to reduce data redundancy and improve data integrity. First Normal Form (1NF) enforces atomic values and unique records. Second Normal Form (2NF) eliminates partial functional dependencies where non-prime attributes depend on only part of a composite candidate key. Third Normal Form (3NF) eliminates transitive functional dependencies, ensuring non-prime attributes depend solely on the candidate key. Boyce-Codd Normal Form (BCNF) strictly requires every determinant of a non-trivial dependency to be a super key.";
    }

    setState(() {
      _isProcessing = true;
    });

    Future.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _hasGenerated = true;

        if (_selectedTask == "Summarise") {
          _generatedSummary =
              "Normalization progressively organizes relational schemas to eliminate redundancy and update anomalies while preserving functional dependencies across 1NF, 2NF, 3NF and BCNF.";
          _keyTakeaways = [
            "1NF requires all attribute values to be atomic with no repeating groups or composite values.",
            "2NF eliminates partial dependencies by ensuring all non-key attributes depend on the entire candidate key.",
            "3NF eliminates transitive dependencies: non-key attributes cannot depend on other non-key attributes.",
            "BCNF is a stricter form where every determinant must be a super key.",
          ];
        } else if (_selectedTask == "Extract key concepts") {
          _generatedSummary = "Core database design principles extracted from your document:";
          _keyTakeaways = [
            "Atomic Value: Indivisible scalar value per table column.",
            "Functional Dependency (X -> Y): Determinant X uniquely identifies dependent attribute Y.",
            "Partial Dependency: Non-prime attribute depending on a subset of a composite candidate key.",
            "Transitive Dependency: X -> Y and Y -> Z where Z indirectly depends on key X through non-key Y.",
            "Candidate Key: Minimal super key capable of uniquely identifying every tuple in a relation.",
          ];
        } else if (_selectedTask == "Generate flashcards") {
          _flashcards = [
            {
              "q": "What is the primary condition for 1NF?",
              "a": "All column values must be atomic (indivisible) and each record must be unique with no repeating groups.",
            },
            {
              "q": "How does 2NF differ from 1NF?",
              "a": "2NF must already be in 1NF and additionally eliminate all partial dependencies on composite keys.",
            },
            {
              "q": "What dependency does 3NF eliminate?",
              "a": "Transitive functional dependencies (non-prime attributes depending on other non-prime attributes).",
            },
            {
              "q": "What rule defines Boyce-Codd Normal Form (BCNF)?",
              "a": "For every non-trivial functional dependency X -> Y, X must strictly be a super key.",
            },
          ];
          _selectedFlashcardIndex = null;
        } else if (_selectedTask == "Generate quiz questions") {
          _quizQuestions = [
            {
              "question": "Which normal form removes partial functional dependencies?",
              "options": ["1NF", "2NF", "3NF", "BCNF"],
              "correct": 1,
              "explanation": "2NF requires that no non-prime attribute is partially dependent on any candidate key.",
            },
            {
              "question": "In BCNF, what must every determinant X in (X -> Y) be?",
              "options": ["Foreign Key", "Primary Key only", "Super Key", "Non-prime attribute"],
              "correct": 2,
              "explanation": "BCNF requires every determinant of a non-trivial functional dependency to be a super key.",
            },
          ];
          _selectedAnswers.clear();
        } else {
          // Explain simply
          _generatedSummary =
              "Imagine organizing a messy closet: Normalization is like putting shirts with shirts and shoes with shoes so you don't have doubles, don't lose anything, and everything has exactly one home.";
          _keyTakeaways = [
            "Level 1 (1NF): Only one item per hanger. No cramming 3 things together.",
            "Level 2 (2NF): If a tag says 'Winter Jacket', the whole tag determines it, not just 'Winter'.",
            "Level 3 (3NF): Don't organize pants by what color your shoes are—organize pants by pants.",
          ];
        }
      });
    });
  }

  void _clearOutput() {
    setState(() {
      _hasGenerated = false;
      _textController.clear();
      _generatedSummary = "";
      _keyTakeaways.clear();
      _flashcards.clear();
      _quizQuestions.clear();
      _selectedAnswers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Document AI",
      category: "Academics",
      onBack: widget.onBack,
      children: [
        // 1. Top Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Academics  ›  Document AI",
          category: "ACADEMICS",
          phase: "Phase 2",
          isMvp: false, // Renders amber/orange warning badge
          icon: Icons.article_rounded,
          title: "Document AI",
          subtitle:
              "Upload PDFs, slides or scanned notes — summarise, extract, generate flashcards and questions.",
          watermarkIcon: Icons.description_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Main Two-Column View: Inputs Card & Output Card
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 360,
                    child: _buildInputsCard(),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildOutputCard(),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInputsCard(),
                  const SizedBox(height: 18),
                  _buildOutputCard(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 1. INPUTS CARD
  // ===========================================================================
  Widget _buildInputsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
            "Inputs",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Dropdown Label
          Text(
            "What should AI do?",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),

          // Dropdown Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedTask,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
                items: _aiTasks.map((task) {
                  return DropdownMenuItem(
                    value: task,
                    child: Text(task),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedTask = val;
                      _hasGenerated = false;
                    });
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Textarea Label
          Text(
            "Paste text from your document",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),

          // Multiline Text Input
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Stack(
              children: [
                TextField(
                  controller: _textController,
                  maxLines: 7,
                  minLines: 6,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    hintText: "Paste notes or a section of a chapter...",
                    hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
                // Corner drag/resize indicator icon as shown in screenshot
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Icon(
                    Icons.filter_list_rounded,
                    size: 10,
                    color: Colors.grey.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Process Document Action Button
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: _isProcessing ? null : _processDocument,
              icon: _isProcessing
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.auto_awesome_rounded, size: 16, color: Colors.white),
              label: Text(
                _isProcessing ? "Processing..." : "Process document",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF283593),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. OUTPUT CARD
  // ===========================================================================
  Widget _buildOutputCard() {
    return Container(
      constraints: const BoxConstraints(minHeight: 330),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Output",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              if (_hasGenerated) ...[
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                          text: _generatedSummary.isNotEmpty
                              ? "$_generatedSummary\n\n${_keyTakeaways.join('\n')}"
                              : "Generated with Document AI",
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Output copied to clipboard!"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 14),
                      label: const Text("Copy"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        minimumSize: Size.zero,
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        foregroundColor: const Color(0xFF334155),
                        textStyle: GoogleFonts.poppins(fontSize: 11.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Saved to your Personal Notes!"),
                            backgroundColor: Color(0xFF15803D),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add_outlined, size: 14, color: Colors.white),
                      label: const Text("Save to Notes"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF141938),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        minimumSize: Size.zero,
                        textStyle: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      tooltip: "Clear",
                      icon: const Icon(Icons.refresh_rounded, size: 16, color: Color(0xFF64748B)),
                      onPressed: _clearOutput,
                    ),
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),

          // Container with Graph Paper / Blueprint Grid
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 250),
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
                children: [
                  // Graph paper background
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPaperPainter(
                        gridColor: const Color(0xFFF1F5F9),
                        step: 22.0,
                      ),
                    ),
                  ),

                  // Content: Empty State vs Generated Content
                  !_hasGenerated
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Nothing generated yet",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Fill in the inputs and generate. Output is a draft for you to review and edit.",
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
                        )
                      : Padding(
                          padding: const EdgeInsets.all(18),
                          child: _buildGeneratedContent(),
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
  // 3. GENERATED OUTPUT CONTENT RENDERER
  // ===========================================================================
  Widget _buildGeneratedContent() {
    if (_selectedTask == "Generate flashcards") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.style_rounded, size: 16, color: Color(0xFF4F46E5)),
              const SizedBox(width: 8),
              Text(
                "Interactive Flashcards (${_flashcards.length})",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _flashcards.length,
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemBuilder: (context, idx) {
              final card = _flashcards[idx];
              final isRevealed = _selectedFlashcardIndex == idx;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedFlashcardIndex = isRevealed ? null : idx;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isRevealed ? const Color(0xFF818CF8) : const Color(0xFFE2E8F0),
                      width: isRevealed ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "Card ${idx + 1}",
                              style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF2563EB)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              card["q"]!,
                              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                            ),
                          ),
                          Icon(
                            isRevealed ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            size: 16,
                            color: const Color(0xFF64748B),
                          ),
                        ],
                      ),
                      if (isRevealed) ...[
                        const Divider(height: 18, color: Color(0xFFE2E8F0)),
                        Text(
                          card["a"]!,
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF047857), height: 1.45, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    }

    if (_selectedTask == "Generate quiz questions") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.quiz_rounded, size: 16, color: Color(0xFF4F46E5)),
              const SizedBox(width: 8),
              Text(
                "Knowledge Check Questions",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _quizQuestions.length,
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, qIdx) {
              final q = _quizQuestions[qIdx];
              final options = q["options"] as List<String>;
              final correct = q["correct"] as int;
              final selected = _selectedAnswers[qIdx];

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
                    Text(
                      "${qIdx + 1}. ${q["question"]}",
                      style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(options.length, (optIdx) {
                      final isChosen = selected == optIdx;
                      final isAnswerCorrect = selected != null && optIdx == correct;
                      final isAnswerWrong = selected != null && isChosen && optIdx != correct;

                      Color bg = const Color(0xFFF8FAFC);
                      Color borderColor = const Color(0xFFE2E8F0);
                      if (isAnswerCorrect) {
                        bg = const Color(0xFFECFDF5);
                        borderColor = const Color(0xFF10B981);
                      } else if (isAnswerWrong) {
                        bg = const Color(0xFFFEF2F2);
                        borderColor = const Color(0xFFEF4444);
                      }

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedAnswers[qIdx] = optIdx;
                          });
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            children: [
                              Text(
                                String.fromCharCode(65 + optIdx),
                                style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  options[optIdx],
                                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
                                ),
                              ),
                              if (isAnswerCorrect)
                                const Icon(Icons.check_circle_rounded, size: 15, color: Color(0xFF10B981)),
                              if (isAnswerWrong)
                                const Icon(Icons.cancel_rounded, size: 15, color: Color(0xFFEF4444)),
                            ],
                          ),
                        ),
                      );
                    }),
                    if (selected != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        "Explanation: ${q["explanation"]}",
                        style: GoogleFonts.poppins(fontSize: 11, fontStyle: FontStyle.italic, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      );
    }

    // Default: Summarise / Extract key concepts / Explain simply
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedTask == "Extract key concepts"
                    ? "Extracted Knowledge Overview"
                    : _selectedTask == "Explain simply"
                        ? "Simplified Breakdown"
                        : "Executive Summary",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _generatedSummary,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF334155),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        Text(
          _selectedTask == "Extract key concepts"
              ? "Key Defined Concepts"
              : "Core Principles & Takeaways",
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        ..._keyTakeaways.map((point) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Icon(Icons.circle, size: 6, color: Color(0xFF4F46E5)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF475569),
                      height: 1.45,
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
}

// =============================================================================
// SUBTLE GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  const _GridPaperPainter({required this.gridColor, this.step = 28.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}

