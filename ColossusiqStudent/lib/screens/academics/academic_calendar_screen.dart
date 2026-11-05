import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// ACADEMICS: ACADEMIC CALENDAR SCREEN
// Dynamic Month-based Data: Month Change updates both Month Grid & List View
// Matches Image 1 (Month Grid View) & Image 2 (List View)
// =============================================================================

class CalendarEventItem {
  String id;
  String title;
  String type; // "Class", "Exam", "Assessment", "Holiday", "Event", "Workshop", "Deadline", "Other"
  int year;
  int month;
  List<int> monthDays; // Days in that month where this event displays
  String dateDisplay;
  String? desc;
  String? timeAndVenue;
  Color color;
  Color bgColor;
  Color textColor;

  CalendarEventItem({
    required this.id,
    required this.title,
    required this.type,
    required this.year,
    required this.month,
    required this.monthDays,
    required this.dateDisplay,
    this.desc,
    this.timeAndVenue,
    required this.color,
    required this.bgColor,
    required this.textColor,
  });
}

class AcademicCalendarScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AcademicCalendarScreen({super.key, this.onBack});

  @override
  State<AcademicCalendarScreen> createState() => _AcademicCalendarScreenState();
}

class _AcademicCalendarScreenState extends State<AcademicCalendarScreen> {
  int _viewMode = 0; // 0: Month View (Image 1), 1: List View (Image 2)
  String _selectedFilter = "All Types";
  DateTime _currentMonth = DateTime(2026, 10, 1);

  late List<CalendarEventItem> _events;

