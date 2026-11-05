import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAiEventGeneratorScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalAiEventGeneratorScreen({super.key, this.onBack});

  @override
  State<PrincipalAiEventGeneratorScreen> createState() =>
      _PrincipalAiEventGeneratorScreenState();
}

class _PrincipalAiEventGeneratorScreenState
    extends State<PrincipalAiEventGeneratorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _footfallController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController =
      TextEditingController(text: "09:00 AM");
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _briefController = TextEditingController();

  String _selectedCategory = "Workshop";
  String _selectedDuration = "1 Full Day";
  int _selectedPresetIndex = -1;

  final List<Map<String, dynamic>> _presets = [
    {
      "title": "AI & Cloud Hackathon",
      "subtitle": "₹200k · 500p",
      "icon": Icons.rocket_launch_outlined,
      "category": "Hackathon",
      "budget": "200000",
      "footfall": "500",
      "venue": "Campus Innovation Hub",
    },
    {
      "title": "Annual Cultural Fest",
      "subtitle": "₹450k · 1500p",
      "icon": Icons.theater_comedy_outlined,
      "category": "Cultural",
      "budget": "450000",
      "footfall": "1500",
      "venue": "Open Air Amphitheatre",
    },
    {
      "title": "DeepTech & Research Summit",
      "subtitle": "₹120k · 350p",
      "icon": Icons.lightbulb_outline,
      "category": "Workshop",
      "budget": "120000",
      "footfall": "350",
      "venue": "Convention Centre",
    },
    {
      "title": "Placement & Hiring Sprint",
      "subtitle": "₹85k · 300p",
      "icon": Icons.work_outline_rounded,
      "category": "Workshop",
      "budget": "85000",
      "footfall": "300",
      "venue": "Placement Block Hall A",
    },
    {
      "title": "Inter-College Sports Meet",
      "subtitle": "₹220k · 800p",
      "icon": Icons.emoji_events_outlined,
      "category": "Sports",
      "budget": "220000",
      "footfall": "800",
      "venue": "University Sports Complex",
    },
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _deptController.dispose();
    _footfallController.dispose();
    _budgetController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _venueController.dispose();
    _briefController.dispose();
    super.dispose();
  }

  void _applyPreset(int index) {
    final p = _presets[index];
    setState(() {
      _selectedPresetIndex = index;
      _titleController.text = p["title"] as String;
      _selectedCategory = p["category"] as String;
      _budgetController.text = p["budget"] as String;
      _footfallController.text = p["footfall"] as String;
      _venueController.text = p["venue"] as String;
      _briefController.text =
          "Organized by the institution with keynote speakers, sponsor tracks, hands-on workshop drills, and awards.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 950;
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO BLUEPRINT BANNER (Images 2 & 3)
                _buildHeroBanner(),
                const SizedBox(height: 16),

                // 2. SUB-HEADER BAR
                _buildStudioSubHeader(),
                const SizedBox(height: 16),

                // 3. MAIN WORKSPACE (Left Form + Right Blueprint Canvas)
                _buildWorkspace(isWide),
              ],
            ),
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
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF283685)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
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
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (Scrollable on small devices)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null) ...[
                          InkWell(
                            onTap: widget.onBack,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Campus Life",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "AI Event Generator",
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

                  // Badges: CAMPUS LIFE, Phase 3
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          "CAMPUS LIFE",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD97706),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Phase 3",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Main Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3B7D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            color: Color(0xFFFBBF24), // Yellow Sparkles
                            size: 22,
                          ),
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
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\"Create a one-day technology event for 500 students\" — agenda, budget, promotion and forms.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
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

  // ===========================================================================
  // 2. STUDIO SUB-HEADER BAR (Image 2)
  // ===========================================================================
  Widget _buildStudioSubHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 720;

        final titleAndBadges = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.auto_awesome_rounded,
                  size: 16, color: Color(0xFF4F46E5)),
            ),
            const SizedBox(width: 10),
            Text(
              "AI Event Generator Studio",
              style: GoogleFonts.poppins(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "INSTITUTION",
                style: GoogleFonts.poppins(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "● 2 Events Active",
                style: GoogleFonts.poppins(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF16A34A),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                "No Active Blueprint",
                style: GoogleFonts.poppins(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        );

        final actionButtons = Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save_outlined,
                  size: 14, color: Color(0xFF475569)),
              label: Text("Save Blueprint",
                  style: GoogleFonts.poppins(
                      fontSize: 11.5, color: const Color(0xFF475569))),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded,
                  size: 14, color: Color(0xFF475569)),
              label: Text("Export .MD",
                  style: GoogleFonts.poppins(
                      fontSize: 11.5, color: const Color(0xFF475569))),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send_rounded,
                  size: 14, color: Colors.white),
              label: Text("Publish to Campus Events",
                  style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED), // Purple Button
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );

        if (isSmall) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: titleAndBadges),
              const SizedBox(height: 12),
              actionButtons,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: titleAndBadges)),
            const SizedBox(width: 14),
            actionButtons,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 3. MAIN WORKSPACE (Form Left + Blueprint Canvas Right)
  // ===========================================================================
  Widget _buildWorkspace(bool isWide) {
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column (Presets + Form Parameters)
          SizedBox(
            width: 320,
            child: Column(
              children: [
                _buildQuickStartPresets(),
                const SizedBox(height: 16),
                _buildEventParametersForm(),
                const SizedBox(height: 16),
                _buildSavedEventPlans(),
              ],
            ),
          ),
          const SizedBox(width: 18),

          // Right Column (AI Blueprint Canvas)
          Expanded(
            child: _buildBlueprintCanvas(),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildQuickStartPresets(),
          const SizedBox(height: 16),
          _buildBlueprintCanvas(),
          const SizedBox(height: 16),
          _buildEventParametersForm(),
          const SizedBox(height: 16),
          _buildSavedEventPlans(),
        ],
      );
    }
  }

  // Left Section 1: Quick-Start Presets (Image 2)
  Widget _buildQuickStartPresets() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "QUICK-START PRESETS",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "1-Click Load",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...List.generate(_presets.length, (index) {
            final p = _presets[index];
            final isSelected = _selectedPresetIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => _applyPreset(index),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEEF2FF)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(p["icon"] as IconData,
                          size: 15,
                          color: isSelected
                              ? const Color(0xFF4F46E5)
                              : const Color(0xFF64748B)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          p["title"] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF312E81)
                                : const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      Text(
                        p["subtitle"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Left Section 2: Event Parameters (Images 2 & 3)
  Widget _buildEventParametersForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Parameters",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Tune variables to re-synthesize blueprint",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // Event Title
          _buildFieldLabel("Event Title"),
          _buildTextInput(_titleController, "e.g. National Hackathon 2026"),
          const SizedBox(height: 12),

          // Category & Duration Dropdowns
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Category"),
                    _buildDropdown(
                      value: _selectedCategory,
                      items: [
                        "Workshop",
                        "Cultural",
                        "Hackathon",
                        "Sports",
                        "Summit"
                      ],
                      onChanged: (v) =>
                          setState(() => _selectedCategory = v ?? "Workshop"),
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
                      items: ["1 Full Day", "2 Days", "Half Day", "3 Days"],
                      onChanged: (v) => setState(
                          () => _selectedDuration = v ?? "1 Full Day"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Organising Department / Cell
          _buildFieldLabel("Organising Department / Cell"),
          _buildTextInput(
              _deptController, "e.g. Computer Science & Engineering"),
          const SizedBox(height: 12),

          // Expected Footfall & Budget
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Expected Footfall"),
                    _buildTextInput(_footfallController, "e.g. 500"),
                    const SizedBox(height: 2),
                    Text("Attendees",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel("Total Budget (₹)"),
                    _buildTextInput(_budgetController, "e.g. 150000"),
                    const SizedBox(height: 14),
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
                    _buildTextInput(
                      _dateController,
                      "mm/dd/yyyy",
                      suffixIcon: Icons.calendar_today_outlined,
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
                    _buildTextInput(
                      _timeController,
                      "09:00 AM",
                      suffixIcon: Icons.access_time_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Venue / Facility
          _buildFieldLabel("Venue / Facility"),
          _buildTextInput(_venueController, "e.g. Main Auditorium"),
          const SizedBox(height: 12),

          // Brief & Special Instructions
          _buildFieldLabel("Brief & Special Instructions"),
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _briefController,
              maxLines: 3,
              style: GoogleFonts.poppins(fontSize: 11.5),
              decoration: const InputDecoration(
                hintText:
                    "Keynotes, target sponsors, specific workshops...",
                hintStyle:
                    TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Generate AI Event Plan Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Synthesizing complete event blueprint for ${_titleController.text.isEmpty ? "National Hackathon" : _titleController.text}...",
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.auto_awesome_rounded,
                  size: 15, color: Colors.white),
              label: Text(
                "Generate AI Event Plan",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4338CA), // Deep Indigo / Violet
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Left Section 3: Saved Event Plans (Image 3)
  Widget _buildSavedEventPlans() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SAVED EVENT PLANS (0)",
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  style: BorderStyle.solid),
            ),
            child: Center(
              child: Text(
                "No saved blueprints yet.",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Right Column: Blueprint Canvas Empty State (Image 2)
  Widget _buildBlueprintCanvas() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Sparkles Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 28,
              color: Color(0xFF1E2865),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            "No Event Blueprint Generated Yet",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),

          // Subtext
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              "Configure your event parameters on the left and click \"Generate AI Event Plan\" — or pick one of the Quick-Start Presets — to synthesize a complete executive blueprint, timeline agenda, itemised budget, volunteer squads, and marketing kit.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // 2x2 Feature Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 500;
              final width = isNarrow
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 14) / 2;

              return Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _buildFeatureCard(
                    width: width,
                    icon: Icons.layers_outlined,
                    iconColor: const Color(0xFF475569),
                    title: "Executive Blueprint",
                    desc:
                        "High-level KPIs, readiness checklist & hall matching",
                    bg: const Color(0xFFF8FAFC),
                  ),
                  _buildFeatureCard(
                    width: width,
                    icon: Icons.access_time_rounded,
                    iconColor: const Color(0xFF0284C7),
                    title: "Agenda & Timeline",
                    desc:
                        "Multi-track schedules with speakers, rooms, and sessions",
                    bg: const Color(0xFFF0F9FF),
                  ),
                  _buildFeatureCard(
                    width: width,
                    icon: Icons.attach_money_rounded,
                    iconColor: const Color(0xFFD97706),
                    title: "Budget Planner",
                    desc:
                        "Auto-balanced allocations, per-head costs & contingency buffer",
                    bg: const Color(0xFFFFFBEB),
                  ),
                  _buildFeatureCard(
                    width: width,
                    icon: Icons.campaign_outlined,
                    iconColor: const Color(0xFFE11D48),
                    title: "Promo Kit & Volunteers",
                    desc:
                        "Ready broadcast copy, registration form schema & squad tasks",
                    bg: const Color(0xFFFFF1F2),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),

          // Action Button
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Generating AI Event Plan...",
                    style: GoogleFonts.poppins(),
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.auto_awesome_rounded,
                size: 15, color: Colors.white),
            label: Text(
              "Generate AI Event Plan",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF283685),
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required double width,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
    required Color bg,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
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
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  Widget _buildTextInput(TextEditingController controller, String hint,
      {IconData? suffixIcon}) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(fontSize: 11.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, size: 14, color: const Color(0xFF94A3B8))
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
              fontSize: 11.5, color: const Color(0xFF0F172A)),
          items: items
              .map((it) => DropdownMenuItem(value: it, child: Text(it)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// =============================================================================
// GRID PAINTER
// =============================================================================

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const double step = 28;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
