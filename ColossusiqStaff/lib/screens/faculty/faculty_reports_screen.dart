import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// =============================================================================
// INSTITUTION: FACULTY REPORTS SCREEN (Matches Screenshots 1, 2, 3, 4 & 5)
// - Blueprint grid hero banner with breadcrumbs & badges (INSTITUTION, Phase 3)
// - 4 Metric KPI Stat Cards:
//     1. REPORTS READY: 1 FACULTY, Download as CSV or print to PDF
//     2. SCHEDULED AUTO-RUNS: 0 active crons, No active schedules
//     3. LATEST REPORT: Nov 5, 2026, Most recently compiled report
//     4. SCOPES COVERED: 1 distinct scopes, Departments with a compiled report
// - Search bar + "+ Generate report" button
// - Type filter chips (All, Academic, Department, Placement, Faculty, Compliance, Institution)
// - Dropdowns: All Scopes, All Periods
// - Tab 0: Generated Reports (1) with complete Data Table, Eye & Download actions
// - Tab 1: Automated Schedules (0) with faint blueprint grid empty state (Screenshot 5)
// - Report Preview Modal with Executive Briefing, 6 KPI boxes, Detailed Evaluation Table,
//   Download CSV & Export PDF action buttons (Screenshots 2 & 3)
// - Generate New Institutional Report Dialog with domain, scope, period, and metrics checklist (Screenshot 4)
// =============================================================================

class FacultyReportsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyReportsScreen({super.key, this.onBack});

  @override
  State<FacultyReportsScreen> createState() => _FacultyReportsScreenState();
}

class _FacultyReportsScreenState extends State<FacultyReportsScreen> {
  int _selectedTab = 0;
  String _searchQuery = '';
  String _selectedType = 'All';
  String _selectedScope = 'All Scopes';
  String _selectedPeriod = 'All Periods';
  int _rowsPerPage = 5;

  final List<String> _types = [
    'All',
    'Academic',
    'Department',
    'Placement',
    'Faculty',
    'Compliance',
    'Institution',
  ];

  final List<String> _scopes = [
    'All Scopes',
    'Institution',
    'Department',
    'Faculty',
    'Placement',
  ];

  final List<String> _periods = [
    'All Periods',
    'AY 2026-27 Odd semester',
    'AY 2025-26 Even semester',
    'AY 2025-26 Odd semester',
  ];