  @override
  void initState() {
    super.initState();
    _events = [
      // ─────────────────────────────────────────────────────────────────────────
      // SEPTEMBER 2026
      // ─────────────────────────────────────────────────────────────────────────
      CalendarEventItem(
        id: "sep1",
        title: "Orientation & Induction",
        type: "Class",
        year: 2026,
        month: 9,
        monthDays: [1, 2],
        dateDisplay: "1 Sep — 2 Sep",
        desc: "Welcome and orientation program for students and academic briefing.",
        timeAndVenue: "09:00 AM · University Auditorium",
        color: const Color(0xFF2563EB),
        bgColor: const Color(0xFFDBEAFE),
        textColor: const Color(0xFF1D4ED8),
      ),
      CalendarEventItem(
        id: "sep2",
        title: "Teachers' Day Celebrations",
        type: "Event",
        year: 2026,
        month: 9,
        monthDays: [5],
        dateDisplay: "5 Sep",
        desc: "Annual faculty felicitations and special department student seminars.",
        timeAndVenue: "02:00 PM · Central Seminar Hall",
        color: const Color(0xFF8B5CF6),
        bgColor: const Color(0xFFF3E8FF),
        textColor: const Color(0xFF7E22CE),
      ),
      CalendarEventItem(
        id: "sep3",
        title: "Engineers' Day Hackathon",
        type: "Workshop",
        year: 2026,
        month: 9,
        monthDays: [15],
        dateDisplay: "15 Sep · 09:00 · Lab 2",
        desc: "24-hour campus innovation hackathon and hardware exhibit.",
        timeAndVenue: "09:00 AM · Innovation Center",
        color: const Color(0xFF6366F1),
        bgColor: const Color(0xFFEEF2FF),
        textColor: const Color(0xFF4338CA),
      ),
      CalendarEventItem(
        id: "sep4",
        title: "Course Registration Closes",
        type: "Deadline",
        year: 2026,
        month: 9,
        monthDays: [21],
        dateDisplay: "21 Sep",
        desc: "Final deadline for professional elective enrollment and portal signoff.",
        timeAndVenue: "11:59 PM · Student Academic Portal",
        color: const Color(0xFFE11D48),
        bgColor: const Color(0xFFFEE2E2),
        textColor: const Color(0xFFDC2626),
      ),
      CalendarEventItem(
        id: "sep5",
        title: "IA-I Timetable Published",
        type: "Assessment",
        year: 2026,
        month: 9,
        monthDays: [29],
        dateDisplay: "29 Sep",
        desc: "Internal Assessment 1 schedules and seating matrices released.",
        timeAndVenue: "10:00 AM · Department Notice Board",
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
        textColor: const Color(0xFFB45309),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // OCTOBER 2026 (Matches User Reference Images 1 & 2 Pixel-for-Pixel)
      // ─────────────────────────────────────────────────────────────────────────
      CalendarEventItem(
        id: "e1",
        title: "Semester Commencement",
        type: "Class",
        year: 2026,
        month: 10,
        monthDays: [2],
        dateDisplay: "1 Oct",
        desc: "Official commencement of odd semester academic coursework.",
        timeAndVenue: "08:30 AM · Main Academic Block",
        color: const Color(0xFF2563EB),
        bgColor: const Color(0xFFDBEAFE),
        textColor: const Color(0xFF1D4ED8),
      ),
      CalendarEventItem(
        id: "e2",
        title: "Internal Assessment I",
        type: "Assessment",
        year: 2026,
        month: 10,
        monthDays: [7, 8, 9, 10, 11],
        dateDisplay: "6 Oct — 10 Oct",
        desc: "Written tests for all subjects.",
        timeAndVenue: "09:30 AM · Examination Hall 1 & 2",
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
        textColor: const Color(0xFFB45309),
      ),
      CalendarEventItem(
        id: "e3",
        title: "Python Workshop",
        type: "Workshop",
        year: 2026,
        month: 10,
        monthDays: [9],
        dateDisplay: "8 Oct  10:00  Lab 3",
        desc: "Hands-on data analytics and automation with Python.",
        timeAndVenue: "10:00 AM · Lab 3 Computing Center",
        color: const Color(0xFF6366F1),
        bgColor: const Color(0xFFEEF2FF),
        textColor: const Color(0xFF4338CA),
      ),
      CalendarEventItem(
        id: "e4",
        title: "Diwali Holiday",
        type: "Holiday",
        year: 2026,
        month: 10,
        monthDays: [14, 15, 16],
        dateDisplay: "13 Oct — 15 Oct",
        desc: "Campus closed for Diwali festival celebrations.",
        timeAndVenue: "All Day · Campus Closed",
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFDCFCE7),
        textColor: const Color(0xFF15803D),
      ),
      CalendarEventItem(
        id: "e5",
        title: "Guest Lecture - Dr. Rajan",
        type: "Event",
        year: 2026,
        month: 10,
        monthDays: [18],
        dateDisplay: "17 Oct  14:00  Seminar Hall",
        desc: "Distinguished industry lecture on high performance cloud architectures.",
        timeAndVenue: "14:00 · Seminar Hall",
        color: const Color(0xFF8B5CF6),
        bgColor: const Color(0xFFF3E8FF),
        textColor: const Color(0xFF7E22CE),
      ),
      CalendarEventItem(
        id: "e6",
        title: "Assignment Submission Deadline",
        type: "Deadline",
        year: 2026,
        month: 10,
        monthDays: [21],
        dateDisplay: "20 Oct",
        desc: "Submission cut-off for Machine Learning & Database coursework assignments.",
        timeAndVenue: "11:59 PM · Student Portal Submission Box",
        color: const Color(0xFFE11D48),
        bgColor: const Color(0xFFFEE2E2),
        textColor: const Color(0xFFDC2626),
      ),
      CalendarEventItem(
        id: "e7",
        title: "Internal Assessment II",
        type: "Assessment",
        year: 2026,
        month: 10,
        monthDays: [23, 24, 25, 26],
        dateDisplay: "23 Oct — 26 Oct",
        desc: "Mid-term written tests and theory evaluations across all branches.",
        timeAndVenue: "09:30 AM · Examination Hall 1 & 2",
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
        textColor: const Color(0xFFB45309),
      ),
      CalendarEventItem(
        id: "e8",
        title: "Department Technical Fest",
        type: "Event",
        year: 2026,
        month: 10,
        monthDays: [28],
        dateDisplay: "28 Oct  09:00  Campus Grounds",
        desc: "Hackathon, paper presentation, and coding challenges.",
        timeAndVenue: "09:00 AM · Campus Grounds & Auditorium",
        color: const Color(0xFF8B5CF6),
        bgColor: const Color(0xFFF3E8FF),
        textColor: const Color(0xFF7E22CE),
      ),
      CalendarEventItem(
        id: "e9",
        title: "Project Review",
        type: "Assessment",
        year: 2026,
        month: 10,
        monthDays: [30],
        dateDisplay: "30 Oct  11:00  Conference Hall",
        desc: "Phase 1 Capstone Project milestone viva & review.",
        timeAndVenue: "11:00 AM · Conference Hall",
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
        textColor: const Color(0xFFB45309),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // NOVEMBER 2026
      // ─────────────────────────────────────────────────────────────────────────
      CalendarEventItem(
        id: "nov1",
        title: "National Symposium TECHVISTA",
        type: "Event",
        year: 2026,
        month: 11,
        monthDays: [2],
        dateDisplay: "2 Nov",
        desc: "Inter-collegiate paper presentation and project design competition.",
        timeAndVenue: "09:00 AM · APJ Abdul Kalam Auditorium",
        color: const Color(0xFF8B5CF6),
        bgColor: const Color(0xFFF3E8FF),
        textColor: const Color(0xFF7E22CE),
      ),
      CalendarEventItem(
        id: "nov2",
        title: "Cloud & DevOps Masterclass",
        type: "Workshop",
        year: 2026,
        month: 11,
        monthDays: [6],
        dateDisplay: "6 Nov · 10:00 · Lab 1",
        desc: "Kubernetes clustering and production CI/CD pipelines hands-on lab.",
        timeAndVenue: "10:00 AM · Lab 1 Systems Lab",
        color: const Color(0xFF6366F1),
        bgColor: const Color(0xFFEEF2FF),
        textColor: const Color(0xFF4338CA),
      ),
      CalendarEventItem(
        id: "nov3",
        title: "Last Working Day for Theory Classes",
        type: "Class",
        year: 2026,
        month: 11,
        monthDays: [14],
        dateDisplay: "14 Nov",
        desc: "Completion of semester syllabus and attendance verification sign-off.",
        timeAndVenue: "05:00 PM · Office of Dean Academics",
        color: const Color(0xFF2563EB),
        bgColor: const Color(0xFFDBEAFE),
        textColor: const Color(0xFF1D4ED8),
      ),
      CalendarEventItem(
        id: "nov4",
        title: "Practical Lab Examinations Begin",
        type: "Assessment",
        year: 2026,
        month: 11,
        monthDays: [18, 19, 20, 21],
        dateDisplay: "18 Nov — 21 Nov",
        desc: "External examiner evaluations and laboratory viva voce.",
        timeAndVenue: "08:30 AM · Department Tech Labs",
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
        textColor: const Color(0xFFB45309),
      ),
      CalendarEventItem(
        id: "nov5",
        title: "Final Capstone Code Submission",
        type: "Deadline",
        year: 2026,
        month: 11,
        monthDays: [25],
        dateDisplay: "25 Nov",
        desc: "GitHub repository and documentation upload cutoff on portal.",
        timeAndVenue: "11:59 PM · Portal Repository Link",
        color: const Color(0xFFE11D48),
        bgColor: const Color(0xFFFEE2E2),
        textColor: const Color(0xFFDC2626),
      ),
      CalendarEventItem(
        id: "nov6",
        title: "Model Theory Examinations",
        type: "Exam",
        year: 2026,
        month: 11,
        monthDays: [27, 28, 29],
        dateDisplay: "27 Nov — 29 Nov",
        desc: "Full syllabus preparatory examinations for university semester window.",
        timeAndVenue: "09:30 AM · Central Exam Halls",
        color: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
        textColor: const Color(0xFFDC2626),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // DECEMBER 2026
      // ─────────────────────────────────────────────────────────────────────────
      CalendarEventItem(
        id: "dec1",
        title: "End Semester Theory Examinations",
        type: "Exam",
        year: 2026,
        month: 12,
        monthDays: [1, 2, 4, 7, 9, 11, 14],
        dateDisplay: "1 Dec — 14 Dec",
        desc: "University autonomous semester end theory examinations.",
        timeAndVenue: "09:30 AM · Main Examination Block",
        color: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
        textColor: const Color(0xFFDC2626),
      ),
      CalendarEventItem(
        id: "dec2",
        title: "Central Valuation & Grade Entry",
        type: "Assessment",
        year: 2026,
        month: 12,
        monthDays: [18, 19],
        dateDisplay: "18 Dec — 19 Dec",
        desc: "Faculty evaluation board and controller of exams moderation.",
        timeAndVenue: "10:00 AM · Valuation Center",
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
        textColor: const Color(0xFFB45309),
      ),
      CalendarEventItem(
        id: "dec3",
        title: "Winter Vacation & Christmas Holidays",
        type: "Holiday",
        year: 2026,
        month: 12,
        monthDays: [24, 25, 26, 27, 28, 29, 30, 31],
        dateDisplay: "24 Dec — 31 Dec",
        desc: "Semester recess and festive winter holidays observed.",
        timeAndVenue: "All Day · Campus Recess",
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFDCFCE7),
        textColor: const Color(0xFF15803D),
      ),

      // ─────────────────────────────────────────────────────────────────────────
      // JANUARY 2027
      // ─────────────────────────────────────────────────────────────────────────
      CalendarEventItem(
        id: "jan1",
        title: "Even Semester Reopening",
        type: "Class",
        year: 2027,
        month: 1,
        monthDays: [4],
        dateDisplay: "4 Jan",
        desc: "Commencement of even semester classes and curriculum distribution.",
        timeAndVenue: "08:30 AM · Department Classrooms",
        color: const Color(0xFF2563EB),
        bgColor: const Color(0xFFDBEAFE),
        textColor: const Color(0xFF1D4ED8),
      ),
      CalendarEventItem(
        id: "jan2",
        title: "Pongal & Makar Sankranti Holidays",
        type: "Holiday",
        year: 2027,
        month: 1,
        monthDays: [14, 15, 16],
        dateDisplay: "14 Jan — 16 Jan",
        desc: "Traditional harvest festival campus holidays.",
        timeAndVenue: "All Day · Campus Closed",
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFDCFCE7),
        textColor: const Color(0xFF15803D),
      ),
      CalendarEventItem(
        id: "jan3",
        title: "Campus Placement Drive - Phase 1",
        type: "Event",
        year: 2027,
        month: 1,
        monthDays: [22],
        dateDisplay: "22 Jan  09:00  Placement Cell",
        desc: "Tier-1 software and product company on-campus recruitment interviews.",
        timeAndVenue: "09:00 AM · Placement Hub",
        color: const Color(0xFF8B5CF6),
        bgColor: const Color(0xFFF3E8FF),
        textColor: const Color(0xFF7E22CE),
      ),
      CalendarEventItem(
        id: "jan4",
        title: "Republic Day Celebrations",
        type: "Holiday",
        year: 2027,
        month: 1,
        monthDays: [26],
        dateDisplay: "26 Jan",
        desc: "National flag hoisting and university ceremonial parade.",
        timeAndVenue: "08:00 AM · University Stadium",
        color: const Color(0xFF10B981),
        bgColor: const Color(0xFFDCFCE7),
        textColor: const Color(0xFF15803D),
      ),
    ];  
  }

