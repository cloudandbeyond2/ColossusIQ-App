import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalStudentFeesScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalStudentFeesScreen({super.key, this.onBack});

  @override
  State<PrincipalStudentFeesScreen> createState() =>
      _PrincipalStudentFeesScreenState();
}

typedef StudentFeesScreen = PrincipalStudentFeesScreen;

class _PrincipalStudentFeesScreenState
    extends State<PrincipalStudentFeesScreen> {
  // Selected filter: "Students" (All), "Paid", "Waived", "Awaiting verification", "Due"
  String _selectedFilter = "Students";
  final TextEditingController _searchController = TextEditingController();

  // Selected student IDs for reminders
  final Set<String> _selectedStudentIds = {};

  // Pagination
  int _currentPage = 1;
  final int _perPage = 10;

  // Reminders history
  late List<Map<String, dynamic>> _remindersSent;

  // 17 Students data matching Images 1 & 3
  late List<Map<String, dynamic>> _allStudents;

  @override
  void initState() {
    super.initState();
    _allStudents = [
      {
        "id": "STU-1001",
        "name": "Aarthi Subramanian",
        "email": "aarthi.subramanian@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Online",
        "clearedOn": "18 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid via Razorpay (Online payment). Receipt: CIQ/2026-27/A8114F2",
      },
      {
        "id": "STU-1002",
        "name": "Anand Kumar",
        "email": "student1@ait.edu.in",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Offline",
        "clearedOn": "20 Oct 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid offline via Cash at college counter. Receipt: 10001.",
      },
      {
        "id": "STU-1003",
        "name": "Arjun Balasubramanian",
        "email": "arjun.balasubramanian@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Waived",
        "paidVia": "Waiver",
        "clearedOn": "23 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Full fee waiver approved under Institutional Merit Scholarship.",
      },
      {
        "id": "STU-1004",
        "name": "Divya Lakshmi",
        "email": "divya.lakshmi@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Online",
        "clearedOn": "27 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid via UPI (Online payment). Receipt: CIQ/2026-27/D27419F",
      },
      {
        "id": "STU-1005",
        "name": "Divya Ramesh",
        "email": "student2@ait.edu.in",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Due",
        "paidVia": "—",
        "clearedOn": "—",
        "lastReminder": "10 Nov 2026",
        "paymentDetails": "",
      },
      {
        "id": "STU-1006",
        "name": "Ganesh Perumal",
        "email": "ganesh.perumal@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Due",
        "paidVia": "—",
        "clearedOn": "—",
        "lastReminder": "10 Nov 2026",
        "paymentDetails": "",
      },
      {
        "id": "STU-1007",
        "name": "Harini Raghavan",
        "email": "harini.raghavan@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Awaiting verification",
        "paidVia": "—",
        "clearedOn": "—",
        "lastReminder": "10 Nov 2026",
        "paymentDetails": "Offline Challan submitted. Pending verification by the University office.",
      },
      {
        "id": "STU-1008",
        "name": "Karthik Raja",
        "email": "student3@ait.edu.in",
        "note": "not signed in this year",
        "fee": "₹1,500.00",
        "status": "Due",
        "paidVia": "—",
        "clearedOn": "—",
        "lastReminder": "10 Nov 2026",
        "paymentDetails": "",
      },
      {
        "id": "STU-1009",
        "name": "Karthik Rajan",
        "email": "karthik.rajan@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Online",
        "clearedOn": "21 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid via Netbanking. Receipt: CIQ/2026-27/K88319B",
      },
      {
        "id": "STU-1010",
        "name": "Meenakshi Sundaram",
        "email": "meenakshi.sundaram@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Due",
        "paidVia": "—",
        "clearedOn": "—",
        "lastReminder": "10 Nov 2026",
        "paymentDetails": "",
      },
      {
        "id": "STU-1011",
        "name": "Naveen Kumar",
        "email": "naveen.kumar@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Online",
        "clearedOn": "19 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid online via Debit Card. Receipt: CIQ/2026-27/N19441C",
      },
      {
        "id": "STU-1012",
        "name": "Pooja Sharma",
        "email": "pooja.sharma@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Online",
        "clearedOn": "22 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid online via UPI. Receipt: CIQ/2026-27/P22991D",
      },
      {
        "id": "STU-1013",
        "name": "Pravin Raj",
        "email": "pravin.raj@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Due",
        "paidVia": "—",
        "clearedOn": "—",
        "lastReminder": "10 Nov 2026",
        "paymentDetails": "",
      },
      {
        "id": "STU-1014",
        "name": "Rahul Varma",
        "email": "rahul.varma@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Online",
        "clearedOn": "25 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid online via UPI. Receipt: CIQ/2026-27/R25102F",
      },
      {
        "id": "STU-1015",
        "name": "Sneha Parthasarathy",
        "email": "sneha.p@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Paid",
        "paidVia": "Offline",
        "clearedOn": "28 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Paid offline via Demand Draft. Receipt: DD-88914.",
      },
      {
        "id": "STU-1016",
        "name": "Surya Narayanan",
        "email": "surya.n@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Waived",
        "paidVia": "Waiver",
        "clearedOn": "24 Sept 2026",
        "lastReminder": "—",
        "paymentDetails": "Sports quota 100% waiver sanctioned.",
      },
      {
        "id": "STU-1017",
        "name": "Swetha Raman",
        "email": "swetha.raman@fees-seed.test",
        "note": "",
        "fee": "₹1,500.00",
        "status": "Due",
        "paidVia": "—",
        "clearedOn": "—",
        "lastReminder": "10 Nov 2026",
        "paymentDetails": "",
      },
    ];

    _remindersSent = [
      {
        "message":
            "Dear student, your ColossusIQ app fee of ₹1,500.00 for 2026-27 is due by 31 Oct 2026. Please pay under Fees & Payments to avoid your account being locked. — College office",
        "meta":
            "To All students with fees due · Dr. Lakshmi Sundaram · 10 Nov, 05:30 pm",
      },
      {
        "message":
            "Dear student, your ColossusIQ app fee of ₹1,500.00 for 2026-27 is due by 31 Oct 2026. Please pay under Fees & Payments to avoid your account being locked. — College office",
        "meta":
            "To All students with fees due · Dr. Lakshmi Sundaram · 5 Nov, 12:27 pm",
      },
      {
        "message":
            "Dear student, your ColossusIQ app fee of ₹1,500.00 for 2026-27 is due by 31 Oct 2026. Please pay under Fees & Payments to avoid your account being locked. — College office",
        "meta":
            "To All students with fees due · Dr. Lakshmi Sundaram · 13 Oct, 01:36 pm",
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredStudents {
    final query = _searchController.text.trim().toLowerCase();
    return _allStudents.where((s) {
      if (_selectedFilter != "Students") {
        if (s["status"] != _selectedFilter) return false;
      }
      if (query.isNotEmpty) {
        final name = (s["name"] as String).toLowerCase();
        final email = (s["email"] as String).toLowerCase();
        return name.contains(query) || email.contains(query);
      }
      return true;
    }).toList();
  }

  int get _dueCount =>
      _allStudents.where((s) => s["status"] == "Due").length;
  int get _paidCount =>
      _allStudents.where((s) => s["status"] == "Paid").length;
  int get _waivedCount =>
      _allStudents.where((s) => s["status"] == "Waived").length;
  int get _awaitingCount =>
      _allStudents.where((s) => s["status"] == "Awaiting verification").length;

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
                const SizedBox(height: 18),

                // 2. ACADEMIC YEAR & DUE DATE BANNER CARD
                _buildAcademicYearNoticeCard(),
                const SizedBox(height: 16),

                // 3. COLLECTIONS SUMMARY & PROGRESS CARD
                _buildCollectionsProgressCard(),
                const SizedBox(height: 16),

                // 4. STATUS FILTER CARDS ROW
                _buildFilterCardsRow(),
                const SizedBox(height: 18),

                // 5. STUDENTS TABLE CARD
                _buildStudentsTableCard(),
                const SizedBox(height: 20),

                // 6. REMINDERS SENT CARD (Image 3)
                _buildRemindersSentCard(),
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
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1E2865),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.25),
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
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.credit_card_rounded,
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
                  // Breadcrumb
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
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        _buildBreadcrumbSeparator(),
                        Text(
                          "Institution",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        _buildBreadcrumbSeparator(),
                        Text(
                          "Student Fees",
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

                  // Header with Icon, Badges, Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.credit_card_rounded,
                            size: 26,
                            color: Color(0xFFFBBF24), // Golden Amber
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
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2E3B7D),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "INSTITUTION",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Student Fees",
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Every student's app fee for this academic year: paid, waived, awaiting verification or due. Send fee reminders through the portal.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFFCBD5E1),
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

  Widget _buildBreadcrumbSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.chevron_right_rounded,
          size: 13, color: Colors.white.withValues(alpha: 0.5)),
    );
  }

  // ===========================================================================
  // 2. ACADEMIC YEAR & NOTICE CARD
  // ===========================================================================
  Widget _buildAcademicYearNoticeCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 900;

          final metrics = Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              _buildYearMetric("Academic year", "2026-27"),
              _buildYearMetric("App fee per student", "₹1,500.00"),
              _buildYearMetric("Due by", "31 Oct 2026"),
            ],
          );

          final notice = Text(
            "Students see a reminder on every page from 16 Oct 2026. Unpaid accounts lock after 15 Nov 2026 if the University has locking on.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                metrics,
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),
                notice,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              metrics,
              const SizedBox(width: 28),
              Expanded(child: notice),
            ],
          );
        },
      ),
    );
  }

  Widget _buildYearMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. COLLECTIONS SUMMARY & PROGRESS CARD
  // ===========================================================================
  Widget _buildCollectionsProgressCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
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
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 650;

              final statsRow = Wrap(
                spacing: 36,
                runSpacing: 12,
                children: [
                  _buildCollectionStatItem(
                    label: "Collected",
                    value: "₹13,500.00",
                    valueColor: const Color(0xFF0D9488), // Teal green
                  ),
                  _buildCollectionStatItem(
                    label: "Still to collect",
                    value: "₹9,000.00",
                    valueColor: const Color(0xFFDC2626), // Soft red
                  ),
                  _buildCollectionStatItem(
                    label: "Total payable",
                    value: "₹22,500.00",
                    valueColor: const Color(0xFF0F172A), // Dark navy
                  ),
                ],
              );

              final refreshArea = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Updated 12:27 pm",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Collection data refreshed"),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          const Icon(Icons.refresh_rounded,
                              size: 15, color: Color(0xFF334155)),
                          const SizedBox(width: 4),
                          Text(
                            "Refresh",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    statsRow,
                    const SizedBox(height: 12),
                    refreshArea,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  statsRow,
                  refreshArea,
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Progress Bar & Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Collection progress",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "60%",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.60,
              minHeight: 6,
              backgroundColor: Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionStatItem({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. STATUS FILTER CARDS ROW
  // ===========================================================================
  Widget _buildFilterCardsRow() {
    final filters = [
      {
        "key": "Students",
        "label": "Students",
        "count": _allStudents.length,
        "color": const Color(0xFF0F172A),
      },
      {
        "key": "Paid",
        "label": "Paid",
        "count": _paidCount,
        "color": const Color(0xFF0D9488),
      },
      {
        "key": "Waived",
        "label": "Waived",
        "count": _waivedCount,
        "color": const Color(0xFF0F172A),
      },
      {
        "key": "Awaiting verification",
        "label": "Awaiting verification",
        "count": _awaitingCount,
        "color": const Color(0xFF2563EB),
      },
      {
        "key": "Due",
        "label": "Due",
        "count": _dueCount,
        "color": const Color(0xFFDC2626),
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((f) {
          final key = f["key"] as String;
          final label = f["label"] as String;
          final count = f["count"] as int;
          final color = f["color"] as Color;
          final isSelected = _selectedFilter == key;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedFilter = key;
                  _currentPage = 1;
                });
              },
              borderRadius: BorderRadius.circular(14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 175,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                    width: isSelected ? 2.0 : 1.0,
                  ),
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
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$count",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: color,
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
  // 5. STUDENTS TABLE CARD
  // ===========================================================================
  Widget _buildStudentsTableCard() {
    final filtered = _filteredStudents;
    final totalCount = filtered.length;

    // Slice for page
    final startIndex = (_currentPage - 1) * _perPage;
    final endIndex = (startIndex + _perPage < totalCount)
        ? startIndex + _perPage
        : totalCount;
    final pageStudents = (startIndex < totalCount)
        ? filtered.sublist(startIndex, endIndex)
        : <Map<String, dynamic>>[];

    final totalPages = (totalCount / _perPage).ceil().clamp(1, 999);
    final allSelected = pageStudents.isNotEmpty &&
        pageStudents.every((s) => _selectedStudentIds.contains(s["id"]));

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
          // Table Card Header & Actions
          Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, c) {
                final isNarrow = c.maxWidth < 780;

                final titleBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Students",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Fee status for this academic year. Offline payments are verified by the University.",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final actionButtons = Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Export CSV
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Exporting student fee records to CSV..."),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.file_download_outlined, size: 15),
                      label: Text(
                        "Export CSV",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // Remind selected (count)
                    OutlinedButton.icon(
                      onPressed: _selectedStudentIds.isNotEmpty
                          ? () => _showSendReminderDialog(
                              isAllUnpaid: false,
                              selectedCount: _selectedStudentIds.length)
                          : null,
                      icon: const Icon(Icons.notifications_none_rounded, size: 15),
                      label: Text(
                        "Remind selected (${_selectedStudentIds.length})",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        disabledForegroundColor: const Color(0xFF94A3B8),
                        side: BorderSide(
                          color: _selectedStudentIds.isNotEmpty
                              ? const Color(0xFFCBD5E1)
                              : const Color(0xFFE2E8F0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    // Remind all unpaid (6)
                    ElevatedButton.icon(
                      onPressed: () => _showSendReminderDialog(
                          isAllUnpaid: true, selectedCount: _dueCount),
                      icon: const Icon(Icons.campaign_outlined,
                          size: 16, color: Colors.white),
                      label: Text(
                        "Remind all unpaid ($_dueCount)",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E3875), // Deep navy/purple in Image 1
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleBlock,
                      const SizedBox(height: 14),
                      actionButtons,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: titleBlock),
                    const SizedBox(width: 14),
                    actionButtons,
                  ],
                );
              },
            ),
          ),

          // Search Field
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
            child: SizedBox(
              width: 280,
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _currentPage = 1),
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF0F172A),
                ),
                decoration: InputDecoration(
                  hintText: "Search by name or email",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E2865)),
                  ),
                ),
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              headingRowHeight: 44,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 64,
              horizontalMargin: 20,
              columnSpacing: 26,
              columns: [
                DataColumn(
                  label: Checkbox(
                    value: allSelected,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          for (var s in pageStudents) {
                            _selectedStudentIds.add(s["id"] as String);
                          }
                        } else {
                          for (var s in pageStudents) {
                            _selectedStudentIds.remove(s["id"] as String);
                          }
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                _buildTableHeader("STUDENT"),
                _buildTableHeader("FEE"),
                _buildTableHeader("STATUS"),
                _buildTableHeader("PAID VIA"),
                _buildTableHeader("CLEARED ON"),
                _buildTableHeader("LAST REMINDER"),
                const DataColumn(label: SizedBox()), // Action column
              ],
              rows: pageStudents.map((s) {
                final id = s["id"] as String;
                final isChecked = _selectedStudentIds.contains(id);
                final status = s["status"] as String;
                final note = (s["note"] as String? ?? "").trim();

                return DataRow(
                  cells: [
                    // Checkbox
                    DataCell(
                      Checkbox(
                        value: isChecked,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _selectedStudentIds.add(id);
                            } else {
                              _selectedStudentIds.remove(id);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    // Student
                    DataCell(
                      InkWell(
                        onTap: () => _showStudentDetailsModal(s),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              s["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  s["email"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                                if (note.isNotEmpty) ...[
                                  Text(
                                    " · $note",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF94A3B8),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Fee
                    DataCell(
                      Text(
                        s["fee"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    // Status Pill
                    DataCell(_buildStatusBadge(status)),
                    // Paid via
                    DataCell(
                      Text(
                        s["paidVia"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    // Cleared on
                    DataCell(
                      Text(
                        s["clearedOn"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    // Last reminder
                    DataCell(
                      Text(
                        s["lastReminder"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    // Details Action
                    DataCell(
                      InkWell(
                        onTap: () => _showStudentDetailsModal(s),
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Text(
                            "Details",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table Footer Pagination (Images 1 & 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: LayoutBuilder(
              builder: (context, c) {
                final isNarrow = c.maxWidth < 650;

                final leftInfo = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Showing ${totalCount == 0 ? 0 : startIndex + 1} to $endIndex of $totalCount students",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      "Per page: 10",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final rightPagination = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Page $_currentPage of $totalPages",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Prev button
                    OutlinedButton(
                      onPressed: _currentPage > 1
                          ? () => setState(() => _currentPage--)
                          : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        disabledForegroundColor: const Color(0xFF94A3B8),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "< Prev",
                        style: GoogleFonts.poppins(fontSize: 11.5),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Page 1 button
                    ElevatedButton(
                      onPressed: () => setState(() => _currentPage = 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 1
                            ? const Color(0xFF1E2865)
                            : Colors.white,
                        foregroundColor: _currentPage == 1
                            ? Colors.white
                            : const Color(0xFF334155),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        minimumSize: const Size(32, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(
                            color: _currentPage == 1
                                ? const Color(0xFF1E2865)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                      ),
                      child: Text(
                        "1",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (totalPages >= 2) ...[
                      const SizedBox(width: 6),
                      // Page 2 button
                      ElevatedButton(
                        onPressed: () => setState(() => _currentPage = 2),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentPage == 2
                              ? const Color(0xFF1E2865)
                              : Colors.white,
                          foregroundColor: _currentPage == 2
                              ? Colors.white
                              : const Color(0xFF334155),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          minimumSize: const Size(32, 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: _currentPage == 2
                                  ? const Color(0xFF1E2865)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                        ),
                        child: Text(
                          "2",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(width: 6),
                    // Next button
                    OutlinedButton(
                      onPressed: _currentPage < totalPages
                          ? () => setState(() => _currentPage++)
                          : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        disabledForegroundColor: const Color(0xFF94A3B8),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Next >",
                        style: GoogleFonts.poppins(fontSize: 11.5),
                      ),
                    ),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      leftInfo,
                      const SizedBox(height: 10),
                      rightPagination,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftInfo,
                    rightPagination,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _buildTableHeader(String text) {
    return DataColumn(
      label: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: const Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg;
    Color fg;

    switch (status) {
      case "Paid":
        bg = const Color(0xFFCCFBF1);
        fg = const Color(0xFF0D9488);
        break;
      case "Due":
        bg = const Color(0xFFFFEDD5);
        fg = const Color(0xFFC2410C);
        break;
      case "Waived":
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF475569);
        break;
      case "Awaiting verification":
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0284C7);
        break;
      default:
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF64748B);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  // ===========================================================================
  // 6. REMINDERS SENT CARD (Image 3)
  // ===========================================================================
  Widget _buildRemindersSentCard() {
    return Container(
      padding: const EdgeInsets.all(22),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reminders sent",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Students see these in a popup and in their notifications until their fee is cleared.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _remindersSent.length,
            separatorBuilder: (c, i) =>
                const Divider(height: 24, color: Color(0xFFF1F5F9)),
            itemBuilder: (c, i) {
              final item = _remindersSent[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["message"] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF1E293B),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item["meta"] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 7. DIALOG: SEND FEE REMINDER (Image 2)
  // ===========================================================================
  void _showSendReminderDialog({
    required bool isAllUnpaid,
    required int selectedCount,
  }) {
    final messageCtrl = TextEditingController(
      text:
          "Dear student, your ColossusIQ app fee of ₹1,500.00 for 2026-27 is due by 31 Oct 2026. Please pay under Fees & Payments to avoid your account being locked. — College office",
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final charCount = messageCtrl.text.length;

            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                width: 520,
                padding: const EdgeInsets.all(26),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Send fee reminder",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isAllUnpaid
                          ? "To all $selectedCount students whose fee is due. They see it in a popup and in their notifications until the fee is cleared."
                          : "To $selectedCount selected students. They see it in a popup and in their notifications until the fee is cleared.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Label
                    Text(
                      "Message",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Textarea
                    TextField(
                      controller: messageCtrl,
                      maxLines: 4,
                      maxLength: 500,
                      onChanged: (v) => setDialogState(() {}),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF0F172A),
                        height: 1.4,
                      ),
                      decoration: InputDecoration(
                        counterText: "$charCount/500",
                        counterStyle: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                        ),
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF1E2865)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            final text = messageCtrl.text.trim();
                            if (text.isEmpty) return;

                            setState(() {
                              _remindersSent.insert(0, {
                                "message": text,
                                "meta": isAllUnpaid
                                    ? "To All students with fees due · Dr. Lakshmi Sundaram · Just now"
                                    : "To $selectedCount selected students · Dr. Lakshmi Sundaram · Just now",
                              });

                              // Update last reminder for due students
                              for (var s in _allStudents) {
                                if (isAllUnpaid) {
                                  if (s["status"] == "Due") {
                                    s["lastReminder"] = "Today";
                                  }
                                } else {
                                  if (_selectedStudentIds.contains(s["id"])) {
                                    s["lastReminder"] = "Today";
                                  }
                                }
                              }
                            });

                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Fee reminder broadcasted to $selectedCount student(s)"),
                                backgroundColor: const Color(0xFF0D9488),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.send_rounded,
                              size: 15, color: Colors.white),
                          label: Text(
                            "Send reminder",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF283593), // Indigo/navy in Image 2
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ===========================================================================
  // 8. DIALOG: STUDENT FEE DETAILS (Image 4)
  // ===========================================================================
  void _showStudentDetailsModal(Map<String, dynamic> student) {
    final name = student["name"] as String;
    final email = student["email"] as String;
    final status = student["status"] as String;
    final fee = student["fee"] as String;
    final clearedOn = student["clearedOn"] as String;
    final paidVia = student["paidVia"] as String;
    final lastReminder = student["lastReminder"] as String;
    final paymentDetails = (student["paymentDetails"] as String? ?? "").trim();

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Name and Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          email,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(status),
                ],
              ),
              const SizedBox(height: 24),

              // 2x2 Grid of details
              Row(
                children: [
                  Expanded(
                    child: _buildModalDetailItem("Fee for 2026-27", fee),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildModalDetailItem("Cleared on", clearedOn),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _buildModalDetailItem("Settled by", paidVia),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildModalDetailItem("Last reminder", lastReminder),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Payments this year section
              Text(
                "Payments this year",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                paymentDetails.isNotEmpty
                    ? paymentDetails
                    : "No payment has been made or submitted yet.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 26),

              // Close action
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    "Close",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
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