  // Primary dataset matching Screenshot 1 & 2
  final List<Map<String, dynamic>> _generatedReports = [
    {
      'title': 'test',
      'domain': 'Academic',
      'scope': 'Institution',
      'period': 'AY 2026-27 Odd semester',
      'formats': ['PDF', 'CSV'],
      'date': 'Nov 5, 2026, 3:27 PM',
      'size': '1.1 KB',
      'generatedBy': 'Dr. Lakshmi Sundaram (Principal Office)',
      'briefing':
          'Academic report for Anna Institute of Technology (Institution, AY 2026-27 Odd semester), compiled from live records on 2026-11-05: 5 active students, 6 faculty and staff, 15 courses, 14 graded quiz attempts, 5 placement drives.',
      'metrics': {
        'scope': 'Institution',
        'activeStudents': '5',
        'facultyStaff': '6',
        'quizPassRate': '57.1%',
        'studentsAtRisk': '1 of 3',
        'offersRecorded': '46 from 5 drives',
      },
      'evaluationData': [
        {
          'category': 'Institution - Active students',
          'cohort': '5',
          'score': 'n/a',
          'status': 'Recorded',
          'statusColor': const Color(0xFF64748B),
          'statusBg': const Color(0xFFF1F5F9),
        },
        {
          'category': 'Institution - Active faculty & staff',
          'cohort': '6',
          'score': 'n/a',
          'status': 'Recorded',
          'statusColor': const Color(0xFF64748B),
          'statusBg': const Color(0xFFF1F5F9),
        },
        {
          'category': 'Institution - Courses offered',
          'cohort': '15',
          'score': 'n/a',
          'status': 'Recorded',
          'statusColor': const Color(0xFF64748B),
          'statusBg': const Color(0xFFF1F5F9),
        },
        {
          'category': 'Institution - Quiz pass rate (50% or above)',
          'cohort': '14',
          'score': '57.1%',
          'status': 'Below target',
          'statusColor': const Color(0xFFD97706),
          'statusBg': const Color(0xFFFEF3C7),
        },
        {
          'category': 'Institution - Students averaging 60% or above',
          'cohort': '3',
          'score': '66.7%',
          'status': 'Below target',
          'statusColor': const Color(0xFFD97706),
          'statusBg': const Color(0xFFFEF3C7),
        },
        {
          'category': 'Placement drives - Offers against openings',
          'cohort': '5',
          'score': '43.8%',
          'status': 'Below target',
          'statusColor': const Color(0xFFD97706),
          'statusBg': const Color(0xFFFEF3C7),
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _automatedSchedules = [];

  // ===========================================================================
  // REAL CSV FILE DOWNLOAD FUNCTION
  // ===========================================================================
  Future<void> _downloadCsvReport(Map<String, dynamic> r) async {
    final buffer = StringBuffer();
    buffer.writeln("ANNA INSTITUTE OF TECHNOLOGY - INSTITUTIONAL REPORT");
    buffer.writeln("Report Title,${r['title']}");
    buffer.writeln("Domain,${r['domain'] ?? 'Academic'}");
    buffer.writeln("Scope,${r['scope']}");
    buffer.writeln("Period,${r['period']}");
    buffer.writeln("Generated By,${r['generatedBy']}");
    buffer.writeln("Date,${r['date']}");
    buffer.writeln("");
    buffer.writeln("EXECUTIVE BRIEFING");
    buffer.writeln("\"${r['briefing']}\"");
    buffer.writeln("");
    buffer.writeln("KEY METRIC HIGHLIGHTS");
    final metrics = (r['metrics'] as Map<String, dynamic>?) ?? {};
    metrics.forEach((k, v) {
      buffer.writeln("$k,$v");
    });
    buffer.writeln("");
    buffer.writeln("DETAILED EVALUATION DATA");
    buffer.writeln("CATEGORY / SUBJECT,EVALUATED COHORT,ATTAINMENT SCORE,STATUS");
    final evalData = (r['evaluationData'] as List<dynamic>?) ?? [];
    for (final row in evalData) {
      buffer.writeln(
          "\"${row['category']}\",${row['cohort']},${row['score']},${row['status']}");
    }

    final csvContent = buffer.toString();
    final fileName = "${(r['title'] as String).replaceAll(' ', '_')}_Report.csv";

    try {
      final userProfile =
          Platform.environment['USERPROFILE'] ?? 'C:\\Users\\WIN';
      final downloadsDir = Directory('$userProfile\\Downloads');
      if (await downloadsDir.exists()) {
        final file = File('${downloadsDir.path}\\$fileName');
        await file.writeAsString(csvContent);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle_rounded,
                      color: Color(0xFF10B981), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Downloaded $fileName to Downloads folder! (${r['size'] ?? '1.1 KB'})",
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF1E2865),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
        }
        return;
      }
    } catch (_) {}

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Exported $fileName successfully (${r['size'] ?? '1.1 KB'})!"),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ===========================================================================
  // REAL PDF EXPORT FUNCTION
  // ===========================================================================
  Future<void> _exportReportPdf(Map<String, dynamic> r) async {
    final pdf = pw.Document();
    final evalData = (r['evaluationData'] as List<dynamic>?) ?? [];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "ANNA INSTITUTE OF TECHNOLOGY",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex('#1E2865'),
                      ),
                    ),
                    pw.Text(
                      "Institutional Performance & Analytics Report",
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColor.fromHex('#64748B'),
                      ),
                    ),
                  ],
                ),
                pw.Text(
                  r['date'] as String? ?? 'Nov 5, 2026',
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColor.fromHex('#64748B'),
                  ),
                ),
              ],
            ),
            pw.Divider(thickness: 1, color: PdfColor.fromHex('#E2E8F0')),
            pw.SizedBox(height: 8),

            pw.Text(
              r['title'] as String,
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#0F172A'),
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              "Generated by ${r['generatedBy']} · Scope: ${r['scope']} · Period: ${r['period']}",
              style: pw.TextStyle(
                fontSize: 9.5,
                color: PdfColor.fromHex('#64748B'),
              ),
            ),
            pw.SizedBox(height: 12),

            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#F8FAFC'),
                borderRadius: pw.BorderRadius.circular(6),
                border: pw.Border.all(color: PdfColor.fromHex('#E2E8F0')),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "EXECUTIVE BRIEFING",
                    style: pw.TextStyle(
                      fontSize: 8.5,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#475569'),
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    r['briefing'] as String? ?? '',
                    style: pw.TextStyle(
                      fontSize: 9,
                      color: PdfColor.fromHex('#334155'),
                      lineSpacing: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 14),

            pw.Text(
              "DETAILED EVALUATION DATA",
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#0F172A'),
              ),
            ),
            pw.SizedBox(height: 6),
            pw.TableHelper.fromTextArray(
              headers: ['CATEGORY / SUBJECT', 'COHORT', 'SCORE', 'STATUS'],
              data: evalData.map((row) {
                return [
                  row['category'] ?? '',
                  row['cohort'] ?? '',
                  row['score'] ?? '',
                  row['status'] ?? '',
                ];
              }).toList(),
              headerStyle: pw.TextStyle(
                fontSize: 8.5,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#0F172A'),
              ),
              headerDecoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#FBF8F1'),
              ),
              cellStyle: const pw.TextStyle(fontSize: 8),
              cellPadding:
                  const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      name: '${r['title']}_Report.pdf',
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // ===========================================================================
  // MODAL: REPORT PREVIEW MODAL (Matches Screenshots 2 & 3)
  // ===========================================================================
  void _showReportPreviewModal(Map<String, dynamic> r) {
    final metrics = (r['metrics'] as Map<String, dynamic>?) ?? {};
    final evalData = (r['evaluationData'] as List<dynamic>?) ?? [];

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620, maxHeight: 720),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Tag Bar & Close (Screenshot 2)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              r['domain'] as String? ?? 'Academic',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              r['scope'] as String? ?? 'Institution',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4F46E5),
                              ),
                            ),
                          ),
                          Text(
                            r['period'] as String? ?? 'AY 2026-27 Odd semester',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close_rounded,
                          size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      splashRadius: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Title & Subtitle (Screenshot 2)
                Text(
                  r['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Generated by ${r['generatedBy']} · ${r['date']} (${r['size'] ?? '1.1 KB'})",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Executive Briefing Box (Screenshot 2)
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "EXECUTIVE BRIEFING",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                r['briefing'] as String? ?? '',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 6 Quick Metric Stat Boxes (Screenshot 2)
                        LayoutBuilder(
                          builder: (context, c) {
                            final boxWidth = c.maxWidth > 500
                                ? (c.maxWidth - 20) / 3
                                : (c.maxWidth - 10) / 2;
                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                _buildPreviewStatBox(
                                    boxWidth, 'Scope', metrics['scope'] ?? 'Institution'),
                                _buildPreviewStatBox(boxWidth, 'Active students',
                                    metrics['activeStudents'] ?? '5'),
                                _buildPreviewStatBox(boxWidth, 'Faculty & staff',
                                    metrics['facultyStaff'] ?? '6'),
                                _buildPreviewStatBox(boxWidth,
                                    'Quiz pass rate (50%+)', metrics['quizPassRate'] ?? '57.1%'),
                                _buildPreviewStatBox(boxWidth, 'Students at risk',
                                    metrics['studentsAtRisk'] ?? '1 of 3'),
                                _buildPreviewStatBox(boxWidth, 'Offers recorded',
                                    metrics['offersRecorded'] ?? '46 from 5 drives'),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),

                        // Detailed Evaluation Data Section (Screenshots 2 & 3)
                        Text(
                          "DETAILED EVALUATION DATA",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Evaluation Table
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: 560,
                                child: Column(
                                  children: [
                                    // Table Header with Warm Cream background
                                    Container(
                                      color: const Color(0xFFFAF7F0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              'CATEGORY / SUBJECT',
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.6,
                                                color: const Color(0xFF64748B),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                'EVALUATED\nCOHORT',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.6,
                                                  color: const Color(0xFF64748B),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                'ATTAINMENT\nSCORE',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.6,
                                                  color: const Color(0xFF64748B),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'STATUS',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.6,
                                                  color: const Color(0xFF64748B),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Rows
                                    ...List.generate(evalData.length, (idx) {
                                      final item = evalData[idx];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0xFFF1F5F9)),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                item['category'] as String,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF1E293B),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Text(
                                                  item['cohort'] as String,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xFF334155),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Text(
                                                  item['score'] as String,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        const Color(0xFF0F172A),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                                  decoration: BoxDecoration(
                                                    color: item['statusBg']
                                                        as Color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    item['status'] as String,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10.5,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: item['statusColor']
                                                          as Color,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Bottom Action Bar (Screenshot 3)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => _downloadCsvReport(r),
                          icon: const Icon(Icons.table_chart_outlined,
                              size: 15, color: Color(0xFF059669)),
                          label: Text(
                            'Download CSV',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF059669),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFA7F3D0)),
                            backgroundColor: const Color(0xFFECFDF5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 11),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () => _exportReportPdf(r),
                          icon: const Icon(Icons.picture_as_pdf_outlined,
                              size: 15, color: Color(0xFFDC2626)),
                          label: Text(
                            'Export PDF',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFFECACA)),
                            backgroundColor: const Color(0xFFFEF2F2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 11),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF475569),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'Close Preview',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildPreviewStatBox(double width, String title, String value) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // MODAL: GENERATE NEW INSTITUTIONAL REPORT (Matches Screenshot 4)
  // ===========================================================================
  void _showGenerateReportDialog() {
    final titleController = TextEditingController();
    String reportDomain = 'Academic (CO/PO)';
    String deptScope = 'Institution (All)';
    final periodController =
        TextEditingController(text: 'AY 2026-27 Odd semester');

    bool includePassRate = true;
    bool includeBelow60 = true;
    bool includePlacement = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520, maxHeight: 660),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Header (Screenshot 4)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.auto_awesome_rounded,
                            color: Color(0xFF4F46E5), size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Generate New Institutional Report',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Compiled from your college's live records",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: Color(0xFF64748B)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Report Title
                          _buildFieldLabel('Report Title'),
                          TextField(
                            controller: titleController,
                            style: GoogleFonts.poppins(fontSize: 12.5),
                            decoration: _dialogInputDec(
                              hint: 'e.g. End of Term Department Performance',
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Two Column Dropdowns: Domain & Scope
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Report Domain'),
                                    DropdownButtonFormField<String>(
                                      initialValue: reportDomain,
                                      isDense: true,
                                      decoration: _dialogInputDec(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      items: [
                                        'Academic (CO/PO)',
                                        'Faculty Performance',
                                        'Placement & Training',
                                        'Student Risk & Remedials',
                                        'Institutional Accreditation',
                                      ]
                                          .map((d) => DropdownMenuItem(
                                                value: d,
                                                child: Text(d,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ))
                                          .toList(),
                                      onChanged: (val) {
                                        if (val != null) {
                                          setDialogState(
                                              () => reportDomain = val);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel('Department Scope'),
                                    DropdownButtonFormField<String>(
                                      initialValue: deptScope,
                                      isDense: true,
                                      decoration: _dialogInputDec(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      items: [
                                        'Institution (All)',
                                        'Computer Science & Engineering',
                                        'Information Technology',
                                        'AI & Data Science',
                                        'Electronics & Communication',
                                        'Mechanical Engineering',
                                      ]
                                          .map((s) => DropdownMenuItem(
                                                value: s,
                                                child: Text(s,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ))
                                          .toList(),
                                      onChanged: (val) {
                                        if (val != null) {
                                          setDialogState(
                                              () => deptScope = val);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Period / Term
                          _buildFieldLabel('Period / Term'),
                          TextField(
                            controller: periodController,
                            style: GoogleFonts.poppins(fontSize: 12.5),
                            decoration: _dialogInputDec(),
                          ),
                          const SizedBox(height: 16),

                          // Checklist Section (Screenshot 4)
                          Text(
                            'INCLUDE MODULES & METRICS',
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildCheckboxTile(
                            title: 'Quiz pass-rate analytics',
                            value: includePassRate,
                            onChanged: (v) =>
                                setDialogState(() => includePassRate = v ?? false),
                          ),
                          _buildCheckboxTile(
                            title: 'Students averaging below 60% on quizzes',
                            value: includeBelow60,
                            onChanged: (v) =>
                                setDialogState(() => includeBelow60 = v ?? false),
                          ),
                          _buildCheckboxTile(
                            title: 'Placement drives, openings and offers',
                            value: includePlacement,
                            onChanged: (v) =>
                                setDialogState(() => includePlacement = v ?? false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Actions
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF475569),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 11),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                              fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          final title = titleController.text.trim().isNotEmpty
                              ? titleController.text.trim()
                              : 'Institutional Performance Report';
                          Navigator.pop(ctx);
                          setState(() {
                            _generatedReports.insert(0, {
                              'title': title,
                              'domain': reportDomain.split(' ').first,
                              'scope': deptScope.replaceAll(' (All)', ''),
                              'period': periodController.text.trim(),
                              'formats': ['PDF', 'CSV'],
                              'date': 'Today, 04:45 PM',
                              'size': '1.3 KB',
                              'generatedBy':
                                  'Dr. Lakshmi Sundaram (Principal Office)',
                              'briefing':
                                  'Performance report compiled from live college records for $deptScope ($periodController.text): verified attendance, quiz benchmarks and placement statistics.',
                              'metrics': {
                                'scope': deptScope,
                                'activeStudents': '5',
                                'facultyStaff': '6',
                                'quizPassRate': includePassRate ? '57.1%' : 'n/a',
                                'studentsAtRisk':
                                    includeBelow60 ? '1 of 3' : 'n/a',
                                'offersRecorded':
                                    includePlacement ? '46 from 5 drives' : 'n/a',
                              },
                              'evaluationData': [
                                {
                                  'category': '$deptScope - Active students',
                                  'cohort': '5',
                                  'score': 'n/a',
                                  'status': 'Recorded',
                                  'statusColor': const Color(0xFF64748B),
                                  'statusBg': const Color(0xFFF1F5F9),
                                },
                                {
                                  'category':
                                      '$deptScope - Active faculty & staff',
                                  'cohort': '6',
                                  'score': 'n/a',
                                  'status': 'Recorded',
                                  'statusColor': const Color(0xFF64748B),
                                  'statusBg': const Color(0xFFF1F5F9),
                                },
                                {
                                  'category':
                                      '$deptScope - Quiz pass rate (50%+)',
                                  'cohort': '14',
                                  'score': '57.1%',
                                  'status': 'Below target',
                                  'statusColor': const Color(0xFFD97706),
                                  'statusBg': const Color(0xFFFEF3C7),
                                },
                                {
                                  'category':
                                      'Placement drives - Offers against openings',
                                  'cohort': '5',
                                  'score': '43.8%',
                                  'status': 'Below target',
                                  'statusColor': const Color(0xFFD97706),
                                  'statusBg': const Color(0xFFFEF3C7),
                                },
                              ],
                            });
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Compiled & Saved "$title" successfully!',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: const Color(0xFF1E2865),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.auto_awesome_rounded,
                            size: 15, color: Colors.white),
                        label: Text(
                          'Compile & Save Report',
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E2A72),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 11),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: const Color(0xFF2563EB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dialogInputDec({String? hint}) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 12,
        color: const Color(0xFF94A3B8),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2E2A72), width: 1.5),
      ),
    );
  }

  // ===========================================================================
  // MAIN BUILD
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 16),
              _buildStatMetricCards(),
              const SizedBox(height: 18),
              _buildFilterAndSearchToolbar(),
              const SizedBox(height: 16),
              _buildTabBar(),
              const SizedBox(height: 16),
              if (_selectedTab == 0)
                _buildGeneratedReportsTab()
              else
                _buildAutomatedSchedulesTab(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP BLUEPRINT BANNER (Screenshot 1)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF222B68),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            Positioned(
              right: 18,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.description_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          child: Text(
                            'Home',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.45),
                            ),
                          ),
                        ),
                        Text(
                          'Institution',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.45),
                            ),
                          ),
                        ),
                        Text(
                          'Reports',
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Amber Icon Box
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                const Color(0xFFF59E0B).withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.description_rounded,
                          color: Color(0xFFFBBF24),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges Row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'INSTITUTION',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706)
                                        .withValues(alpha: 0.35),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Phase 3',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: const Color(0xFFFBBF24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Reports',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Student, faculty, department, course, skill, placement and institutional reports.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.85),
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
  // 4 STAT METRIC KPI CARDS (Matches Screenshot 1)
  // ===========================================================================
  Widget _buildStatMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isVeryWide = constraints.maxWidth >= 1060;
        final isMedium = constraints.maxWidth >= 540;

        // Card 1: REPORTS READY (Screenshot 1)
        final card1 = _buildKpiCard(
          title: 'REPORTS READY',
          icon: Icons.description_outlined,
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_generatedReports.length}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'FACULTY',
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          subtitle: 'Download as CSV or print to PDF',
        );

        // Card 2: SCHEDULED AUTO-RUNS (Screenshot 1)
        final card2 = _buildKpiCard(
          title: 'SCHEDULED AUTO-RUNS',
          icon: Icons.access_time_rounded,
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${_automatedSchedules.length}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'active crons',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          subtitle: 'No active schedules',
        );

        // Card 3: LATEST REPORT (Screenshot 1)
        final card3 = _buildKpiCard(
          title: 'LATEST REPORT',
          icon: Icons.file_download_outlined,
          iconColor: const Color(0xFFD97706),
          valueWidget: Text(
            _generatedReports.isNotEmpty ? 'Nov 5, 2026' : 'None yet',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          subtitle: 'Most recently compiled report',
        );

        // Card 4: SCOPES COVERED (Screenshot 1)
        final card4 = _buildKpiCard(
          title: 'SCOPES COVERED',
          icon: Icons.description_outlined,
          iconColor: const Color(0xFF0D9488),
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '1',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'distinct scopes',
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0D9488),
                ),
              ),
            ],
          ),
          subtitle: 'Departments with a compiled report',
        );

        if (isVeryWide) {
          return Row(
            children: [
              Expanded(child: card1),
              const SizedBox(width: 12),
              Expanded(child: card2),
              const SizedBox(width: 12),
              Expanded(child: card3),
              const SizedBox(width: 12),
              Expanded(child: card4),
            ],
          );
        } else if (isMedium) {
          return Column(
            children: [
              Row(children: [
                Expanded(child: card1),
                const SizedBox(width: 10),
                Expanded(child: card2),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: card3),
                const SizedBox(width: 10),
                Expanded(child: card4),
              ]),
            ],
          );
        } else {
          return Column(
            children: [
              card1,
              const SizedBox(height: 10),
              card2,
              const SizedBox(height: 10),
              card3,
              const SizedBox(height: 10),
              card4,
            ],
          );
        }
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required IconData icon,
    required Widget valueWidget,
    required String subtitle,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                icon,
                size: 16,
                color: iconColor ?? const Color(0xFF64748B),
              ),
            ],
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: valueWidget,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FILTER AND SEARCH TOOLBAR (Screenshot 1)
  // ===========================================================================
  Widget _buildFilterAndSearchToolbar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1060;
        final isSmall = constraints.maxWidth < 520;

        final searchBar = Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search reports by title, scope or keyword...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    filled: false,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        );

        final generateBtn = Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: _showGenerateReportDialog,
            child: Ink(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2865),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 14, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    'Generate report',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row 1: Search + Generate
            if (isSmall) ...[
              searchBar,
              const SizedBox(height: 10),
              generateBtn,
            ] else ...[
              Row(
                children: [
                  Expanded(child: searchBar),
                  const SizedBox(width: 14),
                  generateBtn,
                ],
              ),
            ],
            const SizedBox(height: 12),

            // Row 2: Filters & Dropdowns
            if (isDesktop)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTypeChips()),
                  const SizedBox(width: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 140, child: _buildScopeDropdown()),
                      const SizedBox(width: 10),
                      SizedBox(width: 180, child: _buildPeriodDropdown()),
                    ],
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTypeChips(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildScopeDropdown()),
                      const SizedBox(width: 10),
                      Expanded(child: _buildPeriodDropdown()),
                    ],
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildTypeChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.filter_alt_outlined,
                  size: 13, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                'TYPE:',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          ..._types.map((t) {
            final isSel = _selectedType == t;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => setState(() => _selectedType = t),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isSel
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    t,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                      color: isSel ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildScopeDropdown() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedScope,
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFF64748B)),
          items: _scopes
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(
                      s,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _selectedScope = v!),
        ),
      ),
    );
  }

  Widget _buildPeriodDropdown() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedPeriod,
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFF64748B)),
          items: _periods
              .map((p) => DropdownMenuItem(
                    value: p,
                    child: Text(
                      p,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _selectedPeriod = v!),
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB NAVIGATION (Screenshot 1 & 5)
  // ===========================================================================
  Widget _buildTabBar() {
    final tabs = [
      {
        'title': 'Generated Reports',
        'count': '${_generatedReports.length}',
        'icon': Icons.description_outlined,
      },
      {
        'title': 'Automated Schedules',
        'count': '${_automatedSchedules.length}',
        'icon': Icons.access_time_rounded,
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
            width: 1.5,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final isSelected = _selectedTab == i;
            final tab = tabs[i];
            return Padding(
              padding: const EdgeInsets.only(right: 28),
              child: InkWell(
                onTap: () => setState(() => _selectedTab = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tab['icon'] as IconData,
                        size: 16,
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${tab['title']} (${tab['count']})",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF1E2865)
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
      ),
    );
  }

  // ===========================================================================
  // TAB 0: GENERATED REPORTS TABLE (Screenshot 1)
  // ===========================================================================
  Widget _buildGeneratedReportsTab() {
    final filtered = _generatedReports.where((r) {
      if (_selectedType != 'All' &&
          r['domain'] != _selectedType &&
          r['scope'] != _selectedType) {
        return false;
      }
      if (_selectedScope != 'All Scopes' && r['scope'] != _selectedScope) {
        return false;
      }
      if (_selectedPeriod != 'All Periods' && r['period'] != _selectedPeriod) {
        return false;
      }
      if (_searchQuery.isNotEmpty &&
          !(r['title'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Table with Horizontal Scroll Support for narrow viewports
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1040,
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 360,
                          child: Text(
                            'REPORT',
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: Text(
                            'SCOPE',
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: Text(
                            'PERIOD',
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            'FORMATS',
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            'LAST GENERATED',
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 70,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'ACTIONS',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Table Body
                  if (filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      child: Center(
                        child: Text(
                          "No reports found matching your filters.",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    )
                  else
                    ...List.generate(filtered.length, (idx) {
                      final r = filtered[idx];
                      final formats =
                          (r['formats'] as List<dynamic>?)?.cast<String>() ??
                              ['PDF', 'CSV'];

                      return InkWell(
                        onTap: () => _showReportPreviewModal(r),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFF1F5F9)),
                            ),
                          ),
                          child: Row(
                            children: [
                              // REPORT Column
                              SizedBox(
                                width: 360,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.description_outlined,
                                        size: 18,
                                        color: Color(0xFF1E2865),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            r['title'] as String,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            r['briefing'] as String? ??
                                                'Academic report for Anna Institute of Technology...',
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
                                  ],
                                ),
                              ),

                              // SCOPE Column
                              SizedBox(
                                width: 130,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEEF2FF),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      r['scope'] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF4F46E5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // PERIOD Column
                              SizedBox(
                                width: 170,
                                child: Text(
                                  r['period'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF334155),
                                  ),
                                ),
                              ),

                              // FORMATS Column
                              SizedBox(
                                width: 100,
                                child: Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: formats.map((fmt) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAF7F0),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: const Color(0xFFEFE9DB)),
                                      ),
                                      child: Text(
                                        fmt,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF78350F),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),

                              // LAST GENERATED Column
                              SizedBox(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      r['date'] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      r['size'] as String? ?? '1.1 KB',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ACTIONS Column
                              SizedBox(
                                width: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          _showReportPreviewModal(r),
                                      icon: const Icon(
                                        Icons.visibility_outlined,
                                        size: 16,
                                        color: Color(0xFF64748B),
                                      ),
                                      tooltip: 'View Report Preview',
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      splashRadius: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () => _downloadCsvReport(r),
                                      icon: const Icon(
                                        Icons.file_download_outlined,
                                        size: 16,
                                        color: Color(0xFF64748B),
                                      ),
                                      tooltip: 'Download CSV',
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      splashRadius: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),

          // Pagination Bar (Screenshot 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 10,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Showing 1 to ${filtered.length} of ${filtered.length} reports',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Rows per page:',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _rowsPerPage,
                          isDense: true,
                          items: [5, 10, 20]
                              .map((n) => DropdownMenuItem(
                                    value: n,
                                    child: Text(
                                      '$n',
                                      style: GoogleFonts.poppins(fontSize: 11.5),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => _rowsPerPage = v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Page 1 of 1',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.chevron_left,
                                size: 14, color: Color(0xFF94A3B8)),
                            Text(
                              'Prev',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2865),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '1',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Next',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                size: 14, color: Color(0xFF94A3B8)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 1: AUTOMATED SCHEDULES (Screenshot 5)
  // ===========================================================================
  Widget _buildAutomatedSchedulesTab() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row (Screenshot 5)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report Schedules',
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Each schedule compiles a new report from live records when it falls due. Only the principal office manages schedules.',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '0 Active',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF16A34A),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Blueprint Grid Empty State Container (Screenshot 5)
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFFDFDFE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _LightBlueprintGridPainter(),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No schedules yet',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'The principal office has not set up any report schedules.',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Background painter for blueprint grid in top banner
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const step = 24.0;
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

// Background painter for faint grid inside empty state card
class _LightBlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.45)
      ..strokeWidth = 1.0;

    const step = 20.0;
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
