import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// =============================================================================
// CALENDAR EVENT MODEL
// =============================================================================
class CalendarEvent {
  final String id;
  String title;
  String category; // 'Assessment', 'Holiday', 'Exam cell', 'Event', 'Milestone'
  String department; // 'All Departments', 'Computer Science & Engineering', etc.
  String audience; // 'Everyone (All)', 'Students Only', 'Faculty Only', etc.
  bool isAllDay;
  DateTime startDate;
  DateTime? endDate;
  String timeStr;
  String venue;
  String description;
  bool postToNoticeBoard;
  bool isImportant;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.category,
    this.department = 'All Departments',
    this.audience = 'Everyone (All)',
    this.isAllDay = false,
    required this.startDate,
    this.endDate,
    this.timeStr = 'Full day',
    this.venue = '',
    this.description = '',
    this.postToNoticeBoard = false,
    this.isImportant = false,
  });

  Color get categoryColor {
    switch (category) {
      case 'Assessment':
        return const Color(0xFFDC2626); // Red
      case 'Holiday':
        return const Color(0xFF10B981); // Emerald Green
      case 'Exam cell':
        return const Color(0xFF3B82F6); // Blue
      case 'Event':
        return const Color(0xFFA855F7); // Purple
      case 'Milestone':
        return const Color(0xFF06B6D4); // Cyan
      default:
        return const Color(0xFF6B7280);
    }
  }

  Color get categoryBgColor {
    switch (category) {
      case 'Assessment':
        return const Color(0xFFFEE2E2);
      case 'Holiday':
        return const Color(0xFFDCFCE7);
      case 'Exam cell':
        return const Color(0xFFDBEAFE);
      case 'Event':
        return const Color(0xFFF3E8FF);
      case 'Milestone':
        return const Color(0xFFE0F2FE);
      default:
        return const Color(0xFFF3F4F6);
    }
  }

  Color get categoryTextColor {
    switch (category) {
      case 'Assessment':
        return const Color(0xFFDC2626);
      case 'Holiday':
        return const Color(0xFF15803D);
      case 'Exam cell':
        return const Color(0xFF1D4ED8);
      case 'Event':
        return const Color(0xFF7E22CE);
      case 'Milestone':
        return const Color(0xFF0369A1);
      default:
        return const Color(0xFF374151);
    }
  }

  bool occursOn(DateTime date) {
    final cur = DateTime(date.year, date.month, date.day);
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    if (endDate != null) {
      final end = DateTime(endDate!.year, endDate!.month, endDate!.day);
      return !cur.isBefore(start) && !cur.isAfter(end);
    }
    return cur.isAtSameMomentAs(start);
  }
}

// =============================================================================
// ACADEMIC CALENDAR SCREEN
// =============================================================================
class AcademicCalendarScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AcademicCalendarScreen({super.key, this.onBack});

  @override
  State<AcademicCalendarScreen> createState() => _AcademicCalendarScreenState();
}

class _AcademicCalendarScreenState extends State<AcademicCalendarScreen> {
  // Navigation & View State
  DateTime _currentMonth = DateTime(2026, 11, 1);
  int _viewMode = 0; // 0: Month Grid, 1: List View
  String _selectedCategory = 'All Categories';
  String _selectedDept = 'All Departments';
  bool _isSyncing = false;

  final List<String> _departments = [
    'All Departments',
    'Administration',
    'Artificial Intelligence & Data Science',
    'Civil Engineering',
    'Computer Science & Engineering',
    'Electrical & Electronics',
    'Electronics & Communication',
    'Information Technology',
    'Mechanical Engineering',
    'Science & Humanities',
  ];

  final List<String> _categoryOptions = [
    'All Categories',
    'Assessment',
    'Holiday',
    'Exam cell',
    'Event',
    'Milestone',
  ];

  // 13 Pre-populated events matching the reference screens
  late List<CalendarEvent> _events;

