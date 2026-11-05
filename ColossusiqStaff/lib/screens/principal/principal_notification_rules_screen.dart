import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalNotificationRulesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalNotificationRulesScreen({super.key, this.onBack});

  @override
  State<PrincipalNotificationRulesScreen> createState() => _PrincipalNotificationRulesScreenState();
}

class _PrincipalNotificationRulesScreenState extends State<PrincipalNotificationRulesScreen> {
  int _selectedTab = 0;

  // Channels state (Tab 0)
  bool _inAppEnabled = true;
  bool _emailEnabled = true;
  bool _pushEnabled = true;
  bool _smsEnabled = false;
  bool _whatsappEnabled = false;

  // Academic event rules state (Tab 1)
  String _examReminderLead = "7 days and 1 day before (Recommended)";
  bool _lowAttendanceEnabled = true;
  bool _tuitionFeeEnabled = true;
  bool _placementDrivesEnabled = true;
  bool _weeklyDigestEnabled = true;
  bool _emergencyBroadcastEnabled = true;

  // Quiet hours & throttling state (Tab 2)
  String _quietHoursWindow = "22:00 – 07:00 (Standard Campus Policy)";
  String _dailyFrequencyCap = "10 per day (Recommended)";

  // Live test dispatcher state (Tab 3)
  late TextEditingController _testTitleController;
  late TextEditingController _testBodyController;
  String _selectedDeliveryChannel = "In-app / Web Bell";
  String _selectedTonePriority = "Brand (Informational)";
  String _selectedTargetAudience = "Student Cohort";

  // Recent delivery log (Tab 4)
  final List<Map<String, String>> _deliveryLogs = [
    {
      "time": "Just now",
      "event": "Internal Assessment Hall Ticket Released",
      "channel": "In-App / Web Bell",
      "audience": "Student Cohort (2,840)",
      "latency": "38ms",
      "status": "Delivered",
    },
    {
      "time": "12 mins ago",
      "event": "Low Attendance Warning Notice (< 75%)",
      "channel": "Campus Email & Mobile Push",
      "audience": "Defaulters List (142)",
      "latency": "1.1s",
      "status": "Delivered",
    },
    {
      "time": "2 hours ago",
      "event": "Odd Semester Tuition Fee 2nd Reminder",
      "channel": "Email & WhatsApp",
      "audience": "Unpaid Enrolments (318)",
      "latency": "840ms",
      "status": "Delivered",
    },
    {
      "time": "Yesterday, 09:00",
      "event": "Amazon Campus Recruitment Drive Open",
      "channel": "Mobile Push Notification",
      "audience": "Final Year CSE / ECE (420)",
      "latency": "290ms",
      "status": "Delivered",
    },
    {
      "time": "Yesterday, 07:05",
      "event": "Weekly Faculty Academic Digest Batch",
      "channel": "Official Campus Email",
      "audience": "Faculty & HODs (184)",
      "latency": "1.4s",
      "status": "Delivered",
    },
  ];

  @override
  void initState() {
    super.initState();
    _testTitleController = TextEditingController(text: "Internal Assessment Hall Ticket Released");
    _testBodyController = TextEditingController(
      text: "Odd semester hall tickets are ready for download in your academic portal.",
    );
  }

  @override
  void dispose() {
    _testTitleController.dispose();
    _testBodyController.dispose();
    super.dispose();
  }

