import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAuditLogScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalAuditLogScreen({super.key, this.onBack});

  @override
  State<PrincipalAuditLogScreen> createState() => _PrincipalAuditLogScreenState();
}

class _AuditEvent {
  const _AuditEvent({
    required this.id,
    required this.timestamp,
    required this.actor,
    required this.actorRole,
    required this.tenant,
    required this.action,
    required this.category,
    required this.severity,
    required this.resource,
    required this.outcome,
    required this.actorEmail,
    required this.ipAddress,
    required this.resourceId,
    required this.detail,
  });

  final String id;
  final String timestamp;
  final String actor;
  final String actorRole;
  final String tenant;
  final String action;
  final String category;
  final String severity;
  final String resource;
  final String outcome;
  final String actorEmail;
  final String ipAddress;
  final String resourceId;
  final String detail;

  Map<String, String> toJson() => {
        'logId': id,
        'timestamp': timestamp,
        'actor': actor,
        'actorRole': actorRole,
        'tenant': tenant,
        'action': action,
        'category': category,
        'severity': severity,
        'resource': resource,
        'outcome': outcome,
        'actorEmail': actorEmail,
        'ipAddress': ipAddress,
        'resourceId': resourceId,
        'detail': detail,
      };

  List<String> toCsvRow() => [
        timestamp,
        actor,
        actorRole,
        tenant,
        action,
        category,
        severity,
        resource,
        outcome,
        id,
        actorEmail,
        ipAddress,
        resourceId,
        detail,
      ];
}

