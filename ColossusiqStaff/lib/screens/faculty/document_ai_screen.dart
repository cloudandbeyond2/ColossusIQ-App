import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ACADEMICS: DOCUMENT AI SCREEN
// Matches screenshot: Hero blueprint grid banner, Inputs card with dropdown,
// paste textarea, and Output card with blueprint grid empty/generated state.
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
  ];

  String _generatedSummary = "";
  List<String> _keyTakeaways = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _processDocument() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      // Load sample text for demonstration if empty
      _textController.text =
          "Database Normalization is the process of structuring a relational database in accordance with a series of normal forms to reduce data redundancy and improve data integrity. First Normal Form (1NF) enforces atomic values and unique records. Second Normal Form (2NF) eliminates partial functional dependencies. Third Normal Form (3NF) eliminates transitive functional dependencies. Boyce-Codd Normal Form (BCNF) strictly requires every determinant to be a candidate key.";
    }

    setState(() {
      _isProcessing = true;
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _hasGenerated = true;
        _generatedSummary =
            "Normalization progressively organizes relational schemas to eliminate redundancy and update anomalies while preserving functional dependencies across 1NF, 2NF, 3NF and BCNF.";
        _keyTakeaways = [
          "1NF requires attribute values to be atomic with no repeating groups.",
          "2NF mandates that all non-prime attributes are fully functionally dependent on the primary key.",
          "3NF eliminates transitive dependencies (no non-key attribute depends on another non-key).",
          "BCNF is a stricter variant where every determinant must be a super key.",
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Top Hero Banner
              _buildHeroBanner(),
              const SizedBox(height: 20),

              // 2. Main Split View: Inputs & Output
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 380,
                      child: _buildInputsCard(),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _buildOutputCard(),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildInputsCard(),
                    const SizedBox(height: 18),
                    _buildOutputCard(),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BANNER
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

            // Large decorative document watermark on the right
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.description_rounded,
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
                  // Breadcrumb row (Home clickable)
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
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Academics",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Document AI",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Main Title & Icon row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document icon rounded container
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2865).withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF3B487A),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.article_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title + Badges + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2352),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF38467D), width: 1),
                                  ),
                                  child: Text(
                                    "ACADEMICS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "Phase 2",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "Document AI",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),

                            // Subtitle description
                            Text(
                              "Upload PDFs, slides or scanned notes — summarise, extract, generate flashcards and questions.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFFC7D2FE).withValues(alpha: 0.9),
                                height: 1.35,
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
  // 2. INPUTS CARD
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
                  if (val != null) setState(() => _selectedTask = val);
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
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    hintText: "Paste notes or a section of a chapter...",
                    hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
                // Corner drag indicator icon like in screenshot
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
                  : const Icon(Icons.auto_awesome_rounded, size: 16),
              label: Text(
                _isProcessing ? "Processing..." : "Process document",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
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
  // 3. OUTPUT CARD
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
                        Clipboard.setData(ClipboardData(text: _generatedSummary));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Output copied to clipboard!")),
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
                          const SnackBar(content: Text("Draft exported as PDF successfully.")),
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 14),
                      label: const Text("Export Draft"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF141938),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        minimumSize: Size.zero,
                        textStyle: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                      ),
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

                  // Content
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Executive Summary",
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
                                        fontSize: 12,
                                        color: const Color(0xFF334155),
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),

                              Text(
                                "Key Extracted Principles",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ..._keyTakeaways.map((point) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
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
                                            fontSize: 12,
                                            color: const Color(0xFF475569),
                                            height: 1.4,
                                          ),
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
            ),
          ),
        ],
      ),
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
