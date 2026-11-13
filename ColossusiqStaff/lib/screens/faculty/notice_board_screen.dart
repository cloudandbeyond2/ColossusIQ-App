import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// NOTICE DATA MODEL
// =============================================================================
class NoticeItem {
  final String id;
  String title;
  bool hasBullet;
  String authorRole;
  String authorName;
  String dateStr;
  String audience;
  String category;
  List<String> tags;
  String body;
  String? venue;
  String? validity;
  int readCount;
  int ackCount;
  bool isUrgent;
  bool isUnread;
  bool toAcknowledge;
  bool isAcknowledged;
  bool isSentByMe;
  IconData icon;
  Color iconColor;
  Color iconBg;
  bool hasAmberBorder;
  bool isExpanded;
  bool hasOpenLink;
  bool hasDelete;
  bool showMarkAsRead;
  bool showIHaveReadThisButton;

  NoticeItem({
    required this.id,
    required this.title,
    this.hasBullet = false,
    required this.authorRole,
    required this.authorName,
    required this.dateStr,
    required this.audience,
    required this.category,
    required this.tags,
    required this.body,
    this.venue,
    this.validity,
    this.readCount = 0,
    this.ackCount = 0,
    this.isUrgent = false,
    this.isUnread = false,
    this.toAcknowledge = false,
    this.isAcknowledged = false,
    this.isSentByMe = false,
    this.icon = Icons.edit_note_rounded,
    this.iconColor = const Color(0xFFD97706),
    this.iconBg = const Color(0xFFFEF3C7),
    this.hasAmberBorder = false,
    this.isExpanded = true,
    this.hasOpenLink = false,
    this.hasDelete = false,
    this.showMarkAsRead = false,
    this.showIHaveReadThisButton = false,
  });
}

