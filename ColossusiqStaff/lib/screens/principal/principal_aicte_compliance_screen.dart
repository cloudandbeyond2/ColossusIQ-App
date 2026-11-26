import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAicteComplianceScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalAicteComplianceScreen({super.key, this.onBack});

  @override
  State<PrincipalAicteComplianceScreen> createState() =>
      _PrincipalAicteComplianceScreenState();
}

class _PrincipalAicteComplianceScreenState
    extends State<PrincipalAicteComplianceScreen> {
  int _selectedTab =
      0; // 0: Norms, 1: Dept Breakdown, 2: Statutory Committees, 3: Action Plan
  String _deptSearchQuery = "";
  String _selectedDeptFilter = "All Sanctioned Departments";
  String _actionStatusFilter = "All Statuses";
  String _aicteId = '';
  DateTime? _lastSync;

  final List<_ComplianceDepartment> _departments = [
    _ComplianceDepartment(
      name: 'Computer Science & Engineering',
      students: 6,
      faculty: 3,
      professors: 1,
      associateProfessors: 1,
      assistantProfessors: 1,
      courses: 13,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Artificial Intelligence & Data Science',
      students: 0,
      faculty: 0,
      courses: 2,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Electronics & Communication',
      students: 0,
      faculty: 0,
      courses: 1,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Electrical & Electronics',
      students: 0,
      faculty: 0,
      courses: 0,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Information Technology',
      students: 1,
      faculty: 0,
      courses: 0,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Civil Engineering',
      students: 0,
      faculty: 0,
      courses: 0,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Science & Humanities',
      students: 0,
      faculty: 1,
      assistantProfessors: 1,
      courses: 0,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Mechanical Engineering',
      students: 0,
      faculty: 0,
      courses: 0,
      labs: 0,
    ),
    _ComplianceDepartment(
      name: 'Administration',
      students: 0,
      faculty: 0,
      courses: 0,
      labs: 0,
    ),
  ];

  final List<_StatutoryCommittee> _committees = [
    _StatutoryCommittee(
      name: 'Anti-Ragging Committee & Squad',
      code: 'COM-01',
      description:
          'AICTE Regulations 2009 (Clause 6a) – Ragging prevention, squad monitoring, and student affidavits',
      status: 'Constituted & Active',
      lead: 'Dr. Lakshmi Sundaram',
      members: 7,
      lastMeeting: '4 Sept 2026',
      minutes: 'Certified by Principal',
    ),
    _StatutoryCommittee(
      name: 'Internal Complaints Committee (ICC) / POSH',
      code: 'COM-02',
      description:
          'POSH Act 2013 & AICTE Regulations 2016 – Gender sensitization, woman safety, and grievance redressal',
      status: 'Constituted & Active',
      lead: 'Dr. S. Venkatesh',
      members: 6,
      lastMeeting: '8 Aug 2026',
      minutes: 'Pending',
    ),
    _StatutoryCommittee(
      name: 'Student Grievance Redressal Committee (SGRC)',
      code: 'COM-03',
      description:
          'AICTE Regulations 2019 – Ombudsman oversight, student grievance portal, and appellate mechanism',
      status: 'Constituted & Active',
      lead: 'Dr. Lakshmi Sundaram',
      members: 6,
      lastMeeting: '22 Aug 2026',
      minutes: 'Certified by Principal',
    ),
    _StatutoryCommittee(
      name: 'SC / ST Committee & Equal Opportunity Cell',
      code: 'COM-04',
      description:
          'Scheduled Castes & Scheduled Tribes Prevention of Atrocities Act & AICTE guidelines',
      status: 'Pending Reconstitution',
      lead: 'Dr. Meena Raghavan',
      members: 5,
      lastMeeting: '25 Aug 2025',
      minutes: 'Not Held',
    ),
    _StatutoryCommittee(
      name: 'Internal Quality Assurance Cell (IQAC)',
      code: 'COM-05',
      description:
          'Continuous quality monitoring, academic audits, NIRF/NBA alignment, and student feedback',
      status: 'Constituted & Active',
      lead: 'Dr. Lakshmi Sundaram',
      members: 9,
      lastMeeting: '18 Sept 2026',
      minutes: 'Certified by Principal',
    ),
    _StatutoryCommittee(
      name: 'Industry-Institute Interaction Cell (IIIC) & Placement',
      code: 'COM-06',
      description:
          'AICTE Internship Policy, industry MoUs, campus placement drives, and skill development',
      status: 'Constituted & Active',
      lead: 'Dr. Lakshmi Sundaram',
      members: 8,
      lastMeeting: '11 Jul 2026',
      minutes: 'Certified by Principal',
    ),
  ];

  final List<_ComplianceAction> _actions = [
    _ComplianceAction(
      title: 'Reconstitute the SC / ST Committee and hold its first meeting',
      description:
          'Nominate members for the new term and circulate the notice.',
      category: 'Statutory Committees',
      priority: 'High',
      status: 'Open',
      assignedTo: 'Principal Office',
      dueDate: DateTime(2026, 10, 3),
      loggedBy: 'Seed (test data)',
    ),
    _ComplianceAction(
      title: 'Get ICC meeting minutes certified',
      description:
          'Minutes of the last meeting are with the Principal for signature.',
      category: 'Statutory Committees',
      priority: 'Medium',
      status: 'In Progress',
      assignedTo: 'Dr. S. Venkatesh',
      dueDate: DateTime(2026, 10, 18),
      loggedBy: 'Seed (test data)',
    ),
    _ComplianceAction(
      title:
          'Add laboratory courses for departments without a practical course',
      description:
          'Register the lab courses in Course Management so the laboratory norm can be measured.',
      category: 'Infrastructure & Labs',
      priority: 'Medium',
      status: 'Open',
      assignedTo: 'Dr. Meena Raghavan',
      dueDate: DateTime(2026, 11, 8),
      loggedBy: 'Seed (test data)',
    ),
    _ComplianceAction(
      title: 'Update the mandatory disclosure page',
      description: 'Profile fields and contact details verified.',
      category: 'Mandatory Disclosures',
      priority: 'Low',
      status: 'Resolved',
      assignedTo: 'Principal Office',
      dueDate: DateTime(2026, 9, 27),
      resolvedDate: DateTime(2026, 9, 24),
      loggedBy: 'Seed (test data)',
    ),
  ];

  int get _teachingFaculty =>
      _departments.fold(0, (total, department) => total + department.faculty);

  int get _constitutedCommittees => _committees
      .where((committee) => committee.status == 'Constituted & Active')
      .length;

  bool _isOverdue(_ComplianceAction action) {
    final today = DateTime.now();
    final dueDay = DateTime(
      action.dueDate.year,
      action.dueDate.month,
      action.dueDate.day,
    );
    final todayStart = DateTime(today.year, today.month, today.day);
    return action.status != 'Resolved' && dueDay.isBefore(todayStart);
  }

  String _formatIsoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  String _formatPickerDate(DateTime date) =>
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.year.toString().padLeft(4, '0')}';

  Widget _actionMetadata(String label, String value, {Color? valueColor}) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          color: const Color(0xFF64748B),
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: valueColor ?? const Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteAction(_ComplianceAction action) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete action item?'),
        content: Text('Delete "${action.title}" from the compliance plan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _actions.remove(action));
  }

  Future<void> _editAicteId() async {
    var idValue = _aicteId;
    final id = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('AICTE Permanent ID'),
        content: TextFormField(
          initialValue: idValue,
          onChanged: (value) => idValue = value,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Permanent ID',
            hintText: 'Enter the institution AICTE ID',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, idValue.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (id == null || !mounted) return;
    setState(() => _aicteId = id);
  }

  void _syncMetrics() {
    setState(() => _lastSync = DateTime.now());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Local compliance snapshot refreshed. Live AICTE portal sync is not connected.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _exportReport() async {
    final rows = <List<String>>[
      ['AICTE Compliance Dossier'],
      ['Generated at', DateTime.now().toIso8601String()],
      ['AICTE Permanent ID', _aicteId.isEmpty ? 'Not entered' : _aicteId],
      ['Compliance index', '72%'],
      ['Faculty-student ratio', '1:1.8'],
      ['Teaching faculty', '$_teachingFaculty'],
      ['Statutory committees constituted', '$_constitutedCommittees/6'],
      [],
      ['Departments', 'Students', 'Faculty', 'Courses', 'Labs'],
      ..._departments.map(
        (department) => [
          department.name,
          '${department.students}',
          '${department.faculty}',
          '${department.courses}',
          '${department.labs}',
        ],
      ),
      [],
      ['Committees', 'Status', 'Lead', 'Members', 'Last meeting', 'Minutes'],
      ..._committees.map(
        (committee) => [
          committee.name,
          committee.status,
          committee.lead,
          '${committee.members}',
          committee.lastMeeting,
          committee.minutes,
        ],
      ),
      [],
      [
        'Action items',
        'Description',
        'Category',
        'Priority',
        'Assignee',
        'Status',
        'Due date',
        'Resolved date',
        'Logged by',
      ],
      ..._actions.map(
        (action) => [
          action.title,
          action.description,
          action.category,
          action.priority,
          action.assignedTo,
          action.status,
          _formatIsoDate(action.dueDate),
          action.resolvedDate == null
              ? ''
              : _formatIsoDate(action.resolvedDate!),
          action.loggedBy,
        ],
      ),
    ];
    final csv = rows
        .map(
          (row) =>
              row.map((cell) => '"${cell.replaceAll('"', '""')}"').join(','),
        )
        .join('\r\n');
    final bytes = Uint8List.fromList(utf8.encode('\uFEFF$csv'));
    final path = await FilePicker.saveFile(
      dialogTitle: 'Export AICTE compliance report',
      fileName: 'aicte_compliance_report.csv',
      bytes: bytes,
    );
    if (path == null || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AICTE compliance CSV exported.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildActionCategoryField({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'Statutory Committees',
          child: Text('Statutory Committees'),
        ),
        DropdownMenuItem(
          value: 'Infrastructure & Labs',
          child: Text('Infrastructure & Labs'),
        ),
        DropdownMenuItem(
          value: 'Mandatory Disclosures',
          child: Text('Mandatory Disclosures'),
        ),
        DropdownMenuItem(
          value: 'Faculty & Academics',
          child: Text('Faculty & Academics'),
        ),
      ],
      onChanged: onChanged,
    );
  }

  Widget _buildActionPriorityField({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Priority',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'High', child: Text('High')),
        DropdownMenuItem(value: 'Medium', child: Text('Medium')),
        DropdownMenuItem(value: 'Low', child: Text('Low')),
      ],
      onChanged: onChanged,
    );
  }

  Future<void> _showLogActionDialog() async {
    var title = '';
    var description = '';
    var dueDate = DateTime.now().add(const Duration(days: 14));
    var priority = 'High';
    var category = 'Statutory Committees';
    var assignee = 'Principal Office';
    final isWideDialog = MediaQuery.sizeOf(context).width >= 600;
    final action = await showDialog<_ComplianceAction>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Log AICTE Compliance Action',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: true,
                  onChanged: (value) => title = value,
                  decoration: const InputDecoration(
                    labelText: 'Action title',
                    hintText: 'e.g. Schedule Anti-Ragging Committee meeting',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (isWideDialog)
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCategoryField(
                          value: category,
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => category = value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionPriorityField(
                          value: priority,
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => priority = value);
                            }
                          },
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildActionCategoryField(
                        value: category,
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() => category = value);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildActionPriorityField(
                        value: priority,
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() => priority = value);
                          }
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: assignee,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Assignee / Lead',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Principal Office',
                      child: Text('Principal Office'),
                    ),
                    DropdownMenuItem(
                      value: 'Dr. Lakshmi Sundaram',
                      child: Text('Dr. Lakshmi Sundaram'),
                    ),
                    DropdownMenuItem(
                      value: 'Dr. S. Venkatesh',
                      child: Text('Dr. S. Venkatesh'),
                    ),
                    DropdownMenuItem(
                      value: 'Dr. Meena Raghavan',
                      child: Text('Dr. Meena Raghavan'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => assignee = value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: ValueKey(_formatPickerDate(dueDate)),
                  initialValue: _formatPickerDate(dueDate),
                  readOnly: true,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: dueDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setDialogState(() => dueDate = selectedDate);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Target Due Date',
                    suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  maxLines: 3,
                  onChanged: (value) => description = value,
                  decoration: const InputDecoration(
                    labelText: 'Notes / Scope',
                    hintText: 'Details on requirements and deliverables...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final actionTitle = title.trim();
                if (actionTitle.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter an action title.')),
                  );
                  return;
                }
                Navigator.pop(
                  ctx,
                  _ComplianceAction(
                    title: actionTitle,
                    description: description.trim(),
                    category: category,
                    priority: priority,
                    assignedTo: assignee,
                    status: 'Open',
                    dueDate: dueDate,
                    loggedBy: 'Principal Office',
                  ),
                );
              },
              child: const Text('Save Action'),
            ),
          ],
        ),
      ),
    );
    if (action == null || !mounted) return;
    setState(() {
      _actions.insert(0, action);
      _selectedTab = 3;
    });
  }

  Future<void> _showRecordCommitteeDialog(_StatutoryCommittee committee) async {
    var lead = committee.lead;
    var members = committee.members == 0 ? '' : '${committee.members}';
    var meeting = committee.lastMeeting;
    var status = committee.status;
    var minutes = committee.minutes;
    final updatedCommittee = await showDialog<_StatutoryCommittee>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          scrollable: true,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            committee.name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  committee.code,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: status,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Constituted & Active',
                      child: Text('Constituted & Active'),
                    ),
                    DropdownMenuItem(
                      value: 'Pending Reconstitution',
                      child: Text('Pending Reconstitution'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => status = value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: lead,
                  onChanged: (value) => lead = value,
                  decoration: const InputDecoration(
                    labelText: 'Chairperson / lead',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: members,
                  onChanged: (value) => members = value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Members',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: meeting,
                  onChanged: (value) => meeting = value,
                  decoration: const InputDecoration(
                    labelText: 'Last meeting',
                    hintText: 'DD/MM/YYYY',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: minutes,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Meeting minutes (MoM)',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Certified by Principal',
                      child: Text('Certified by Principal'),
                    ),
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(
                      value: 'Not Held',
                      child: Text('Not Held'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => minutes = value);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final memberCount = int.tryParse(members.trim());
                if (lead.trim().isEmpty ||
                    memberCount == null ||
                    memberCount < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a lead and a valid member count.'),
                    ),
                  );
                  return;
                }
                Navigator.pop(
                  ctx,
                  _StatutoryCommittee(
                    name: committee.name,
                    code: committee.code,
                    description: committee.description,
                    status: status,
                    lead: lead.trim(),
                    members: memberCount,
                    lastMeeting: meeting.trim(),
                    minutes: minutes,
                  ),
                );
              },
              child: const Text('Save committee'),
            ),
          ],
        ),
      ),
    );
    if (updatedCommittee == null || !mounted) return;
    setState(() {
      final index = _committees.indexWhere(
        (item) => item.code == updatedCommittee.code,
      );
      if (index >= 0) _committees[index] = updatedCommittee;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
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
                // 1. TOP BLUEPRINT HERO BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. INSTITUTIONAL REGULATORY & APPROVAL TRACKING CARD
                _buildInstitutionOverviewCard(),
                const SizedBox(height: 20),

                // 3. 4 METRIC KPI STAT CARDS
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 22),

                // 4. NAVIGATION SUB-TABS
                _buildSubTabs(),
                const SizedBox(height: 20),

                // 5. ACTIVE SUB-TAB CONTENT
                switch (_selectedTab) {
                  1 => _buildDepartmentBreakdownTab(constraints.maxWidth),
                  2 => _buildStatutoryCommitteesTab(constraints.maxWidth),
                  3 => _buildComplianceActionPlanTab(),
                  _ => _buildNormsScorecardTab(constraints.maxWidth),
                },
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. TOP BLUEPRINT HERO BANNER
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
              child: CustomPaint(painter: _BlueprintGridPainter()),
            ),
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.verified_user_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
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
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
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
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        Text(
                          "Institution",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        Text(
                          "AICTE Compliance",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header Row with Icon & Badges
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E285F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.verified_user_rounded,
                            color: Color(0xFFF59E0B),
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "INSTITUTION",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Phase 3",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "AICTE Compliance",
                              style: GoogleFonts.poppins(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Approval conditions, faculty-student ratio, labs and mandatory disclosures.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFCBD5E1),
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
  // 2. INSTITUTIONAL REGULATORY & APPROVAL TRACKING CARD
  // ===========================================================================
  Widget _buildInstitutionOverviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;

          final leftInfo = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "AICTE REGULATORY & APPROVAL TRACKING",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _aicteId.isEmpty ? "PID: Not entered" : "PID: $_aicteId",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _editAicteId,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _aicteId.isEmpty ? "Enter AICTE ID" : "Edit AICTE ID",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "AY 2026–2027",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Review needed (72%)",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Anna Institute of Technology",
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Institutional approval conditions, faculty-to-student cadre norms, laboratory curricula, and mandatory public disclosures.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
            ],
          );

          final rightActions = Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              OutlinedButton(
                onPressed: _syncMetrics,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _lastSync == null
                      ? "Refresh Snapshot"
                      : "Refreshed ${TimeOfDay.fromDateTime(_lastSync!).format(context)}",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _exportReport,
                icon: const Icon(Icons.download_rounded, size: 14),
                label: Text(
                  "Export Report (CSV)",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showLogActionDialog,
                icon: const Icon(Icons.add_rounded, size: 16),
                label: Text(
                  "Log Action",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF131B4D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );

          if (isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: leftInfo),
                const SizedBox(width: 16),
                rightActions,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [leftInfo, const SizedBox(height: 16), rightActions],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 3. 4 METRIC KPI STAT CARDS
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    final professors = _departments.fold(
      0,
      (total, department) => total + department.professors,
    );
    final associateProfessors = _departments.fold(
      0,
      (total, department) => total + department.associateProfessors,
    );
    final assistantProfessors = _departments.fold(
      0,
      (total, department) => total + department.assistantProfessors,
    );
    final pendingCommittees = _committees.length - _constitutedCommittees;
    final kpis = [
      {
        "title": "AICTE Compliance Index",
        "value": "72%",
        "subtitle": "Review needed",
        "dotColor": const Color(0xFFF59E0B),
      },
      {
        "title": "Faculty-Student Ratio",
        "value": "1 : 1.8",
        "subtitle": "Norm: 1:20 (within limit)",
        "dotColor": const Color(0xFF10B981), // Green
      },
      {
        "title": "Teaching Faculty",
        "value": '$_teachingFaculty',
        "subtitle":
            "$professors Prof · $associateProfessors Assoc · $assistantProfessors Asst",
        "dotColor": null,
      },
      {
        "title": "Statutory Committees",
        "value": "$_constitutedCommittees / ${_committees.length} Constituted",
        "subtitle": "$pendingCommittees pending",
        "dotColor": const Color(0xFFF59E0B), // Orange
      },
    ];

    if (maxWidth >= 1000) {
      return Row(
        children: kpis.map((k) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _buildSingleKpiCard(k),
            ),
          );
        }).toList(),
      );
    } else if (maxWidth >= 600) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSingleKpiCard(kpis[0])),
              const SizedBox(width: 12),
              Expanded(child: _buildSingleKpiCard(kpis[1])),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSingleKpiCard(kpis[2])),
              const SizedBox(width: 12),
              Expanded(child: _buildSingleKpiCard(kpis[3])),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: kpis.map((k) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildSingleKpiCard(k),
          );
        }).toList(),
      );
    }
  }

  Widget _buildSingleKpiCard(Map<String, dynamic> k) {
    return Container(
      padding: const EdgeInsets.all(18),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  k["title"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (k["dotColor"] != null)
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: k["dotColor"] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            k["value"] as String,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            k["subtitle"] as String,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. NAVIGATION SUB-TABS
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      {"icon": Icons.shield_outlined, "title": "Norms Scorecard & Analysis"},
      {
        "icon": Icons.apps_outlined,
        "title": "Department Breakdown (${_departments.length})",
      },
      {
        "icon": Icons.group_outlined,
        "title": "Statutory Committees & Disclosures",
      },
      {"title": "Compliance Action Plan (${_actions.length})"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final t = tabs[index];
          final isSelected = _selectedTab == index;

          return Padding(
            padding: const EdgeInsets.only(right: 18),
            child: InkWell(
              onTap: () {
                setState(() => _selectedTab = index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1E1B4B)
                          : Colors.transparent,
                      width: 2.2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    if (t["icon"] != null) ...[
                      Icon(
                        t["icon"] as IconData,
                        size: 16,
                        color: isSelected
                            ? const Color(0xFF1E1B4B)
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      t["title"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF1E1B4B)
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // 5A. TAB 0: NORMS SCORECARD & ANALYSIS (Images 1 & 2)
  // ===========================================================================
  Widget _buildNormsScorecardTab(double maxWidth) {
    final isDesktop = maxWidth >= 900;

    // Charts Row
    final chartsRow = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildNormsComplianceScoreCard()),
              const SizedBox(width: 18),
              Expanded(child: _buildDepartmentFacultyStudentsCard()),
            ],
          )
        : Column(
            children: [
              _buildNormsComplianceScoreCard(),
              const SizedBox(height: 18),
              _buildDepartmentFacultyStudentsCard(),
            ],
          );

    // Strengths & Observations Row (Image 2)
    final strengthsAndObsRow = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: _buildInstitutionalStrengthsCard()),
              const SizedBox(width: 18),
              Expanded(flex: 6, child: _buildActionableObservationsCard()),
            ],
          )
        : Column(
            children: [
              _buildInstitutionalStrengthsCard(),
              const SizedBox(height: 18),
              _buildActionableObservationsCard(),
            ],
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        chartsRow,
        const SizedBox(height: 20),
        strengthsAndObsRow,
        const SizedBox(height: 20),
        _buildRegulatoryStandardsEvaluationCard(),
      ],
    );
  }

  Widget _buildNormsComplianceScoreCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AICTE Norms Compliance Score (%)",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: CustomPaint(painter: _AicteNormsBarChartPainter()),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentFacultyStudentsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Department Faculty vs Students Allocation",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: CustomPaint(
              painter: _AicteFacultyAllocationChartPainter(_departments),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstitutionalStrengthsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(
                Icons.check_rounded,
                color: Color(0xFF0D9488),
                size: 18,
              ),
              Text(
                "Institutional Strengths",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 6, right: 10),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D9488),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  "Faculty-student ratio is 1 : 1.8 (7 students, 4 teaching faculty), within the 1:20 norm.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF334155),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionableObservationsCard() {
    final observations = [
      "No Professor-level faculty are recorded; designate or recruit senior faculty.",
      "1 statutory committee is pending reconstitution: SC / ST Committee & Equal Opportunity Cell.",
      "Review practical courses and laboratory coverage across the 9 sanctioned departments.",
      "Information Technology has 1 student and no assigned faculty.",
      "Artificial Intelligence & Data Science has no current enrolment or assigned faculty.",
      "Electrical & Electronics has no current enrolment or assigned faculty.",
      "Mechanical Engineering has no current enrolment or assigned faculty.",
      "Civil Engineering has no current enrolment or assigned faculty.",
      "Public disclosure incomplete: AICTE permanent id.",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Actionable Observations & Routine Audit",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          ...observations.map((obs) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD97706), // Amber bullet
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      obs,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF334155),
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRegulatoryStandardsEvaluationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AICTE Regulatory Standards Evaluation",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),

          // Standard 1: FSR
          _buildStandardEvaluationRow(
            title: "Faculty-Student Ratio (FSR)",
            badge: "Compliant",
            badgeColor: const Color(0xFFCCFBF1),
            badgeTextColor: const Color(0xFF0F766E),
            category: "(Faculty & Academics)",
            normReq:
                "Norm Requirement: Min 1:20 for UG Technical Courses (AICTE APH 2026–2027)",
            actualRecord:
                "Actual Institutional Record: 1 : 1.8 (7 enrolled students : 4 teaching faculty)",
            note: "Within the regulatory limit.",
            progressVal: 1.0,
            progressColor: const Color(0xFF0D9488),
            percentText: "100%",
          ),
          const Divider(height: 32, color: Color(0xFFF1F5F9)),

          // Standard 2: Cadre Ratio
          _buildStandardEvaluationRow(
            title: "Faculty Cadre Ratio",
            badge: "Deficient",
            badgeColor: const Color(0xFFFEE2E2),
            badgeTextColor: const Color(0xFFDC2626),
            category: "(Faculty & Academics)",
            normReq:
                "Norm Requirement: 1 : 2 : 6 (Professor : Assoc. Professor : Asst. Professor)",
            actualRecord:
                "Actual Institutional Record: 0 Prof : 2 Assoc : 1 Asst Prof",
            note:
                "Add Professor and Associate Professor posts, or correct the designations in Staff Management.",
            progressVal: 0.56,
            progressColor: const Color(0xFF991B1B),
            percentText: "56%",
          ),
          const Divider(height: 32, color: Color(0xFFF1F5F9)),

          // Standard 3: Statutory Committees
          _buildStandardEvaluationRow(
            title: "Statutory Committees & Grievance Bodies",
            badge: "Deficient",
            badgeColor: const Color(0xFFFEE2E2),
            badgeTextColor: const Color(0xFFDC2626),
            category: "(Governance & Statutory)",
            normReq:
                "Norm Requirement: Mandatory constitution of Anti-Ragging, ICC, SGRC, SC/ST, IQAC and IIIC",
            actualRecord:
                "Actual Institutional Record: 0 of 6 constituted · 0 recorded on this page",
            note: "Record 6 committees in the Statutory Committees tab.",
            progressVal: 0.0,
            progressColor: const Color(0xFF991B1B),
            percentText: "0%",
          ),
        ],
      ),
    );
  }

  Widget _buildStandardEvaluationRow({
    required String title,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    required String category,
    required String normReq,
    required String actualRecord,
    required String note,
    required double progressVal,
    required Color progressColor,
    required String percentText,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 650;

        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: badgeTextColor,
                    ),
                  ),
                ),
                Text(
                  category,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              normReq,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF475569),
              ),
            ),
            Text(
              actualRecord,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              note,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        );

        final bar = SizedBox(
          width: isNarrow ? double.infinity : 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                percentText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progressVal,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFF1F5F9),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
            ],
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [details, const SizedBox(height: 12), bar],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: details),
            const SizedBox(width: 20),
            bar,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 5B. TAB 1: DEPARTMENT BREAKDOWN (8) (Image 3)
  // ===========================================================================
  Widget _buildDepartmentBreakdownTab(double maxWidth) {
    final depts = _departments.map((department) {
      final isShortage = department.students > 0 && department.faculty == 0;
      final ratio = department.faculty == 0
          ? 'Faculty Shortage'
          : '1 : ${(department.students / department.faculty).toStringAsFixed(1)}';
      return <String, dynamic>{
        'name': department.name,
        'status': isShortage ? 'Action Required' : 'Compliant',
        'statusColor': isShortage
            ? const Color(0xFFFFFBEB)
            : const Color(0xFFCCFBF1),
        'textColor': isShortage
            ? const Color(0xFFB45309)
            : const Color(0xFF0F766E),
        'students': department.students,
        'faculty': department.faculty,
        'ratio': ratio,
        'isShortage': isShortage,
        'cadre':
            '${department.professors} Prof · ${department.associateProfessors} Assoc · ${department.assistantProfessors} Asst',
        'courses': '${department.courses} Courses (${department.labs} Labs)',
      };
    }).toList();

    final filtered = depts.where((d) {
      final matchesSearch = (d["name"] as String).toLowerCase().contains(
        _deptSearchQuery.toLowerCase(),
      );
      final matchesFilter =
          _selectedDeptFilter == 'All Sanctioned Departments' ||
          d['status'] == _selectedDeptFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      children: [
        // Search & Filter Row
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  onChanged: (val) => setState(() => _deptSearchQuery = val),
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF1E293B),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: Color(0xFF94A3B8),
                    ),
                    hintText: "Search departments...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedDeptFilter,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: Color(0xFF64748B),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "All Sanctioned Departments",
                      child: Text("All Departments"),
                    ),
                    DropdownMenuItem(
                      value: "Action Required",
                      child: Text("Action Required"),
                    ),
                    DropdownMenuItem(
                      value: "Compliant",
                      child: Text("Compliant"),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedDeptFilter = val);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Grid of Department Cards
        LayoutBuilder(
          builder: (context, box) {
            final colCount = box.maxWidth >= 1100
                ? 3
                : box.maxWidth >= 720
                ? 2
                : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: colCount == 1
                    ? 1.35
                    : colCount == 2
                    ? 1.15
                    : 1.05,
              ),
              itemCount: filtered.length,
              itemBuilder: (ctx, idx) {
                final d = filtered[idx];
                final isShortage = d["isShortage"] as bool;

                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
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
                      // Header: Title & Pill
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              d["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2.5,
                            ),
                            decoration: BoxDecoration(
                              color: d["statusColor"] as Color,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              d["status"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: d["textColor"] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Metric Row 1: Enrolled & Teaching Faculty
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enrolled Students",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                                Text(
                                  "${d["students"]}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Teaching Faculty",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                                Text(
                                  "${d["faculty"]}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Dept FSR Ratio
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Dept. FSR (Ratio)",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              d["ratio"] as String,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: isShortage
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Cadre Distribution
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cadre Distribution",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              d["cadre"] as String,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF334155),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Courses & Laboratories
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Courses & Laboratories",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              d["courses"] as String,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF334155),
                              ),
                              overflow: TextOverflow.ellipsis,
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
      ],
    );
  }

  // ===========================================================================
  // 5C. TAB 2: STATUTORY COMMITTEES & DISCLOSURES (Image 4)
  // ===========================================================================
  Widget _buildStatutoryCommitteesTab(double maxWidth) {
    return Column(
      children: [
        // Banner: AICTE Mandatory Public Disclosure Portal
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
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.language_rounded,
                  color: Color(0xFF0F172A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
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
                          "AICTE Mandatory Public Disclosure Portal",
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCFBF1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "Profile 90% complete",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Publicly accessible regulatory disclosures containing approved programmes, faculty profiles, grievance mechanism, and fee structure.",
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
        ),
        const SizedBox(height: 18),

        // Grid of 6 Committee Cards
        LayoutBuilder(
          builder: (context, box) {
            final colCount = box.maxWidth >= 1100
                ? 3
                : box.maxWidth >= 720
                ? 2
                : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: colCount == 1
                    ? 0.95
                    : colCount == 2
                    ? 1.08
                    : 1.2,
              ),
              itemCount: _committees.length,
              itemBuilder: (ctx, idx) {
                final c = _committees[idx];
                final isActive = c.status == 'Constituted & Active';

                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Title & Pill
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  c.code,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFCCFBF1)
                                  : const Color(0xFFFFFBEB),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              c.status,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: isActive
                                    ? const Color(0xFF0F766E)
                                    : const Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 18, color: Color(0xFFF1F5F9)),

                      Text(
                        c.description,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF475569),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Key value details
                      _buildCommitteeMetaRow("Chairperson / Lead", c.lead),
                      const Divider(height: 14, color: Color(0xFFF1F5F9)),
                      _buildCommitteeMetaRow(
                        "Constituted Members",
                        '${c.members} Members',
                      ),
                      const Divider(height: 14, color: Color(0xFFF1F5F9)),
                      _buildCommitteeMetaRow(
                        "Last Review Meeting",
                        c.lastMeeting,
                      ),
                      const Divider(height: 14, color: Color(0xFFF1F5F9)),
                      _buildCommitteeMetaRow(
                        "Meeting Minutes (MoM)",
                        c.minutes,
                        valueColor: c.minutes == 'Certified by Principal'
                            ? const Color(0xFF0D9488)
                            : c.minutes == 'Pending'
                            ? const Color(0xFFD97706)
                            : const Color(0xFF1E293B),
                      ),
                      const SizedBox(height: 12),

                      // Action Button
                      OutlinedButton.icon(
                        onPressed: () => _showRecordCommitteeDialog(c),
                        icon: const Icon(Icons.edit_outlined, size: 14),
                        label: Text(
                          "Update details",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF1E293B),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          minimumSize: const Size(double.infinity, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCommitteeMetaRow(
    String label,
    String value, {
    Color valueColor = const Color(0xFF1E293B),
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          textAlign: TextAlign.right,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5D. TAB 3: COMPLIANCE ACTION PLAN (0) (Image 5)
  // ===========================================================================
  Widget _buildComplianceActionPlanTab() {
    final openCount = _actions
        .where((action) => action.status == 'Open')
        .length;
    final inProgressCount = _actions
        .where((action) => action.status == 'In Progress')
        .length;
    final resolvedCount = _actions
        .where((action) => action.status == 'Resolved')
        .length;
    final overdueCount = _actions.where(_isOverdue).length;
    final filteredActions = _actions
        .where(
          (action) =>
              _actionStatusFilter == 'All Statuses' ||
              action.status == _actionStatusFilter,
        )
        .toList();
    return Column(
      children: [
        // Controls Row
        LayoutBuilder(
          builder: (context, box) {
            final isCompact = box.maxWidth < 680;

            final filterWidget = Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Filter by Status:",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _actionStatusFilter,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF1E293B),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "All Statuses",
                          child: Text("All Statuses"),
                        ),
                        DropdownMenuItem(value: "Open", child: Text("Open")),
                        DropdownMenuItem(
                          value: "In Progress",
                          child: Text("In Progress"),
                        ),
                        DropdownMenuItem(
                          value: "Resolved",
                          child: Text("Resolved"),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _actionStatusFilter = val);
                        }
                      },
                    ),
                  ),
                ),
              ],
            );

            final summaryAndActionWidget = Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: isCompact ? WrapAlignment.start : WrapAlignment.end,
              children: [
                Text(
                  "$openCount open · $inProgressCount in progress · $resolvedCount resolved",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Text(
                  '· $overdueCount overdue',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: overdueCount == 0
                        ? const Color(0xFF64748B)
                        : const Color(0xFFDC2626),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showLogActionDialog,
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: Text(
                    "Log Action Item",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF131B4D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            );

            if (isCompact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  filterWidget,
                  const SizedBox(height: 12),
                  summaryAndActionWidget,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [filterWidget, summaryAndActionWidget],
            );
          },
        ),
        const SizedBox(height: 18),

        if (filteredActions.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Center(
              child: Text(
                'No ${_actionStatusFilter == 'All Statuses' ? '' : '$_actionStatusFilter '}actions found.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  for (var index = 0; index < filteredActions.length; index++)
                    _buildActionTile(
                      filteredActions[index],
                      isLast: index == filteredActions.length - 1,
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionTile(_ComplianceAction action, {required bool isLast}) {
    final isOverdue = _isOverdue(action);
    final priorityColor = switch (action.priority) {
      'High' => const Color(0xFFDC2626),
      'Medium' => const Color(0xFFD97706),
      _ => const Color(0xFF475569),
    };
    final priorityBackground = switch (action.priority) {
      'High' => const Color(0xFFFEE2E2),
      'Medium' => const Color(0xFFFFF1DB),
      _ => const Color(0xFFF1F5F9),
    };
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              action.title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: priorityBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${action.priority} Priority',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: priorityColor,
                ),
              ),
            ),
            Text(
              '(${action.category})',
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        if (action.description.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            action.description,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
        const SizedBox(height: 4),
        Wrap(
          spacing: 14,
          runSpacing: 4,
          children: [
            _actionMetadata('Assigned to', action.assignedTo),
            _actionMetadata(
              'Due',
              _formatIsoDate(action.dueDate),
              valueColor: isOverdue ? const Color(0xFFDC2626) : null,
            ),
            if (isOverdue)
              Text(
                'overdue',
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  color: const Color(0xFFDC2626),
                ),
              ),
            if (action.resolvedDate != null)
              _actionMetadata('Resolved', _formatIsoDate(action.resolvedDate!)),
          ],
        ),
        const SizedBox(height: 4),
        _actionMetadata('Logged by', action.loggedBy),
      ],
    );

    final controls = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Delete action',
          onPressed: () => _confirmDeleteAction(action),
          icon: const Icon(
            Icons.delete_outline_rounded,
            size: 18,
            color: Color(0xFF475569),
          ),
        ),
        Container(
          width: 126,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E8F0)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            key: ValueKey('action-status-${action.title}'),
            value: action.status,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: const [
              DropdownMenuItem(value: 'Open', child: Text('Open')),
              DropdownMenuItem(
                value: 'In Progress',
                child: Text('In Progress'),
              ),
              DropdownMenuItem(value: 'Resolved', child: Text('Resolved')),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                action.status = value;
                action.resolvedDate = value == 'Resolved'
                    ? DateTime.now()
                    : null;
              });
            },
          ),
        ),
      ],
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 640) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    details,
                    const SizedBox(height: 8),
                    Align(alignment: Alignment.centerRight, child: controls),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: details),
                  const SizedBox(width: 12),
                  controls,
                ],
              );
            },
          ),
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
      ],
    );
  }
}

