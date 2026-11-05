import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

// =============================================================================
// OVERVIEW: NOTICE BOARD (FACULTY PORTAL)
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

  // New Notice form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  String _formCategory = "Academic";
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

  // In-memory notice state (defaults to empty like in the screenshot, with interactive demo support)
  final List<Map<String, dynamic>> _notices = [];
  final List<Map<String, dynamic>> _sentNotices = [];

  @override
  void dispose() {
    _searchController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _publishNotice() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a notice title")),
      );
      return;
    }
    final newNotice = {
      "title": _titleController.text.trim(),
      "category": _formCategory,
      "date": "Just now",
      "author": "Dr. V. Ramanathan (Faculty)",
      "content": _bodyController.text.trim().isEmpty
          ? "No additional description provided."
          : _bodyController.text.trim(),
      "isUrgent": _isUrgent,
      "isUnread": true,
      "toAcknowledge": true,
    };

    setState(() {
      _notices.insert(0, newNotice);
      _sentNotices.insert(0, newNotice);
      _titleController.clear();
      _bodyController.clear();
      _selectedTab = 0; // Switch back to notices list
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Notice published successfully!")),
    );
  }

  void _showNoticeDetailsDialog(Map<String, dynamic> n) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.campaign_rounded, color: Color(0xFF2563EB), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(n["title"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                    Text("${n["category"]} · ${n["date"]}", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
                  ],
                ),
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n["content"] as String,
                    style: GoogleFonts.poppins(fontSize: 13, height: 1.5, color: const Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Text("Issued by: ${n["author"]}", style: GoogleFonts.poppins(fontSize: 12, fontStyle: FontStyle.italic, color: const Color(0xFF64748B))),
                      if (n["toAcknowledge"] == true)
                        Text("Pending Acknowledgment", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFFD97706)))
                      else
                        Text("Acknowledged", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF15803D))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            if (n["toAcknowledge"] == true)
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    n["toAcknowledge"] = false;
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Acknowledged receipt of '${n["title"]}'", style: GoogleFonts.poppins()),
                      backgroundColor: const Color(0xFF15803D),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline_rounded, size: 15),
                label: const Text("Acknowledge Notice"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E),
                  foregroundColor: Colors.white,
                ),
              ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
              ),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoticeDialog(Map<String, dynamic> n) {
    final titleCtrl = TextEditingController(text: n["title"] as String);
    final contentCtrl = TextEditingController(text: n["content"] as String);
    final authorCtrl = TextEditingController(text: n["author"] as String);
    String category = n["category"] as String;
    bool isUrgent = n["isUrgent"] == true;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDlgState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text("Edit Announcement", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
              content: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleCtrl,
                        decoration: const InputDecoration(labelText: "Notice Title"),
                      ),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final dropdownField = DropdownButtonFormField<String>(
                            isExpanded: true,
                            initialValue: category,
                            decoration: const InputDecoration(labelText: "Category"),
                            items: ["Academic", "Examination", "Administrative", "Placement", "Events"]
                                .map((c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(c, overflow: TextOverflow.ellipsis),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) setDlgState(() => category = val);
                            },
                          );

                          final urgentTile = CheckboxListTile(
                            title: Text("Urgent", style: GoogleFonts.poppins(fontSize: 12)),
                            value: isUrgent,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (val) => setDlgState(() => isUrgent = val ?? false),
                          );

                          if (constraints.maxWidth < 340) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                dropdownField,
                                const SizedBox(height: 6),
                                urgentTile,
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: dropdownField,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: urgentTile,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: authorCtrl,
                        decoration: const InputDecoration(labelText: "Author / Issuing Body"),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: contentCtrl,
                        maxLines: 4,
                        decoration: const InputDecoration(labelText: "Notice Content"),
                      ),
                    ],
                  ),
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
                      n["title"] = titleCtrl.text.trim();
                      n["category"] = category;
                      n["isUrgent"] = isUrgent;
                      n["author"] = authorCtrl.text.trim();
                      n["content"] = contentCtrl.text.trim();
                      n["date"] = "Updated just now";
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Announcement updated successfully!"),
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
      },
    );
  }

  void _showDeleteNoticeDialog(Map<String, dynamic> n) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Delete Announcement?", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          content: Text(
            "Are you sure you want to delete '${n["title"]}'? This announcement will be removed from notice boards.",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final source = _selectedTab == 2 ? _sentNotices : _notices;
                final removed = Map<String, dynamic>.from(n);
                final index = source.indexOf(n);
                setState(() {
                  source.remove(n);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Announcement deleted"),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: const Color(0xFFFBBF24),
                      onPressed: () {
                        setState(() {
                          source.insert(index >= 0 ? index : 0, removed);
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

  void _loadDemoNotices() {
    setState(() {
      _notices.addAll([
        {
          "title": "Submission of Internal Assessment II Question Papers",
          "category": "Academic",
          "date": "Today, 10:30 AM",
          "author": "Controller of Examinations",
          "content": "All faculty members are requested to submit two sets of question papers along with answer keys for IA-II by Friday 5:00 PM.",
          "isUrgent": true,
          "isUnread": true,
          "toAcknowledge": true,
        },
        {
          "title": "NBA Accreditation Mock Audit Schedule",
          "category": "Examination",
          "date": "Yesterday",
          "author": "Dean Academic Affairs",
          "content": "Department course files and Course Outcome (CO) attainment sheets must be updated on the portal by October 20th.",
          "isUrgent": false,
          "isUnread": false,
          "toAcknowledge": false,
        },
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Top Hero Banner (Gradient + Blueprint Grid + Breadcrumbs)
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. Tab Navigation Pills (Notices, New notice, Sent by me)
              _buildTabPills(),
              const SizedBox(height: 18),

              // 3. Main Content: Split View (Sidebar + Content Panel) or Form
              if (_selectedTab == 1) ...[
                _buildNewNoticeForm(),
              ] else ...[
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Filter Sidebar
                      SizedBox(
                        width: 260,
                        child: _buildFilterSidebar(),
                      ),
                      const SizedBox(width: 18),
                      // Right Main Panel
                      Expanded(
                        child: _buildMainContentPanel(),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilterSidebar(),
                      const SizedBox(height: 18),
                      _buildMainContentPanel(),
                    ],
                  ),
              ],
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BANNER
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
            // Background blueprint grid texture
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative bell watermark on the right
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.notifications_rounded,
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
                  // Breadcrumb row
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

                  // Main Title & Icon row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bell icon rounded box
                      Container(
                        width: 44,
                        height: 44,
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
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title + Badges + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2352),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF38467D), width: 1),
                                  ),
                                  child: Text(
                                    "OVERVIEW",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "Notice Board",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),

                            // Subtitle description
                            Text(
                              "Important announcements from your faculty, HOD, Principal and the University, with read and acknowledgement tracking.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFFC7D2FE).withValues(alpha: 0.9),
                                height: 1.35,
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
  // 2. TAB PILLS (Notices, New notice, Sent by me)
  // ===========================================================================
  Widget _buildTabPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildPillTab(
            index: 0,
            label: "Notices",
            icon: Icons.all_inbox_rounded,
          ),
          const SizedBox(width: 8),
          _buildPillTab(
            index: 1,
            label: "New notice",
            icon: Icons.edit_note_rounded,
          ),
          const SizedBox(width: 8),
          _buildPillTab(
            index: 2,
            label: "Sent by me",
            icon: Icons.near_me_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildPillTab({required int index, required String label, required IconData icon}) {
    final isSelected = _selectedTab == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF141938) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF141938) : const Color(0xFFE2E8F0),
              width: 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF141938).withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
              const SizedBox(width: 7),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF334155),
                ),
              ),
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
    final list = _selectedTab == 2 ? _sentNotices : _notices;
    final allCount = list.length;
    final unreadCount = list.where((n) => n["isUnread"] == true).length;
    final urgentCount = list.where((n) => n["isUrgent"] == true).length;
    final ackCount = list.where((n) => n["toAcknowledge"] == true).length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Box
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

          // Status Filters List
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
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. RIGHT MAIN CONTENT PANEL
  // ===========================================================================
  Widget _buildMainContentPanel() {
    final sourceList = _selectedTab == 2 ? _sentNotices : _notices;
    final query = _searchController.text.trim().toLowerCase();

    final filtered = sourceList.where((n) {
      if (_selectedCategory != "All" && n["category"] != _selectedCategory) {
        return false;
      }
      if (_selectedStatus == "Unread" && n["isUnread"] != true) return false;
      if (_selectedStatus == "Important & urgent" && n["isUrgent"] != true) return false;
      if (_selectedStatus == "To acknowledge" && n["toAcknowledge"] != true) return false;
      if (query.isNotEmpty) {
        final title = (n["title"] as String).toLowerCase();
        final content = (n["content"] as String).toLowerCase();
        if (!title.contains(query) && !content.contains(query)) return false;
      }
      return true;
    }).toList();

    return Container(
      constraints: const BoxConstraints(minHeight: 460),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Faint graph paper / grid background (as shown in the screenshot!)
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: const Color(0xFFF1F5F9),
                  step: 24.0,
                ),
              ),
            ),

            // Content: Empty State (Default) or Notice Cards List
            filtered.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No notices yet",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Announcements from your college and the university will appear here.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 18),
                          if (_notices.isEmpty && _selectedTab == 0) ...[
                            OutlinedButton.icon(
                              onPressed: _loadDemoNotices,
                              icon: const Icon(Icons.refresh_rounded, size: 15),
                              label: const Text("Load Sample Announcements"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primaryBlue,
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final n = filtered[i];
                      final isUrgent = n["isUrgent"] == true;
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: isUrgent
                                            ? const Color(0xFFFEE2E2)
                                            : const Color(0xFFEEF2FF),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        n["category"] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: isUrgent
                                              ? const Color(0xFFDC2626)
                                              : const Color(0xFF4338CA),
                                        ),
                                      ),
                                    ),
                                    if (isUrgent) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDC2626),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          "URGENT",
                                          style: GoogleFonts.poppins(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  n["date"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              n["title"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              n["content"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF475569),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 240),
                                  child: Text(
                                    "Author: ${n["author"]}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if (n["toAcknowledge"] == true)
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          setState(() => n["toAcknowledge"] = false);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Acknowledged '${n["title"]}'", style: GoogleFonts.poppins()),
                                              backgroundColor: const Color(0xFF15803D),
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.done_all_rounded, size: 13),
                                        label: const Text("Acknowledge"),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          minimumSize: Size.zero,
                                          foregroundColor: const Color(0xFF0F766E),
                                          side: const BorderSide(color: Color(0xFF0F766E)),
                                          textStyle: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF64748B)),
                                      onPressed: () => _showNoticeDetailsDialog(n),
                                      tooltip: "View Notice",
                                      splashRadius: 16,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF4338CA)),
                                      onPressed: () => _showEditNoticeDialog(n),
                                      tooltip: "Edit Notice",
                                      splashRadius: 16,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Color(0xFFEF4444)),
                                      onPressed: () => _showDeleteNoticeDialog(n),
                                      tooltip: "Delete Notice",
                                      splashRadius: 16,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. NEW NOTICE COMPOSER FORM (TAB 1)
  // ===========================================================================
  Widget _buildNewNoticeForm() {
    return Container(
      padding: const EdgeInsets.all(22),
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
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Broadcast a notice to students, departments, or entire institution.",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 18),

          // Title Input
          Text(
            "Notice Title",
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

          // Category & Urgent Toggle (Responsive)
          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 650;

              final categorySection = Column(
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

              final urgentSection = Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Mark as Urgent",
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Switch(
                              value: _isUrgent,
                              activeThumbColor: const Color(0xFFDC2626),
                              onChanged: (val) => setState(() => _isUrgent = val),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );

              if (isCompact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    categorySection,
                    const SizedBox(height: 16),
                    urgentSection,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: categorySection),
                  const SizedBox(width: 16),
                  Expanded(child: urgentSection),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Content body
          Text(
            "Notice Body",
            style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _bodyController,
            maxLines: 4,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "Enter full announcement text, instructions, and deadlines...",
              hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 20),

          // Actions
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => setState(() => _selectedTab = 0),
                child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B))),
              ),
              ElevatedButton.icon(
                onPressed: _publishNotice,
                icon: const Icon(Icons.send_rounded, size: 16),
                label: const Text("Publish Announcement"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
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
// SUBTLE GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _GridPaperPainter({required this.gridColor, this.step = 28.0});

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
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
