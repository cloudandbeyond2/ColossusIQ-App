import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// CAMPUS LIFE: AI EVENT GENERATOR SCREEN
// Exactly matches screenshots 1 & 2:
// - Blueprint grid hero banner with watermark & badges (CAMPUS LIFE, Phase 3)
// - Sub-banner studio header bar with status badges, Save Blueprint, Export .MD,
//   and "Publish to Campus Events" actions
// - Left Side:
//     * Quick-Start Presets (1-Click Load) with 5 event types and budget/participant tags
//     * Event Parameters form (Title, Category, Duration, Department, Footfall, Budget, Date, Time, Venue, Brief)
//     * Saved Event Plans (0) empty container
// - Right Side:
//     * Big "No Event Blueprint Generated Yet" canvas with 4 feature preview cards (Executive Blueprint,
//       Agenda & Timeline, Budget Planner, Promo Kit & Volunteers) and Generate button
// =============================================================================

class AiEventGeneratorScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiEventGeneratorScreen({super.key, this.onBack});

  @override
  State<AiEventGeneratorScreen> createState() => _AiEventGeneratorScreenState();
}

class _AiEventGeneratorScreenState extends State<AiEventGeneratorScreen> {
  final TextEditingController _titleController =
      TextEditingController(text: "National Hackathon 2026");
  final TextEditingController _deptController =
      TextEditingController(text: "Computer Science & Engineering");
  final TextEditingController _footfallController =
      TextEditingController(text: "500");
  final TextEditingController _budgetController =
      TextEditingController(text: "150000");
  final TextEditingController _dateController =
      TextEditingController(text: "10/24/2026");
  final TextEditingController _timeController =
      TextEditingController(text: "09:00 AM");
  final TextEditingController _venueController =
      TextEditingController(text: "Main Auditorium");
  final TextEditingController _instructionsController = TextEditingController();

  String _selectedCategory = "Workshop";
  String _selectedDuration = "1 Full Day";

  final List<String> _categories = [
    "Workshop",
    "Hackathon",
    "Cultural",
    "Summit",
    "Sports",
  ];

  final List<String> _durations = [
    "1 Full Day",
    "2 Days",
    "Half Day",
    "Multi-day",
  ];

  final List<Map<String, String>> _presets = [
    {
      "title": "AI & Cloud Hackathon",
      "tag": "₹200k · 500p",
      "category": "Hackathon",
      "duration": "2 Days",
      "budget": "200000",
      "footfall": "500",
      "venue": "Innovation Lab",
    },
    {
      "title": "Annual Cultural Fest",
      "tag": "₹450k · 1500p",
      "category": "Cultural",
      "duration": "2 Days",
      "budget": "450000",
      "footfall": "1500",
      "venue": "Main Auditorium & Open Grounds",
    },
    {
      "title": "DeepTech & Research Summit",
      "tag": "₹120k · 350p",
      "category": "Summit",
      "duration": "1 Full Day",
      "budget": "120000",
      "footfall": "350",
      "venue": "Seminar Hall 1",
    },
    {
      "title": "Placement & Hiring Sprint",
      "tag": "₹85k · 300p",
      "category": "Workshop",
      "duration": "1 Full Day",
      "budget": "85000",
      "footfall": "300",
      "venue": "Placement Block Hall",
    },
    {
      "title": "Inter-College Sports Meet",
      "tag": "₹220k · 800p",
      "category": "Sports",
      "duration": "Multi-day",
      "budget": "220000",
      "footfall": "800",
      "venue": "University Sports Complex",
    },
  ];

  bool _isBlueprintGenerated = false;