  @override
  void initState() {
    super.initState();
    _events = [
      CalendarEvent(
        id: '1',
        title: 'test',
        category: 'Assessment',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: true,
        startDate: DateTime(2026, 11, 3),
        endDate: DateTime(2026, 11, 11),
        timeStr: 'Full day',
        venue: 'dfg',
        description: 'gdf',
        isImportant: true,
      ),
      CalendarEvent(
        id: '2',
        title: 'Workshop Event 2026',
        category: 'Event',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: false,
        startDate: DateTime(2026, 11, 6),
        timeStr: '09:00 AM',
        venue: 'Main Campus Auditorium',
        description:
            'Annual inter-collegiate student technical workshop and developer hackathon sessions.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '3',
        title: 'Generative AI & LLM Deployment Workshop 2026',
        category: 'Event',
        department: 'Computer Science & Engineering',
        audience: 'Everyone (All)',
        isAllDay: false,
        startDate: DateTime(2026, 11, 7),
        timeStr: '09:00 AM',
        venue: 'Central Computing Lab & Seminar Hall A',
        description:
            'Comprehensive hands-on training on transformer architectures, fine-tuning techniques, and deployment paradigms.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '4',
        title: 'National Symposium on Quantum & Edge Computing',
        category: 'Event',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: false,
        startDate: DateTime(2026, 11, 8),
        timeStr: '10:00 AM',
        venue: 'Dr. APJ Abdul Kalam Auditorium',
        description:
            'Distinguished guest lectures from industry scientists and research paper presentations by UG/PG scholars.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '5',
        title: 'Deepavali Festival Holiday',
        category: 'Holiday',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: true,
        startDate: DateTime(2026, 11, 1),
        timeStr: 'Full day',
        venue: 'Campus Closed',
        description: 'Statutory festive holiday observed across all university colleges.',
        isImportant: true,
      ),
      CalendarEvent(
        id: '6',
        title: 'Guru Nanak Jayanti Holiday',
        category: 'Holiday',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: true,
        startDate: DateTime(2026, 11, 15),
        timeStr: 'Full day',
        venue: 'Campus Closed',
        description: 'Statutory gazetted national holiday for all students and faculty.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '7',
        title: 'University Founders Day Holiday',
        category: 'Holiday',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: true,
        startDate: DateTime(2026, 11, 28),
        timeStr: 'Full day',
        venue: 'Campus Closed',
        description: 'Annual institutional commemoration holiday across all affiliated campuses.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '8',
        title: 'Cloud DevOps Bootcamp Session',
        category: 'Event',
        department: 'Computer Science & Engineering',
        audience: 'Students Only',
        isAllDay: false,
        startDate: DateTime(2026, 11, 13),
        timeStr: '02:00 PM',
        venue: 'CSE Lab 3',
        description: 'Industry certified instructor session on Kubernetes clusters and GitHub Actions.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '9',
        title: 'Cyber Security Awareness Seminar',
        category: 'Event',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: false,
        startDate: DateTime(2026, 11, 17),
        timeStr: '11:00 AM',
        venue: 'Mechanical Seminar Hall',
        description: 'Interactive session on phishing detection, multi-factor auth and safe institutional computing.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '10',
        title: 'Robotics & Embedded Systems Expo',
        category: 'Event',
        department: 'Electronics & Communication',
        audience: 'Everyone (All)',
        isAllDay: false,
        startDate: DateTime(2026, 11, 20),
        timeStr: '10:00 AM',
        venue: 'ECE Project Lab',
        description: 'Live hardware exhibition featuring autonomous rovers and IoT smart sensor systems.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '11',
        title: 'Faculty Development Programme (FDP)',
        category: 'Event',
        department: 'All Departments',
        audience: 'Faculty Only',
        isAllDay: false,
        startDate: DateTime(2026, 11, 23),
        timeStr: '09:30 AM',
        venue: 'Conference Hall B',
        description: 'Pedagogy workshop on outcome-based education and NBA accreditation criteria.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '12',
        title: 'Alumni Entrepreneurship Talk',
        category: 'Event',
        department: 'All Departments',
        audience: 'Everyone (All)',
        isAllDay: false,
        startDate: DateTime(2026, 11, 25),
        timeStr: '03:00 PM',
        venue: 'Main Auditorium',
        description: 'Interactive fireside chat with high-growth startup founders from alumni network.',
        isImportant: false,
      ),
      CalendarEvent(
        id: '13',
        title: 'End-Semester Exam Portal Registration Closes',
        category: 'Exam cell',
        department: 'All Departments',
        audience: 'Students Only',
        isAllDay: false,
        startDate: DateTime(2026, 11, 30),
        timeStr: '05:00 PM',
        venue: 'Examination Cell Portal',
        description: 'Final date for verifying internal marks and generating hall tickets.',
        isImportant: true,
      ),
    ];
  }