  // Filter events strictly by selected Year and Month
  List<CalendarEventItem> get _filteredEvents {
    final list = _events.where((e) => e.year == _currentMonth.year && e.month == _currentMonth.month).toList();
    if (_selectedFilter == "All Types") return list;
    return list.where((e) => e.type.toLowerCase() == _selectedFilter.toLowerCase()).toList();
  }

  void _goToToday() {
    setState(() {
      _currentMonth = DateTime(2026, 10, 1);
    });
  }

  void _changeMonth(int delta) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + delta, 1);
    });
  }

  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Academic Calendar",
      category: "Academics",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner (Pixel-perfect match to Image 1)
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Academics  ›  Academic Calendar",
          category: "ACADEMICS",
          phase: "MVP",
          isMvp: true,
          icon: Icons.calendar_month_rounded,
          title: "Academic Calendar",
          subtitle: "Semester schedule, internal assessments, holidays and exam windows.",
          watermarkIcon: Icons.calendar_month_rounded,
        ),
        const SizedBox(height: 18),

        // 2. Navigation Header Row (< October 2026 > Today)
        Row(
          children: [
            InkWell(
              onTap: () => _changeMonth(-1),
              borderRadius: BorderRadius.circular(6),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.chevron_left_rounded, size: 22, color: Color(0xFF475569)),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: () => _changeMonth(1),
              borderRadius: BorderRadius.circular(6),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.chevron_right_rounded, size: 22, color: Color(0xFF475569)),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: _goToToday,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                "Today",
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF334155)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // 3. Filter Dropdown (All Types)
        Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFilter,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF334155), size: 20),
              isExpanded: true,
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
              items: const [
                DropdownMenuItem(value: "All Types", child: Text("All Types")),
                DropdownMenuItem(value: "Class", child: Text("Class")),
                DropdownMenuItem(value: "Exam", child: Text("Exam")),
                DropdownMenuItem(value: "Assessment", child: Text("Assessment")),
                DropdownMenuItem(value: "Holiday", child: Text("Holiday")),
                DropdownMenuItem(value: "Event", child: Text("Event")),
                DropdownMenuItem(value: "Workshop", child: Text("Workshop")),
                DropdownMenuItem(value: "Deadline", child: Text("Deadline")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedFilter = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 4. View Switcher Tabs (Month | List) + Type Legend Row
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Segmented pill switch: Month | List
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildToggleTab("Month", isSelected: _viewMode == 0, onTap: () => setState(() => _viewMode = 0)),
                  _buildToggleTab("List", isSelected: _viewMode == 1, onTap: () => setState(() => _viewMode = 1)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Legend dots row matching Image 1 & 2
            Wrap(
              spacing: 16,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildLegendItem("Class", const Color(0xFF2563EB)),
                _buildLegendItem("Exam", const Color(0xFFEF4444)),
                _buildLegendItem("Assessment", const Color(0xFFF59E0B)),
                _buildLegendItem("Holiday", const Color(0xFF10B981)),
                _buildLegendItem("Event", const Color(0xFF8B5CF6)),
                _buildLegendItem("Workshop", const Color(0xFF6366F1)),
                _buildLegendItem("Deadline", const Color(0xFFE11D48)),
                _buildLegendItem("Other", const Color(0xFF94A3B8)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18),

        // 5. Main Content: Month View (Image 1) or List View (Image 2)
        if (_viewMode == 0)
          _buildMonthCalendarGrid()
        else
          _buildListView(),
      ],
    );
  }

  Widget _buildToggleTab(String label, {required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141938) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color dotColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7.5,
          height: 7.5,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5.5),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w500, color: const Color(0xFF475569)),
        ),
      ],
    );
  }

  // =============================================================================
  // DYNAMIC MONTH GRID VIEW (Image 1)
  // Computes exact weekdays, days in month, and displays events for selected month
  // =============================================================================
  Widget _buildMonthCalendarGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Table min-width ensures cells stay legible and responsive across devices
        final minTableWidth = constraints.maxWidth < 740 ? 740.0 : constraints.maxWidth;

        final int year = _currentMonth.year;
        final int month = _currentMonth.month;

        final DateTime firstOfMonth = DateTime(year, month, 1);
        // In Dart, Monday = 1, ..., Sunday = 7. Sunday as 0:
        final int firstWeekday = firstOfMonth.weekday % 7;

        final DateTime nextMonth = DateTime(year, month + 1, 1);
        final int daysInCurrentMonth = nextMonth.difference(firstOfMonth).inDays;

        final DateTime prevMonth = DateTime(year, month - 1, 1);
        final int daysInPrevMonth = firstOfMonth.difference(prevMonth).inDays;

        // Build array of day cells
        List<_DayCellData> allCells = [];

        // 1. Trailing previous month days
        for (int i = firstWeekday - 1; i >= 0; i--) {
          final dayNum = daysInPrevMonth - i;
          allCells.add(_DayCellData(
            dayNumber: "$dayNum",
            isPrevMonth: true,
          ));
        }

        // 2. Current month days
        final now = DateTime.now();
        for (int d = 1; d <= daysInCurrentMonth; d++) {
          final isToday = (year == 2026 && month == 10 && d == 31) ||
              (year == now.year && month == now.month && d == now.day);

          allCells.add(_DayCellData(
            dayNumber: "$d",
            isPrevMonth: false,
            isToday: isToday,
            events: _getEventsForDay(d),
          ));
        }

        // 3. Leading next month days to complete 5 or 6 full weeks (35 or 42 cells)
        final int targetTotal = allCells.length <= 35 ? 35 : 42;
        int nextDayCounter = 1;
        while (allCells.length < targetTotal) {
          allCells.add(_DayCellData(
            dayNumber: "$nextDayCounter",
            isPrevMonth: true,
            isNextMonth: true,
          ));
          nextDayCounter++;
        }

        // Chunk into weeks (7 days per row)
        List<List<_DayCellData>> weeks = [];
        for (int i = 0; i < allCells.length; i += 7) {
          weeks.add(allCells.sublist(i, i + 7));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: minTableWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Day Headers (Sun - Sat)
                Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
                  ),
                  child: Row(
                    children: [
                      _buildHeaderCell("Sun"),
                      _buildHeaderCell("Mon"),
                      _buildHeaderCell("Tue"),
                      _buildHeaderCell("Wed"),
                      _buildHeaderCell("Thu"),
                      _buildHeaderCell("Fri"),
                      _buildHeaderCell("Sat"),
                    ],
                  ),
                ),

                // Calendar Rows
                for (int w = 0; w < weeks.length; w++)
                  _buildCalendarWeekRow(
                    weeks[w],
                    isLastRow: w == weeks.length - 1,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<CalendarEventItem> _getEventsForDay(int day) {
    return _filteredEvents.where((e) => e.monthDays.contains(day)).toList();
  }

  Widget _buildHeaderCell(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarWeekRow(List<_DayCellData> days, {bool isLastRow = false}) {
    return Container(
      decoration: BoxDecoration(
        border: isLastRow ? null : const Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(days.length, (index) {
          final cellData = days[index];
          final isLastCol = index == days.length - 1;
          return Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 88),
              decoration: BoxDecoration(
                border: isLastCol ? null : const Border(right: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              padding: const EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Number (or highlighted circle if today)
                  if (cellData.isToday)
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFF141938),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cellData.dayNumber,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    )
                  else
                    Text(
                      cellData.dayNumber,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: cellData.isPrevMonth ? const Color(0xFF94A3B8) : const Color(0xFF334155),
                      ),
                    ),

                  // Event Badges inside day cell
                  if (cellData.events != null && cellData.events!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    ...cellData.events!.map((ev) => _buildDayEventBadge(ev)),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDayEventBadge(CalendarEventItem ev) {
    return InkWell(
      onTap: () => _showEventDetailsDialog(ev),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 3.5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: ev.bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          ev.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: ev.textColor,
          ),
        ),
      ),
    );
  }

  // =============================================================================
  // DYNAMIC LIST VIEW (Image 2)
  // Displays filtered events for the currently selected Month & Year
  // =============================================================================
  Widget _buildListView() {
    final events = _filteredEvents;
    if (events.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: [
            const Icon(Icons.event_busy_rounded, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            Text(
              "No events scheduled for ${_getMonthName(_currentMonth.month)} ${_currentMonth.year}",
              style: GoogleFonts.poppins(fontSize: 14.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
            ),
            const SizedBox(height: 4),
            Text(
              "Use previous or next navigation controls to browse other months.",
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: events.map((ev) => _buildListEventCard(ev)).toList(),
    );
  }

  Widget _buildListEventCard(CalendarEventItem ev) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showEventDetailsDialog(ev),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Colored Vertical Bar Indicator
              Container(
                width: 4,
                height: 48,
                decoration: BoxDecoration(
                  color: ev.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 14),

              // Content Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Type Pill
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          ev.title,
                          style: GoogleFonts.poppins(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: ev.bgColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            ev.type,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: ev.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),

                    // Date & Location Subtitle
                    Text(
                      ev.dateDisplay,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Optional Description Line
                    if (ev.desc != null && ev.desc!.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        ev.desc!,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF475569),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Action Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF0F766E)),
                    onPressed: () => _showEventDetailsDialog(ev),
                    tooltip: "View Details",
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF4338CA)),
                    onPressed: () => _showEditEventDialog(ev),
                    tooltip: "Edit Event",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================================
  // EVENT DETAILS & EDIT DIALOGS (Responsive with Wrap)
  // =============================================================================
  void _showEventDetailsDialog(CalendarEventItem ev) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ev.bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.calendar_month_outlined, color: ev.textColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ev.title,
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                  ),
                  Text(
                    "${ev.type} · ${ev.dateDisplay}",
                    style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time_rounded, size: 16, color: Color(0xFF64748B)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          ev.timeAndVenue ?? ev.dateDisplay,
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF334155)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: ev.bgColor, borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          ev.type,
                          style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: ev.textColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Event Description",
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8)),
                ),
                const SizedBox(height: 4),
                Text(
                  ev.desc ?? "Official academic timeline milestone logged in central college portal.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _showEditEventDialog(ev);
                },
                icon: const Icon(Icons.edit_outlined, size: 14),
                label: const Text("Edit Event"),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF141938),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditEventDialog(CalendarEventItem ev) {
    final titleCtrl = TextEditingController(text: ev.title);
    final dateCtrl = TextEditingController(text: ev.dateDisplay);
    final descCtrl = TextEditingController(text: ev.desc ?? "");
    final venueCtrl = TextEditingController(text: ev.timeAndVenue ?? "");
    String selectedType = ev.type;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setModalState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Edit Academic Event",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 440),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(labelText: "Event Title", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: selectedType,
                    decoration: const InputDecoration(labelText: "Event Category", border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(value: "Class", child: Text("Class")),
                      DropdownMenuItem(value: "Exam", child: Text("Exam")),
                      DropdownMenuItem(value: "Assessment", child: Text("Assessment")),
                      DropdownMenuItem(value: "Holiday", child: Text("Holiday")),
                      DropdownMenuItem(value: "Event", child: Text("Event")),
                      DropdownMenuItem(value: "Workshop", child: Text("Workshop")),
                      DropdownMenuItem(value: "Deadline", child: Text("Deadline")),
                      DropdownMenuItem(value: "Other", child: Text("Other")),
                    ],
                    onChanged: (val) {
                      if (val != null) setModalState(() => selectedType = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: dateCtrl,
                    decoration: const InputDecoration(labelText: "Display Date (e.g. 6 Oct — 10 Oct)", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: venueCtrl,
                    decoration: const InputDecoration(labelText: "Time & Venue", border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ev.title = titleCtrl.text.trim();
                      ev.type = selectedType;
                      ev.dateDisplay = dateCtrl.text.trim();
                      ev.desc = descCtrl.text.trim();
                      ev.timeAndVenue = venueCtrl.text.trim();
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Event '${ev.title}' updated successfully!"),
                        backgroundColor: const Color(0xFF15803D),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141938),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DayCellData {
  final String dayNumber;
  final bool isPrevMonth;
  final bool isNextMonth;
  final bool isToday;
  final List<CalendarEventItem>? events;

  _DayCellData({
    required this.dayNumber,
    this.isPrevMonth = false,
    this.isNextMonth = false,
    this.isToday = false,
    this.events,
  });
}