// =============================================================================
// NOTICE BOARD SCREEN (STAFF PORTAL - EXACT REPLICA)
// =============================================================================
class NoticeBoardScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const NoticeBoardScreen({super.key, this.onBack});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  int _selectedTab = 0; // 0: Notices, 1: New notice, 2: Sent by me
  String _selectedStatus = "All notices";
  String _selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();

  // New Notice Composer Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _validityController = TextEditingController();
  String _formCategory = "Academic";
  final String _formAudience = "Everyone";
  bool _isUrgent = false;

  final List<String> _categories = [
    "All",
    "Academic",
    "Examination",
    "Event",
    "Placement",
    "Holiday",
    "Fees",
    "Hostel & Transport",
    "General",
  ];

  late List<NoticeItem> _allNotices;

  @override
  void initState() {
    super.initState();
    _initNotices();
  }

  void _initNotices() {
    _allNotices = [
      // 1. Notice 1: test (Principal)
      NoticeItem(
        id: "n1",
        title: "test",
        hasBullet: true,
        authorRole: "Principal",
        authorName: "Dr. Lakshmi Sundaram",
        dateStr: "3 Nov, 11:08 am",
        audience: "Everyone",
        category: "Examination",
        tags: ["Important", "Examination"],
        body: "Assessment · 3 Nov - 11 Nov · Full day\nVenue: dfg\ngdf",
        validity: "Valid till 11 Nov",
        isUrgent: true,
        isUnread: true,
        toAcknowledge: false,
        isSentByMe: false,
        hasAmberBorder: true,
        icon: Icons.edit_note_rounded,
        iconColor: const Color(0xFFD97706),
        iconBg: const Color(0xFFFEF3C7),
        showMarkAsRead: true,
      ),

      // 2. Notice 2: Internal Assessment II (Faculty - Sent by me)
      NoticeItem(
        id: "n2",
        title: "Internal Assessment II Schedule & Exam Guidelines",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "8 Oct, 10:29 am",
        audience: "All students",
        category: "Academic",
        tags: ["Important", "Academic", "Expired"],
        body:
            "The Internal Assessment II examinations will commence on October 15, 2026. Important Guidelines:\n1. Detailed hall seating arrangements will be published by October 12.\n2. Students must carry their ID cards and hall tickets for all exam sessions.\n3. Mobile phones and smartwatches are strictly prohibited inside the exam hall.\nFor any queries, please reach out to your respective department coordinator.",
        validity: "Valid till 24 Oct",
        readCount: 2,
        ackCount: 2,
        isUrgent: true,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: true,
        icon: Icons.edit_note_rounded,
        iconColor: const Color(0xFFD97706),
        iconBg: const Color(0xFFFEF3C7),
        hasOpenLink: true,
        hasDelete: true,
      ),

      // 3. Notice 3: Testing (HOD - Needs Acknowledgement)
      NoticeItem(
        id: "n3",
        title: "Testing",
        authorRole: "HOD",
        authorName: "Dr. S. Venkatesh",
        dateStr: "21 Oct, 09:43 am",
        audience: "Everyone",
        category: "Academic",
        tags: ["Academic"],
        body: "Test message",
        validity: "Valid till 7 Nov",
        isUrgent: false,
        isUnread: false,
        toAcknowledge: true,
        isAcknowledged: false,
        isSentByMe: false,
        hasAmberBorder: false,
        icon: Icons.edit_note_rounded,
        iconColor: const Color(0xFF4F46E5),
        iconBg: const Color(0xFFEEF2FF),
        showIHaveReadThisButton: true,
      ),

      // 4. Notice 4: testt (Faculty - Sent by me)
      NoticeItem(
        id: "n4",
        title: "testt",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "13 Oct, 11:30 am",
        audience: "Everyone",
        category: "Holiday",
        tags: ["Holiday", "Expired"],
        body: "Holiday · 19 Oct · Full day",
        validity: "Valid till 19 Oct",
        readCount: 0,
        ackCount: 0,
        isUrgent: false,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: false,
        icon: Icons.edit_note_rounded,
        iconColor: const Color(0xFF6B7280),
        iconBg: const Color(0xFFF3F4F6),
        hasDelete: true,
      ),

      // 5. Notice 5: Monday will be Holiday (Faculty - Sent by me)
      NoticeItem(
        id: "n5",
        title: "Monday will be Holiday",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "13 Oct, 10:52 am",
        audience: "All students",
        category: "Holiday",
        tags: ["Holiday", "Expired"],
        body: "Sent by Dr. Meena Raghavan",
        validity: "Valid till 19 Oct",
        readCount: 1,
        ackCount: 1,
        isUrgent: false,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: false,
        icon: Icons.beach_access_rounded,
        iconColor: const Color(0xFF0284C7),
        iconBg: const Color(0xFFE0F2FE),
        hasDelete: true,
      ),

      // 6. Notice 6: Career & Placement Drive (Faculty - Sent by me)
      NoticeItem(
        id: "n6",
        title: "Career & Placement Drive",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "8 Oct, 10:12 am",
        audience: "All students",
        category: "Academic",
        tags: ["Academic"],
        body:
            "🚀 Placement Drive 2026\nMeet leading companies and explore exciting career opportunities.\n📅 12 November 2026\n📍 Seminar Hall",
        validity: "Valid till 31 Dec",
        readCount: 2,
        ackCount: 2,
        isUrgent: false,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: false,
        icon: Icons.business_center_outlined,
        iconColor: const Color(0xFF0D9488),
        iconBg: const Color(0xFFCCFBF1),
        hasDelete: true,
      ),

      // 7. Notice 7: Sports Day (Faculty - Sent by me)
      NoticeItem(
        id: "n7",
        title: "Sports Day",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "8 Oct, 10:12 am",
        audience: "All students",
        category: "Academic",
        tags: ["Academic"],
        body: "Annual inter-department sports competitions and track & field selections.",
        validity: "Valid till 30 Nov",
        readCount: 5,
        ackCount: 4,
        isUrgent: false,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: false,
        icon: Icons.emoji_events_outlined,
        iconColor: const Color(0xFFD97706),
        iconBg: const Color(0xFFFEF3C7),
        hasDelete: true,
      ),

      // 8. Notice 8: Faculty FDP (Faculty - Sent by me)
      NoticeItem(
        id: "n8",
        title: "Faculty Development Program on AI & Cloud",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "5 Oct, 02:15 pm",
        audience: "All Faculty",
        category: "Event",
        tags: ["Event"],
        body: "Hands-on workshop on Large Language Models and Cloud Microservices in CSE Lab 3.",
        validity: "Valid till 15 Nov",
        readCount: 12,
        ackCount: 9,
        isUrgent: false,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: false,
        icon: Icons.computer_rounded,
        iconColor: const Color(0xFF6366F1),
        iconBg: const Color(0xFFEEF2FF),
        hasDelete: true,
      ),

      // 9. Notice 9: Fee Payment Notice (Faculty - Sent by me)
      NoticeItem(
        id: "n9",
        title: "Even Semester Fee Payment Schedule",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "1 Oct, 11:00 am",
        audience: "All students",
        category: "Fees",
        tags: ["Fees", "Expired"],
        body: "Online payment gateway is now open for tuition and exam registration fees.",
        validity: "Valid till 20 Oct",
        readCount: 45,
        ackCount: 38,
        isUrgent: false,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: false,
        icon: Icons.account_balance_wallet_outlined,
        iconColor: const Color(0xFF10B981),
        iconBg: const Color(0xFFD1FAE5),
        hasDelete: true,
      ),

      // 10. Notice 10: Bus Route Timings (Faculty - Sent by me)
      NoticeItem(
        id: "n10",
        title: "Hostel & Transport Route Revision",
        authorRole: "Faculty",
        authorName: "Dr. Meena Raghavan",
        dateStr: "28 Sep, 09:30 am",
        audience: "Hostellers & Day Scholars",
        category: "Hostel & Transport",
        tags: ["Hostel & Transport"],
        body: "Route 12 and Route 18 evening departure timings updated to 5:45 PM.",
        validity: "Valid till 30 Nov",
        readCount: 28,
        ackCount: 22,
        isUrgent: false,
        isUnread: false,
        toAcknowledge: false,
        isSentByMe: true,
        hasAmberBorder: false,
        icon: Icons.directions_bus_outlined,
        iconColor: const Color(0xFFF97316),
        iconBg: const Color(0xFFFFEDD5),
        hasDelete: true,
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _venueController.dispose();
    _validityController.dispose();
    super.dispose();
  }

  void _publishNotice() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a notice title"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final newNotice = NoticeItem(
      id: "n_${DateTime.now().millisecondsSinceEpoch}",
      title: _titleController.text.trim(),
      authorRole: "Faculty",
      authorName: "Dr. Meena Raghavan",
      dateStr: "Just now",
      audience: _formAudience,
      category: _formCategory,
      tags: _isUrgent ? ["Important", _formCategory] : [_formCategory],
      body: _bodyController.text.trim().isEmpty
          ? "No additional description provided."
          : _bodyController.text.trim(),
      validity: _validityController.text.trim().isNotEmpty
          ? "Valid till ${_validityController.text.trim()}"
          : "Valid till 30 Nov",
      venue: _venueController.text.trim().isNotEmpty ? _venueController.text.trim() : null,
      isUrgent: _isUrgent,
      isUnread: false,
      toAcknowledge: false,
      isSentByMe: true,
      hasAmberBorder: _isUrgent,
      icon: Icons.edit_note_rounded,
      iconColor: _isUrgent ? const Color(0xFFD97706) : const Color(0xFF4F46E5),
      iconBg: _isUrgent ? const Color(0xFFFEF3C7) : const Color(0xFFEEF2FF),
      hasDelete: true,
    );

    setState(() {
      _allNotices.insert(0, newNotice);
      _titleController.clear();
      _bodyController.clear();
      _venueController.clear();
      _validityController.clear();
      _isUrgent = false;
      _selectedTab = 2; // Switch to "Sent by me"
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Notice published successfully!"),
        backgroundColor: Color(0xFF15803D),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteNotice(NoticeItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Delete Notice?",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        content: Text(
          "Are you sure you want to delete '${item.title}'? This action cannot be undone.",
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              final idx = _allNotices.indexOf(item);
              setState(() {
                _allNotices.remove(item);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Notice deleted", style: GoogleFonts.poppins()),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: "Undo",
                    textColor: const Color(0xFFFBBF24),
                    onPressed: () {
                      setState(() {
                        _allNotices.insert(idx >= 0 ? idx : 0, item);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 940;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP HERO BLUEPRINT BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. SUB-HEADER: TABS (LEFT) + ACKNOWLEDGEMENT ALERT (RIGHT)
                _buildTabsAndAlertRow(constraints),
                const SizedBox(height: 20),

                // 3. MAIN SECTION: NEW NOTICE FORM OR 2-COLUMN VIEW
                if (_selectedTab == 1) ...[
                  _buildNewNoticeForm(),
                ] else ...[
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Filter Sidebar (exact dimensions & style)
                        SizedBox(
                          width: 250,
                          child: _buildFilterSidebar(),
                        ),
                        const SizedBox(width: 20),

                        // Right Cards List
                        Expanded(
                          child: _buildNoticeCardsList(),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterSidebar(),
                        const SizedBox(height: 18),
                        _buildNoticeCardsList(),
                      ],
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. BLUEPRINT HERO BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1D2866),
            Color(0xFF2B3A8C),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
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

            // Subtle Bell Watermark Icon
            Positioned(
              right: 28,
              top: -12,
              bottom: -12,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.notifications_rounded,
                  size: 170,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb Row
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
                          "Overview",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Notice Board",
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

                  // Title Row with Icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bell Icon rounded box
                      Container(
                        width: 46,
                        height: 46,
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
                            Icons.notifications_rounded,
                            color: Color(0xFFFBBF24),
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Title + Badges + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges: OVERVIEW, MVP
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2352),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF38467D)),
                                  ),
                                  child: Text(
                                    "OVERVIEW",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),

                            Text(
                              "Notice Board",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              "Important announcements from your faculty, HOD, Principal and the University, with read and acknowledgement tracking.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFFC7D2FE).withValues(alpha: 0.92),
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
  // 2. SUB-HEADER: TABS + RIGHT ALERT PILL
  // ===========================================================================
  Widget _buildTabsAndAlertRow(BoxConstraints constraints) {
    final unacknowledgedCount = _allNotices
        .where((n) => n.toAcknowledge && !n.isAcknowledged)
        .length;
    final sentCount = _allNotices.where((n) => n.isSentByMe).length;
    final unreadCount = _allNotices.where((n) => n.isUnread).length;

    final tabsWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tab 0: Notices 1
        _buildNavTab(
          index: 0,
          label: "Notices",
          count: unreadCount > 0 ? unreadCount : null,
          icon: Icons.all_inbox_rounded,
        ),
        const SizedBox(width: 10),

        // Tab 1: New notice
        _buildNavTab(
          index: 1,
          label: "New notice",
          icon: Icons.edit_note_rounded,
        ),
        const SizedBox(width: 10),

        // Tab 2: Sent by me 8
        _buildNavTab(
          index: 2,
          label: "Sent by me",
          count: sentCount,
          icon: Icons.near_me_outlined,
        ),
      ],
    );

    // Right Alert Pill
    final alertPill = unacknowledgedCount > 0
        ? InkWell(
            onTap: () {
              setState(() {
                _selectedTab = 0;
                _selectedStatus = "To acknowledge";
                _selectedCategory = "All";
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFCA5A5).withValues(alpha: 0.6)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: Color(0xFFDC2626),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "$unacknowledgedCount notice need your acknowledgement",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF991B1B),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();

    if (constraints.maxWidth < 780) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: tabsWidget,
          ),
          if (unacknowledgedCount > 0) ...[
            const SizedBox(height: 12),
            alertPill,
          ],
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tabsWidget,
        alertPill,
      ],
    );
  }

  Widget _buildNavTab({
    required int index,
    required String label,
    required IconData icon,
    int? count,
  }) {
    final isSelected = _selectedTab == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF141938) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isSelected ? 0.08 : 0.02),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF334155),
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF283685) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$count",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. LEFT FILTER SIDEBAR
  // ===========================================================================
  Widget _buildFilterSidebar() {
    final list = _selectedTab == 2
        ? _allNotices.where((n) => n.isSentByMe).toList()
        : _allNotices;

    final allCount = list.length;
    final unreadCount = list.where((n) => n.isUnread).length;
    final urgentCount = list.where((n) => n.isUrgent).length;
    final ackCount = list.where((n) => n.toAcknowledge && !n.isAcknowledged).length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
          // Search Input
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF94A3B8),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 17,
                  color: Color(0xFF94A3B8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Status Filters
          _buildStatusFilterItem("All notices", allCount),
          _buildStatusFilterItem("Unread", unreadCount),
          _buildStatusFilterItem("Important & urgent", urgentCount),
          _buildStatusFilterItem("To acknowledge", ackCount),
          const SizedBox(height: 14),

          // Category Header
          Text(
            "CATEGORY",
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),

          // Category Chips Wrap
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _categories.map((cat) {
              final isCatSelected = _selectedCategory == cat;
              return InkWell(
                onTap: () => setState(() => _selectedCategory = cat),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                  decoration: BoxDecoration(
                    color: isCatSelected ? const Color(0xFF141938) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCatSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: isCatSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isCatSelected ? Colors.white : const Color(0xFF475569),
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

  Widget _buildStatusFilterItem(String title, int count) {
    final isSelected = _selectedStatus == title;

    return InkWell(
      onTap: () => setState(() => _selectedStatus = title),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF475569),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "$count",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. RIGHT NOTICES CARDS LIST
  // ===========================================================================
  Widget _buildNoticeCardsList() {
    final sourceList = _selectedTab == 2
        ? _allNotices.where((n) => n.isSentByMe).toList()
        : _allNotices;

    final query = _searchController.text.trim().toLowerCase();

    final filtered = sourceList.where((n) {
      if (_selectedCategory != "All" && n.category != _selectedCategory) {
        return false;
      }
      if (_selectedStatus == "Unread" && !n.isUnread) return false;
      if (_selectedStatus == "Important & urgent" && !n.isUrgent) return false;
      if (_selectedStatus == "To acknowledge" && (!n.toAcknowledge || n.isAcknowledged)) {
        return false;
      }
      if (query.isNotEmpty) {
        final title = n.title.toLowerCase();
        final content = n.body.toLowerCase();
        final author = n.authorName.toLowerCase();
        if (!title.contains(query) && !content.contains(query) && !author.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.mark_email_read_outlined, size: 48, color: Color(0xFF94A3B8)),
              const SizedBox(height: 12),
              Text(
                "No announcements found",
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
              ),
              const SizedBox(height: 4),
              Text(
                "Try selecting a different filter or clearing search criteria.",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filtered.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        return _buildNoticeCard(filtered[index]);
      },
    );
  }

  // ===========================================================================
  // INDIVIDUAL NOTICE CARD COMPONENT
  // ===========================================================================
  Widget _buildNoticeCard(NoticeItem n) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Left Accent Amber Border if applicable
            if (n.hasAmberBorder)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4.5,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              ),

            // Card Inner Padding
            Padding(
              padding: EdgeInsets.fromLTRB(n.hasAmberBorder ? 20 : 18, 16, 18, 14),
              child: LayoutBuilder(
                builder: (context, cardConstraints) {
                  final isNarrow = cardConstraints.maxWidth < 620;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Icon + Title + Badges (Responsive)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: n.iconBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(n.icon, size: 17, color: n.iconColor),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        n.hasBullet ? "• ${n.title}" : n.title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F172A),
                                          height: 1.35,
                                        ),
                                      ),
                                    ),
                                    if (!isNarrow && n.tags.isNotEmpty) ...[
                                      const SizedBox(width: 10),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 4,
                                        children: n.tags.map((tag) => _buildBadgeChip(tag)).toList(),
                                      ),
                                    ],
                                  ],
                                ),
                                if (isNarrow && n.tags.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 5,
                                    children: n.tags.map((tag) => _buildBadgeChip(tag)).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Subtitle: Role · Name · Date · Audience
                      Text(
                        "${n.authorRole} · ${n.authorName} · ${n.dateStr} · ${n.audience}",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Notice Body (with multi-line or collapse)
                      Text(
                        n.body,
                        maxLines: n.hasOpenLink && !n.isExpanded ? 2 : null,
                        overflow: n.hasOpenLink && !n.isExpanded
                            ? TextOverflow.ellipsis
                            : TextOverflow.visible,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Footer Row / Wrap: 100% Overflow-Free
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          // "Mark as read" Link if unread
                          if (n.showMarkAsRead && n.isUnread)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  n.isUnread = false;
                                  n.hasBullet = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Marked as read"),
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Text(
                                "Mark as read",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),

                          // Expander toggle "Show less" / "Show more"
                          if (n.hasOpenLink)
                            InkWell(
                              onTap: () => setState(() => n.isExpanded = !n.isExpanded),
                              child: Text(
                                n.isExpanded ? "Show less" : "Show more",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ),

                          // Open Link Icon
                          if (n.hasOpenLink)
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Opening attached document link..."),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.link_rounded, size: 14, color: Color(0xFF475569)),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Open link",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF475569),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Validity
                          if (n.validity != null)
                            Text(
                              n.validity!,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),

                          // Read stats
                          if (n.readCount > 0 || n.ackCount > 0)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.remove_red_eye_outlined, size: 13, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Text(
                                  "Read by ${n.readCount} · ${n.ackCount} acknowledged",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),

                          // Action: "I have read this" Button
                          if (n.showIHaveReadThisButton)
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  n.isAcknowledged = !n.isAcknowledged;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(n.isAcknowledged
                                        ? "Acknowledgment recorded"
                                        : "Acknowledgment revoked"),
                                    backgroundColor: n.isAcknowledged
                                        ? const Color(0xFF15803D)
                                        : const Color(0xFF1E2865),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: Icon(
                                n.isAcknowledged ? Icons.check_circle_rounded : Icons.check_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                              label: Text(
                                n.isAcknowledged ? "Acknowledged" : "I have read this",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: n.isAcknowledged
                                    ? const Color(0xFF15803D)
                                    : const Color(0xFF1E2865),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),

                          // Trash Icon Button for Deletion
                          if (n.hasDelete)
                            InkWell(
                              onTap: () => _deleteNotice(n),
                              borderRadius: BorderRadius.circular(6),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  size: 16,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeChip(String tag) {
    final isImportant = tag == "Important";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
      decoration: BoxDecoration(
        color: isImportant ? const Color(0xFFFEF3C7) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: isImportant ? const Color(0xFFD97706) : const Color(0xFF475569),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. NEW NOTICE COMPOSER FORM (TAB 1)
  // ===========================================================================
  Widget _buildNewNoticeForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Draft New Announcement",
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Broadcast a notice to students, faculty, departments, or entire institution.",
            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 20),

          // Title Input
          Text(
            "Notice Title *",
            style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _titleController,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "e.g., IA-II Schedule Confirmation & Room Allotment",
              hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),

          // Category & Priority (Responsive)
          LayoutBuilder(
            builder: (context, formConstraints) {
              final isSmall = formConstraints.maxWidth < 600;

              final categoryCol = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _formCategory,
                        isExpanded: true,
                        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                        items: _categories.where((c) => c != "All").map((c) {
                          return DropdownMenuItem(value: c, child: Text(c));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _formCategory = val);
                        },
                      ),
                    ),
                  ),
                ],
              );

              final priorityCol = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Priority Flag",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () => setState(() => _isUrgent = !_isUrgent),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mark as Important",
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                          ),
                          Switch(
                            value: _isUrgent,
                            activeThumbColor: const Color(0xFFD97706),
                            onChanged: (val) => setState(() => _isUrgent = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );

              if (isSmall) {
                return Column(
                  children: [
                    categoryCol,
                    const SizedBox(height: 14),
                    priorityCol,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: categoryCol),
                  const SizedBox(width: 16),
                  Expanded(child: priorityCol),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Validity & Venue (Responsive)
          LayoutBuilder(
            builder: (context, formConstraints) {
              final isSmall = formConstraints.maxWidth < 600;

              final validityCol = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Validity / Expiry Date",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _validityController,
                    style: GoogleFonts.poppins(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: "e.g., 20 Nov 2026",
                      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                ],
              );

              final venueCol = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Venue (Optional)",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _venueController,
                    style: GoogleFonts.poppins(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: "e.g., Seminar Hall, Block B",
                      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                ],
              );

              if (isSmall) {
                return Column(
                  children: [
                    validityCol,
                    const SizedBox(height: 14),
                    venueCol,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: validityCol),
                  const SizedBox(width: 16),
                  Expanded(child: venueCol),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Content body
          Text(
            "Notice Body *",
            style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _bodyController,
            maxLines: 4,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "Enter full announcement text, instructions, and guidelines...",
              hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 22),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => setState(() => _selectedTab = 0),
                child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B))),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _publishNotice,
                icon: const Icon(Icons.send_rounded, size: 16, color: Colors.white),
                label: Text(
                  "Publish Notice",
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
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