  // Filtered Events
  List<CalendarEvent> get _filteredEvents {
    return _events.where((e) {
      if (_selectedCategory != 'All Categories' && e.category != _selectedCategory) {
        return false;
      }
      if (_selectedDept != 'All Departments' && e.department != _selectedDept && e.department != 'All Departments') {
        return false;
      }
      return true;
    }).toList();
  }

  // Metrics (matching exactly: Total: 13, Assessments: 1, Holidays: 3, Milestones: 0)
  int get _totalScheduled => _events.length;
  int get _assessmentsCount => _events.where((e) => e.category == 'Assessment').length;
  int get _holidaysCount => _events.where((e) => e.category == 'Holiday').length;
  int get _milestonesCount => _events.where((e) => e.category == 'Milestone').length;

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _goToToday() {
    setState(() {
      _currentMonth = DateTime(2026, 11, 1);
    });
  }

  void _syncEvents() async {
    setState(() => _isSyncing = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      setState(() => _isSyncing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Academic Calendar synced with University Master Schedule.',
            style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFF1E2865),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  // ===========================================================================
  // ADD / EDIT EVENT MODAL (MATCHING IMAGE 3 EXACTLY)
  // ===========================================================================
  void _openEventModal({CalendarEvent? existingEvent, DateTime? initialDate}) {
    final isEditing = existingEvent != null;
    final titleCtrl = TextEditingController(text: existingEvent?.title ?? '');
    final venueCtrl = TextEditingController(text: existingEvent?.venue ?? '');
    final descCtrl = TextEditingController(text: existingEvent?.description ?? '');

    String selectedCat = existingEvent?.category ?? 'Assessment';
    String selectedDept = existingEvent?.department ?? 'All Departments';
    String selectedAudience = existingEvent?.audience ?? 'Everyone (All)';
    bool isAllDay = existingEvent?.isAllDay ?? true;
    DateTime startDate = existingEvent?.startDate ?? initialDate ?? DateTime(2026, 11, 3);
    DateTime? endDate = existingEvent?.endDate ?? (isEditing ? null : DateTime(2026, 11, 11));
    bool postNotice = existingEvent?.postToNoticeBoard ?? true;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Modal Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isEditing ? 'Edit Event' : 'Add Event',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E2865),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close_rounded, size: 18, color: Color(0xFF6B7280)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Title *
                        _buildFieldLabel('Title *'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: titleCtrl,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF1E2865)),
                          decoration: _inputDecoration(hint: 'e.g. Internal Assessment I'),
                        ),
                        const SizedBox(height: 16),