  int get _activeChannelCount {
    int count = 0;
    if (_inAppEnabled) count++;
    if (_emailEnabled) count++;
    if (_pushEnabled) count++;
    if (_smsEnabled) count++;
    if (_whatsappEnabled) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Breadcrumbs
              _buildBreadcrumbs(),
              const SizedBox(height: 14),

              // 2. Blueprint Hero Banner (Matches Image 1)
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 3. Top Routing Policies & KPI Summary Card (Matches Image 1)
              _buildSummaryCard(),
              const SizedBox(height: 18),

              // 4. Five Navigation Tabs (Matches Images 1, 3, 4, 5)
              _buildTabsBar(),
              const SizedBox(height: 20),

              // 5. Tab Content Dispatcher
              _buildActiveTabContent(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. BREADCRUMBS
  // ===========================================================================
  Widget _buildBreadcrumbs() {
    return Row(
      children: [
        if (widget.onBack != null) ...[
          InkWell(
            onTap: widget.onBack,
            borderRadius: BorderRadius.circular(6),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Color(0xFF64748B)),
            ),
          ),
          const SizedBox(width: 6),
        ],
        Text(
          "Home",
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
        ),
        Text(
          "Institution",
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
        ),
        Text(
          "Notification Rules",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. BLUEPRINT HERO BANNER (Matches Image 1)
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1E5C), Color(0xFF1E3A8A), Color(0xFF2E3D85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F1E5C).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            Positioned(
              right: -10,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.notifications_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(
                    Icons.notifications_rounded,
                    color: Color(0xFFFBBF24),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "INSTITUTION",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF059669),
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
                      const SizedBox(height: 6),
                      Text(
                        "Notification Rules",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Event + priority + audience + timing + channel rules.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFFE2E8F0),
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
    );
  }

  // ===========================================================================
  // 3. TOP SUMMARY CARD (Responsive - Fixes Screenshot 1 overflow)
  // ===========================================================================
  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Responsive Top Badges Row (Prevents 174px overflow)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.notifications_none_rounded, size: 13, color: Color(0xFF4F46E5)),
                        const SizedBox(width: 5),
                        Text(
                          "Campus Notification Engine",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4F46E5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "$_activeChannelCount of 5 Channels Routing",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF059669),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_rounded, size: 12, color: Color(0xFF059669)),
                    const SizedBox(width: 4),
                    Text(
                      "All Rules Up to Date",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF047857),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Title & Description
          Text(
            "Notification Rules & Routing Policies",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Configure event-triggered notification channels, quiet hours, delivery rate limits, and audit delivery pipelines across students, faculty, and departments.",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF64748B),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),

          // 4 KPI Cards in a row
          LayoutBuilder(
            builder: (context, constraints) {
              final colCount = constraints.maxWidth >= 900
                  ? 4
                  : constraints.maxWidth >= 540
                      ? 2
                      : 1;

              final kpis = [
                {
                  "label": "In-App Delivery",
                  "value": "Active (0ms)",
                  "sub": "Top-bar bell & toasts",
                },
                {
                  "label": "Quiet Hours Schedule",
                  "value": _quietHoursWindow.split(" ").first,
                  "sub": "Emergency bypass enabled",
                },
                {
                  "label": "Exam Alert Window",
                  "value": "7 days and 1 day before",
                  "sub": "Automated AI dispatch",
                },
                {
                  "label": "Daily Rate Limit",
                  "value": _dailyFrequencyCap.contains("10") ? "10 per day" : "Custom",
                  "sub": "Per-student anti-spam",
                },
              ];

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: colCount == 4
                      ? 1.85
                      : colCount == 2
                          ? 2.6
                          : 3.2,
                ),
                itemCount: kpis.length,
                itemBuilder: (context, i) {
                  final kpi = kpis[i];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kpi["label"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          kpi["value"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          kpi["sub"]!,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            color: const Color(0xFF94A3B8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. FIVE TABS BAR (Horizontal scrollable)
  // ===========================================================================
  Widget _buildTabsBar() {
    final tabs = [
      {
        "title": "Delivery Channels",
        "badge": "$_activeChannelCount/5",
        "icon": Icons.cell_tower_rounded,
      },
      {
        "title": "Academic Event Rules",
        "icon": Icons.campaign_outlined,
      },
      {
        "title": "Quiet Hours & Throttling",
        "icon": Icons.bedtime_outlined,
      },
      {
        "title": "Live Test Dispatcher",
        "icon": Icons.near_me_outlined,
        "hasDot": true,
      },
      {
        "title": "Recent Delivery Log",
        "badge": "5",
        "icon": Icons.access_time_rounded,
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final t = tabs[index];
            final isSelected = _selectedTab == index;
            final badge = t["badge"] as String?;
            final hasDot = t["hasDot"] == true;

            return InkWell(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? const Color(0xFF131B4D) : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      t["icon"] as IconData,
                      size: 16,
                      color: isSelected ? const Color(0xFF131B4D) : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t["title"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEEF2FF) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                    if (hasDot) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. TAB CONTENT DISPATCHER
  // ===========================================================================
  Widget _buildActiveTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildDeliveryChannelsTab();
      case 1:
        return _buildAcademicEventRulesTab();
      case 2:
        return _buildQuietHoursTab();
      case 3:
        return _buildLiveTestDispatcherTab();
      case 4:
        return _buildRecentDeliveryLogTab();
      default:
        return _buildDeliveryChannelsTab();
    }
  }

  // ===========================================================================
  // 5A. TAB 0: DELIVERY CHANNELS (Matches Images 1 & 2)
  // ===========================================================================
  Widget _buildDeliveryChannelsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Institutional Delivery Channels",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "Toggle approval for outward delivery gateways. Disabled channels prevent notifications from routing regardless of event settings.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        // Grid of 5 Delivery Channels
        LayoutBuilder(
          builder: (context, constraints) {
            final colCount = constraints.maxWidth >= 900
                ? 3
                : constraints.maxWidth >= 600
                    ? 2
                    : 1;

            final channels = [
              {
                "name": "In-App / Web Bells",
                "tag": "Zero Cost",
                "gateway": "CollossusIQ WebSocket Push",
                "desc": "Real-time notification bell dropdown, badges, and instant toast alerts across desktop and mobile browsers.",
                "enabled": _inAppEnabled,
                "onToggle": (bool val) => setState(() => _inAppEnabled = val),
                "icon": Icons.notifications_none_rounded,
                "latency": "Avg. Delivery: < 50ms",
              },
              {
                "name": "Official Campus Email",
                "tag": "Recommended",
                "gateway": "SendGrid Campus Pro",
                "desc": "High-reputation transactional delivery with signed DKIM/SPF headers for official notices, fee receipts, and marks.",
                "enabled": _emailEnabled,
                "onToggle": (bool val) => setState(() => _emailEnabled = val),
                "icon": Icons.mail_outline_rounded,
                "latency": "Avg. Delivery: ~ 1.2s",
              },
              {
                "name": "Mobile Push Notifications",
                "tag": "High Engagement",
                "gateway": "Firebase Cloud Messaging (FCM)",
                "desc": "Native device notifications delivered to Android and iOS student/faculty apps with deep links.",
                "enabled": _pushEnabled,
                "onToggle": (bool val) => setState(() => _pushEnabled = val),
                "icon": Icons.smartphone_rounded,
                "latency": "Avg. Delivery: ~ 350ms",
              },
              {
                "name": "SMS Priority Gateway",
                "tag": "DLT Compliant",
                "gateway": "Twilio / ValueFirst",
                "desc": "TRAI DLT-approved transactional SMS for emergency alerts, OTPs, and critical fee clearance deadlines.",
                "enabled": _smsEnabled,
                "onToggle": (bool val) => setState(() => _smsEnabled = val),
                "icon": Icons.chat_bubble_outline_rounded,
                "latency": "Avg. Delivery: ~ 3.5s",
              },
              {
                "name": "WhatsApp Business API",
                "tag": "Meta Cloud API",
                "gateway": "Meta Business Cloud Gateway",
                "desc": "Official green-tick conversational WhatsApp templates for student queries, exam dates, and counseling.",
                "enabled": _whatsappEnabled,
                "onToggle": (bool val) => setState(() => _whatsappEnabled = val),
                "icon": Icons.language_rounded,
                "latency": "Avg. Delivery: ~ 800ms",
              },
            ];

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: colCount == 1 ? 2.3 : 1.55,
              ),
              itemCount: channels.length,
              itemBuilder: (context, i) {
                final ch = channels[i];
                final isEnabled = ch["enabled"] as bool;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isEnabled ? const Color(0xFFA7F3D0) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top header row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isEnabled ? const Color(0xFFECFDF5) : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              ch["icon"] as IconData,
                              size: 18,
                              color: isEnabled ? const Color(0xFF059669) : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        ch["name"] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F172A),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF2FF),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        ch["tag"] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF4F46E5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Gateway: ${ch["gateway"]}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Switch(
                            value: isEnabled,
                            activeThumbColor: const Color(0xFF059669),
                            activeTrackColor: const Color(0xFFA7F3D0),
                            onChanged: ch["onToggle"] as ValueChanged<bool>,
                          ),
                        ],
                      ),

                      // Description
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          ch["desc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Bottom status row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isEnabled ? const Color(0xFF059669) : const Color(0xFF94A3B8),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isEnabled ? "Active & Routing" : "Channel Disabled",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isEnabled ? const Color(0xFF059669) : const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            ch["latency"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 18),

        // Failover & Reliability Banner (Matches Image 2)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  size: 20,
                  color: Color(0xFF4F46E5),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Channel Failover & Reliability",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "If a student does not open an Urgent alert via Mobile Push within 15 minutes, CollossusIQ will automatically fall back to Email. SMS is strictly reserved for critical reminders to optimize gateway credit consumption.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5B. TAB 1: ACADEMIC EVENT RULES (Responsive - Fixes Screenshot 2 vertical text & overflow)
  // ===========================================================================
  Widget _buildAcademicEventRulesTab() {
    final rules = [
      {
        "icon": Icons.notifications_active_outlined,
        "iconBg": const Color(0xFFFFFBEB),
        "iconColor": const Color(0xFFD97706),
        "title": "Examination Reminders & Hall Tickets",
        "desc": "Automated alerts sent to registered students prior to internal and end-semester examinations.",
        "isDropdown": true,
      },
      {
        "icon": Icons.warning_amber_rounded,
        "iconBg": const Color(0xFFECFDF5),
        "iconColor": const Color(0xFF059669),
        "title": "Low Attendance Warnings (< 75%)",
        "desc": "Sends automated warnings to students and faculty mentors whenever cumulative attendance slips below university eligibility.",
        "enabled": _lowAttendanceEnabled,
        "onToggle": (bool v) => setState(() => _lowAttendanceEnabled = v),
      },
      {
        "icon": Icons.bolt_rounded,
        "iconBg": const Color(0xFFECFDF5),
        "iconColor": const Color(0xFF059669),
        "title": "Tuition & Fee Clearance Reminders",
        "desc": "Dispatches friendly payment due notices 14 days, 7 days, and 1 day before semester fee deadlines.",
        "enabled": _tuitionFeeEnabled,
        "onToggle": (bool v) => setState(() => _tuitionFeeEnabled = v),
      },
      {
        "icon": Icons.cell_tower_rounded,
        "iconBg": const Color(0xFFECFDF5),
        "iconColor": const Color(0xFF059669),
        "title": "Campus Placement & Internship Drives",
        "desc": "Notifies eligible final-year and pre-final-year students when new corporate recruitment drives open.",
        "enabled": _placementDrivesEnabled,
        "onToggle": (bool v) => setState(() => _placementDrivesEnabled = v),
      },
      {
        "icon": Icons.people_outline_rounded,
        "iconBg": const Color(0xFFECFDF5),
        "iconColor": const Color(0xFF059669),
        "title": "Weekly Faculty & HOD Summary Digest",
        "desc": "Every Monday morning briefing summarizing course progress, pending AI evaluations, and department attendance.",
        "enabled": _weeklyDigestEnabled,
        "onToggle": (bool v) => setState(() => _weeklyDigestEnabled = v),
      },
      {
        "icon": Icons.shield_outlined,
        "iconBg": const Color(0xFFECFDF5),
        "iconColor": const Color(0xFF059669),
        "title": "Emergency Campus Broadcast Override",
        "desc": "High-severity safety alerts, holiday declarations, and emergency advisories bypass student quiet hours.",
        "enabled": _emergencyBroadcastEnabled,
        "onToggle": (bool v) => setState(() => _emergencyBroadcastEnabled = v),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Academic Event Trigger Rules",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "Select which campus life events generate automated notifications and set lead times.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        // 6 Rules list
        ...rules.map((r) {
          final isDropdown = r["isDropdown"] == true;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDropdown ? const Color(0xFFFED7AA) : const Color(0xFFA7F3D0),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, cardConstraints) {
                  // If screen width is compact (< 640), wrap dropdown / controls below the text
                  final isCompact = cardConstraints.maxWidth < 640;

                  final iconWidget = Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: r["iconBg"] as Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      r["icon"] as IconData,
                      size: 20,
                      color: r["iconColor"] as Color,
                    ),
                  );

                  final textWidget = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r["title"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        r["desc"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                          height: 1.35,
                        ),
                      ),
                    ],
                  );

                  final dropdownWidget = Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _examReminderLead,
                        isExpanded: isCompact,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF0F172A)),
                        items: const [
                          DropdownMenuItem(
                            value: "7 days and 1 day before (Recommended)",
                            child: Text(
                              "7 days and 1 day before (Recommended)",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "3 days and 1 day before",
                            child: Text(
                              "3 days and 1 day before",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "24 hours prior only",
                            child: Text(
                              "24 hours prior only",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _examReminderLead = val);
                        },
                      ),
                    ),
                  );

                  if (isCompact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            iconWidget,
                            const SizedBox(width: 12),
                            Expanded(child: textWidget),
                            if (!isDropdown) ...[
                              const SizedBox(width: 8),
                              Switch(
                                value: r["enabled"] as bool,
                                activeThumbColor: const Color(0xFF059669),
                                activeTrackColor: const Color(0xFFA7F3D0),
                                onChanged: r["onToggle"] as ValueChanged<bool>,
                              ),
                            ],
                          ],
                        ),
                        if (isDropdown) ...[
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: dropdownWidget,
                          ),
                        ],
                      ],
                    );
                  }

                  // Desktop / wide view
                  return Row(
                    children: [
                      iconWidget,
                      const SizedBox(width: 14),
                      Expanded(child: textWidget),
                      const SizedBox(width: 14),
                      if (isDropdown)
                        dropdownWidget
                      else
                        Switch(
                          value: r["enabled"] as bool,
                          activeThumbColor: const Color(0xFF059669),
                          activeTrackColor: const Color(0xFFA7F3D0),
                          onChanged: r["onToggle"] as ValueChanged<bool>,
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  // ===========================================================================
  // 5C. TAB 2: QUIET HOURS & THROTTLING (Responsive - Fixes Screenshot 3 overflow)
  // ===========================================================================
  Widget _buildQuietHoursTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quiet Hours & Anti-Spam Throttling",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "Prevent notification fatigue and protect student well-being during nighttime hours.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 760;

            final card1 = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row wrapped in Expanded to prevent 31px overflow
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E8FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.bedtime_outlined,
                          size: 20,
                          color: Color(0xFF9333EA),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nighttime Quiet Hours",
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              "Silences non-critical push notifications and SMS",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  Text(
                    "Active Quiet Hours Window",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _quietHoursWindow,
                    isExpanded: true,
                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF0F172A)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "22:00 – 07:00 (Standard Campus Policy)",
                        child: Text("22:00 – 07:00 (Standard Campus Policy)", overflow: TextOverflow.ellipsis),
                      ),
                      DropdownMenuItem(
                        value: "23:00 – 06:00 (Extended Study)",
                        child: Text("23:00 – 06:00 (Extended Study)", overflow: TextOverflow.ellipsis),
                      ),
                      DropdownMenuItem(
                        value: "21:00 – 08:00 (Residential Strict)",
                        child: Text("21:00 – 08:00 (Residential Strict)", overflow: TextOverflow.ellipsis),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _quietHoursWindow = val);
                    },
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Alerts queued during this window dispatch at 07:05 AM.",
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFED7AA)),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF78350F), height: 1.4),
                        children: const [
                          TextSpan(
                            text: "Quiet Hour Behavior: ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: "General announcements, quiz feedback, and placement notices are held in the delivery queue. Security warnings and Emergency broadcasts bypass quiet hours automatically.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

            final card2 = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row wrapped in Expanded to prevent overflow
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.notifications_off_outlined,
                          size: 20,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daily Frequency Cap",
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              "Maximum notifications delivered to any single student",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  Text(
                    "Maximum Daily Messages",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _dailyFrequencyCap,
                    isExpanded: true,
                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF0F172A)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "10 per day (Recommended)",
                        child: Text("10 per day (Recommended)", overflow: TextOverflow.ellipsis),
                      ),
                      DropdownMenuItem(
                        value: "5 per day (High Focus)",
                        child: Text("5 per day (High Focus)", overflow: TextOverflow.ellipsis),
                      ),
                      DropdownMenuItem(
                        value: "15 per day (Permissive)",
                        child: Text("15 per day (Permissive)", overflow: TextOverflow.ellipsis),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _dailyFrequencyCap = val);
                    },
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Batches non-urgent messages into daily digests once limit is reached.",
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569), height: 1.4),
                        children: const [
                          TextSpan(
                            text: "Batching Strategy: ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: "When a student hits their daily cap, lower-priority reminders (like library notices or club invites) merge into a single evening digest summary.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: card1),
                  const SizedBox(width: 16),
                  Expanded(child: card2),
                ],
              );
            }

            return Column(
              children: [
                card1,
                const SizedBox(height: 16),
                card2,
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 5D. TAB 3: LIVE TEST DISPATCHER (Responsive - Fixes Screenshot 4 overflow)
  // ===========================================================================
  Widget _buildLiveTestDispatcherTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Responsive Header (Fixes 621px overflow)
        LayoutBuilder(
          builder: (context, headerBox) {
            final isCompact = headerBox.maxWidth < 650;

            final textHeader = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Live Notification Simulator & Dispatcher",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Compose and test live alerts against your active rules. Delivered notifications will instantly appear in the top-header notification bell.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            );

            final statusBadge = Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFA7F3D0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF059669),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Live Bell Link Active",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF047857),
                    ),
                  ),
                ],
              ),
            );

            if (isCompact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textHeader,
                  const SizedBox(height: 8),
                  statusBadge,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: textHeader),
                const SizedBox(width: 14),
                statusBadge,
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 840;

            // Form Column
            final formCard = Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.near_me_outlined, size: 18, color: Color(0xFF0F172A)),
                      const SizedBox(width: 8),
                      Text(
                        "Compose Test Notification",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Notification Title",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _testTitleController,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Clear, actionable heading (e.g. Exam Alert, Fee Reminder)",
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    "Message Body",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _testBodyController,
                    onChanged: (_) => setState(() {}),
                    maxLines: 3,
                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Detailed alert body visible in notification drawers and push cards.",
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 14),

                  // 3 Dropdowns Row
                  LayoutBuilder(
                    builder: (context, box) {
                      final threeCols = box.maxWidth >= 540;

                      final d1 = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Delivery Channel", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedDeliveryChannel,
                            isExpanded: true,
                            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E293B)),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            items: const [
                              DropdownMenuItem(value: "In-app / Web Bell", child: Text("In-app / Web Bell", overflow: TextOverflow.ellipsis)),
                              DropdownMenuItem(value: "Campus Email", child: Text("Campus Email", overflow: TextOverflow.ellipsis)),
                              DropdownMenuItem(value: "Mobile Push", child: Text("Mobile Push", overflow: TextOverflow.ellipsis)),
                            ],
                            onChanged: (v) => setState(() => _selectedDeliveryChannel = v ?? "In-app / Web Bell"),
                          ),
                        ],
                      );

                      final d2 = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tone / Priority", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedTonePriority,
                            isExpanded: true,
                            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E293B)),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            items: const [
                              DropdownMenuItem(value: "Brand (Informational)", child: Text("Brand (Informational)", overflow: TextOverflow.ellipsis)),
                              DropdownMenuItem(value: "Urgent (High Priority)", child: Text("Urgent (High Priority)", overflow: TextOverflow.ellipsis)),
                              DropdownMenuItem(value: "Statutory (Official)", child: Text("Statutory (Official)", overflow: TextOverflow.ellipsis)),
                            ],
                            onChanged: (v) => setState(() => _selectedTonePriority = v ?? "Brand (Informational)"),
                          ),
                        ],
                      );

                      final d3 = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Target Audience", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedTargetAudience,
                            isExpanded: true,
                            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E293B)),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            items: const [
                              DropdownMenuItem(value: "Student Cohort", child: Text("Student Cohort", overflow: TextOverflow.ellipsis)),
                              DropdownMenuItem(value: "Faculty Members", child: Text("Faculty Members", overflow: TextOverflow.ellipsis)),
                              DropdownMenuItem(value: "Campus-Wide", child: Text("Campus-Wide", overflow: TextOverflow.ellipsis)),
                            ],
                            onChanged: (v) => setState(() => _selectedTargetAudience = v ?? "Student Cohort"),
                          ),
                        ],
                      );

                      if (threeCols) {
                        return Row(
                          children: [
                            Expanded(child: d1),
                            const SizedBox(width: 8),
                            Expanded(child: d2),
                            const SizedBox(width: 8),
                            Expanded(child: d3),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          d1,
                          const SizedBox(height: 8),
                          d2,
                          const SizedBox(height: 8),
                          d3,
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Bottom Action Row (Wrapped to prevent 78px overflow)
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Dispatches instantly with full audit trail logging.",
                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Test alert dispatched: ${_testTitleController.text}"),
                              backgroundColor: const Color(0xFF059669),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.near_me_rounded, size: 15),
                        label: Text(
                          "Send Test Alert",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF131B4D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

            // Preview Column (Matches Image 5)
            final previewCard = Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF0F172A)),
                      const SizedBox(width: 8),
                      Text(
                        "Recipient Live Preview",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Box 1: Dropdown Bell Mockup
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "HEADER BELL DROPDOWN MOCKUP",
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "BRAND",
                                style: GoogleFonts.poppins(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF4F46E5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.notifications_none_rounded, size: 16, color: Color(0xFF1E293B)),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _testTitleController.text.isNotEmpty
                                                ? _testTitleController.text
                                                : "Internal Assessment Hall Ticket Released",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          "Just now",
                                          style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _testBodyController.text.isNotEmpty
                                          ? _testBodyController.text
                                          : "Odd semester hall tickets are ready for download in your academic portal.",
                                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                                    ),
                                    const SizedBox(height: 6),
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        Text("via WEB", style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8))),
                                        Text("Audience: student", style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Box 2: Native Push Notification Mockup
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.smartphone_rounded, size: 12, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Text(
                                  "CollossusIQ Student App",
                                  style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B)),
                                ),
                              ],
                            ),
                            Text("now", style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _testTitleController.text.isNotEmpty
                              ? _testTitleController.text
                              : "Internal Assessment Hall Ticket Released",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          _testBodyController.text.isNotEmpty
                              ? _testBodyController.text
                              : "Odd semester hall tickets are ready for download in your academic portal.",
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: formCard),
                  const SizedBox(width: 16),
                  Expanded(flex: 5, child: previewCard),
                ],
              );
            }

            return Column(
              children: [
                formCard,
                const SizedBox(height: 16),
                previewCard,
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 5E. TAB 4: RECENT DELIVERY LOG (Responsive - Fixes Screenshot 5 overflow)
  // ===========================================================================
  Widget _buildRecentDeliveryLogTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Outward Notification Audits",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "Real-time pipeline logs verifying gateway dispatch status, recipient audience volume, and latency metrics.",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _deliveryLogs.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
            itemBuilder: (context, i) {
              final log = _deliveryLogs[i];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: LayoutBuilder(
                  builder: (context, itemConstraints) {
                    final isCompact = itemConstraints.maxWidth < 580;

                    final iconWidget = Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 18,
                        color: Color(0xFF059669),
                      ),
                    );

                    final titleText = Text(
                      log["event"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    );

                    final metaWrap = Wrap(
                      spacing: 8,
                      runSpacing: 2,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Channel: ${log["channel"]}",
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                        Text("•", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFCBD5E1))),
                        Text(
                          "To: ${log["audience"]}",
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      ],
                    );

                    final statusBadge = Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        log["status"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF059669),
                        ),
                      ),
                    );

                    final timeText = Text(
                      "${log["time"]} (${log["latency"]})",
                      style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8)),
                    );

                    if (isCompact) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              iconWidget,
                              const SizedBox(width: 10),
                              Expanded(child: titleText),
                              const SizedBox(width: 8),
                              statusBadge,
                            ],
                          ),
                          const SizedBox(height: 6),
                          metaWrap,
                          const SizedBox(height: 4),
                          timeText,
                        ],
                      );
                    }

                    return Row(
                      children: [
                        iconWidget,
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              titleText,
                              const SizedBox(height: 2),
                              metaWrap,
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            statusBadge,
                            const SizedBox(height: 2),
                            timeText,
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
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

typedef NotificationRulesScreen = PrincipalNotificationRulesScreen;