  @override
  void dispose() {
    _titleController.dispose();
    _deptController.dispose();
    _footfallController.dispose();
    _budgetController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _venueController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _applyPreset(Map<String, String> preset) {
    setState(() {
      _titleController.text = preset["title"]!;
      _selectedCategory = preset["category"]!;
      _selectedDuration = preset["duration"]!;
      _budgetController.text = preset["budget"]!;
      _footfallController.text = preset["footfall"]!;
      _venueController.text = preset["venue"]!;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Loaded preset: ${preset['title']}",
            style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _generateBlueprint() {
    setState(() {
      _isBlueprintGenerated = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "AI Event Blueprint synthesized for \"${_titleController.text}\"!",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 980;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 16),

              // 2. Studio Header Bar
              _buildStudioHeaderBar(),
              const SizedBox(height: 18),

              // 3. Two-Column Layout (Parameters & Presets on Left, Blueprint on Right)
              if (isNarrow)
                Column(
                  children: [
                    _buildPresetsCard(),
                    const SizedBox(height: 18),
                    _buildParametersCard(),
                    const SizedBox(height: 18),
                    _buildSavedPlansCard(),
                    const SizedBox(height: 20),
                    _buildBlueprintCanvasCard(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          _buildPresetsCard(),
                          const SizedBox(height: 18),
                          _buildParametersCard(),
                          const SizedBox(height: 18),
                          _buildSavedPlansCard(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 13,
                      child: _buildBlueprintCanvasCard(),
                    ),
                  ],
                ),
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
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.auto_awesome_rounded,
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
                  // Breadcrumbs (clean, no leading arrow)
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
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Campus Life",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "AI Event Generator",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildPillBadge(
                        "CAMPUS LIFE",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "Phase 3",
                        const Color(0xFFD97706),
                        Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Icon + Title + Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232F6E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AI Event Generator",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\"Create a one-day technology event for 500 students\" — agenda, budget, promotion and forms.",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
                                height: 1.4,
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

  Widget _buildPillBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. STUDIO HEADER BAR
  // ===========================================================================
  Widget _buildStudioHeaderBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 800;

          final infoPart = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.hub_outlined,
                    size: 20, color: Color(0xFF1E2865)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "AI Event Generator Studio",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        _buildStatusPill("FACULTY", const Color(0xFF1E2865),
                            Colors.white, false),
                        _buildStatusPill("2 Events Active",
                            const Color(0xFF2563EB), const Color(0xFF2563EB), true),
                        _buildStatusPill(
                            _isBlueprintGenerated
                                ? "Blueprint Active"
                                : "No Active Blueprint",
                            _isBlueprintGenerated
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFF1F5F9),
                            _isBlueprintGenerated
                                ? const Color(0xFF16A34A)
                                : const Color(0xFF64748B),
                            false),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Plan, optimize budgets, schedule agendas, generate marketing copy, and publish directly to Campus Life.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

          final actionsPart = Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Blueprint saved successfully!",
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.bookmark_border_rounded, size: 15),
                label: Text("Save Blueprint",
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Exported event blueprint as Markdown (.MD)",
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.file_download_outlined, size: 15),
                label: Text("Export .MD",
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Event published to Campus Events!",
                          style: GoogleFonts.poppins()),
                      backgroundColor: const Color(0xFF4F46E5),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.near_me_rounded, size: 15),
                label: Text("Publish to Campus Events",
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoPart,
                const SizedBox(height: 12),
                actionsPart,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: infoPart),
              const SizedBox(width: 16),
              actionsPart,
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusPill(
      String label, Color bg, Color textColor, bool hasDot) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
      decoration: BoxDecoration(
        color: hasDot ? const Color(0xFFEFF6FF) : bg,
        borderRadius: BorderRadius.circular(6),
        border: hasDot ? Border.all(color: const Color(0xFFBFDBFE)) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. LEFT: QUICK-START PRESETS CARD
  // ===========================================================================
  Widget _buildPresetsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.tune_rounded,
                      size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 6),
                  Text(
                    "QUICK-START PRESETS",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Text(
                "1-Click Load",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Preset items
          Column(
            children: _presets.map((p) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () => _applyPreset(p),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
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
                            p["title"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E293B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: Text(
                            p["tag"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. LEFT: EVENT PARAMETERS FORM CARD
  // ===========================================================================
  Widget _buildParametersCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Parameters",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Tune variables to re-synthesize blueprint",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // Event Title
          _buildFieldLabel("Event Title"),
          _buildTextField(_titleController, "e.g. National Hackathon 2026"),
          const SizedBox(height: 12),

          // Category & Duration
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Category"),
                    _buildDropdown(
                      value: _selectedCategory,
                      items: _categories,
                      onChanged: (v) => setState(() => _selectedCategory = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Duration"),
                    _buildDropdown(
                      value: _selectedDuration,
                      items: _durations,
                      onChanged: (v) => setState(() => _selectedDuration = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Organising Department / Cell
          _buildFieldLabel("Organising Department / Cell"),
          _buildTextField(
              _deptController, "e.g. Computer Science & Engineering"),
          const SizedBox(height: 12),

          // Expected Footfall & Total Budget
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Expected Footfall"),
                    _buildTextField(_footfallController, "e.g. 500"),
                    const SizedBox(height: 2),
                    Text("Attendees",
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: const Color(0xFF94A3B8))),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Total Budget (₹)"),
                    _buildTextField(_budgetController, "e.g. 150000"),
                    const SizedBox(height: 14), // balance subtext height
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Target Date & Start Time
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Target Date"),
                    _buildTextField(
                      _dateController,
                      "mm/dd/yyyy",
                      suffixIcon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          setState(() {
                            _dateController.text =
                                "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Start Time"),
                    _buildTextField(
                      _timeController,
                      "09:00 AM",
                      suffixIcon: Icons.access_time_rounded,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 9, minute: 0),
                        );
                        if (picked != null) {
                          setState(() {
                            _timeController.text = picked.format(context);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Venue / Facility
          _buildFieldLabel("Venue / Facility"),
          _buildTextField(_venueController, "e.g. Main Auditorium"),
          const SizedBox(height: 12),

          // Brief & Special Instructions
          _buildFieldLabel("Brief & Special Instructions"),
          TextField(
            controller: _instructionsController,
            maxLines: 3,
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: "Keynotes, target sponsors, specific workshops...",
              hintStyle: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF94A3B8)),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Action Button: Generate AI Event Plan
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _generateBlueprint,
              icon: const Icon(Icons.auto_awesome_rounded, size: 16),
              label: Text(
                "Generate AI Event Plan",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3B8B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
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

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    IconData? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      style: GoogleFonts.poppins(fontSize: 12.5),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, size: 16, color: const Color(0xFF64748B))
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          style: GoogleFonts.poppins(
              fontSize: 12, color: const Color(0xFF0F172A)),
          items: items.map((i) {
            return DropdownMenuItem(value: i, child: Text(i));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. LEFT: SAVED EVENT PLANS CARD
  // ===========================================================================
  Widget _buildSavedPlansCard() {
    return Container(
      padding: const EdgeInsets.all(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SAVED EVENT PLANS (0)",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Center(
              child: Text(
                "No saved blueprints yet.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. RIGHT: BLUEPRINT CANVAS CARD
  // ===========================================================================
  Widget _buildBlueprintCanvasCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Center Sparkle Badge
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 24,
                color: Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(height: 18),

          Text(
            "No Event Blueprint Generated Yet",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              "Configure your event parameters on the left and click \"Generate AI Event Plan\" — or pick one of the Quick-Start Presets — to synthesize a complete executive blueprint, timeline agenda, itemised budget, volunteer squads, and marketing kit.",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 28),

          // 4 Feature Preview Cards (Responsive grid that never overflows)
          LayoutBuilder(
            builder: (context, constraints) {
              final isVeryNarrow = constraints.maxWidth < 460;
              final childAspectRatio = isVeryNarrow
                  ? 3.2
                  : (constraints.maxWidth < 620 ? 1.85 : 2.3);
              return GridView.count(
                crossAxisCount: isVeryNarrow ? 1 : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: childAspectRatio,
                children: [
                  _buildFeaturePreviewTile(
                    icon: Icons.layers_outlined,
                    iconColor: const Color(0xFF4F46E5),
                    title: "Executive Blueprint",
                    desc: "High-level KPIs, readiness checklist & hall matching",
                    bgColor: const Color(0xFFF8FAFC),
                  ),
                  _buildFeaturePreviewTile(
                    icon: Icons.access_time_rounded,
                    iconColor: const Color(0xFF0284C7),
                    title: "Agenda & Timeline",
                    desc: "Multi-track schedules with speakers, rooms, and sessions",
                    bgColor: const Color(0xFFF0F9FF),
                  ),
                  _buildFeaturePreviewTile(
                    icon: Icons.attach_money_rounded,
                    iconColor: const Color(0xFFD97706),
                    title: "Budget Planner",
                    desc:
                        "Auto-balanced allocations, per-head costs & contingency buffer",
                    bgColor: const Color(0xFFFFFBEB),
                  ),
                  _buildFeaturePreviewTile(
                    icon: Icons.campaign_outlined,
                    iconColor: const Color(0xFFE11D48),
                    title: "Promo Kit & Volunteers",
                    desc:
                        "Ready broadcast copy, registration form schema & squad tasks",
                    bgColor: const Color(0xFFFFF1F2),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),

          // Button
          ElevatedButton.icon(
            onPressed: _generateBlueprint,
            icon: const Icon(Icons.auto_awesome_rounded, size: 16),
            label: Text(
              "Generate AI Event Plan",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFeaturePreviewTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFF64748B),
                    height: 1.25,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

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
