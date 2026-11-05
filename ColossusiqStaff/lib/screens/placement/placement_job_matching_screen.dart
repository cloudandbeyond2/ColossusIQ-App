import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: JOB MATCHING SCREEN
// Exactly matches Screenshots 4 & 5:
// - Blueprint grid hero banner with watermark, PLACEMENT and MVP badges
// - Big Readiness Booster Card:
//     - Left score: 29 OUT OF 100
//     - Needs work tag, Dept (Sem 5) · CGPA 0.0
//     - Headline: "Boost your readiness by 46 points to unlock all Tier-1 drives"
//     - Right buttons: Practice AI Interview, ATS Resume Builder, Readiness Breakdown
//     - Alert bar with recommended actions
// - 5 Metric Stat Cards (Openings 13, Eligible For You 0, Campus Drives 10, Applications 1, Avg Package ₹14.5 LPA)
// - Opportunity Category Tabs (Matched For You 0, All Opportunities 13 [active], Campus Drives 10, Internships 2, My Applications 1, Saved 2)
// - Filter & Search Row (Search, Only eligible for me checkbox, Package filter, Sort dropdown)
// - Responsive Grid of Job Cards (ZOHO, MSFT, TCS, AIH, CSS, AWS, TAT, ZOH, AMA) with skills tags, readiness gap indicators, View Details & Locked/Shortlisted buttons
// =============================================================================

class PlacementJobMatchingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementJobMatchingScreen({super.key, this.onBack});

  @override
  State<PlacementJobMatchingScreen> createState() => _PlacementJobMatchingScreenState();
}