                        // Two Column: Category / Type * & Department
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = constraints.maxWidth < 450;
                            final children = [
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Category / Type *'),
                                    const SizedBox(height: 6),
                                    _buildDropdownField<String>(
                                      value: selectedCat,
                                      items: const ['Assessment', 'Holiday', 'Exam cell', 'Event', 'Milestone'],
                                      onChanged: (val) {
                                        if (val != null) setDialogState(() => selectedCat = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: isMobile ? 0 : 16, height: isMobile ? 16 : 0),
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Department'),
                                    const SizedBox(height: 6),
                                    _buildDropdownField<String>(
                                      value: selectedDept,
                                      items: _departments,
                                      onChanged: (val) {
                                        if (val != null) setDialogState(() => selectedDept = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ];

                            return isMobile ? Column(children: children) : Row(children: children);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Two Column: Audience & All Day checkbox
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = constraints.maxWidth < 450;
                            final children = [
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Audience'),
                                    const SizedBox(height: 6),
                                    _buildDropdownField<String>(
                                      value: selectedAudience,
                                      items: const [
                                        'Everyone (All)',
                                        'Students Only',
                                        'Faculty Only',
                                        'HODs & Principal'
                                      ],
                                      onChanged: (val) {
                                        if (val != null) setDialogState(() => selectedAudience = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: isMobile ? 0 : 16, height: isMobile ? 16 : 0),
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Duration'),
                                    const SizedBox(height: 6),
                                    InkWell(
                                      onTap: () => setDialogState(() => isAllDay = !isAllDay),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 44,
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: const Color(0xFFE5E7EB)),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Checkbox(
                                                value: isAllDay,
                                                activeColor: const Color(0xFF1E2865),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                onChanged: (v) => setDialogState(() => isAllDay = v ?? false),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'All day event',
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 13,
                                                color: const Color(0xFF374151),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ];

                            return isMobile ? Column(children: children) : Row(children: children);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Two Column: Start Date * & End Date
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = constraints.maxWidth < 450;
                            final children = [
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Start Date *'),
                                    const SizedBox(height: 6),
                                    _buildDatePickerField(
                                      context: dialogCtx,
                                      date: startDate,
                                      onDateSelected: (newDate) {
                                        setDialogState(() => startDate = newDate);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: isMobile ? 0 : 16, height: isMobile ? 16 : 0),
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('End Date (Optional)'),
                                    const SizedBox(height: 6),
                                    _buildDatePickerField(
                                      context: dialogCtx,
                                      date: endDate,
                                      allowClear: true,
                                      onDateSelected: (newDate) {
                                        setDialogState(() => endDate = newDate);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ];

                            return isMobile ? Column(children: children) : Row(children: children);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Venue
                        _buildFieldLabel('Venue'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: venueCtrl,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF1E2865)),
                          decoration: _inputDecoration(hint: 'e.g. Seminar Hall / Exam Hall A / Online'),
                        ),
                        const SizedBox(height: 16),

                        // Description
                        _buildFieldLabel('Description'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: descCtrl,
                          maxLines: 3,
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF1E2865)),
                          decoration: _inputDecoration(hint: 'Details regarding event schedule, participants and notes...'),
                        ),
                        const SizedBox(height: 16),

                        // Post announcement checkbox
                        InkWell(
                          onTap: () => setDialogState(() => postNotice = !postNotice),
                          borderRadius: BorderRadius.circular(6),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Checkbox(
                                  value: postNotice,
                                  activeColor: const Color(0xFF1E2865),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  onChanged: (v) => setDialogState(() => postNotice = v ?? false),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Post announcement to Notice Board and notify attendees',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    color: const Color(0xFF374151),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF4B5563),
                                side: const BorderSide(color: Color(0xFFD1D5DB)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                final title = titleCtrl.text.trim();
                                if (title.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please enter an event title',
                                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  if (isEditing) {
                                    existingEvent.title = title;
                                    existingEvent.category = selectedCat;
                                    existingEvent.department = selectedDept;
                                    existingEvent.audience = selectedAudience;
                                    existingEvent.isAllDay = isAllDay;
                                    existingEvent.startDate = startDate;
                                    existingEvent.endDate = endDate;
                                    existingEvent.venue = venueCtrl.text.trim();
                                    existingEvent.description = descCtrl.text.trim();
                                    existingEvent.postToNoticeBoard = postNotice;
                                  } else {
                                    _events.insert(
                                      0,
                                      CalendarEvent(
                                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                                        title: title,
                                        category: selectedCat,
                                        department: selectedDept,
                                        audience: selectedAudience,
                                        isAllDay: isAllDay,
                                        startDate: startDate,
                                        endDate: endDate,
                                        timeStr: isAllDay ? 'Full day' : '09:00 AM',
                                        venue: venueCtrl.text.trim(),
                                        description: descCtrl.text.trim(),
                                        postToNoticeBoard: postNotice,
                                        isImportant: selectedCat == 'Assessment',
                                      ),
                                    );
                                  }
                                });

                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isEditing ? 'Event updated successfully' : 'Event added to Academic Calendar',
                                      style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                    backgroundColor: const Color(0xFF1E2865),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2865),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                isEditing ? 'Save Changes' : 'Add Event',
                                style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Delete Confirmation
  void _confirmDeleteEvent(CalendarEvent event) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          'Delete Event',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: const Color(0xFF1E2865)),
        ),
        content: Text(
          'Are you sure you want to remove "${event.title}" from the academic schedule?',
          style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF4B5563)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.plusJakartaSans(color: const Color(0xFF6B7280))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _events.removeWhere((e) => e.id == event.id);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Event deleted',
                    style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Delete', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // Event Detail Modal (when clicked from Month Grid)
  void _showEventDetail(CalendarEvent event) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: event.categoryBgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        event.category,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: event.categoryTextColor,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(ctx),
                      borderRadius: BorderRadius.circular(20),
                      child: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  event.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E2865),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF6B7280)),
                    const SizedBox(width: 6),
                    Text(
                      event.endDate != null
                          ? '${DateFormat('d MMM yyyy').format(event.startDate)} – ${DateFormat('d MMM yyyy').format(event.endDate!)} · ${event.timeStr}'
                          : '${DateFormat('d MMM yyyy').format(event.startDate)} · ${event.timeStr}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF6B7280)),
                    ),
                  ],
                ),
                if (event.venue.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF6B7280)),
                      const SizedBox(width: 6),
                      Text(
                        event.venue,
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF6B7280)),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.groups_outlined, size: 14, color: Color(0xFF6B7280)),
                    const SizedBox(width: 6),
                    Text(
                      '${event.department} · ${event.audience}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF6B7280)),
                    ),
                  ],
                ),
                if (event.description.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Text(
                      event.description,
                      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF374151), height: 1.4),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _confirmDeleteEvent(event);
                      },
                      icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626)),
                      tooltip: 'Delete Event',
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _openEventModal(existingEvent: event);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: Text('Edit', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // BUILD METHOD
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HERO BLUEPRINT BANNER
              _buildHeroBanner(),
              const SizedBox(height: 16),

              // 2. ACADEMIC TERM CARD
              _buildAcademicTermCard(),
              const SizedBox(height: 16),

              // 3. 4 KPI STAT CARDS
              _buildKpiCardsRow(),
              const SizedBox(height: 20),

              // 4. CONTROLS BAR (Date navigator, Dept filter, View switch, Add Event button)
              _buildControlsBar(),
              const SizedBox(height: 14),

              // 5. CATEGORY FILTER PILLS
              _buildCategoryPillsRow(),
              const SizedBox(height: 18),

              // 6. MAIN CONTENT: MONTH GRID OR LIST VIEW
              _viewMode == 0 ? _buildMonthCalendarGrid() : _buildEventsListView(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. BLUEPRINT HERO BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E2865),
            Color(0xFF283593),
            Color(0xFF1E2865),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background Blueprint Grid
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(
                  gridColor: Colors.white.withValues(alpha: 0.07),
                  step: 26.0,
                ),
              ),
            ),
            // Watermark icon on right
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.calendar_month_rounded,
                size: 160,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  Row(
                    children: [
                      if (widget.onBack != null) ...[
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back_ios_new_rounded, size: 12, color: Colors.white70),
                              const SizedBox(width: 4),
                              Text(
                                'Home',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Home',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.75),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      Text(
                        '  ›  Academics  ›  ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        'Academic Calendar',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tag badges row: ACADEMICS + MVP
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ACADEMICS',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'MVP',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Icon + Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF141B4D),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xFFF59E0B),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Academic Calendar',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Semester schedule, internal assessments, holidays and exam windows.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.82),
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
  // 2. ACADEMIC TERM CARD
  // ===========================================================================
  Widget _buildAcademicTermCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 620;

          final termInfo = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACADEMIC TERM',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Odd Semester 2026–27',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E2865),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '1 Aug 2026 – 20 Dec 2026',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );

          final progressAndSync = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: isNarrow ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    'Progress',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Week 15 of 21',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E2865),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: _isSyncing ? null : _syncEvents,
                icon: _isSyncing
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF1E2865)),
                      )
                    : const Icon(Icons.sync_rounded, size: 16, color: Color(0xFF374151)),
                label: Text(
                  'Sync Events',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD1D5DB)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                termInfo,
                const SizedBox(height: 14),
                progressAndSync,
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              termInfo,
              progressAndSync,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 3. 4 KPI STAT CARDS ROW
  // ===========================================================================
  Widget _buildKpiCardsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // 4 in a row if wide, 2 in a row if medium, 1 in a row if narrow
        double itemWidth;
        if (width >= 900) {
          itemWidth = (width - 48) / 4;
        } else if (width >= 550) {
          itemWidth = (width - 16) / 2;
        } else {
          itemWidth = width;
        }

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildSingleKpiCard(
              title: 'Total Scheduled',
              value: '$_totalScheduled',
              valueColor: const Color(0xFF1E2865),
              width: itemWidth,
            ),
            _buildSingleKpiCard(
              title: 'Assessments & Exams',
              value: '$_assessmentsCount',
              valueColor: const Color(0xFFDC2626),
              width: itemWidth,
            ),
            _buildSingleKpiCard(
              title: 'Holidays & Breaks',
              value: '$_holidaysCount',
              valueColor: const Color(0xFF059669),
              width: itemWidth,
            ),
            _buildSingleKpiCard(
              title: 'Key Milestones',
              value: '$_milestonesCount',
              valueColor: const Color(0xFF2563EB),
              width: itemWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSingleKpiCard({
    required String title,
    required String value,
    required Color valueColor,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. CONTROLS BAR (NAVIGATOR, DEPT, VIEW MODE, ADD EVENT)
  // ===========================================================================
  Widget _buildControlsBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 780;

        // Month Navigator widget
        final monthNavigator = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _previousMonth,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.chevron_left_rounded, size: 18, color: Color(0xFF4B5563)),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat('MMMM yyyy').format(_currentMonth),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E2865),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: _nextMonth,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF4B5563)),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: _goToToday,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Today',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                  ),
                ),
              ),
            ),
          ],
        );

        // Action widgets
        final actions = Wrap(
          spacing: 10,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Department Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFD97706),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedDept,
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  elevation: 6,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF1E2865)),
                  selectedItemBuilder: (context) {
                    return _departments.map((dept) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dept,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: const Color(0xFF1E2865),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  items: _departments.map((dept) {
                    final isSelected = dept == _selectedDept;
                    return DropdownMenuItem<String>(
                      value: dept,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF1D68D8) : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          dept,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: isSelected ? Colors.white : const Color(0xFF1F2937),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedDept = val);
                  },
                ),
              ),
            ),

            // View toggle: [Month] [List]
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildViewTab(title: 'Month', index: 0),
                  _buildViewTab(title: 'List', index: 1),
                ],
              ),
            ),

            // + Add Event Button
            ElevatedButton.icon(
              onPressed: () => _openEventModal(),
              icon: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
              label: Text(
                'Add Event',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              monthNavigator,
              const SizedBox(height: 12),
              actions,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            monthNavigator,
            actions,
          ],
        );
      },
    );
  }

  Widget _buildViewTab({required String title, required int index}) {
    final isActive = _viewMode == index;
    return InkWell(
      onTap: () => setState(() => _viewMode = index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E2865) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. CATEGORY FILTER PILLS
  // ===========================================================================
  Widget _buildCategoryPillsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categoryOptions.map((cat) {
          final isSelected = _selectedCategory == cat;
          Color? dotColor;
          if (cat == 'Assessment') dotColor = const Color(0xFFDC2626);
          if (cat == 'Holiday') dotColor = const Color(0xFF10B981);
          if (cat == 'Exam cell') dotColor = const Color(0xFF3B82F6);
          if (cat == 'Event') dotColor = const Color(0xFFA855F7);
          if (cat == 'Milestone') dotColor = const Color(0xFF06B6D4);

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () => setState(() => _selectedCategory = cat),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE5E7EB),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (dotColor != null) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      cat,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ===========================================================================
  // 6A. MONTH CALENDAR GRID VIEW (MATCHES IMAGE 1 & 2)
  // ===========================================================================
  Widget _buildMonthCalendarGrid() {
    final year = _currentMonth.year;
    final month = _currentMonth.month;

    // Total days in current month
    final daysInMonth = DateTime(year, month + 1, 0).day;
    // Weekday of 1st day (1 = Mon, ..., 7 = Sun)
    final firstWeekday = DateTime(year, month, 1).weekday;
    // We want Sunday as column 0 (0 = Sun, 1 = Mon, ..., 6 = Sat)
    final startOffset = firstWeekday == 7 ? 0 : firstWeekday;

    // Calculate total calendar cells needed (multiples of 7)
    final totalCells = ((startOffset + daysInMonth + 6) ~/ 7) * 7;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Days of week header (Sun, Mon, Tue, Wed, Thu, Fri, Sat)
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              children: const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((d) {
                return Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      d,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Grid rows
          LayoutBuilder(
            builder: (context, constraints) {
              final numRows = totalCells ~/ 7;

              return Column(
                children: List.generate(numRows, (rowIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: rowIndex == numRows - 1
                            ? BorderSide.none
                            : const BorderSide(color: Color(0xFFE5E7EB)),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(7, (colIndex) {
                          final cellIndex = rowIndex * 7 + colIndex;
                          final dayNumber = cellIndex - startOffset + 1;
                          final isCurrentMonth = dayNumber >= 1 && dayNumber <= daysInMonth;

                          DateTime? cellDate;
                          List<CalendarEvent> dayEvents = [];

                          if (isCurrentMonth) {
                            cellDate = DateTime(year, month, dayNumber);
                            dayEvents = _filteredEvents.where((e) => e.occursOn(cellDate!)).toList();
                          }

                          // Today highlight: Day 10 in Nov 2026 as shown in screenshot
                          final isToday = isCurrentMonth && year == 2026 && month == 11 && dayNumber == 10;

                          return Expanded(
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 90),
                              decoration: BoxDecoration(
                                color: isCurrentMonth ? Colors.white : const Color(0xFFFBFBFB),
                                border: Border(
                                  right: colIndex == 6
                                      ? BorderSide.none
                                      : const BorderSide(color: Color(0xFFE5E7EB)),
                                ),
                              ),
                              child: InkWell(
                                onTap: isCurrentMonth
                                    ? () => _openEventModal(initialDate: cellDate)
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Day Number Row
                                      if (isCurrentMonth) ...[
                                        if (isToday)
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF1E2865),
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '$dayNumber',
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        else
                                          Text(
                                            '$dayNumber',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF374151),
                                            ),
                                          ),
                                        const SizedBox(height: 4),

                                        // Events in this day
                                        ...dayEvents.map((event) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 3.0),
                                            child: InkWell(
                                              onTap: () => _showEventDetail(event),
                                              borderRadius: BorderRadius.circular(4),
                                              child: Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: event.categoryBgColor,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  event.title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.plusJakartaSans(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    color: event.categoryTextColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6B. EVENTS LIST VIEW (MATCHES IMAGE 4)
  // ===========================================================================
  Widget _buildEventsListView() {
    final list = _filteredEvents;

    if (list.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(Icons.event_busy_rounded, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              'No events found for this filter',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B5563),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Try changing your category or department selection',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      separatorBuilder: (_, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final event = list[index];
        return _buildEventCardItem(event);
      },
    );
  }

  Widget _buildEventCardItem(CalendarEvent event) {
    // Format date string: "3 Nov – 11 Nov · Full day" or "6 Nov 2026 · 09:00"
    String dateRangeStr;
    if (event.endDate != null) {
      dateRangeStr =
          '${DateFormat('d MMM').format(event.startDate)} – ${DateFormat('d MMM').format(event.endDate!)} · ${event.timeStr}';
    } else {
      dateRangeStr = '${DateFormat('d MMM yyyy').format(event.startDate)} · ${event.timeStr}';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: event.categoryColor,
                width: 5,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: LayoutBuilder(
            builder: (context, cardConstraints) {
              final isNarrow = cardConstraints.maxWidth < 650;

              // Badges component
              final badgesWidget = Wrap(
                spacing: 6,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (event.isImportant)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Important',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: event.categoryBgColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      event.category,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: event.categoryTextColor,
                      ),
                    ),
                  ),
                ],
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Square icon box
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: event.categoryBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.edit_note_rounded,
                      size: 20,
                      color: event.categoryTextColor,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // All text & details inside Expanded to prevent any right overflow
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: Title and Badges
                        if (isNarrow) ...[
                          Text(
                            event.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E2865),
                            ),
                            softWrap: true,
                          ),
                          const SizedBox(height: 6),
                          badgesWidget,
                        ] else ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  event.title,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E2865),
                                  ),
                                  softWrap: true,
                                ),
                              ),
                              const SizedBox(width: 8),
                              badgesWidget,
                            ],
                          ),
                        ],
                        const SizedBox(height: 4),

                        // Date & Subtitle
                        Text(
                          '${event.category} · $dateRangeStr',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B7280),
                          ),
                        ),

                        // Venue
                        if (event.venue.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Venue: ${event.venue}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ],

                        // Description
                        if (event.description.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            event.description,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: const Color(0xFF4B5563),
                              height: 1.4,
                            ),
                          ),
                        ],

                        const SizedBox(height: 10),

                        // Bottom Meta & Action Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                event.endDate != null
                                    ? 'Valid till ${DateFormat('d MMM').format(event.endDate!)}'
                                    : 'Valid on ${DateFormat('d MMM').format(event.startDate)}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  color: const Color(0xFF9CA3AF),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _openEventModal(existingEvent: event),
                                  icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF6B7280)),
                                  tooltip: 'Edit Event',
                                  splashRadius: 18,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 14),
                                IconButton(
                                  onPressed: () => _confirmDeleteEvent(event),
                                  icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFDC2626)),
                                  tooltip: 'Delete Event',
                                  splashRadius: 18,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // HELPER WIDGETS FOR FORM FIELDS
  // ===========================================================================
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF374151),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF9CA3AF)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF6B7280)),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: const Color(0xFF1E2865),
            fontWeight: FontWeight.w500,
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text('$item', overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDatePickerField({
    required BuildContext context,
    required DateTime? date,
    required ValueChanged<DateTime> onDateSelected,
    bool allowClear = false,
  }) {
    final text = date != null ? DateFormat('yyyy-MM-dd').format(date) : 'Select date';

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime(2026, 11, 1),
          firstDate: DateTime(2026, 1, 1),
          lastDate: DateTime(2027, 12, 31),
          builder: (ctx, child) {
            return Theme(
              data: Theme.of(ctx).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF1E2865),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Color(0xFF1E2865),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: date != null ? const Color(0xFF1E2865) : const Color(0xFF9CA3AF),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF6B7280)),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _BlueprintGridPainter({required this.gridColor, this.step = 26.0});

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
  bool shouldRepaint(covariant _BlueprintGridPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
