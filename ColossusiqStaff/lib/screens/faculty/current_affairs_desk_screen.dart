import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ASSESSMENT: CURRENT AFFAIRS DESK SCREEN
// Matches screenshot: Blueprint grid hero banner, 3 metric cards
// (Published / Drafts / Quiz questions this week), filter pills (All / Published / Drafts),
// action button "+ New item", and blueprint graph paper empty state.
// =============================================================================
class CurrentAffairsDeskScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CurrentAffairsDeskScreen({super.key, this.onBack});

  @override
  State<CurrentAffairsDeskScreen> createState() =>
      _CurrentAffairsDeskScreenState();
}

class _CurrentAffairsDeskScreenState extends State<CurrentAffairsDeskScreen> {
  String _activeFilter = "All"; // "All", "Published", "Drafts"

  final List<Map<String, dynamic>> _items = [];

  int get _publishedCount =>
      _items.where((i) => i["status"] == "Published").length;
  int get _draftCount =>
      _items.where((i) => i["status"] == "Draft").length;
  int get _quizQuestionsCount =>
      _items.where((i) => (i["hasQuiz"] as bool? ?? false)).length;

  List<Map<String, dynamic>> get _filteredItems {
    if (_activeFilter == "All") return _items;
    return _items.where((i) => i["status"] == _activeFilter).toList();
  }

  void _openCreateItemDialog() {
    final titleController = TextEditingController();
    final summaryController = TextEditingController();
    final quizController = TextEditingController();
    String itemStatus = "Published";

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Add Daily Current Affairs Item",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Headline / Topic",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "e.g. India Semiconductor Mission R&D Grant",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Context / Summary (2-3 lines)",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: summaryController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Key facts for civil service & competitive exams...",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Associated Quiz Question (Optional)",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: quizController,
                      decoration: InputDecoration(
                        hintText: "e.g. Which ministry spearheads ISM?",
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "Status: ",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text("Published"),
                          selected: itemStatus == "Published",
                          onSelected: (val) {
                            if (val) setModalState(() => itemStatus = "Published");
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text("Draft"),
                          selected: itemStatus == "Draft",
                          onSelected: (val) {
                            if (val) setModalState(() => itemStatus = "Draft");
                          },
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
                        _items.insert(0, {
                          "title": titleController.text.trim(),
                          "summary": summaryController.text.trim(),
                          "status": itemStatus,
                          "hasQuiz": quizController.text.trim().isNotEmpty,
                          "quiz": quizController.text.trim(),
                          "date": "Today, 14 Oct 2026",
                        });
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            itemStatus == "Published"
                                ? "Current affairs item published!"
                                : "Item saved as draft.",
                          ),
                          backgroundColor: itemStatus == "Published"
                              ? const Color(0xFF15803D)
                              : const Color(0xFF475569),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141938),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save Item"),
                ),
              ],
            );
          },
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
          final isNarrow = constraints.maxWidth < 750;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. 3 Metric Tiles
              if (isNarrow)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMetricCard(
                      value: "$_publishedCount",
                      title: "Published",
                    ),
                    const SizedBox(height: 12),
                    _buildMetricCard(
                      value: "$_draftCount",
                      title: "Drafts",
                    ),
                    const SizedBox(height: 12),
                    _buildMetricCard(
                      value: "$_quizQuestionsCount",
                      title: "Quiz questions this week",
                      subtitle: "Students need at least 3 for the weekly quiz",
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        value: "$_publishedCount",
                        title: "Published",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        value: "$_draftCount",
                        title: "Drafts",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        value: "$_quizQuestionsCount",
                        title: "Quiz questions this week",
                        subtitle: "Students need at least 3 for the weekly quiz",
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 18),

              // 3. Main Items Card
              _buildItemsCard(),
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
                  Icons.newspaper_rounded,
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
                          "Current Affairs Desk",
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
                      // Document icon box
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
                            Icons.newspaper_rounded,
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
                                  "MVP",
                                  backgroundColor: const Color(0xFF0F766E),
                                  textColor: const Color(0xFFCCFBF1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "Current Affairs Desk",
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
                    "Curate daily current-affairs items and quiz questions for students preparing for competitive exams.",
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
  // 2. METRIC CARDS
  // ===========================================================================
  Widget _buildMetricCard({
    required String value,
    required String title,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN ITEMS CARD
  // ===========================================================================
  Widget _buildItemsCard() {
    final filtered = _filteredItems;

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
      padding: const EdgeInsets.all(22),
      child: Column(
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
                      "Items",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Newest first. Students see published items dated today or earlier.",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Filter Pills: All / Published / Drafts
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterPill("All"),
                          const SizedBox(width: 8),
                          _buildFilterPill("Published"),
                          const SizedBox(width: 8),
                          _buildFilterPill("Drafts"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              ElevatedButton.icon(
                onPressed: _openCreateItemDialog,
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  "New item",
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
          const SizedBox(height: 20),

          // Content Area
          if (filtered.isEmpty)
            // Empty State (Matches screenshot blueprint graph paper container)
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 280),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFD),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GridPaperPainter(
                          gridColor: const Color(0xFFE2E8F0).withValues(alpha: 0.7),
                          step: 24.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Nothing here yet",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Add a short daily item: a headline, two or three lines of context\nand, ideally, one quiz question.",
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
            // Populated State
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = filtered[index];
                final isPublished = item["status"] == "Published";
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isPublished ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        isPublished ? Icons.article_rounded : Icons.edit_note_rounded,
                        color: isPublished ? const Color(0xFF15803D) : const Color(0xFF64748B),
                        size: 22,
                      ),
                    ),
                  ),
                  title: Text(
                    item["title"],
                    style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item["summary"] != null && item["summary"].toString().isNotEmpty)
                        Text(
                          item["summary"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569)),
                        ),
                      const SizedBox(height: 2),
                      Text(
                        "${item["date"]} · ${item["hasQuiz"] == true ? "Includes Quiz Question" : "No Quiz"}",
                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPublished ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item["status"],
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: isPublished ? const Color(0xFF15803D) : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label) {
    final isSelected = _activeFilter == label;
    return InkWell(
      onTap: () => setState(() => _activeFilter = label),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141938) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
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
