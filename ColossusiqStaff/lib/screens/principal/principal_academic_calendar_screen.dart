import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PRINCIPAL: ACADEMIC CALENDAR SCREEN (Matches Image 3)
// Fully responsive with adaptive text wrapping and mobile layout alignment.
// =============================================================================

class PrincipalAcademicCalendarScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalAcademicCalendarScreen({super.key, this.onBack});

  @override
  State<PrincipalAcademicCalendarScreen> createState() =>
      _PrincipalAcademicCalendarScreenState();
}

class _PrincipalAcademicCalendarScreenState
    extends State<PrincipalAcademicCalendarScreen> {
  int _activeView = 0; // 0: Timeline View, 1: Monthly Grid
  int _activeFilterChip = 0; // 0: All, 1: Assessment, 2: Holiday, etc.
  String _selectedDept = "All Departments";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _events = [
    {
      "month": "SEP",
      "day": "29",
      "weekday": "Tue",
      "title": "IA-II Timetable Published",
      "tag": "Exam cell",
      "tagColor": const Color(0xFF6366F1),
      "tagBg": const Color(0xFFEEF2FF),
      "desc":
          "Official schedule for Internal Assessment II released for all UG and PG programs.",
      "time": "10:00 AM",
      "venue": "Central Exam Cell / Portal",
      "category": "Exam cell",
    },
    {
      "month": "OCT",
      "day": "02",
      "weekday": "Fri",
      "title": "Gandhi Jayanti National Holiday",
      "tag": "Holiday",
      "tagColor": const Color(0xFF0D9488),
      "tagBg": const Color(0xFFCCFBF1),
      "desc":
          "Statutory gazetted national holiday for all students, teaching and non-teaching staff.",
      "time": "All Day",
      "venue": "Campus Closed",
      "category": "Holiday",
    },
    {
      "month": "OCT",
      "day": "14",
      "weekday": "Wed",
      "title": "Odd Semester Model Practical Examinations",
      "tag": "Assessment",
      "tagColor": const Color(0xFFDC2626),
      "tagBg": const Color(0xFFFEE2E2),
      "desc":
          "Autonomous model laboratory examinations and viva voce for all departments.",
      "time": "09:30 AM",
      "venue": "Department Laboratories",
      "category": "Assessment",
    },
    {
      "month": "OCT",
      "day": "25",
      "weekday": "Sun",
      "title": "National Technical Symposium: InnovateIQ 2026",
      "tag": "Event",
      "tagColor": const Color(0xFFD97706),
      "tagBg": const Color(0xFFFEF3C7),
      "desc":
          "Flagship technical paper presentation, hackathon and robotics competition.",
      "time": "09:00 AM",
      "venue": "Campus Auditorium & Tech Park",
      "category": "Event",
    },
    {
      "month": "NOV",
      "day": "04",
      "weekday": "Wed",
      "title": "End-Semester Practical Examinations",
      "tag": "Assessment",
      "tagColor": const Color(0xFFDC2626),
      "tagBg": const Color(0xFFFEE2E2),
      "desc":
          "University autonomous practical exams with external examiners appointment.",
      "time": "08:30 AM",
      "venue": "Institutional Labs",
      "category": "Assessment",
    },
    {
      "month": "NOV",
      "day": "14",
      "weekday": "Sat",
      "title": "Autonomous End-Semester Theory Exams Begin",
      "tag": "Milestone",
      "tagColor": const Color(0xFF2563EB),
      "tagBg": const Color(0xFFEFF6FF),
      "desc":
          "Commencement of major autonomous end-semester university written examinations.",
      "time": "10:00 AM",
      "venue": "Examination Halls 1 - 42",
      "category": "Milestone",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                // 1. HERO BLUEPRINT BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. OFFICIAL INSTITUTIONAL ACADEMIC CALENDAR CARD
                _buildCalendarHeaderCard(isWide),
                const SizedBox(height: 20),

                // 3. SEARCH & DROPDOWN & VIEW TOGGLE ROW
                _buildSearchAndFiltersRow(isWide),
                const SizedBox(height: 14),

                // 4. CATEGORY FILTER CHIPS
                _buildCategoryChips(),
                const SizedBox(height: 20),

                // 5. OFFICIAL ACADEMIC SCHEDULE & EVENTS LIST
                _buildEventsSection(),
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
                  Icons.calendar_month_rounded,
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
                  Row(
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
                      Text("Home",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF94A3B8))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text("Academics",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF94A3B8))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text("Academic Calendar",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 14),
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
                          "ACADEMICS",
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
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "MVP",
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
                            Icons.calendar_month_rounded,
                            color: Color(0xFFFBBF24),
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
                              "Academic Calendar",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Semester schedule, internal assessments, holidays and exam windows.",
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
  // 2. OFFICIAL INSTITUTIONAL ACADEMIC CALENDAR CARD
  // ===========================================================================
  Widget _buildCalendarHeaderCard(bool isWide) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 13, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text(
                      "Odd Semester 2026–27",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Week 12 of 21",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Official Institutional Academic Calendar",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Timetables, internal assessments, national holidays, model exams and university examination windows.",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildHeaderButtons(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Official Institutional Academic Calendar",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Timetables, internal assessments, national holidays, model exams and university examination windows.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildHeaderButtons(),
                  ],
                ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 4,
            children: [
              Text(
                "Term Start: Aug 1, 2026",
                style: GoogleFonts.poppins(
                    fontSize: 11.5, color: const Color(0xFF475569)),
              ),
              Text(
                "Progress: 57%",
                style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A)),
              ),
              Text(
                "Term End: Dec 20, 2026",
                style: GoogleFonts.poppins(
                    fontSize: 11.5, color: const Color(0xFF475569)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.57,
              minHeight: 6,
              backgroundColor: Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E2865)),
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isFourCol = constraints.maxWidth >= 750;
              final items = [
                _buildStatTile("Total Items", "10", "Scheduled this semester",
                    Icons.calendar_today_outlined, const Color(0xFF64748B)),
                _buildStatTile("Assessments", "3", "IA-I, IA-II & Model tests",
                    Icons.menu_book_outlined, const Color(0xFFDC2626)),
                _buildStatTile("Holidays", "2", "National & term vacations",
                    Icons.school_outlined, const Color(0xFF0D9488)),
                _buildStatTile("Workshops & Events", "3", "Symposiums & tech fests",
                    Icons.auto_awesome_outlined, const Color(0xFFD97706)),
              ];

              if (isFourCol) {
                return Row(
                  children: items
                      .map((widget) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: widget,
                            ),
                          ))
                      .toList(),
                );
              } else {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: items
                      .map((w) => SizedBox(
                            width: (constraints.maxWidth - 10) / 2,
                            child: w,
                          ))
                      .toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download_rounded, size: 14),
          label: const Text("Export .ics"),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1E293B),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sync_rounded, size: 14),
          label: const Text("Sync Events"),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1E293B),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
          label: Text(
            "Add Calendar Item",
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildStatTile(String label, String value, String sub, IconData icon,
      Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: const Color(0xFF64748B)),
                ),
              ),
              Icon(icon, size: 15, color: valueColor),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                fontSize: 10, color: const Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SEARCH & DROPDOWN & VIEW TOGGLE ROW
  // ===========================================================================
  Widget _buildSearchAndFiltersRow(bool isWide) {
    final searchInput = Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(fontSize: 12.5),
        decoration: const InputDecoration(
          hintText: "Search schedule, exams, venues...",
          hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          prefixIcon:
              Icon(Icons.search_rounded, size: 16, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 9),
        ),
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
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
              fontSize: 12.5, color: const Color(0xFF334155)),
          items: [
            "All Departments",
            "Computer Science & Engineering",
            "Information Technology",
            "Artificial Intelligence & DS",
            "Electronics & Communication",
            "Mechanical Engineering",
          ].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
          onChanged: (val) {
            if (val != null) setState(() => _selectedDept = val);
          },
        ),
      ),
    );

    final viewToggle = Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _activeView = 0),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _activeView == 0
                    ? const Color(0xFFF1F5F9)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.view_timeline_outlined,
                      size: 15,
                      color: _activeView == 0
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    "Timeline View",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight:
                          _activeView == 0 ? FontWeight.w600 : FontWeight.w400,
                      color: _activeView == 0
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => setState(() => _activeView = 1),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _activeView == 1
                    ? const Color(0xFFF1F5F9)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_view_month_rounded,
                      size: 15,
                      color: _activeView == 1
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    "Monthly Grid",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight:
                          _activeView == 1 ? FontWeight.w600 : FontWeight.w400,
                      color: _activeView == 1
                          ? const Color(0xFF0F172A)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (isWide) {
      return Row(
        children: [
          Expanded(flex: 3, child: searchInput),
          const SizedBox(width: 12),
          Expanded(flex: 3, child: deptDropdown),
          const SizedBox(width: 12),
          viewToggle,
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          searchInput,
          const SizedBox(height: 10),
          deptDropdown,
          const SizedBox(height: 10),
          Align(alignment: Alignment.centerLeft, child: viewToggle),
        ],
      );
    }
  }

  // ===========================================================================
  // 4. CATEGORY FILTER CHIPS
  // ===========================================================================
  Widget _buildCategoryChips() {
    final chips = [
      {"label": "All", "count": 10},
      {"label": "Assessment", "count": 3},
      {"label": "Holiday", "count": 2},
      {"label": "Exam cell", "count": 1},
      {"label": "Event", "count": 3},
      {"label": "Milestone", "count": 1},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.filter_list_rounded,
                  size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                "Filter:",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          for (int index = 0; index < chips.length; index++) ...[
            Builder(builder: (context) {
              final isSelected = _activeFilterChip == index;
              final c = chips[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => setState(() => _activeFilterChip = index),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          c["label"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF475569),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.2)
                                : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${c["count"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. OFFICIAL ACADEMIC SCHEDULE & EVENTS LIST (Adaptive & Responsive)
  // ===========================================================================
  Widget _buildEventsSection() {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Official Academic Schedule & Events",
                  style: GoogleFonts.poppins(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "8 entries",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          LayoutBuilder(
            builder: (context, constraints) {
              final isItemWide = constraints.maxWidth >= 650;

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _events.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  final ev = _events[index];

                  if (isItemWide) {
                    // DESKTOP / WIDE LAYOUT: Date Box -> Expanded Details -> Action Buttons on Right
                    return Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDateBox(ev),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    Text(
                                      ev["title"] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    _buildTagBadge(ev),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  ev["desc"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildTimeAndVenue(ev),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          _buildActionButtons(),
                        ],
                      ),
                    );
                  } else {
                    // MOBILE / NARROW LAYOUT: Date Box -> Expanded Details with buttons aligned below
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDateBox(ev),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    Text(
                                      ev["title"] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    _buildTagBadge(ev),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  ev["desc"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    color: const Color(0xFF64748B),
                                    height: 1.45,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildTimeAndVenue(ev),
                                const SizedBox(height: 12),
                                // Actions aligned right at bottom on mobile
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: _buildActionButtons(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateBox(Map<String, dynamic> ev) {
    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ev["month"] as String,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          Text(
            ev["day"] as String,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              height: 1.1,
            ),
          ),
          Text(
            ev["weekday"] as String,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagBadge(Map<String, dynamic> ev) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: ev["tagBg"] as Color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        ev["tag"] as String,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: ev["tagColor"] as Color,
        ),
      ),
    );
  }

  Widget _buildTimeAndVenue(Map<String, dynamic> ev) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.access_time_rounded,
                size: 13, color: Color(0xFF94A3B8)),
            const SizedBox(width: 4),
            Text(
              ev["time"] as String,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on_outlined,
                size: 13, color: Color(0xFF94A3B8)),
            const SizedBox(width: 4),
            Text(
              ev["venue"] as String,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit_outlined, size: 13),
          label: const Text("Edit"),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF334155),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        const SizedBox(width: 6),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline_rounded, size: 13),
          label: const Text("Delete"),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFDC2626),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            side: const BorderSide(color: Color(0xFFFEE2E2)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ],
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
      ..strokeWidth = 1.0;

    const double step = 28.0;

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
