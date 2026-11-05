import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// AI COURSE & CERTIFICATION: AI QUIZ BUILDER SCREEN
// Matches screenshot 4: Blueprint grid hero banner, disclaimer banner,
// 4 metric cards (Quizzes 3, Published 3, Attempts 0, Average score 0%),
// search bar, department dropdown, filter pills (All / Published / Draft / Closed),
// "+ New AI quiz" button, and table with 3 departmental quizzes.
// =============================================================================
class AiQuizBuilderScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiQuizBuilderScreen({super.key, this.onBack});

  @override
  State<AiQuizBuilderScreen> createState() => _AiQuizBuilderScreenState();
}

class _AiQuizBuilderScreenState extends State<AiQuizBuilderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDept = "All departments (3)";
  String _activeFilter = "All"; // "All", "Published", "Draft", "Closed"

  final List<Map<String, dynamic>> _quizzes = [
    {
      "title": "Placement aptitude — quantitative",
      "dept": "Training & Placement",
      "duration": "10 min",
      "hasCert": true,
      "questions": "3",
      "passMark": "60%",
      "students": "0",
      "average": "—",
      "passRate": "—",
      "status": "Published",
    },
    {
      "title": "Computer Science & Engineering — Unit test 1",
      "dept": "Computer Science & Engineering",
      "duration": "15 min",
      "hasCert": true,
      "questions": "6",
      "passMark": "50%",
      "students": "0",
      "average": "—",
      "passRate": "—",
      "status": "Published",
    },
    {
      "title": "Electronics & Communication — Certification quiz",
      "dept": "Electronics & Communication",
      "duration": "15 min",
      "hasCert": true,
      "questions": "5",
      "passMark": "50%",
      "students": "0",
      "average": "—",
      "passRate": "—",
      "status": "Published",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredQuizzes {
    final query = _searchController.text.trim().toLowerCase();
    return _quizzes.where((q) {
      if (_activeFilter != "All" && q["status"] != _activeFilter) {
        return false;
      }
      if (query.isNotEmpty) {
        final title = (q["title"] ?? "").toString().toLowerCase();
        final dept = (q["dept"] ?? "").toString().toLowerCase();
        return title.contains(query) || dept.contains(query);
      }
      return true;
    }).toList();
  }

  int get _publishedCount =>
      _quizzes.where((q) => q["status"] == "Published").length;

  void _openNewQuizDialog() {
    final titleController = TextEditingController();
    final deptController = TextEditingController(text: "Computer Science & Engineering");
    final countController = TextEditingController(text: "5");
    final passController = TextEditingController(text: "60%");

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Generate AI Quiz",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quiz Title", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "e.g. Operating Systems Concurrency & Deadlocks",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text("Department", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: deptController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Questions", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: countController,
                            keyboardType: TextInputType.number,
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
                          Text("Pass Mark", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: passController,
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
                if (titleController.text.trim().isNotEmpty) {
                  setState(() {
                    _quizzes.insert(0, {
                      "title": titleController.text.trim(),
                      "dept": deptController.text.trim(),
                      "duration": "15 min",
                      "hasCert": true,
                      "questions": countController.text.trim(),
                      "passMark": passController.text.trim(),
                      "students": "0",
                      "average": "—",
                      "passRate": "—",
                      "status": "Published",
                    });
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("AI Quiz generated and published!"),
                      backgroundColor: Color(0xFF15803D),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
              ),
              child: const Text("Create Quiz"),
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
          final isNarrow = constraints.maxWidth < 800;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 14),

              // 2. Info Alert Banner
              _buildDisclaimerAlert(),
              const SizedBox(height: 18),

              // 3. 4 Metric Cards
              if (isNarrow)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.quiz_outlined,
                            title: "Quizzes",
                            value: "${_quizzes.length}",
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.check_circle_outline_rounded,
                            title: "Published",
                            value: "$_publishedCount",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.people_outline_rounded,
                            title: "Attempts",
                            value: "0",
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.analytics_outlined,
                            title: "Average score",
                            value: "0%",
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.quiz_outlined,
                        title: "Quizzes",
                        value: "${_quizzes.length}",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.check_circle_outline_rounded,
                        title: "Published",
                        value: "$_publishedCount",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.people_outline_rounded,
                        title: "Attempts",
                        value: "0",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.analytics_outlined,
                        title: "Average score",
                        value: "0%",
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),

              // 4. Main Card: Department Quizzes
              _buildQuizzesCard(),
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
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.assignment_turned_in_rounded,
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
                          "AI Course & Certification",
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
                          "AI Quiz Builder",
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                            Icons.assignment_turned_in_rounded,
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
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "AI COURSE & CERTIFICATION",
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
                              "AI Quiz Builder",
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

                  Text(
                    "Generate department MCQs, edit them, set pass mark and time, enable certificates and track results.",
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
              "Review every AI-generated question and answer key before publishing. Questions marked \"review\" were built from templates.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. METRIC CARDS
  // ===========================================================================
  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. MAIN CARD: DEPARTMENT QUIZZES
  // ===========================================================================
  Widget _buildQuizzesCard() {
    final filtered = _filteredQuizzes;

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
          // Header row with + New AI quiz button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Department quizzes",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Server-scored · students never receive the answer key",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              ElevatedButton.icon(
                onPressed: _openNewQuizDialog,
                icon: const Icon(Icons.auto_awesome_rounded, size: 16),
                label: Text(
                  "New AI quiz",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search + Dropdown + Filter Pills Row
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 760;
              final searchField = Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFD),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: "Search quizzes...",
                          hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
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
                  ],
                ),
              );

              final deptDropdown = Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDept,
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
                    items: ["All departments (3)", "Computer Science & Engineering", "Electronics & Communication", "Training & Placement"]
                        .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedDept = val);
                    },
                  ),
                ),
              );

              final pills = Row(
                children: [
                  _buildFilterPill("All"),
                  const SizedBox(width: 6),
                  _buildFilterPill("Published"),
                  const SizedBox(width: 6),
                  _buildFilterPill("Draft"),
                  const SizedBox(width: 6),
                  _buildFilterPill("Closed"),
                ],
              );

              if (isWide) {
                return Row(
                  children: [
                    Expanded(flex: 3, child: searchField),
                    const SizedBox(width: 10),
                    deptDropdown,
                    const SizedBox(width: 10),
                    pills,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  searchField,
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: deptDropdown),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: pills,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Horizontally Scrollable Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1000),
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
                columnSpacing: 22,
                columns: const [
                  DataColumn(label: Text("QUIZ")),
                  DataColumn(label: Text("QUESTIONS")),
                  DataColumn(label: Text("PASS MARK")),
                  DataColumn(label: Text("STUDENTS")),
                  DataColumn(label: Text("AVERAGE")),
                  DataColumn(label: Text("PASS RATE")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: filtered.map((quiz) {
                  return DataRow(
                    cells: [
                      // QUIZ
                      DataCell(
                        SizedBox(
                          width: 290,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                quiz["title"],
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${quiz["dept"]} · ${quiz["duration"]} · ${quiz["hasCert"] ? "certificate" : ""}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // QUESTIONS
                      DataCell(Text(quiz["questions"])),

                      // PASS MARK
                      DataCell(Text(quiz["passMark"])),

                      // STUDENTS
                      DataCell(Text(quiz["students"])),

                      // AVERAGE
                      DataCell(Text(quiz["average"])),

                      // PASS RATE
                      DataCell(Text(quiz["passRate"])),

                      // STATUS
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: quiz["status"] == "Active" ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            quiz["status"],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: quiz["status"] == "Active" ? const Color(0xFF15803D) : const Color(0xFF92400E),
                            ),
                          ),
                        ),
                      ),

                      // ACTIONS
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _showQuizResultsDialog(quiz),
                              icon: const Icon(Icons.analytics_outlined, size: 14),
                              label: const Text("Results"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF334155),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(width: 6),
                            OutlinedButton.icon(
                              onPressed: () => _showEditQuizDialog(quiz),
                              icon: const Icon(Icons.edit_outlined, size: 14),
                              label: const Text("Edit"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF4338CA),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(width: 6),
                            OutlinedButton(
                              onPressed: () {
                                final isNowClosed = quiz["status"] == "Active";
                                setState(() {
                                  quiz["status"] = isNowClosed ? "Closed" : "Active";
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${quiz["title"]} is now ${quiz["status"]}"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                side: BorderSide(
                                  color: quiz["status"] == "Active" ? const Color(0xFFCBD5E1) : const Color(0xFF15803D),
                                ),
                                foregroundColor: quiz["status"] == "Active" ? const Color(0xFF334155) : const Color(0xFF15803D),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(quiz["status"] == "Active" ? "Close" : "Reopen"),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFFEF4444)),
                              onPressed: () => _showDeleteQuizDialog(quiz),
                              tooltip: "Delete Quiz",
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

  void _showQuizResultsDialog(Map<String, dynamic> quiz) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.analytics_rounded, color: Color(0xFF2563EB), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quiz Analytics & Results", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(quiz["title"], style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQuizResultRow("Department", quiz["dept"]),
                _buildQuizResultRow("Total Questions", "${quiz["questions"]} Questions"),
                _buildQuizResultRow("Duration", quiz["duration"]),
                _buildQuizResultRow("Pass Mark", "${quiz["passMark"]} / 100"),
                _buildQuizResultRow("Total Students Attempted", "${quiz["students"]} Students"),
                _buildQuizResultRow("Class Average Score", quiz["average"], highlightColor: const Color(0xFF2563EB)),
                _buildQuizResultRow("Overall Pass Rate", quiz["passRate"], highlightColor: const Color(0xFF15803D)),
                _buildQuizResultRow("Certificate Enabled", quiz["hasCert"] ? "Yes (QR Verifiable)" : "No"),
                _buildQuizResultRow("Current Status", quiz["status"]),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
              ),
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuizResultRow(String label, String value, {Color? highlightColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
          const SizedBox(width: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: highlightColor ?? const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditQuizDialog(Map<String, dynamic> quiz) {
    final titleCtrl = TextEditingController(text: quiz["title"]);
    final questionsCtrl = TextEditingController(text: quiz["questions"]);
    final passMarkCtrl = TextEditingController(text: quiz["passMark"]);
    final durationCtrl = TextEditingController(text: quiz["duration"]);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Edit Quiz Settings", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Quiz Title"),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: questionsCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Questions Count"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: passMarkCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Pass Mark (%)"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: durationCtrl,
                  decoration: const InputDecoration(labelText: "Duration (e.g. 45 min)"),
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
                setState(() {
                  quiz["title"] = titleCtrl.text.trim();
                  quiz["questions"] = questionsCtrl.text.trim();
                  quiz["passMark"] = passMarkCtrl.text.trim();
                  quiz["duration"] = durationCtrl.text.trim();
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Quiz '${quiz["title"]}' updated successfully!"),
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
  }

  void _showDeleteQuizDialog(Map<String, dynamic> quiz) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Delete Quiz?", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: Text(
            "Are you sure you want to delete '${quiz["title"]}'? All associated results and questions will be permanently removed.",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final removed = Map<String, dynamic>.from(quiz);
                final index = _quizzes.indexOf(quiz);
                setState(() {
                  _quizzes.remove(quiz);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Quiz '${removed["title"]}' deleted"),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: const Color(0xFFFBBF24),
                      onPressed: () {
                        setState(() {
                          _quizzes.insert(index >= 0 ? index : 0, removed);
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

  Widget _buildFilterPill(String label) {
    final isSelected = _activeFilter == label;
    return InkWell(
      onTap: () => setState(() => _activeFilter = label),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141938) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
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
