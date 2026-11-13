import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DATA MODEL: CURRENT AFFAIRS ITEM
// =============================================================================
class CurrentAffairsItem {
  String id;
  String date;
  String category;
  String headline;
  String summary;
  String sourceName;
  String? sourceLink;
  String author;
  String status; // "Published" or "Draft"
  List<String> usefulFor;
  bool hasQuiz;
  String? quizQuestion;
  List<String> quizOptions;
  int correctOptionIndex;
  String? quizExplanation;

  CurrentAffairsItem({
    required this.id,
    required this.date,
    required this.category,
    required this.headline,
    required this.summary,
    required this.sourceName,
    this.sourceLink,
    this.author = 'By Dr. Meena Raghavan',
    this.status = 'Published',
    this.usefulFor = const [],
    this.hasQuiz = false,
    this.quizQuestion,
    List<String>? quizOptions,
    this.correctOptionIndex = 0,
    this.quizExplanation,
  }) : quizOptions = quizOptions ?? ['', '', '', ''];
}

// =============================================================================
// ASSESSMENT: CURRENT AFFAIRS DESK SCREEN
// Matches Screenshot 1, 2, 3, 4:
// 1. Hero blueprint banner with ASSESSMENT & MVP badges
// 2. 3 KPI cards (5 Published / 0 Drafts / 0 Quiz questions this week)
// 3. Items list with filter pills (All / Published / Drafts) and "+ New item" action
// 4. Detailed current-affairs cards with date, category pill, external source link, and author
// 5. "New current-affairs item" & "Edit item" form with dynamic counters (0/140, 0/600),
//    category dropdown, date picker, 34 exam chips, and optional embedded weekly quiz question editor.
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
  bool _isEditingForm = false;
  CurrentAffairsItem? _editingTarget;

  // Form Controllers & State
  DateTime _selectedDate = DateTime(2026, 11, 11);
  String _selectedCategory = "National";
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _sourceNameController = TextEditingController();
  final TextEditingController _sourceLinkController = TextEditingController();
  final Set<String> _selectedExams = {"UPSC CSE", "SSC CGL", "TNPSC Group 4"};

  bool _hasQuizQuestion = false;
  final TextEditingController _quizQuestionController = TextEditingController();
  final List<TextEditingController> _quizOptionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  int _correctOptionIndex = 0;
  final TextEditingController _quizExplanationController = TextEditingController();
  bool _publishToStudents = true;

  final List<String> _categories = [
    "National",
    "International",
    "Economy & Banking",
    "Environment",
    "Science & Tech",
    "Defense & Security",
    "Sports",
    "Awards & Honors",
    "Government Schemes",
  ];

  final List<String> _availableExams = [
    "UPSC CSE", "SSC CGL", "SSC CHSL", "SSC MTS", "TNPSC Group 1", "TNPSC Group 2",
    "TNPSC Group 4", "IBPS PO", "IBPS Clerk", "SBI PO", "RBI Grade B", "RRB NTPC",
    "RRB Group D", "NDA", "CDS", "AFCAT", "CTET", "TNTET", "UGC-NET", "TN SET",
    "JEE Main", "NEET-UG", "CUET-UG", "TNEA", "CLAT UG", "GATE", "CAT",
    "CUET-PG", "TANCET", "NEET-PG", "INI-CET", "FMGE", "NExT Step 1", "IIT JAM",
  ];

  // Pre-populated Items matching Screenshot 1
  final List<CurrentAffairsItem> _items = [
    // 1. ISRO Chandrayaan-4
    CurrentAffairsItem(
      id: "ca_1",
      date: "2026-10-30",
      category: "National",
      headline: "ISRO Launches Chandrayaan-4 Lunar Sample Return Mission",
      summary:
          "The Indian Space Research Organisation (ISRO) has successfully launched the Chandrayaan-4 mission from Sriharikota. The mission objective is to collect soil and rock samples from the lunar south pole and safely return them to Earth for advanced scientific research.",
      sourceName: "ISRO / PIB",
      sourceLink: "https://pib.gov.in/PressReleasePage.aspx",
      author: "By University Super Admin",
      status: "Published",
      usefulFor: ["UPSC CSE", "Science & Tech", "GATE", "SSC CGL"],
      hasQuiz: false,
    ),

    // 2. Railway 100% Electrification
    CurrentAffairsItem(
      id: "ca_2",
      date: "2026-10-14",
      category: "National",
      headline:
          "India Achieves 100% Electrification of Broad-Gauge Railway Network Under Mission 100%",
      summary:
          "Indian Railways has completed 100% electrification of its broad-gauge railway network, making it the largest electrified rail network in the world. The transition reduces annual carbon emissions by over 14 million tonnes and substantially lowers crude oil import bills. The milestone directly supports India's target of achieving Net Zero...",
      sourceName: "PIB",
      sourceLink: "https://pib.gov.in/PressReleasePage.aspx",
      author: "By Dr. Meena Raghavan",
      status: "Published",
      usefulFor: ["UPSC CSE", "SSC CGL", "RRB NTPC", "IBPS PO"],
      hasQuiz: true,
      quizQuestion:
          "What is the estimated annual carbon emission reduction achieved by the 100% electrification of India's broad-gauge rail network?",
      quizOptions: [
        "Over 14 million tonnes",
        "5 million tonnes",
        "25 million tonnes",
        "50 million tonnes",
      ],
      correctOptionIndex: 0,
      quizExplanation:
          "Mission 100% achieves an annual carbon emission reduction exceeding 14 million tonnes.",
    ),

    // 3. Ramsar Wetlands
    CurrentAffairsItem(
      id: "ca_3",
      date: "2026-10-08",
      category: "Environment",
      headline: "India adds 3 more wetlands to Ramsar list, taking national tally to 85",
      summary:
          "India has designated three additional wetlands—Nanjarayan Bird Sanctuary and Kazhuveli Bird Sanctuary in Tamil Nadu, and Tawa Reservoir in Madhya Pradesh—as Ramsar Sites of International Importance. India now ranks second globally in the number of Ramsar sites.",
      sourceName: "Ministry of Environment, Forest and Climate Change (PIB)",
      sourceLink: "https://pib.gov.in/PressReleasePage.aspx",
      author: "By Dr. Meena Raghavan",
      status: "Published",
      usefulFor: ["UPSC CSE", "TNPSC Group 4", "SSC CGL", "Environment"],
      hasQuiz: true,
      quizQuestion:
          "Which of the following wetlands was recently added to India's Ramsar list from Madhya Pradesh?",
      quizOptions: [
        "Bhoj Wetland",
        "Tawa Reservoir",
        "Sakhya Sagar",
        "Sirpur Wetland",
      ],
      correctOptionIndex: 1,
      quizExplanation:
          "Tawa Reservoir in Hoshangabad district, Madhya Pradesh, was designated alongside two Tamil Nadu sanctuaries.",
    ),

    // 4. Supercomputer Commissioning
    CurrentAffairsItem(
      id: "ca_4",
      date: "2026-10-01",
      category: "Science & Tech",
      headline:
          "PARAM Ananta Supercomputer Commissioned under National Supercomputing Mission",
      summary:
          "State-of-the-art 838 teraflops supercomputing facility commissioned to accelerate computational biology, quantum chemistry, molecular dynamics and AI modeling.",
      sourceName: "C-DAC / DST",
      sourceLink: "https://pib.gov.in/PressReleasePage.aspx",
      author: "By Dr. Lakshmi Sundaram",
      status: "Published",
      usefulFor: ["GATE", "UPSC CSE", "Science & Tech"],
      hasQuiz: false,
    ),

    // 5. RBI Bilateral Rupee Settlements
    CurrentAffairsItem(
      id: "ca_5",
      date: "2026-09-24",
      category: "Economy & Banking",
      headline:
          "RBI Introduces Interoperable Payment System for Cross-Border Rupee Settlements",
      summary:
          "Reserve Bank of India expands bilateral rupee settlements across partner central banks to enhance international trade efficiency without third-party currency conversion volatility.",
      sourceName: "RBI Bulletin",
      sourceLink: "https://rbi.org.in",
      author: "By Dr. Meena Raghavan",
      status: "Published",
      usefulFor: ["IBPS PO", "SBI PO", "RBI Grade B", "UPSC CSE"],
      hasQuiz: true,
      quizQuestion:
          "Which regulatory body oversees the implementation of Special Rupee Vostro Accounts (SRVA)?",
      quizOptions: [
        "Reserve Bank of India (RBI)",
        "Securities and Exchange Board of India (SEBI)",
        "Ministry of Commerce",
        "NITI Aayog",
      ],
      correctOptionIndex: 0,
      quizExplanation:
          "The Reserve Bank of India regulates SRVA mechanisms for international trade invoicing.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _resetForm();
  }

  void _resetForm() {
    _editingTarget = null;
    _selectedDate = DateTime(2026, 11, 11);
    _selectedCategory = "National";
    _headlineController.clear();
    _summaryController.clear();
    _sourceNameController.clear();
    _sourceLinkController.clear();
    _selectedExams.clear();
    _selectedExams.addAll(["UPSC CSE", "SSC CGL", "TNPSC Group 4"]);
    _hasQuizQuestion = false;
    _quizQuestionController.clear();
    for (var c in _quizOptionControllers) {
      c.clear();
    }
    _correctOptionIndex = 0;
    _quizExplanationController.clear();
    _publishToStudents = true;
  }

  void _populateFormForEdit(CurrentAffairsItem item) {
    _editingTarget = item;
    // Parse date if possible
    try {
      final parts = item.date.split('-');
      if (parts.length == 3) {
        _selectedDate = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      }
    } catch (_) {}

    _selectedCategory = _categories.contains(item.category) ? item.category : _categories.first;
    _headlineController.text = item.headline;
    _summaryController.text = item.summary;
    _sourceNameController.text = item.sourceName;
    _sourceLinkController.text = item.sourceLink ?? "";
    _selectedExams.clear();
    _selectedExams.addAll(item.usefulFor);

    _hasQuizQuestion = item.hasQuiz;
    _quizQuestionController.text = item.quizQuestion ?? "";
    for (int i = 0; i < 4; i++) {
      if (item.quizOptions.length > i) {
        _quizOptionControllers[i].text = item.quizOptions[i];
      } else {
        _quizOptionControllers[i].clear();
      }
    }
    _correctOptionIndex = item.correctOptionIndex;
    _quizExplanationController.text = item.quizExplanation ?? "";
    _publishToStudents = item.status == "Published";
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _summaryController.dispose();
    _sourceNameController.dispose();
    _sourceLinkController.dispose();
    _quizQuestionController.dispose();
    for (var c in _quizOptionControllers) {
      c.dispose();
    }
    _quizExplanationController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // SAVE / PUBLISH ITEM
  // ===========================================================================
  void _saveItem() {
    final headline = _headlineController.text.trim();
    final summary = _summaryController.text.trim();
    final sourceName = _sourceNameController.text.trim();

    if (headline.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Headline is required (up to 140 chars)."),
          backgroundColor: Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (summary.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Summary is required (up to 600 chars)."),
          backgroundColor: Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final formattedDate =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    final status = _publishToStudents ? "Published" : "Draft";

    final options = _quizOptionControllers.map((c) => c.text.trim()).toList();

    if (_editingTarget != null) {
      // Update existing item
      setState(() {
        _editingTarget!.date = formattedDate;
        _editingTarget!.category = _selectedCategory;
        _editingTarget!.headline = headline;
        _editingTarget!.summary = summary;
        _editingTarget!.sourceName = sourceName.isNotEmpty ? sourceName : "PIB";
        _editingTarget!.sourceLink = _sourceLinkController.text.trim();
        _editingTarget!.usefulFor = _selectedExams.toList();
        _editingTarget!.status = status;
        _editingTarget!.hasQuiz = _hasQuizQuestion;
        if (_hasQuizQuestion) {
          _editingTarget!.quizQuestion = _quizQuestionController.text.trim();
          _editingTarget!.quizOptions = options;
          _editingTarget!.correctOptionIndex = _correctOptionIndex;
          _editingTarget!.quizExplanation = _quizExplanationController.text.trim();
        }
        _isEditingForm = false;
        _resetForm();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Current affairs item updated successfully!"),
          backgroundColor: Color(0xFF15803D),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // Create new item
      final newItem = CurrentAffairsItem(
        id: "ca_${DateTime.now().millisecondsSinceEpoch}",
        date: formattedDate,
        category: _selectedCategory,
        headline: headline,
        summary: summary,
        sourceName: sourceName.isNotEmpty ? sourceName : "PIB",
        sourceLink: _sourceLinkController.text.trim(),
        author: "By Dr. Meena Raghavan",
        status: status,
        usefulFor: _selectedExams.toList(),
        hasQuiz: _hasQuizQuestion,
        quizQuestion: _hasQuizQuestion ? _quizQuestionController.text.trim() : null,
        quizOptions: options,
        correctOptionIndex: _correctOptionIndex,
        quizExplanation: _hasQuizQuestion ? _quizExplanationController.text.trim() : null,
      );

      setState(() {
        _items.insert(0, newItem);
        _isEditingForm = false;
        _resetForm();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("'$headline' saved and $status to students!"),
          backgroundColor: const Color(0xFF15803D),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ===========================================================================
  // DELETE CONFIRMATION DIALOG
  // ===========================================================================
  void _showDeleteItemDialog(CurrentAffairsItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Delete Current Affairs Item?",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        content: Text(
          "Are you sure you want to delete '${item.headline}'? Students will no longer see this in their daily briefs.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF64748B),
            height: 1.45,
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _items.remove(item));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Item deleted"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              "Delete",
              style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DATE PICKER
  // ===========================================================================
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E2865),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0F172A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // ===========================================================================
  // MAIN BUILD
  // ===========================================================================
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
              const SizedBox(height: 16),

              // 2. 3 Metric Tiles (5 Published / 0 Drafts / 0 Quiz questions this week)
              _buildKpiMetricsRow(isNarrow),
              const SizedBox(height: 18),

              // 3. Form View or Items List View
              if (_isEditingForm)
                _buildItemFormCard(constraints)
              else
                _buildItemsListCard(constraints),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Matching Screenshot 1)
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
                  // Breadcrumb row (Home > Assessment > Current Affairs Desk)
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
                      // Newspaper Icon box
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
                            Icons.article_rounded,
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
  // 2. 3 METRIC TILES (5 Published / 0 Drafts / 0 Quiz questions this week)
  // ===========================================================================
  Widget _buildKpiMetricsRow(bool isNarrow) {
    final publishedCount = _items.where((i) => i.status == "Published").length;
    final draftCount = _items.where((i) => i.status == "Draft").length;

    final card1 = _buildMetricCard(
      value: "$publishedCount",
      title: "Published",
    );

    final card2 = _buildMetricCard(
      value: "$draftCount",
      title: "Drafts",
    );

    final card3 = _buildMetricCard(
      value: "0",
      title: "Quiz questions this week",
      subtitle: "Students need at least 3 for the weekly quiz",
    );

    if (isNarrow) {
      return Column(
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
      children: [
        Expanded(child: card1),
        const SizedBox(width: 14),
        Expanded(child: card2),
        const SizedBox(width: 14),
        Expanded(child: card3),
      ],
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String title,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
              height: 1.15,
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
  // 3. ITEMS LIST CARD (Matching Screenshot 1)
  // ===========================================================================
  Widget _buildItemsListCard(BoxConstraints constraints) {
    final filtered = _items.where((i) {
      if (_activeFilter == "All") return true;
      return i.status == _activeFilter;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Title + Subtitle & Action Button
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
                  ],
                ),
              ),
              const SizedBox(width: 14),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _resetForm();
                    _isEditingForm = true;
                  });
                },
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  "New item",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Filter Pills (All / Published / Drafts)
          Row(
            children: [
              _buildFilterPill("All", _activeFilter == "All", () => setState(() => _activeFilter = "All")),
              const SizedBox(width: 8),
              _buildFilterPill(
                  "Published", _activeFilter == "Published", () => setState(() => _activeFilter = "Published")),
              const SizedBox(width: 8),
              _buildFilterPill("Drafts", _activeFilter == "Drafts", () => setState(() => _activeFilter = "Drafts")),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Items List
          if (filtered.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.article_outlined, size: 40, color: Color(0xFFCBD5E1)),
                    const SizedBox(height: 10),
                    Text(
                      "No current affairs items found",
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Badges on Left, Edit & Delete Actions on Right
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                // Date badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item.date,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),

                                // Category badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEF2FF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.category,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF4338CA),
                                    ),
                                  ),
                                ),

                                // Published badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCFCE7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.status,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF15803D),
                                    ),
                                  ),
                                ),

                                // Quiz question badge if available
                                if (item.hasQuiz)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEF3C7),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Quiz question",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFD97706),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Actions: Edit & Delete
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 17, color: Color(0xFF64748B)),
                                onPressed: () {
                                  setState(() {
                                    _populateFormForEdit(item);
                                    _isEditingForm = true;
                                  });
                                },
                                splashRadius: 18,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                tooltip: "Edit item",
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, size: 17, color: Color(0xFFDC2626)),
                                onPressed: () => _showDeleteItemDialog(item),
                                splashRadius: 18,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                tooltip: "Delete item",
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Headline (Full Width)
                      Text(
                        item.headline,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Summary text (Full Width)
                      Text(
                        item.summary,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF475569),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Source Link (100% Overflow-Free with Wrap)
                      if (item.sourceLink != null && item.sourceLink!.isNotEmpty)
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Opening source: ${item.sourceName}"),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 4,
                            runSpacing: 2,
                            children: [
                              Text(
                                item.sourceName,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                              const Icon(Icons.open_in_new_rounded, size: 12, color: Color(0xFF64748B)),
                            ],
                          ),
                        )
                      else
                        Text(
                          item.sourceName,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      const SizedBox(height: 2),

                      // Author
                      Text(
                        item.author,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. NEW & EDIT CURRENT AFFAIRS ITEM FORM (Matching Screenshots 2, 3 & 4)
  // ===========================================================================
  Widget _buildItemFormCard(BoxConstraints constraints) {
    final isDesktop = constraints.maxWidth >= 780;
    final isEditing = _editingTarget != null;

    final formattedDate =
        "${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.year}";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            isEditing ? "Edit item" : "New current-affairs item",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Plain text only. Keep it factual and cite an official or reputable source.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Row 1: Date & Category
          if (isDesktop)
            Row(
              children: [
                Expanded(child: _buildDateField(formattedDate)),
                const SizedBox(width: 18),
                Expanded(child: _buildCategoryField()),
              ],
            )
          else ...[
            _buildDateField(formattedDate),
            const SizedBox(height: 14),
            _buildCategoryField(),
          ],
          const SizedBox(height: 16),

          // Row 2: Headline with character counter (0/140)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Headline (${_headlineController.text.length}/140)",
                style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
              ),
              const SizedBox(height: 6),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: TextField(
                  controller: _headlineController,
                  maxLength: 140,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Row 3: Summary with character counter (0/600)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Summary (${_summaryController.text.length}/600)",
                style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: TextField(
                  controller: _summaryController,
                  maxLength: 600,
                  maxLines: 4,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A), height: 1.45),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Two to four sentences: what happened, why it matters, the facts an exam might ask.",
                style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Row 4: Source Name & Source Link
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildSourceNameField()),
                const SizedBox(width: 18),
                Expanded(child: _buildSourceLinkField()),
              ],
            )
          else ...[
            _buildSourceNameField(),
            const SizedBox(height: 14),
            _buildSourceLinkField(),
          ],
          const SizedBox(height: 18),

          // Row 5: Useful for (optional) Chips
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Useful for (optional)",
                style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableExams.map((exam) {
                  final isSelected = _selectedExams.contains(exam);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedExams.remove(exam);
                        } else {
                          _selectedExams.add(exam);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        exam,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF334155),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Row 6: Add a quiz question container (Matching Screenshots 2, 3 & 4)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox toggle (Responsive & Wrap-safe)
                InkWell(
                  onTap: () => setState(() => _hasQuizQuestion = !_hasQuizQuestion),
                  borderRadius: BorderRadius.circular(6),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _hasQuizQuestion,
                        activeColor: const Color(0xFF1E2865),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (val) => setState(() => _hasQuizQuestion = val ?? false),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Add a quiz question (used in the weekly quiz)",
                          softWrap: true,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (_hasQuizQuestion) ...[
                  const SizedBox(height: 14),

                  // Question input
                  Text(
                    "Question",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: TextField(
                      controller: _quizQuestionController,
                      style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // 4 Options A, B, C, D
                  LayoutBuilder(
                    builder: (context, box) {
                      final isWide = box.maxWidth >= 600;

                      final optA = _buildQuizOptionRow(0, "A", "Option A");
                      final optB = _buildQuizOptionRow(1, "B", "Option B");
                      final optC = _buildQuizOptionRow(2, "C", "Option C");
                      final optD = _buildQuizOptionRow(3, "D", "Option D");

                      if (isWide) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: optA),
                                const SizedBox(width: 12),
                                Expanded(child: optB),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(child: optC),
                                const SizedBox(width: 12),
                                Expanded(child: optD),
                              ],
                            ),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          optA,
                          const SizedBox(height: 8),
                          optB,
                          const SizedBox(height: 8),
                          optC,
                          const SizedBox(height: 8),
                          optD,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Select the radio button next to the correct option.",
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 12),

                  // Explanation input
                  Text(
                    "Explanation (shown after the quiz)",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: TextField(
                      controller: _quizExplanationController,
                      style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 16),

          // Footer Row: Checkbox + Cancel & Publish
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _publishToStudents,
                    activeColor: const Color(0xFF1E2865),
                    onChanged: (val) => setState(() => _publishToStudents = val ?? true),
                  ),
                  Text(
                    "Publish to students",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _isEditingForm = false;
                        _resetForm();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF475569)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _saveItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2865),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      isEditing ? "Save changes" : "Publish",
                      style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String formattedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date",
          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: _pickDate,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                ),
                const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
              items: _categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSourceNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Source name",
          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: TextField(
            controller: _sourceNameController,
            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: "e.g. PIB, The Hindu",
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSourceLinkField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Source link (optional)",
          style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: TextField(
            controller: _sourceLinkController,
            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: "https://pib.gov.in/...",
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "https only, from government sites or: rbi.org.in, prsindia.org, thehindu.com, indianexpress.com, hindustantimes.com ...",
          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildQuizOptionRow(int optionIndex, String letter, String placeholder) {
    final isSelected = _correctOptionIndex == optionIndex;
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFCBD5E1),
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => setState(() => _correctOptionIndex = optionIndex),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1E2865) : const Color(0xFF94A3B8),
                  width: isSelected ? 5.0 : 1.5,
                ),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            letter,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF1E2865) : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _quizOptionControllers[optionIndex],
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
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