class _PrincipalAuditLogScreenState extends State<PrincipalAuditLogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTenant = 'All Tenants';
  String _selectedCategory = 'All Categories';
  String _selectedSeverity = 'All Severity';
  String _selectedOutcome = 'All Outcomes';
  String? _expandedEventId;

  final List<_AuditEvent> _events = const [
    _AuditEvent(
      id: 'a001',
      timestamp: '29 Oct, 13:14:12',
      actor: 'Rajesh Kumar',
      actorRole: 'Admin',
      tenant: 'Platform',
      action: 'ai-provider.update',
      category: 'config',
      severity: 'Warning',
      resource: 'ai-providers',
      outcome: 'Success',
      actorEmail: 'rajesh@colossusiq.com',
      ipAddress: '103.24.11.5',
      resourceId: 'gemini-1.5-pro',
      detail: 'Default model changed from gemini-1.5-flash to gemini-1.5-pro',
    ),
    _AuditEvent(
      id: 'a002',
      timestamp: '29 Oct, 13:08:55',
      actor: 'Priya Anand',
      actorRole: 'Institution',
      tenant: 'PSG College',
      action: 'user.role.change',
      category: 'user',
      severity: 'Warning',
      resource: 'users',
      outcome: 'Success',
      actorEmail: 'priya.anand@example.edu',
      ipAddress: '203.0.113.12',
      resourceId: 'usr-2048',
      detail: 'Role updated from Faculty to Department Admin',
    ),
    _AuditEvent(
      id: 'a003',
      timestamp: '29 Oct, 13:01:04',
      actor: 'System',
      actorRole: 'System',
      tenant: 'SNS College',
      action: 'ai.request.failed',
      category: 'ai',
      severity: 'Critical',
      resource: 'research-agent',
      outcome: 'Failure',
      actorEmail: 'system@colossusiq.com',
      ipAddress: '203.0.113.18',
      resourceId: 'req-7f2a',
      detail: 'AI request failed after the provider returned a timeout',
    ),
    _AuditEvent(
      id: 'a004',
      timestamp: '29 Oct, 12:52:40',
      actor: 'Meena Krishnan',
      actorRole: 'Admin',
      tenant: 'Platform',
      action: 'module.toggle',
      category: 'config',
      severity: 'Info',
      resource: 'module-control',
      outcome: 'Success',
      actorEmail: 'meena@colossusiq.com',
      ipAddress: '203.0.113.21',
      resourceId: 'module-research',
      detail: 'Research module enabled for the selected tenant',
    ),
    _AuditEvent(
      id: 'a005',
      timestamp: '29 Oct, 12:45:19',
      actor: 'Arjun Selvam',
      actorRole: 'Institution',
      tenant: 'KPR Institute',
      action: 'score.override',
      category: 'data',
      severity: 'Critical',
      resource: 'evaluation',
      outcome: 'Success',
      actorEmail: 'arjun.selvam@example.edu',
      ipAddress: '203.0.113.33',
      resourceId: 'evaluation-8841',
      detail: 'Assessment score changed from 72 to 82 with approval',
    ),
    _AuditEvent(
      id: 'a006',
      timestamp: '29 Oct, 12:38:02',
      actor: 'Rajesh Kumar',
      actorRole: 'Admin',
      tenant: 'Platform',
      action: 'billing.waiver.grant',
      category: 'billing',
      severity: 'Warning',
      resource: 'billing',
      outcome: 'Success',
      actorEmail: 'rajesh@colossusiq.com',
      ipAddress: '103.24.11.5',
      resourceId: 'invoice-2025-104',
      detail: 'Billing waiver granted for the current subscription period',
    ),
    _AuditEvent(
      id: 'a007',
      timestamp: '29 Oct, 12:29:33',
      actor: 'Divya Lakshmi',
      actorRole: 'Institution',
      tenant: 'RVS College',
      action: 'integration.secret.update',
      category: 'security',
      severity: 'Warning',
      resource: 'integrations',
      outcome: 'Success',
      actorEmail: 'divya.lakshmi@example.edu',
      ipAddress: '203.0.113.42',
      resourceId: 'integration-zoho',
      detail: 'Integration secret rotated by an institution administrator',
    ),
    _AuditEvent(
      id: 'a008',
      timestamp: '29 Oct, 12:22:11',
      actor: 'Unknown',
      actorRole: 'System',
      tenant: 'Amrita Vishwa',
      action: 'auth.login.failed',
      category: 'auth',
      severity: 'Critical',
      resource: 'auth',
      outcome: 'Failure',
      actorEmail: 'unknown',
      ipAddress: '203.0.113.55',
      resourceId: 'login-attempt-448',
      detail: 'Login rejected after repeated invalid credentials',
    ),
    _AuditEvent(
      id: 'a009',
      timestamp: '29 Oct, 12:14:28',
      actor: 'Meena Krishnan',
      actorRole: 'Admin',
      tenant: 'Platform',
      action: 'content.publish',
      category: 'content',
      severity: 'Info',
      resource: 'content-desk',
      outcome: 'Success',
      actorEmail: 'meena@colossusiq.com',
      ipAddress: '203.0.113.21',
      resourceId: 'content-319',
      detail: 'Approved content was published to the student portal',
    ),
    _AuditEvent(
      id: 'a010',
      timestamp: '29 Oct, 12:08:55',
      actor: 'Suresh Babu',
      actorRole: 'HOD',
      tenant: 'PSG College',
      action: 'certificate.issue',
      category: 'data',
      severity: 'Info',
      resource: 'certificate-authority',
      outcome: 'Success',
      actorEmail: 'suresh.babu@example.edu',
      ipAddress: '203.0.113.62',
      resourceId: 'certificate-771',
      detail: 'A completion certificate was issued to a student',
    ),
    _AuditEvent(
      id: 'a011',
      timestamp: '29 Oct, 12:00:07',
      actor: 'System',
      actorRole: 'System',
      tenant: 'Platform',
      action: 'security.mfa.enforce',
      category: 'security',
      severity: 'Info',
      resource: 'security-settings',
      outcome: 'Success',
      actorEmail: 'system@colossusiq.com',
      ipAddress: '203.0.113.18',
      resourceId: 'mfa-policy',
      detail: 'Multi-factor authentication policy was enforced',
    ),
    _AuditEvent(
      id: 'a012',
      timestamp: '29 Oct, 11:52:44',
      actor: 'Rajesh Kumar',
      actorRole: 'Admin',
      tenant: 'Platform',
      action: 'college.suspend',
      category: 'config',
      severity: 'Critical',
      resource: 'colleges',
      outcome: 'Success',
      actorEmail: 'rajesh@colossusiq.com',
      ipAddress: '103.24.11.5',
      resourceId: 'tenant-sns',
      detail: 'Tenant account suspended after an administrative review',
    ),
  ];

  static const _tenants = [
    'All Tenants',
    'Amrita Vishwa',
    'KPR Institute',
    'PSG College',
    'Platform',
    'RVS College',
    'SNS College',
  ];
  static const _categories = [
    'All Categories',
    'auth',
    'config',
    'data',
    'ai',
    'user',
    'billing',
    'security',
    'content',
  ];
  static const _severities = [
    'All Severity',
    'Info',
    'Warning',
    'Critical',
  ];
  static const _outcomes = ['All Outcomes', 'Success', 'Failure'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final events = _filteredEvents;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Breadcrumbs
              _buildBreadcrumbs(),
              const SizedBox(height: 14),

              // 2. Blueprint Hero Banner (Matches Mockup)
              _buildHeroBanner(),
              const SizedBox(height: 18),

              _buildPageHeading(),
              const SizedBox(height: 18),

              _buildMetrics(events),
              const SizedBox(height: 18),

              _buildFilters(),
              const SizedBox(height: 18),

              _buildAuditTable(events),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  List<_AuditEvent> get _filteredEvents {
    final query = _searchController.text.trim().toLowerCase();
    return _events.where((event) {
      final matchesTenant =
          _selectedTenant == 'All Tenants' || event.tenant == _selectedTenant;
      final matchesCategory =
          _selectedCategory == 'All Categories' ||
          event.category == _selectedCategory;
      final matchesSeverity =
          _selectedSeverity == 'All Severity' ||
          event.severity == _selectedSeverity;
      final matchesOutcome =
          _selectedOutcome == 'All Outcomes' ||
          event.outcome == _selectedOutcome;
      final matchesSearch =
          query.isEmpty ||
          [
            event.timestamp,
            event.actor,
            event.actorRole,
            event.tenant,
            event.action,
            event.category,
            event.severity,
            event.resource,
            event.outcome,
            event.id,
            event.actorEmail,
            event.ipAddress,
            event.resourceId,
            event.detail,
          ].any((value) => value.toLowerCase().contains(query));

      return matchesTenant &&
          matchesCategory &&
          matchesSeverity &&
          matchesOutcome &&
          matchesSearch;
    }).toList();
  }

  // ===========================================================================
  // 1. BREADCRUMBS
  // ===========================================================================
  Widget _buildBreadcrumbs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
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
            "Platform",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
          ),
          Text(
            "Audit Log",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
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
            // Blueprint grid overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintDarkGridPainter(),
              ),
            ),
            // Background watermark icon
            Positioned(
              right: -10,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.receipt_long_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Scroll / Document Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(
                    Icons.description_rounded,
                    color: Color(0xFFFBBF24),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),

                // Title, Badges & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "PLATFORM",
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
                        "Audit Log",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Security-relevant actions, score overrides and configuration changes.",
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

  Widget _buildPageHeading() {
    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Audit Log',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        Text(
          'Security-relevant actions, configuration changes and score overrides — immutable and tamper-evident.',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
    final actions = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: _copyJson,
          icon: const Icon(Icons.copy_rounded, size: 15),
          label: const Text('Copy JSON'),
          style: _actionButtonStyle(),
        ),
        OutlinedButton.icon(
          onPressed: _exportCsv,
          icon: const Icon(Icons.download_rounded, size: 15),
          label: const Text('Export CSV'),
          style: _actionButtonStyle(),
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              const SizedBox(height: 10),
              actions,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: title),
            actions,
          ],
        );
      },
    );
  }

  ButtonStyle _actionButtonStyle() => OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF334155),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      );

  Widget _buildMetrics(List<_AuditEvent> events) {
    final metrics = [
      ('Total Events', '${events.length}', 'filtered', const Color(0xFF0F172A)),
      (
        'Critical',
        '${events.where((event) => event.severity == 'Critical').length}',
        'severity',
        const Color(0xFFDC2626),
      ),
      (
        'Failures',
        '${events.where((event) => event.outcome == 'Failure').length}',
        'outcome',
        const Color(0xFFDC2626),
      ),
      ('Categories', '${events.map((event) => event.category).toSet().length}', 'distinct', const Color(0xFF0F172A)),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnCount = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 500
                ? 2
                : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: metrics.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 84,
          ),
          itemBuilder: (context, index) {
            final metric = metrics[index];
            return _buildMetricCard(
              metric.$1,
              metric.$2,
              metric.$3,
              metric.$4,
            );
          },
        );
      },
    );
  }

  Widget _buildMetricCard(String label, String value, String footer, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7E3DC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
          ),
          Text(
            value,
            key: ValueKey('audit-metric-value-$label'),
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            footer,
            style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: const Color(0xFFE7E3DC)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: 'Search actor, action, IP, detail...',
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
              prefixIcon: const Icon(Icons.search_rounded, size: 17, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildFilterDropdown(
          key: const ValueKey('audit-filter-tenant'),
          value: _selectedTenant,
          options: _tenants,
          onChanged: (value) => setState(() => _selectedTenant = value),
        ),
        const SizedBox(height: 10),
        _buildFilterDropdown(
          key: const ValueKey('audit-filter-category'),
          value: _selectedCategory,
          options: _categories,
          onChanged: (value) => setState(() => _selectedCategory = value),
        ),
        const SizedBox(height: 10),
        _buildFilterDropdown(
          key: const ValueKey('audit-filter-severity'),
          value: _selectedSeverity,
          options: _severities,
          onChanged: (value) => setState(() => _selectedSeverity = value),
        ),
        const SizedBox(height: 10),
        _buildFilterDropdown(
          key: const ValueKey('audit-filter-outcome'),
          value: _selectedOutcome,
          options: _outcomes,
          onChanged: (value) => setState(() => _selectedOutcome = value),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown({
    required Key key,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFE7E3DC)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          key: key,
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF334155)),
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
          items: options
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (nextValue) {
            if (nextValue != null) onChanged(nextValue);
          },
        ),
      ),
    );
  }

  Widget _buildAuditTable(List<_AuditEvent> events) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tableWidth = constraints.maxWidth < 1160 ? 1160.0 : constraints.maxWidth;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      children: [
                        _buildTableHeader(),
                        if (events.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(28),
                            child: Text(
                              'No matching records',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          )
                        else
                          ...events.map(
                            (event) => Column(
                              children: [
                                _buildAuditRow(event),
                                if (_expandedEventId == event.id)
                                  _buildExpandedDetails(event, tableWidth),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
                  ),
                  child: Text(
                    'Showing ${events.length} of ${_events.length} entries. Click a row to expand detail. (Demo data — connect the audit API to see live logs.) Audit entries are immutable and cannot be edited or deleted.',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          _tableCell(15, const Text('TIMESTAMP'), header: true),
          _tableCell(14, const Text('ACTOR'), header: true),
          _tableCell(13, const Text('TENANT'), header: true),
          _tableCell(17, const Text('ACTION'), header: true),
          _tableCell(9, const Text('CATEGORY'), header: true),
          _tableCell(10, const Text('SEVERITY'), header: true),
          _tableCell(14, const Text('RESOURCE'), header: true),
          _tableCell(8, const Text('OUTCOME'), header: true),
        ],
      ),
    );
  }

  Widget _buildAuditRow(_AuditEvent event) {
    final expanded = _expandedEventId == event.id;
    return Material(
      color: expanded ? const Color(0xFFF8FAFC) : Colors.white,
      child: InkWell(
        onTap: () => setState(
          () => _expandedEventId = expanded ? null : event.id,
        ),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
          ),
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              _tableCell(15, _monoText(event.timestamp, color: const Color(0xFF64748B))),
              _tableCell(
                14,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.actor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      event.actorRole,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              _tableCell(13, _bodyText(event.tenant)),
              _tableCell(17, _monoText(event.action)),
              _tableCell(9, _buildBadge(_categoryLabel(event.category))),
              _tableCell(10, _buildSeverityBadge(event.severity)),
              _tableCell(14, _monoText(event.resource)),
              _tableCell(8, _buildOutcomeBadge(event.outcome)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableCell(int flex, Widget child, {bool header = false}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: header
            ? Text(
                child is Text ? child.data ?? '' : '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.3,
                ),
              )
            : child,
      ),
    );
  }

  Widget _bodyText(String value) => Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155)),
      );

  Widget _monoText(String value, {Color color = const Color(0xFF334155)}) => Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.robotoMono(fontSize: 10.5, color: color),
      );

  Widget _buildBadge(String label, {Color? background, Color? foreground}) {
    final colors = _categoryColors(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background ?? colors.$1,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: foreground ?? colors.$2,
        ),
      ),
    );
  }

  (Color, Color) _categoryColors(String category) {
    switch (category.toLowerCase()) {
      case 'config':
        return (const Color(0xFFF1F5F9), const Color(0xFF334155));
      case 'user':
        return (const Color(0xFFDCFCE7), const Color(0xFF15803D));
      case 'ai':
        return (const Color(0xFFE0E7FF), const Color(0xFF4F46E5));
      case 'data':
        return (const Color(0xFFCFFAFE), const Color(0xFF0E7490));
      case 'billing':
        return (const Color(0xFFFEF3C7), const Color(0xFFB45309));
      case 'security':
        return (const Color(0xFFFEE2E2), const Color(0xFFB91C1C));
      case 'auth':
        return (const Color(0xFFF3E8FF), const Color(0xFF7E22CE));
      case 'content':
        return (const Color(0xFFCCFBF1), const Color(0xFF0F766E));
      default:
        return (const Color(0xFFF1F5F9), const Color(0xFF334155));
    }
  }

  Widget _buildSeverityBadge(String severity) {
    switch (severity) {
      case 'Critical':
        return _buildBadge(
          severity,
          background: const Color(0xFFFEE2E2),
          foreground: const Color(0xFFDC2626),
        );
      case 'Warning':
        return _buildBadge(
          severity,
          background: const Color(0xFFFEF3C7),
          foreground: const Color(0xFFB45309),
        );
      default:
        return _buildBadge(
          severity,
          background: const Color(0xFFDBEAFE),
          foreground: const Color(0xFF2563EB),
        );
    }
  }

  Widget _buildOutcomeBadge(String outcome) => _buildBadge(
        outcome,
        background: outcome == 'Failure'
            ? const Color(0xFFFEE2E2)
            : const Color(0xFFD1FAE5),
        foreground: outcome == 'Failure'
            ? const Color(0xFFDC2626)
            : const Color(0xFF047857),
      );

  String _categoryLabel(String category) =>
      category[0].toUpperCase() + category.substring(1);

  Widget _buildExpandedDetails(_AuditEvent event, double tableWidth) {
    return Container(
      width: tableWidth,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      color: const Color(0xFFF8FAFC),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900
              ? 3
              : constraints.maxWidth >= 600
                  ? 2
                  : 1;
          final fieldWidth =
              (constraints.maxWidth - 16 * (columns - 1)) / columns;
          return Wrap(
            spacing: 16,
            runSpacing: 14,
            children: [
              _detailField('LOG ID', event.id, fieldWidth),
              _detailField('ACTOR EMAIL', event.actorEmail, fieldWidth),
              _detailField('IP ADDRESS', event.ipAddress, fieldWidth),
              _detailField('RESOURCE ID', event.resourceId, fieldWidth),
              _detailField('DETAIL', event.detail, fieldWidth),
            ],
          );
        },
      ),
    );
  }

  Widget _detailField(String label, String value, double width) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF94A3B8),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155)),
          ),
        ],
      ),
    );
  }

  Future<void> _copyJson() async {
    final events = _filteredEvents;
    try {
      await Clipboard.setData(
        ClipboardData(
          text: const JsonEncoder.withIndent('  ')
              .convert(events.map((event) => event.toJson()).toList()),
        ),
      );
      if (!mounted) return;
      _showMessage('Copied ${events.length} audit entries as JSON.');
    } catch (error) {
      if (!mounted) return;
      _showMessage('Could not copy audit entries: $error');
    }
  }

  Future<void> _exportCsv() async {
    final events = _filteredEvents;
    const header = [
      'Timestamp',
      'Actor',
      'Actor role',
      'Tenant',
      'Action',
      'Category',
      'Severity',
      'Resource',
      'Outcome',
      'Log ID',
      'Actor email',
      'IP address',
      'Resource ID',
      'Detail',
    ];
    final rows = [
      header,
      ...events.map((event) => event.toCsvRow()),
    ];
    final csv = rows
        .map(
          (row) => row
              .map((value) => '"${value.replaceAll('"', '""')}"')
              .join(','),
        )
        .join('\r\n');
    const fileName = 'audit_log.csv';

    try {
      final path = await FilePicker.saveFile(
        fileName: fileName,
        bytes: Uint8List.fromList(utf8.encode('\uFEFF$csv')),
        mimeType: 'text/csv',
        dialogTitle: 'Export audit log as CSV',
      );
      if (path == null || !mounted) return;
      _showMessage('Exported ${events.length} audit entries to CSV.');
    } catch (error) {
      if (!mounted) return;
      _showMessage('Could not export $fileName: $error');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

}

// =============================================================================
// GRID PAINTERS
// =============================================================================
class _BlueprintDarkGridPainter extends CustomPainter {
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

typedef AuditLogScreen = PrincipalAuditLogScreen;