class _ComplianceDepartment {
  const _ComplianceDepartment({
    required this.name,
    required this.students,
    required this.faculty,
    this.professors = 0,
    this.associateProfessors = 0,
    this.assistantProfessors = 0,
    required this.courses,
    required this.labs,
  });

  final String name;
  final int students;
  final int faculty;
  final int professors;
  final int associateProfessors;
  final int assistantProfessors;
  final int courses;
  final int labs;
}

class _StatutoryCommittee {
  const _StatutoryCommittee({
    required this.name,
    required this.code,
    required this.description,
    required this.status,
    required this.lead,
    required this.members,
    required this.lastMeeting,
    required this.minutes,
  });

  final String name;
  final String code;
  final String description;
  final String status;
  final String lead;
  final int members;
  final String lastMeeting;
  final String minutes;
}

class _ComplianceAction {
  _ComplianceAction({
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.assignedTo,
    required this.status,
    required this.dueDate,
    required this.loggedBy,
    this.resolvedDate,
  });

  final String title;
  final String description;
  final String category;
  final String priority;
  final String assignedTo;
  String status;
  final DateTime dueDate;
  final String loggedBy;
  DateTime? resolvedDate;
}

// =============================================================================
// AICTE NORMS COMPLIANCE SCORE BAR CHART PAINTER (Navy bars)
// =============================================================================
class _AicteNormsBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const leftPad = 32.0;
    const bottomPad = 26.0;
    final chartW = w - leftPad - 10;
    final chartH = h - bottomPad - 10;

    // Y Axis grid lines (0, 25, 50, 75, 100)
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;
    final textStyle = GoogleFonts.poppins(
      fontSize: 9.5,
      color: const Color(0xFF94A3B8),
    );

    final steps = [0, 25, 50, 75, 100];
    for (int i = 0; i < steps.length; i++) {
      final y = chartH - (i / (steps.length - 1)) * chartH + 10;
      canvas.drawLine(Offset(leftPad, y), Offset(w - 10, y), gridPaint);
      final tp = TextPainter(
        text: TextSpan(text: "${steps[i]}", style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    // 4 Norm Categories
    final categories = [
      {"name": "FSR", "val": 100.0},
      {"name": "Cadre", "val": 56.0},
      {"name": "Committees", "val": 83.0},
      {"name": "Public Discl.", "val": 90.0},
    ];

    final colWidth = chartW / categories.length;
    final barW = (colWidth * 0.4).clamp(16.0, 36.0);

    for (int i = 0; i < categories.length; i++) {
      final c = categories[i];
      final val = c["val"] as double;
      final x = leftPad + i * colWidth + (colWidth - barW) / 2;

      if (val > 0) {
        final barH = (val / 100.0) * chartH;
        final barY = chartH - barH + 10;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(x, barY, barW, barH),
          topLeft: const Radius.circular(4),
          topRight: const Radius.circular(4),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1E293B));
      }

      final tp = TextPainter(
        text: TextSpan(
          text: c["name"] as String,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            color: const Color(0xFF64748B),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(leftPad + i * colWidth + (colWidth - tp.width) / 2, h - 18),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// AICTE FACULTY ALLOCATION BAR CHART PAINTER (Grouped Navy & Gold)
// =============================================================================
class _AicteFacultyAllocationChartPainter extends CustomPainter {
  _AicteFacultyAllocationChartPainter(this.departments);

  final List<_ComplianceDepartment> departments;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const leftPad = 26.0;
    const bottomPad = 26.0;
    final chartW = w - leftPad - 10;
    final chartH = h - bottomPad - 10;

    // Y Axis (0, 1.5, 3, 4.5, 6)
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;
    final textStyle = GoogleFonts.poppins(
      fontSize: 9.5,
      color: const Color(0xFF94A3B8),
    );

    const maxStudents = 6.0;
    final steps = ["0", "1.5", "3", "4.5", "6"];
    for (int i = 0; i < steps.length; i++) {
      final y = chartH - (i / (steps.length - 1)) * chartH + 10;
      canvas.drawLine(Offset(leftPad, y), Offset(w - 10, y), gridPaint);
      final tp = TextPainter(
        text: TextSpan(text: steps[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    final colWidth = chartW / departments.length;
    final barW = (colWidth * 0.25).clamp(4.0, 12.0);

    for (int i = 0; i < departments.length; i++) {
      final department = departments[i];
      final studentsVal = department.students.toDouble();
      final facultyVal = department.faculty.toDouble();
      final groupCenterX = leftPad + i * colWidth + colWidth / 2;

      // Students Bar (Navy)
      if (studentsVal > 0) {
        final barH = (studentsVal / maxStudents) * chartH;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(
            groupCenterX - barW - 1,
            chartH - barH + 10,
            barW,
            barH,
          ),
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1E293B));
      }

      // Faculty Bar (Gold)
      if (facultyVal > 0) {
        final barH = (facultyVal / maxStudents) * chartH;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(groupCenterX + 1, chartH - barH + 10, barW, barH),
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFFD97706));
      }

      // X Label
      final label = department.name.length > 8
          ? department.name.substring(0, 8)
          : department.name;
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: GoogleFonts.poppins(
            fontSize: 7,
            color: const Color(0xFF64748B),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(groupCenterX - tp.width / 2, h - 18));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

    const spacing = 28.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
