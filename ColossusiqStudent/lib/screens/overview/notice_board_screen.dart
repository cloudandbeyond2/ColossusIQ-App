import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// STUDENT: NOTICE BOARD SCREEN
// Matches Image 1 (media_1793777571663_ac781ca6.jpg)
// and Image 2 (media_1793777591793_887a14ae.jpg)
// =============================================================================

class NoticeBoardScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const NoticeBoardScreen({super.key, this.onBack});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  String _selectedStatus = "All notices";
  String _selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = const [
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

  // 7 Pre-populated notices strictly matching Image 1 & Image 2
  late List<Map<String, dynamic>> _notices;

  @override
  void initState() {
    super.initState();
    _notices = [
      {
        "id": "1",
        "title": "test",
        "category": "Examination",
        "isImportant": true,
        "isUnread": true,
        "toAcknowledge": false,
        "acknowledged": false,
        "authorRole": "Principal",
        "authorName": "Dr. Lakshmi Sundaram",
        "date": "3 Nov, 11:08 am",
        "audience": "Everyone",
        "accentColor": const Color(0xFFF59E0B),
        "icon": Icons.edit_note_rounded,
        "bodyLines": [
          "Assessment · 3 Nov – 11 Nov · Full day",
          "Venue: dfg",
          "gdf",
        ],
        "validTill": "Valid till 11 Nov",
      },
      {
        "id": "2",
        "title": "Testing",
        "category": "Academic",
        "isImportant": false,
        "isUnread": true,
        "toAcknowledge": true,
        "acknowledged": false,
        "authorRole": "HOD",
        "authorName": "Dr. S. Venkatesh",
        "date": "21 Oct, 09:43 am",
        "audience": "Everyone",
        "accentColor": const Color(0xFF6366F1),
        "icon": Icons.edit_note_rounded,
        "bodyLines": [
          "Test message",
        ],
        "validTill": "Valid till 7 Nov",
      },
      {
        "id": "3",
        "title": "College Cultural Fest",
        "category": "Academic",
        "isImportant": false,
        "isUnread": true,
        "toAcknowledge": true,
        "acknowledged": false,
        "authorRole": "Faculty",
        "authorName": "Dr. Meena Raghavan",
        "date": "8 Oct, 10:12 am",
        "audience": "All students",
        "accentColor": const Color(0xFF3B82F6),
        "icon": Icons.auto_awesome_rounded,
        "bodyLines": [
          "✨ Annual Cultural Fest 2026",
          "Showcase your talent, enjoy amazing performances, and celebrate together!",
          "📅 25 October 2026",
          "📍 Main Campus",
        ],
        "validTill": "Valid till 31 Dec",
      },
      {
        "id": "4",
        "title": "Freshers Day",
        "category": "Event",
        "isImportant": false,
        "isUnread": true,
        "toAcknowledge": true,
        "acknowledged": false,
        "authorRole": "Faculty",
        "authorName": "Dr. Meena Raghavan",
        "date": "8 Oct, 10:11 am",
        "audience": "All students",
        "accentColor": const Color(0xFF0EA5E9),
        "icon": Icons.calendar_month_outlined,
        "bodyLines": [
          "🎓 Welcome Freshers 2026!",
          "Get ready for an exciting day filled with fun, music, games, and new memories.",
          "📅 15 October 2026",
          "⏰ 10:00 AM onwards",
          "📍 College Auditorium",
          "Join us & make your first day unforgettable!",
        ],
        "validTill": "Valid till 31 Dec",
      },
      {
        "id": "5",
        "title": "Career & Placement Drive",
        "category": "Academic",
        "isImportant": false,
        "isUnread": false,
        "toAcknowledge": false,
        "acknowledged": true,
        "authorRole": "Faculty",
        "authorName": "Dr. Meena Raghavan",
        "date": "8 Oct, 10:12 am",
        "audience": "All students",
        "accentColor": const Color(0xFF10B981),
        "icon": Icons.work_outline_rounded,
        "bodyLines": [
          "🚀 Placement Drive 2026",
          "Meet leading companies and explore exciting career opportunities.",
          "📅 12 November 2026",
          "📍 Seminar Hall",
        ],
        "validTill": "Valid till 31 Dec",
      },
      {
        "id": "6",
        "title": "Sports Day",
        "category": "Academic",
        "isImportant": false,
        "isUnread": false,
        "toAcknowledge": true,
        "acknowledged": false,
        "authorRole": "Faculty",
        "authorName": "Dr. Meena Raghavan",
        "date": "8 Oct, 10:12 am",
        "audience": "All students",
        "accentColor": const Color(0xFFF59E0B),
        "icon": Icons.emoji_events_outlined,
        "bodyLines": [
          "🏆 Annual Sports Day 2026",
          "Get ready to compete, cheer for your team, and make unforgettable memories!",
          "📅 5 November 2026",
          "📍 College Sports Ground",
        ],
        "validTill": "Valid till 31 Dec",
      },
      {
        "id": "7",
        "title": "Internal Exam Schedule",
        "category": "Examination",
        "isImportant": false,
        "isUnread": false,
        "toAcknowledge": false,
        "acknowledged": false,
        "authorRole": "Faculty",
        "authorName": "Dr. Meena Raghavan",
        "date": "8 Oct, 10:09 am",
        "audience": "All students",
        "accentColor": const Color(0xFF8B5CF6),
        "icon": Icons.assignment_outlined,
        "bodyLines": [
          "✨ Internal Exam Schedule",
          "Internal exams will start from 15 October.",
          "📅 15 Oct 2026",
        ],
        "validTill": "Valid till 15 Oct",
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _markAsRead(Map<String, dynamic> notice) {
    setState(() {
      notice["isUnread"] = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Marked '${notice["title"]}' as read", style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _acknowledgeNotice(Map<String, dynamic> notice) {
    setState(() {
      notice["toAcknowledge"] = false;
      notice["acknowledged"] = true;
      notice["isUnread"] = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Acknowledged: '${notice["title"]}'",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0D9488),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showNoticeDetails(Map<String, dynamic> notice) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (notice["accentColor"] as Color).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        notice["icon"] as IconData,
                        color: notice["accentColor"] as Color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notice["title"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "${notice["authorRole"]} · ${notice["authorName"]} · ${notice["date"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 16),
                ...((notice["bodyLines"] as List<String>).map((line) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      line,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        color: const Color(0xFF1E293B),
                        height: 1.45,
                      ),
                    ),
                  );
                })),
                const SizedBox(height: 16),
                Text(
                  notice["validTill"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        "Close",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    if (notice["toAcknowledge"] == true) ...[
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _acknowledgeNotice(notice);
                        },
                        icon: const Icon(Icons.check_rounded, size: 15),
                        label: Text(
                          "I have read this",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF161F38),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int allCount = _notices.length;
    final int unreadCount = _notices.where((n) => n["isUnread"] == true).length;
    final int urgentCount = _notices.where((n) => n["isImportant"] == true).length;
    final int ackCount = _notices.where((n) => n["toAcknowledge"] == true).length;

    return PortalPageBody(
      title: "Notice Board",
      category: "Overview",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Overview  ›  Notice Board",
          category: "OVERVIEW",
          phase: "MVP",
          isMvp: true,
          icon: Icons.notifications_rounded,
          title: "Notice Board",
          subtitle:
              "Important announcements from your faculty, HOD, Principal and the University, with read and acknowledgement tracking.",
          watermarkIcon: Icons.notifications_rounded,
        ),
        const SizedBox(height: 18),

        // 2. Bar Below Banner: Notices (4) Pill + Acknowledgement Warning Alert
        _buildStatusBar(unreadCount, ackCount),
        const SizedBox(height: 20),

        // 3. Main Content: Responsive Split Layout (Filter Sidebar + Notices List)
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 850;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: _buildFilterSidebar(
                      allCount: allCount,
                      unreadCount: unreadCount,
                      urgentCount: urgentCount,
                      ackCount: ackCount,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildNoticesList(),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSidebar(
                    allCount: allCount,
                    unreadCount: unreadCount,
                    urgentCount: urgentCount,
                    ackCount: ackCount,
                  ),
                  const SizedBox(height: 20),
                  _buildNoticesList(),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Status Bar (Pill button + Alert)
  // ---------------------------------------------------------------------------
  Widget _buildStatusBar(int unreadCount, int ackCount) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620;

        final noticesBadge = Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
          decoration: BoxDecoration(
            color: const Color(0xFF161F38), // Dark Navy
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF161F38).withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_unread_outlined, size: 15, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                "Notices",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$unreadCount",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );

        final ackWarning = ackCount > 0
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFEE2E2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline_rounded, size: 15, color: Color(0xFFDC2626)),
                    const SizedBox(width: 7),
                    Text(
                      "$ackCount notices need your acknowledgement",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFB91C1C),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink();

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noticesBadge,
              if (ackCount > 0) ...[
                const SizedBox(height: 10),
                ackWarning,
              ],
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            noticesBadge,
            ackWarning,
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Left Filter Sidebar Card
  // ---------------------------------------------------------------------------
  Widget _buildFilterSidebar({
    required int allCount,
    required int unreadCount,
    required int urgentCount,
    required int ackCount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Search Input
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
              decoration: InputDecoration(
                isDense: true,
                hintText: "Search...",
                hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Status Filters List
          _buildStatusFilterRow("All notices", allCount),
          _buildStatusFilterRow("Unread", unreadCount),
          _buildStatusFilterRow("Important & urgent", urgentCount),
          _buildStatusFilterRow("To acknowledge", ackCount),
          const SizedBox(height: 18),

          // Category Section Header
          Text(
            "CATEGORY",
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),

          // Category Chips Wrap
          Wrap(
            spacing: 6,
            runSpacing: 7,
            children: _categories.map((cat) {
              final isCatSelected = _selectedCategory == cat;
              return InkWell(
                onTap: () => setState(() => _selectedCategory = cat),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                  decoration: BoxDecoration(
                    color: isCatSelected ? const Color(0xFF0F172A) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCatSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
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

  Widget _buildStatusFilterRow(String title, int count) {
    final isSelected = _selectedStatus == title;
    return InkWell(
      onTap: () => setState(() => _selectedStatus = title),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: const Color(0xFFC7D2FE).withValues(alpha: 0.8))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF475569),
                ),
              ),
            ),
            Text(
              "$count",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Right Notices List
  // ---------------------------------------------------------------------------
  Widget _buildNoticesList() {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = _notices.where((n) {
      // Category filter
      if (_selectedCategory != "All" && n["category"] != _selectedCategory) {
        return false;
      }
      // Status filter
      if (_selectedStatus == "Unread" && n["isUnread"] != true) return false;
      if (_selectedStatus == "Important & urgent" && n["isImportant"] != true) return false;
      if (_selectedStatus == "To acknowledge" && n["toAcknowledge"] != true) return false;

      // Query filter
      if (query.isNotEmpty) {
        final title = (n["title"] as String).toLowerCase();
        final role = (n["authorRole"] as String).toLowerCase();
        final name = (n["authorName"] as String).toLowerCase();
        final lines = (n["bodyLines"] as List<String>).join(" ").toLowerCase();
        if (!title.contains(query) &&
            !role.contains(query) &&
            !name.contains(query) &&
            !lines.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            const Icon(Icons.mark_email_read_outlined, size: 40, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            Text(
              "No notices found",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Try adjusting your search query or switching filters.",
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _selectedStatus = "All notices";
                  _selectedCategory = "All";
                });
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1E293B),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Clear filters", style: GoogleFonts.poppins(fontSize: 12)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: filtered.map((n) => _buildNoticeCard(n)).toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // Individual Notice Card (Image 1 & Image 2)
  // ---------------------------------------------------------------------------
  Widget _buildNoticeCard(Map<String, dynamic> n) {
    final Color accentColor = n["accentColor"] as Color;
    final IconData icon = n["icon"] as IconData;
    final bool isUnread = n["isUnread"] == true;
    final bool isImportant = n["isImportant"] == true;
    final bool toAcknowledge = n["toAcknowledge"] == true;
    final bool acknowledged = n["acknowledged"] == true;
    final List<String> bodyLines = n["bodyLines"] as List<String>;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Left Accent Strip
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(color: accentColor),
            ),

            // Main Card Body
            InkWell(
              onTap: () => _showNoticeDetails(n),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        // Header Row: Icon + Title & Badges
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rounded Icon container
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(icon, color: accentColor, size: 20),
                            ),
                            const SizedBox(width: 12),

                            // Title and Badges
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (isUnread) ...[
                                        Text(
                                          "• ",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xFF2563EB), // Blue unread dot
                                          ),
                                        ),
                                      ],
                                      Expanded(
                                        child: Text(
                                          n["title"] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // Badges (Important + Category)
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 4,
                                        alignment: WrapAlignment.end,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          if (isImportant)
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFEF3C7),
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              child: Text(
                                                "Important",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xFFD97706),
                                                ),
                                              ),
                                            ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF1F5F9),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Text(
                                              n["category"] as String,
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF475569),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),

                                  // Subheader line
                                  Text(
                                    "${n["authorRole"]} · ${n["authorName"]} · ${n["date"]} · ${n["audience"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Content Body Lines
                        LayoutBuilder(
                          builder: (context, c) {
                            final isNarrow = c.maxWidth < 450;
                            return Padding(
                              padding: EdgeInsets.only(left: isNarrow ? 0 : 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: bodyLines.map((line) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      line,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: const Color(0xFF334155),
                                        height: 1.45,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // Bottom Action Row (Responsive Wrap to prevent overflow)
                        LayoutBuilder(
                          builder: (context, c) {
                            final isNarrow = c.maxWidth < 450;
                            return Padding(
                              padding: EdgeInsets.only(left: isNarrow ? 0 : 50),
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 12,
                                runSpacing: 10,
                                children: [
                                  // Left side: Mark as read + Valid till
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isUnread) ...[
                                        InkWell(
                                          onTap: () => _markAsRead(n),
                                          child: Text(
                                            "Mark as read",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                      ],
                                      Text(
                                        n["validTill"] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.5,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Right side: Acknowledge button or Acknowledged status badge
                                  if (toAcknowledge)
                                    ElevatedButton.icon(
                                      onPressed: () => _acknowledgeNotice(n),
                                      icon: const Icon(Icons.check_rounded, size: 14),
                                      label: Text(
                                        "I have read this",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF161F38), // Navy pill
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                        minimumSize: Size.zero,
                                      ),
                                    )
                                  else if (acknowledged)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE6F4EA),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.check_rounded,
                                              size: 14, color: Color(0xFF0D9488)),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Acknowledged",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF0D9488),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
}