class _PlacementJobMatchingScreenState extends State<PlacementJobMatchingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = "All Opportunities";
  bool _onlyEligible = false;
  String _selectedPackage = "All packages";
  String _selectedSort = "Highest Match %";

  final Set<String> _bookmarked = {};

  final List<Map<String, dynamic>> _opportunities = [
    {
      "id": "zoho-sde",
      "tag": "ZOHO",
      "title": "Software Development Engineer (SDE)",
      "company": "Zoho Corporation",
      "salary": "₹8.4-12.0 LPA",
      "match": "67% Match",
      "type": "Campus Drive",
      "location": "CS Computer Lab 2 & 3 (Chennai / Tenkasi / Remote)",
      "driveDate": "2026-10-24",
      "deadline": "2026-10-20",
      "skills": ["✓ Java", "✓ Data Structures", "✓ Algorithms", "✓ Object-Oriented Design", "+2"],
      "cutoff": 70,
      "current": 29,
      "status": "locked",
    },
    {
      "id": "msft-sde",
      "tag": "MSFT",
      "title": "Software Engineer Trainee",
      "company": "Microsoft India",
      "salary": "₹18.0-26.0 LPA",
      "match": "59% Match",
      "type": "Campus Drive",
      "location": "Microsoft Teams (Virtual Assessment) (Bengaluru / Hyderaba...)",
      "driveDate": "2026-11-02",
      "deadline": "2026-10-28",
      "skills": ["✓ Data Structures", "✓ Algorithms", "System Design", "✓ Operating Systems", "+3"],
      "cutoff": 78,
      "current": 29,
      "status": "locked",
    },
    {
      "id": "tcs-sys",
      "tag": "TCS",
      "title": "System Engineer - Digital Innovator",
      "company": "Tata Consultancy Services",
      "salary": "₹7.0-9.2 LPA",
      "match": "58% Match",
      "type": "Campus Drive",
      "location": "Main Auditorium, Academic Block A (Chennai / Bengaluru / Pu...)",
      "driveDate": "2026-10-18",
      "deadline": "2026-10-15",
      "skills": ["✓ Data Structures", "✓ Java", "Python", "✓ SQL", "+2"],
      "cutoff": 60,
      "current": 29,
      "status": "shortlisted",
    },
    {
      "id": "aih-da",
      "tag": "AIH",
      "title": "Data Analyst & BI Engineer",
      "company": "Analytics Insights Hub",
      "salary": "₹6.5-9.5 LPA",
      "match": "54% Match",
      "type": "Campus Drive",
      "location": "Department Seminar Hall (Coimbatore / Chennai)",
      "driveDate": "2026-11-05",
      "deadline": "2026-10-31",
      "skills": ["✓ SQL", "✓ Python", "Data Analysis", "PowerBI", "+2"],
      "cutoff": 60,
      "current": 29,
      "status": "locked",
    },
    {
      "id": "css-devops",
      "tag": "CSS",
      "title": "Cloud Operations & DevOps Intern",
      "company": "CloudSphere Solutions",
      "salary": "₹35,000 / month (Stipend)",
      "match": "54% Match",
      "type": "Internship",
      "location": "Google Meet (Online) (Hyderabad / Remote)",
      "driveDate": "2026-10-22",
      "deadline": "2026-10-19",
      "skills": ["Linux", "✓ Operating Systems", "✓ Computer Networks", "Docker", "+2"],
      "cutoff": 62,
      "current": 29,
      "status": "locked",
    },
    {
      "id": "aws-support",
      "tag": "AWS",
      "title": "Cloud Support Associate Intern",
      "company": "Amazon Web Services (AWS)",
      "salary": "₹45,000 / month (Stipend)",
      "match": "54% Match",
      "type": "Internship",
      "location": "Amazon Chime (Virtual) (Bengaluru / Hyderabad)",
      "driveDate": "2026-11-10",
      "deadline": "2026-11-05",
      "skills": ["✓ Computer Networks", "✓ Operating Systems", "Linux", "Troubleshooting", "+2"],
      "cutoff": 72,
      "current": 29,
      "status": "locked",
    },
    {
      "id": "tat-digital",
      "tag": "TAT",
      "title": "Digital Innovator & Prime Engineer",
      "company": "Tata Consultancy Services (TCS)",
      "salary": "₹9.0-11.5 LPA",
      "match": "52% Match",
      "type": "Campus Drive",
      "location": "TCS Siruseri Campus / Online Proctored",
      "driveDate": "2026-11-14",
      "deadline": "2026-11-08",
      "skills": ["✓ Java", "Spring Boot", "React", "✓ SQL", "+1"],
      "cutoff": 65,
      "current": 29,
      "status": "locked",
    },
    {
      "id": "zoh-swe",
      "tag": "ZOH",
      "title": "Software Engineer",
      "company": "Zoho Corporation",
      "salary": "₹7.5-10.0 LPA",
      "match": "50% Match",
      "type": "Campus Drive",
      "location": "Estancia IT Park, Guduvanchery",
      "driveDate": "2026-11-18",
      "deadline": "2026-11-12",
      "skills": ["C++", "✓ Data Structures", "Algorithms", "+2"],
      "cutoff": 68,
      "current": 29,
      "status": "locked",
    },
    {
      "id": "ama-cloud",
      "tag": "AMA",
      "title": "Associate Cloud Support Engineer",
      "company": "Amazon AWS",
      "salary": "₹14.0-20.0 LPA",
      "match": "48% Match",
      "type": "Campus Drive",
      "location": "Amazon Development Centre (Chennai)",
      "driveDate": "2026-11-25",
      "deadline": "2026-11-18",
      "skills": ["AWS Basics", "Networking", "✓ Linux", "Bash", "+2"],
      "cutoff": 70,
      "current": 29,
      "status": "locked",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showJobDetails(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          job["title"],
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: 440,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${job['company']} · ${job['salary']}",
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF1E2865)),
              ),
              const SizedBox(height: 10),
              Text(
                "Location: ${job['location']}",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 4),
              Text(
                "Drive Date: ${job['driveDate']} · Deadline: ${job['deadline']}",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),
              Text(
                "Required Skills:",
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: (job["skills"] as List<String>)
                    .map((s) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(s, style: GoogleFonts.poppins(fontSize: 11)),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFFD97706)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Requires readiness total of ${job['cutoff']}+ (current: ${job['current']})",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFFB45309)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
            ),
            child: Text("Close", style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _opportunities.where((job) {
      if (_onlyEligible && job["status"] == "locked") return false;
      if (_selectedTab == "Campus Drives" && job["type"] != "Campus Drive") return false;
      if (_selectedTab == "Internships" && job["type"] != "Internship") return false;
      if (_selectedTab == "My Applications" && job["status"] != "shortlisted") return false;
      if (_selectedTab == "Saved" && !_bookmarked.contains(job["id"])) return false;
      if (_selectedTab == "Matched For You" && (job["status"] == "locked")) return false;

      final query = _searchController.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        final title = (job["title"] as String).toLowerCase();
        final company = (job["company"] as String).toLowerCase();
        final skills = (job["skills"] as List<String>).join(" ").toLowerCase();
        return title.contains(query) || company.contains(query) || skills.contains(query);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 20),
              _buildReadinessBoosterCard(),
              const SizedBox(height: 20),
              _buildStatCardsRow(),
              const SizedBox(height: 20),
              _buildTabsRow(),
              const SizedBox(height: 16),
              _buildFilterAndSearchRow(),
              const SizedBox(height: 20),
              _buildOpportunityGrid(filtered),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Image 4)
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
            Color(0xFF38439E),
          ],
        ),
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
            // Watermark icon on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.hub_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Placement',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Job Matching',
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
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.hub_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E2548),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.25),
                                    ),
                                  ),
                                  child: Text(
                                    'PLACEMENT',
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
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'MVP',
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
                              'Job Matching',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Open roles matched to verified student profiles and eligibility.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
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
  // READINESS BOOSTER CARD (Image 4)
  // ===========================================================================
  Widget _buildReadinessBoosterCard() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;
                final bool isDesktop = width >= 860;
                final bool isMobile = width < 540;

                Widget buildScoreBox({double size = 90, double fontSize = 32}) {
                  return Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "29",
                          style: GoogleFonts.poppins(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "OUT OF 100",
                          style: GoogleFonts.poppins(
                            fontSize: size < 80 ? 8.5 : 9.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                Widget buildTagAndSubtitle() {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Needs work",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFDC2626),
                          ),
                        ),
                      ),
                      Text(
                        "•  Computer Science & Engineering (Sem 5)  •  CGPA 0.0",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  );
                }

                Widget buildHeadline({double fontSize = 17}) {
                  return Text(
                    "Boost your readiness by 46 points to unlock all Tier-1 drives",
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      height: 1.25,
                    ),
                  );
                }

                Widget buildDescription() {
                  return Text(
                    "Your profile is verified with ATS Resume (82%), Quizzes (0%), and Mock Interview (48%).",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                      height: 1.4,
                    ),
                  );
                }

                Widget buildButton(String label, IconData icon, {bool isFull = false}) {
                  final btn = OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(icon, size: 15, color: const Color(0xFF475569)),
                    label: Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F172A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );

                  if (isFull) {
                    return SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: btn,
                    );
                  }
                  return btn;
                }

                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildScoreBox(size: 90, fontSize: 32),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTagAndSubtitle(),
                            const SizedBox(height: 6),
                            buildHeadline(fontSize: 17),
                            const SizedBox(height: 4),
                            buildDescription(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildButton("Practice AI Interview",
                              Icons.auto_awesome_rounded),
                          const SizedBox(height: 8),
                          buildButton("ATS Resume Builder",
                              Icons.description_outlined),
                          const SizedBox(height: 8),
                          buildButton("Readiness Breakdown",
                              Icons.trending_up_rounded),
                        ],
                      ),
                    ],
                  );
                } else if (isMobile) {
                  // Smart Responsive Mobile Layout
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Compact Score Box + Badge & Headline
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildScoreBox(size: 78, fontSize: 27),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTagAndSubtitle(),
                                const SizedBox(height: 6),
                                buildHeadline(fontSize: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      buildDescription(),
                      const SizedBox(height: 14),
                      // Smart Full-Width Action Buttons on Mobile
                      buildButton("Practice AI Interview",
                          Icons.auto_awesome_rounded,
                          isFull: true),
                      const SizedBox(height: 8),
                      buildButton("ATS Resume Builder",
                          Icons.description_outlined,
                          isFull: true),
                      const SizedBox(height: 8),
                      buildButton("Readiness Breakdown",
                          Icons.trending_up_rounded,
                          isFull: true),
                    ],
                  );
                } else {
                  // Tablet Layout
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildScoreBox(size: 86, fontSize: 30),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildTagAndSubtitle(),
                                const SizedBox(height: 6),
                                buildHeadline(fontSize: 16),
                                const SizedBox(height: 4),
                                buildDescription(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          buildButton("Practice AI Interview",
                              Icons.auto_awesome_rounded),
                          buildButton("ATS Resume Builder",
                              Icons.description_outlined),
                          buildButton("Readiness Breakdown",
                              Icons.trending_up_rounded),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          // Alert info footer bar (Top-aligned icon & clean text wrap)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFBEB),
              border: Border(
                top: BorderSide(color: Color(0xFFFDE68A)),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.error_outline_rounded,
                      size: 16, color: Color(0xFFD97706)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Action recommended to boost matching: ",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                        TextSpan(
                          text:
                              "Raise your quiz average to 60% • Earn 2 more certificate(s) • Score 50+ in a mock interview • Reach a total of 70",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFB45309),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5 STAT CARDS (Image 4)
  // ===========================================================================
  Widget _buildStatCardsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final cards = [
          _buildStatCard("Openings", "13", "Verified opportunities", Icons.business_center_outlined, null),
          _buildStatCard("Eligible For You", "0", "You meet all rules", Icons.check_circle_outline_rounded, const Color(0xFF059669)),
          _buildStatCard("Campus Drives", "10", "Scheduled recruitment", Icons.school_outlined, null),
          _buildStatCard("Applications", "1", "1 shortlisted", Icons.send_outlined, null),
          _buildStatCard("Avg Package", "₹14.5 LPA", "Peak: ₹32.5 LPA", Icons.bolt_rounded, const Color(0xFFD97706)),
        ];

        if (isWide) {
          return Row(
            children: cards
                .map((card) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: card,
                      ),
                    ))
                .toList(),
          );
        } else {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: cards
                .map((card) => SizedBox(
                      width: (constraints.maxWidth - 10) / 2,
                      child: card,
                    ))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildStatCard(String label, String value, String subtitle, IconData icon, Color? iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Icon(icon, size: 18, color: iconColor ?? const Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
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
  // TABS ROW (Image 4)
  // ===========================================================================
  Widget _buildTabsRow() {
    final tabs = [
      {"name": "Matched For You", "count": 0},
      {"name": "All Opportunities", "count": 13},
      {"name": "Campus Drives", "count": 10},
      {"name": "Internships", "count": 2},
      {"name": "My Applications", "count": 1},
      {"name": "Saved", "count": 2},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((t) {
          final isSelected = _selectedTab == t["name"];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _selectedTab = t["name"] as String),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      t["name"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.2)
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${t['count']}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF475569),
                        ),
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
  // FILTER & SEARCH ROW (Image 4)
  // ===========================================================================
  Widget _buildFilterAndSearchRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 850;

        final searchBar = Row(
          children: [
            const Icon(Icons.search_rounded, size: 20, color: Color(0xFF94A3B8)),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                decoration: InputDecoration(
                  hintText: "Search by company, role title, or skills...",
                  hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        );

        final filterControls = Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _onlyEligible,
                  onChanged: (val) => setState(() => _onlyEligible = val ?? false),
                  activeColor: const Color(0xFF1E2865),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  "Only eligible for me",
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCBD5E1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPackage,
                  isDense: true,
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
                  items: const [
                    DropdownMenuItem(value: "All packages", child: Text("Package: All packages")),
                    DropdownMenuItem(value: "Tier 1", child: Text("Package: Tier 1 (>15 LPA)")),
                    DropdownMenuItem(value: "Tier 2", child: Text("Package: Tier 2 (8-15 LPA)")),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedPackage = val);
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCBD5E1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedSort,
                  isDense: true,
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
                  items: const [
                    DropdownMenuItem(value: "Highest Match %", child: Text("Sort: Highest Match %")),
                    DropdownMenuItem(value: "Salary: High to Low", child: Text("Sort: Salary: High to Low")),
                    DropdownMenuItem(value: "Deadline: Soonest", child: Text("Sort: Deadline: Soonest")),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedSort = val);
                  },
                ),
              ),
            ),
          ],
        );

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBar,
                    const Divider(height: 16, color: Color(0xFFF1F5F9)),
                    filterControls,
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: searchBar),
                    const SizedBox(width: 12),
                    filterControls,
                  ],
                ),
        );
      },
    );
  }

  // ===========================================================================
  // OPPORTUNITY GRID (Images 4 & 5)
  // ===========================================================================
  Widget _buildOpportunityGrid(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        alignment: Alignment.center,
        child: Text(
          "No matching job opportunities found.",
          style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF64748B)),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1150) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 750) {
          crossAxisCount = 2;
        }

        final columnWidth = (constraints.maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: items
              .map((job) => SizedBox(
                    width: columnWidth,
                    child: _buildJobCard(job),
                  ))
              .toList(),
        );
      },
    );
  }

  // ===========================================================================
  // SINGLE JOB CARD (Images 4 & 5)
  // ===========================================================================
  Widget _buildJobCard(Map<String, dynamic> job) {
    final isBookmarked = _bookmarked.contains(job["id"]);
    final isShortlisted = job["status"] == "shortlisted";

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
          // Header: Logo Tag, Title, Company, Bookmark
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  job["tag"],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E2865),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job["title"],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      job["company"],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  size: 20,
                  color: isBookmarked ? const Color(0xFF1E2865) : const Color(0xFF94A3B8),
                ),
                onPressed: () {
                  setState(() {
                    if (isBookmarked) {
                      _bookmarked.remove(job["id"]);
                    } else {
                      _bookmarked.add(job["id"]);
                    }
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Badges: Salary, Match, Type
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  job["salary"],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  job["match"],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFD97706),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: job["type"] == "Campus Drive"
                      ? const Color(0xFFF3E8FF)
                      : const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  job["type"],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: job["type"] == "Campus Drive"
                        ? const Color(0xFF7E22CE)
                        : const Color(0xFF0284C7),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Location
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF94A3B8)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  job["location"],
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Drive & Deadline
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 13, color: Color(0xFF94A3B8)),
              const SizedBox(width: 5),
              Text(
                "Drive: ${job['driveDate']} · Deadline: ${job['deadline']}",
                style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Skills tags
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: (job["skills"] as List<String>)
                .map((skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: skill.startsWith("✓")
                            ? const Color(0xFFECFDF5)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: skill.startsWith("✓")
                              ? const Color(0xFFA7F3D0)
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        skill,
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: skill.startsWith("✓")
                              ? const Color(0xFF065F46)
                              : const Color(0xFF475569),
                        ),
                      ),
                    ))
                .toList(),
          ),

          const SizedBox(height: 12),

          // Readiness gap warning
          Row(
            children: [
              const Icon(Icons.error_outline_rounded, size: 14, color: Color(0xFFD97706)),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  "Requires readiness total of ${job['cutoff']}+ (current: ${job['current']})",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFFD97706),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Actions: View Details & Locked/Shortlisted
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showJobDetails(job),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0F172A),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    "View Details",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: isShortlisted
                    ? ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check_rounded, size: 14),
                        label: Text(
                          "Shortlisted",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFECFDF5),
                          foregroundColor: const Color(0xFF065F46),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xFFA7F3D0)),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Locked: Reach readiness total of ${job['cutoff']}+ to unlock registration.",
                                style: GoogleFonts.poppins(),
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7E84B7),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Locked (Gap)",
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
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
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1;

    const step = 28.0;
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
