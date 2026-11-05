import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ASSESSMENT: QUESTION BANK SCREEN
// Matches screenshot: Blueprint grid hero banner with "Generate with AI" & "+ Add question"
// action buttons, status pills (All 10 / Active 10 / Draft 0 / Archived 0),
// search bar with "10 records" counter, and 10-column data table.
// =============================================================================
class QuestionBankScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const QuestionBankScreen({super.key, this.onBack});

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  String _activeStatus = "All"; // "All", "Active", "Draft", "Archived"
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _questions = [
    {
      "id": "Q-1049",
      "question":
          "Explain the differences between clustered and non-clustered indexes in PostgreSQL.",
      "topic": "Indexing",
      "difficulty": "Medium",
      "bloom": "Understand",
      "co": "CO1",
      "marks": "5",
      "status": "Active",
      "updated": "23 Sept 2026",
    },
    {
      "id": "Q-1048",
      "question":
          "Discuss conflict serializability and precedence graphs for schedule verification.",
      "topic": "Transactions",
      "difficulty": "Hard",
      "bloom": "Analyse",
      "co": "CO4",
      "marks": "10",
      "status": "Active",
      "updated": "22 Sept 2026",
    },
    {
      "id": "Q-1047",
      "question":
          "Write an optimized SQL query to find the second-highest salary without using LIMIT.",
      "topic": "SQL",
      "difficulty": "Medium",
      "bloom": "Apply",
      "co": "CO3",
      "marks": "4",
      "status": "Active",
      "updated": "21 Sept 2026",
    },
    {
      "id": "Q-1046",
      "question":
          "Construct a B+ tree for keys [10, 20, 5, 15, 30, 25] with order 3.",
      "topic": "Indexing",
      "difficulty": "Hard",
      "bloom": "Apply",
      "co": "CO3",
      "marks": "10",
      "status": "Active",
      "updated": "20 Sept 2026",
    },
    {
      "id": "Q-1045",
      "question":
          "Define functional dependency and state Armstrong axioms with examples.",
      "topic": "Normalization",
      "difficulty": "Medium",
      "bloom": "Remember",
      "co": "CO2",
      "marks": "4",
      "status": "Active",
      "updated": "19 Sept 2026",
    },
    {
      "id": "Q-1044",
      "question":
          "Explain lossless-join decomposition and provide conditions to verify it.",
      "topic": "Normalization",
      "difficulty": "Hard",
      "bloom": "Apply",
      "co": "CO4",
      "marks": "8",
      "status": "Active",
      "updated": "18 Sept 2026",
    },
    {
      "id": "Q-1043",
      "question":
          "Differentiate between B-Tree and B+ Tree indexing with disk I/O cost analysis.",
      "topic": "Indexing",
      "difficulty": "Medium",
      "bloom": "Understand",
      "co": "CO1",
      "marks": "6",
      "status": "Active",
      "updated": "17 Sept 2026",
    },
    {
      "id": "Q-1042",
      "question":
          "Demonstrate multi-version concurrency control (MVCC) isolation levels.",
      "topic": "Transactions",
      "difficulty": "Hard",
      "bloom": "Analyse",
      "co": "CO4",
      "marks": "12",
      "status": "Active",
      "updated": "16 Sept 2026",
    },
    {
      "id": "Q-1041",
      "question":
          "Perform canonical cover synthesis for a set of functional dependencies.",
      "topic": "Normalization",
      "difficulty": "Medium",
      "bloom": "Apply",
      "co": "CO2",
      "marks": "7",
      "status": "Active",
      "updated": "15 Sept 2026",
    },
    {
      "id": "Q-1040",
      "question":
          "Write ACID compliant transaction blocks using savepoints in PL/pgSQL.",
      "topic": "SQL",
      "difficulty": "Easy",
      "bloom": "Apply",
      "co": "CO3",
      "marks": "5",
      "status": "Active",
      "updated": "14 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredQuestions {
    final query = _searchController.text.trim().toLowerCase();
    return _questions.where((q) {
      if (_activeStatus != "All" && q["status"] != _activeStatus) {
        return false;
      }
      if (query.isNotEmpty) {
        final id = (q["id"] ?? "").toString().toLowerCase();
        final text = (q["question"] ?? "").toString().toLowerCase();
        final topic = (q["topic"] ?? "").toString().toLowerCase();
        return id.contains(query) || text.contains(query) || topic.contains(query);
      }
      return true;
    }).toList();
  }

  int _countForStatus(String status) {
    if (status == "All") return _questions.length;
    return _questions.where((q) => q["status"] == status).length;
  }

  void _openAddQuestionDialog() {
    final questionController = TextEditingController();
    final topicController = TextEditingController(text: "Indexing");
    final marksController = TextEditingController(text: "5");
    String difficulty = "Medium";
    String bloom = "Understand";
    String co = "CO1";

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(
                "Add New Question",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Question Statement", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: questionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Enter full problem statement...",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Topic", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              TextField(
                                controller: topicController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Marks", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              TextField(
                                controller: marksController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Difficulty", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                isExpanded: true,
                                initialValue: difficulty,
                                items: ["Easy", "Medium", "Hard"]
                                    .map((d) => DropdownMenuItem(value: d, child: Text(d, style: GoogleFonts.poppins(fontSize: 12))))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) setModalState(() => difficulty = v);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bloom Level", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                isExpanded: true,
                                initialValue: bloom,
                                items: ["Remember", "Understand", "Apply", "Analyse", "Evaluate"]
                                    .map((b) => DropdownMenuItem(value: b, child: Text(b, style: GoogleFonts.poppins(fontSize: 12))))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) setModalState(() => bloom = v);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (questionController.text.trim().isNotEmpty) {
                      final newId = "Q-${1050 + _questions.length}";
                      setState(() {
                        _questions.insert(0, {
                          "id": newId,
                          "question": questionController.text.trim(),
                          "topic": topicController.text.trim(),
                          "difficulty": difficulty,
                          "bloom": bloom,
                          "co": co,
                          "marks": marksController.text.trim(),
                          "status": "Active",
                          "updated": "Today",
                        });
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Question $newId added to repository."),
                          backgroundColor: const Color(0xFF15803D),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141938),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Add Question"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openAiGenerateDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, color: Color(0xFF4F46E5), size: 20),
              const SizedBox(width: 8),
              Text(
                "Generate with AI",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI will synthesize high-quality questions according to Bloom's Taxonomy standards and course outcomes.",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 14),
              Text("Topic: Relational Query Optimization (CO4)", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  "\"Given an SQL query with multiple joins, draw the relational algebra heuristic tree and push selection down to minimize intermediate tuple sizes.\"",
                  style: GoogleFonts.spaceMono(fontSize: 11, color: const Color(0xFF334155)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Dismiss"),
            ),
            ElevatedButton(
              onPressed: () {
                final newId = "Q-${1050 + _questions.length}";
                setState(() {
                  _questions.insert(0, {
                    "id": newId,
                    "question":
                        "Given an SQL query with multiple joins, draw the relational algebra heuristic tree and push selection down to minimize intermediate tuple sizes.",
                    "topic": "Query Optimization",
                    "difficulty": "Hard",
                    "bloom": "Analyse",
                    "co": "CO4",
                    "marks": "10",
                    "status": "Active",
                    "updated": "Today",
                  });
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("AI generated question $newId inserted into Question Bank."),
                    backgroundColor: const Color(0xFF15803D),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
              child: const Text("Approve & Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. Status Filter Pills
              _buildStatusPills(),
              const SizedBox(height: 16),

              // 3. Main Card with Search Bar & Data Table
              _buildTableCard(),
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
                  Icons.layers_rounded,
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
                          "Question Bank",
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

                  // Badges + Title Row + Actions Row
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 760;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Stack Icon Box
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
                                Icons.layers_rounded,
                                color: Color(0xFFFBBF24),
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Title and Badges
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      "MVP",
                                      backgroundColor: const Color(0xFF0F766E),
                                      textColor: const Color(0xFFCCFBF1),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Question Bank",
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

                          // Top-right Action Buttons (matching screenshot)
                          if (isWide) ...[
                            const SizedBox(width: 12),
                            _buildHeroBannerActions(),
                          ],
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    "Tagged questions by topic, difficulty, Bloom level and course outcome.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  // Narrow screen banner actions
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 760) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: _buildHeroBannerActions(),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBannerActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // "Generate with AI" (White button with sparkle icon)
        ElevatedButton.icon(
          onPressed: _openAiGenerateDialog,
          icon: const Icon(
            Icons.auto_awesome_rounded,
            size: 15,
            color: Color(0xFF1E293B),
          ),
          label: Text(
            "Generate with AI",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF1E293B),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // "+ Add question" (Amber/orange button)
        ElevatedButton.icon(
          onPressed: _openAddQuestionDialog,
          icon: const Icon(
            Icons.add_rounded,
            size: 16,
            color: Color(0xFF1E293B),
          ),
          label: Text(
            "Add question",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFBBF24),
            foregroundColor: const Color(0xFF1E293B),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. STATUS FILTER PILLS (All 10 / Active 10 / Draft 0 / Archived 0)
  // ===========================================================================
  Widget _buildStatusPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatusPillItem("All"),
          const SizedBox(width: 10),
          _buildStatusPillItem("Active"),
          const SizedBox(width: 10),
          _buildStatusPillItem("Draft"),
          const SizedBox(width: 10),
          _buildStatusPillItem("Archived"),
        ],
      ),
    );
  }

  Widget _buildStatusPillItem(String label) {
    final isSelected = _activeStatus == label;
    final count = _countForStatus(label);

    return InkWell(
      onTap: () => setState(() => _activeStatus = label),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141938) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF141938).withValues(alpha: 0.15),
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
                color: isSelected ? Colors.white : const Color(0xFF334155),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "$count",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF93C5FD) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN TABLE CARD
  // ===========================================================================
  Widget _buildTableCard() {
    final filtered = _filteredQuestions;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search row + record count
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFD),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      const Icon(Icons.search_rounded, size: 18, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.poppins(fontSize: 12.5),
                          decoration: InputDecoration(
                            hintText: "Search by name, ID or topic...",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF94A3B8),
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 16),
                          onPressed: () => setState(() => _searchController.clear()),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "${filtered.length} records",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Scrollable Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1050),
              child: DataTable(
                dataRowMinHeight: 64,
                dataRowMaxHeight: 74,
                headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                dataTextStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF1E293B),
                ),
                horizontalMargin: 12,
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("QUESTION")),
                  DataColumn(label: Text("TOPIC")),
                  DataColumn(label: Text("DIFFICULTY")),
                  DataColumn(label: Text("BLOOM LEVEL")),
                  DataColumn(label: Text("COURSE OUTCOME")),
                  DataColumn(label: Text("MARKS")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("UPDATED")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: filtered.map((q) {
                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          q["id"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // QUESTION
                      DataCell(
                        SizedBox(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                q["question"]!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "...more",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  color: const Color(0xFF3B82F6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // TOPIC
                      DataCell(
                        Text(
                          q["topic"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // DIFFICULTY
                      DataCell(_buildDifficultyBadge(q["difficulty"]!)),

                      // BLOOM LEVEL
                      DataCell(_buildBloomBadge(q["bloom"]!)),

                      // COURSE OUTCOME
                      DataCell(
                        Text(
                          q["co"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // MARKS
                      DataCell(
                        Text(
                          q["marks"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),

                      // STATUS
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            q["status"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF15803D),
                            ),
                          ),
                        ),
                      ),

                      // UPDATED
                      DataCell(
                        Text(
                          q["updated"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),

                      // ACTIONS
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF64748B)),
                              onPressed: () {
                                _showQuestionDetails(q);
                              },
                              tooltip: "View Details",
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF4338CA)),
                              onPressed: () {
                                _showEditQuestionDialog(q);
                              },
                              tooltip: "Edit Question",
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFFEF4444)),
                              onPressed: () {
                                _showDeleteQuestionDialog(q);
                              },
                              tooltip: "Delete Question",
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditQuestionDialog(Map<String, dynamic> q) {
    final questionCtrl = TextEditingController(text: q["question"]);
    final topicCtrl = TextEditingController(text: q["topic"]);
    final marksCtrl = TextEditingController(text: q["marks"]);
    String difficulty = q["difficulty"] ?? "Medium";
    String bloom = q["bloom"] ?? "Apply";
    String co = q["co"] ?? "CO3";
    String status = q["status"] ?? "Active";

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text("Edit Question ${q["id"]}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: questionCtrl,
                        maxLines: 3,
                        decoration: const InputDecoration(labelText: "Question Text"),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: topicCtrl,
                        decoration: const InputDecoration(labelText: "Topic"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              initialValue: difficulty,
                              decoration: const InputDecoration(labelText: "Difficulty"),
                              items: ["Easy", "Medium", "Hard"]
                                  .map((d) => DropdownMenuItem(value: d, child: Text(d, style: GoogleFonts.poppins(fontSize: 12))))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setDlgState(() => difficulty = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              initialValue: bloom,
                              decoration: const InputDecoration(labelText: "Bloom Level"),
                              items: ["Remember", "Understand", "Apply", "Analyze", "Evaluate", "Create"]
                                  .map((b) => DropdownMenuItem(value: b, child: Text(b, style: GoogleFonts.poppins(fontSize: 12))))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setDlgState(() => bloom = val);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              initialValue: co,
                              decoration: const InputDecoration(labelText: "Course Outcome"),
                              items: ["CO1", "CO2", "CO3", "CO4", "CO5"]
                                  .map((c) => DropdownMenuItem(value: c, child: Text(c, style: GoogleFonts.poppins(fontSize: 12))))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setDlgState(() => co = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: marksCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: "Marks"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: status,
                        decoration: const InputDecoration(labelText: "Status"),
                        items: ["Active", "Archived"]
                            .map((s) => DropdownMenuItem(value: s, child: Text(s, style: GoogleFonts.poppins(fontSize: 12))))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setDlgState(() => status = val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      q["question"] = questionCtrl.text.trim();
                      q["topic"] = topicCtrl.text.trim();
                      q["marks"] = marksCtrl.text.trim();
                      q["difficulty"] = difficulty;
                      q["bloom"] = bloom;
                      q["co"] = co;
                      q["status"] = status;
                      q["updated"] = "Today";
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Question ${q["id"]} updated successfully!"),
                        backgroundColor: const Color(0xFF0F766E),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141938),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save Changes"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteQuestionDialog(Map<String, dynamic> q) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Delete Question ${q["id"]}?", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: Text(
            "Are you sure you want to delete this question? It will be removed from your repository.",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final removed = Map<String, dynamic>.from(q);
                final index = _questions.indexOf(q);
                setState(() {
                  _questions.remove(q);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Question ${removed["id"]} removed."),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: const Color(0xFFFBBF24),
                      onPressed: () {
                        setState(() {
                          _questions.insert(index >= 0 ? index : 0, removed);
                        });
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showQuestionDetails(Map<String, dynamic> q) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "${q["id"]} · ${q["topic"]}",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              q["question"]!,
              style: GoogleFonts.poppins(fontSize: 13, height: 1.5, color: const Color(0xFF1E293B)),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _buildDifficultyBadge(q["difficulty"]!),
                _buildBloomBadge(q["bloom"]!),
                _buildPillBadge(q["co"]!, backgroundColor: const Color(0xFFEEF2FF), textColor: const Color(0xFF4F46E5)),
                _buildPillBadge("${q["marks"]} Marks", backgroundColor: const Color(0xFFF1F5F9), textColor: const Color(0xFF334155)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyBadge(String difficulty) {
    Color bg;
    Color fg;
    if (difficulty == "Hard") {
      bg = const Color(0xFFFEE2E2);
      fg = const Color(0xFFDC2626);
    } else if (difficulty == "Medium") {
      bg = const Color(0xFFFEF3C7);
      fg = const Color(0xFFD97706);
    } else {
      bg = const Color(0xFFDCFCE7);
      fg = const Color(0xFF15803D);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        difficulty,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  Widget _buildBloomBadge(String bloom) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        bloom,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF4338CA),
        ),
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
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
