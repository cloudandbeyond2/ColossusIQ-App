import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';
import '../career/career_modules.dart';
import '../placement/placement_screen.dart';

class JobOpportunity {
  final String id;
  final String company;
  final String avatar;
  final Color avatarBg;
  final Color avatarColor;
  final String role;
  final String package;
  final int matchScore;
  final String type; // e.g. "Campus Drive" or ""
  final String venue;
  final String driveDate;
  final String deadline;
  final List<String> verifiedSkills;
  final List<String> otherSkills;
  final int extraSkillsCount;
  final String alertMessage;
  final bool isShortlisted;
  final bool isEligible;
  final bool isSaved;
  final int openings;
  final String overview;
  final List<String> responsibilities;
  final List<String> selectionRounds;

  const JobOpportunity({
    required this.id,
    required this.company,
    required this.avatar,
    required this.avatarBg,
    required this.avatarColor,
    required this.role,
    required this.package,
    required this.matchScore,
    this.type = "",
    required this.venue,
    required this.driveDate,
    required this.deadline,
    required this.verifiedSkills,
    required this.otherSkills,
    this.extraSkillsCount = 0,
    required this.alertMessage,
    this.isShortlisted = false,
    this.isEligible = false,
    this.isSaved = false,
    this.openings = 10,
    required this.overview,
    required this.responsibilities,
    required this.selectionRounds,
  });
}

/// Job Matching Screen [MVP] (Matching Images 3, 4 & 5)
class JobMatchingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onOpenInterview;
  final VoidCallback? onOpenResume;
  final VoidCallback? onOpenReadiness;

  const JobMatchingScreen({
    super.key,
    this.onBack,
    this.onOpenInterview,
    this.onOpenResume,
    this.onOpenReadiness,
  });

  @override
  State<JobMatchingScreen> createState() => _JobMatchingScreenState();
}

class _JobMatchingScreenState extends State<JobMatchingScreen> {
  int _selectedTab = 0; // 0: Matched For You, 1: All Opportunities, 2: Campus Drives, 3: Internships, 4: My Applications, 5: Saved
  final TextEditingController _searchController = TextEditingController();
  bool _onlyEligible = false;
  String _selectedPackageFilter = "All packages";
  String _selectedSort = "Highest Match %";

  late List<JobOpportunity> _jobs;

  @override
  void initState() {
    super.initState();
    _jobs = [
      JobOpportunity(
        id: "job-1",
        company: "Zoho Corporation",
        avatar: "ZOHO",
        avatarBg: const Color(0xFFE0F2FE),
        avatarColor: const Color(0xFF0369A1),
        role: "Software Development Engineer (SDE)",
        package: "₹8.4–12.0 LPA",
        matchScore: 83,
        type: "Campus Drive",
        venue: "CS Computer Lab 2 & 3 (Chennai / Tenkasi / Remote)",
        driveDate: "2026-10-24",
        deadline: "2026-10-20",
        verifiedSkills: ["Java", "Data Structures", "Algorithms", "Object-Oriented Design"],
        otherSkills: ["REST APIs", "SQL"],
        extraSkillsCount: 2,
        alertMessage: "Requires readiness total of 70+ (current: 69)",
        isShortlisted: false,
        isEligible: false,
        openings: 25,
        overview:
            "Design and develop scalable multi-tenant SaaS business applications using robust Java backends, high-throughput microservices, and clean distributed architectures.",
        responsibilities: [
          "Write performant, memory-efficient backend logic in core Java",
          "Design scalable relational database schemas and queries in PostgreSQL/MySQL",
          "Collaborate with product designers and frontend teams on API integration",
        ],
        selectionRounds: [
          "Round 1: Online Technical Aptitude & Basic C/Java Programming",
          "Round 2: Advanced Data Structures & Algorithm Design Round",
          "Round 3: Object-Oriented System Architecture & Coding",
          "Round 4: Technical & Cultural Fitment Discussion",
        ],
      ),
      JobOpportunity(
        id: "job-2",
        company: "Microsoft India",
        avatar: "MSFT",
        avatarBg: const Color(0xFFEEF2FF),
        avatarColor: const Color(0xFF4338CA),
        role: "Software Engineer Trainee",
        package: "₹18.0–26.0 LPA",
        matchScore: 75,
        type: "",
        venue: "Microsoft Teams (Virtual Assessment) (Bengaluru / Hyderabad...)",
        driveDate: "2026-11-02",
        deadline: "2026-10-28",
        verifiedSkills: ["Data Structures", "Algorithms", "Operating Systems"],
        otherSkills: ["System Design", "Cloud Computing"],
        extraSkillsCount: 3,
        alertMessage: "Requires readiness total of 78+ (current: 69)",
        isShortlisted: false,
        isEligible: false,
        openings: 12,
        overview:
            "Join engineering teams building enterprise-grade cloud applications, intelligent Azure cloud fabric services, and AI-accelerated developer productivity tools.",
        responsibilities: [
          "Develop enterprise cloud capabilities deployed on Azure infrastructure",
          "Optimize multithreaded systems for high concurrency and ultra-low latency",
          "Write comprehensive automated unit, integration, and fuzz tests",
        ],
        selectionRounds: [
          "Round 1: Codility Online Algorithm Assessment (3 Coding Questions)",
          "Round 2: Data Structures & Live Problem Solving (Virtual)",
          "Round 3: Low-Level Architecture & Operating Systems Concepts",
          "Round 4: AA Interview with Senior Engineering Director",
        ],
      ),
      JobOpportunity(
        id: "job-3",
        company: "Tata Consultancy Services",
        avatar: "TCS",
        avatarBg: const Color(0xFFF1F5F9),
        avatarColor: const Color(0xFF334155),
        role: "System Engineer - Digital Innovator",
        package: "₹7.0–9.2 LPA",
        matchScore: 74,
        type: "Campus Drive",
        venue: "Main Auditorium, Academic Block A (Chennai / Bengaluru / Pu...",
        driveDate: "2026-10-18",
        deadline: "2026-10-15",
        verifiedSkills: ["Data Structures", "Java", "Python", "SQL"],
        otherSkills: ["Cybersecurity"],
        extraSkillsCount: 2,
        alertMessage: "Minimum CGPA required is 6.5 (current: 1.7)",
        isShortlisted: true,
        isEligible: false,
        openings: 50,
        overview:
            "Build modern cloud native systems, enterprise ERP integrations, and machine learning proof-of-concepts for global Fortune 500 corporate clients.",
        responsibilities: [
          "Participate in full software engineering lifecycles using Agile sprints",
          "Construct API gateways and microservices using Java Spring Boot and Python",
          "Ensure high code quality through continuous integration and testing",
        ],
        selectionRounds: [
          "Round 1: TCS NQT Cognitive & Advanced Coding Examination",
          "Round 2: Technical Interview on CS Core Fundamentals",
          "Round 3: Managerial & Project Architecture Review",
          "Round 4: HR Onboarding Documentation",
        ],
      ),
      JobOpportunity(
        id: "job-4",
        company: "Analytics Insights Hub",
        avatar: "AIH",
        avatarBg: const Color(0xFFECFDF5),
        avatarColor: const Color(0xFF047857),
        role: "Data Analyst & BI Engineer",
        package: "₹6.5–9.5 LPA",
        matchScore: 70,
        type: "Campus Drive",
        venue: "Department Seminar Hall (Coimbatore / Chennai)",
        driveDate: "2026-11-05",
        deadline: "2026-10-31",
        verifiedSkills: ["SQL", "Python", "Database Management Systems"],
        otherSkills: ["Data Analysis", "PowerBI", "Statistics"],
        extraSkillsCount: 2,
        alertMessage: "Minimum CGPA required is 6.0 (current: 1.7)",
        isShortlisted: false,
        isEligible: false,
        openings: 15,
        overview:
            "Transform multi-terabyte datasets into actionable business intelligence dashboards, predictive pipelines, and automated anomaly detection models.",
        responsibilities: [
          "Write complex analytical SQL queries, CTEs, and window functions",
          "Build dynamic PowerBI / Tableau dashboards for executive leadership",
          "Automate data extraction and cleaning scripts in Python and Pandas",
        ],
        selectionRounds: [
          "Round 1: Analytical Aptitude & SQL Assessment",
          "Round 2: Live SQL & Data Wrangling Practical Test",
          "Round 3: Technical Viva & Case Study Presentation",
          "Round 4: HR Discussion",
        ],
      ),
      JobOpportunity(
        id: "job-5",
        company: "CloudSphere Solutions",
        avatar: "CSS",
        avatarBg: const Color(0xFFEFF6FF),
        avatarColor: const Color(0xFF1D4ED8),
        role: "Cloud Operations & DevOps Intern",
        package: "₹35,000 / month (Stipend)",
        matchScore: 70,
        type: "",
        venue: "Google Meet (Online) (Hyderabad / Remote)",
        driveDate: "2026-10-22",
        deadline: "2026-10-19",
        verifiedSkills: ["Operating Systems", "Computer Networks"],
        otherSkills: ["Linux", "Docker"],
        extraSkillsCount: 2,
        alertMessage: "Minimum CGPA required is 6.5 (current: 1.7)",
        isShortlisted: false,
        isEligible: false,
        openings: 8,
        overview:
            "Maintain Kubernetes cluster operations, continuous delivery deployment scripts, and telemetry monitoring pipelines for cloud-hosted applications.",
        responsibilities: [
          "Automate cloud deployment manifests using Terraform and Docker",
          "Monitor system metrics with Prometheus, Grafana, and ELK stack",
          "Troubleshoot networking, DNS, and container security alerts",
        ],
        selectionRounds: [
          "Round 1: Linux CLI & Networking Fundamentals Quiz",
          "Round 2: Hands-on Docker & Shell Scripting Exercise",
          "Round 3: DevOps Architecture & Technical Interview",
          "Round 4: Internship Offer Alignment Discussion",
        ],
      ),
      JobOpportunity(
        id: "job-6",
        company: "Amazon Web Services (AWS)",
        avatar: "AWS",
        avatarBg: const Color(0xFFFFFBEB),
        avatarColor: const Color(0xFFB45309),
        role: "Cloud Support Associate Intern",
        package: "₹45,000 / month (Stipend)",
        matchScore: 70,
        type: "",
        venue: "Amazon Chime (Virtual) (Bengaluru / Hyderabad)",
        driveDate: "2026-11-10",
        deadline: "2026-11-05",
        verifiedSkills: ["Computer Networks", "Operating Systems"],
        otherSkills: ["Linux", "Troubleshooting"],
        extraSkillsCount: 2,
        alertMessage: "Requires readiness total of 72+ (current: 69)",
        isShortlisted: false,
        isEligible: false,
        openings: 20,
        overview:
            "Support global AWS enterprise developers in diagnosing and resolving cloud architectural, EC2 compute, VPC networking, and database issues.",
        responsibilities: [
          "Diagnose complex cloud networking, storage, and compute configurations",
          "Replicate customer architecture bottlenecks in sandbox environments",
          "Author technical knowledge base articles for AWS community documentation",
        ],
        selectionRounds: [
          "Round 1: AWS Online Technical Assessment & Troubleshooting Case",
          "Round 2: OS Internals & Networking Deep Dive Interview",
          "Round 3: Behavioral Interview following Amazon Leadership Principles",
          "Round 4: Bar Raiser Assessment Round",
        ],
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<JobOpportunity> get _filteredJobs {
    final query = _searchController.text.trim().toLowerCase();
    return _jobs.where((j) {
      if (_selectedTab == 0) {
        // Matched for you (all default 6)
      } else if (_selectedTab == 1) {
        // All opportunities
      } else if (_selectedTab == 2) {
        if (j.type != "Campus Drive") return false;
      } else if (_selectedTab == 3) {
        if (!j.package.contains("month") && !j.package.contains("Stipend")) return false;
      } else if (_selectedTab == 4) {
        if (!j.isShortlisted) return false;
      } else if (_selectedTab == 5) {
        if (!j.isSaved) return false;
      }

      if (_onlyEligible && !j.isEligible) return false;

      if (query.isNotEmpty) {
        final matchesCompany = j.company.toLowerCase().contains(query);
        final matchesRole = j.role.toLowerCase().contains(query);
        final matchesSkills = j.verifiedSkills.any((s) => s.toLowerCase().contains(query)) ||
            j.otherSkills.any((s) => s.toLowerCase().contains(query));
        if (!matchesCompany && !matchesRole && !matchesSkills) return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredJobs;

    return PortalPageBody(
      title: "Job Matching",
      category: "Placement",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner (Matching Image 3)
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Placement  ›  Job Matching",
          category: "PLACEMENT",
          phase: "MVP",
          isMvp: true,
          icon: Icons.handshake_outlined,
          watermarkIcon: Icons.handshake_outlined,
          title: "Job Matching",
          subtitle: "Open roles matched to verified student profiles and eligibility.",
        ),
        const SizedBox(height: 18),

        // 2. Readiness Score Hero Card (Matching Image 3)
        _buildReadinessHeroCard(),
        const SizedBox(height: 16),

        // 3. 5 KPI Stat Cards (Matching Image 3)
        _buildKpiRow(),
        const SizedBox(height: 18),

        // 4. Filter Tabs Row (Matching Image 3)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTabPill(0, "Matched For You", 6),
              const SizedBox(width: 8),
              _buildTabPill(1, "All Opportunities", 13),
              const SizedBox(width: 8),
              _buildTabPill(2, "Campus Drives", 10),
              const SizedBox(width: 8),
              _buildTabPill(3, "Internships", 2),
              const SizedBox(width: 8),
              _buildTabPill(4, "My Applications", 1),
              const SizedBox(width: 8),
              _buildTabPill(5, "Saved", 2),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 5. Search & Filter Bar (Matching Image 3)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 980;

              final searchField = Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                        decoration: InputDecoration(
                          hintText: "Search by company, role title, or skills (e.g. Python, SQL)...",
                          hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () => setState(() => _searchController.clear()),
                        child: const Icon(Icons.close, size: 14, color: Color(0xFF94A3B8)),
                      ),
                  ],
                ),
              );

              final filtersRow = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Only eligible for me
                  InkWell(
                    onTap: () => setState(() => _onlyEligible = !_onlyEligible),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _onlyEligible,
                          onChanged: (v) => setState(() => _onlyEligible = v ?? false),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          activeColor: const Color(0xFF1E1B4B),
                        ),
                        Text(
                          "Only eligible for me",
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Package Dropdown
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPackageFilter,
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                        items: const [
                          DropdownMenuItem(value: "All packages", child: Text("Package: All packages")),
                          DropdownMenuItem(value: "≥ ₹6 LPA", child: Text("Package: ≥ ₹6 LPA")),
                          DropdownMenuItem(value: "≥ ₹10 LPA", child: Text("Package: ≥ ₹10 LPA")),
                        ],
                        onChanged: (v) {
                          if (v != null) setState(() => _selectedPackageFilter = v);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Sort Dropdown
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSort,
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                        items: const [
                          DropdownMenuItem(value: "Highest Match %", child: Text("Sort: Highest Match %")),
                          DropdownMenuItem(value: "Newest First", child: Text("Sort: Newest First")),
                          DropdownMenuItem(value: "Highest Package", child: Text("Sort: Highest Package")),
                        ],
                        onChanged: (v) {
                          if (v != null) setState(() => _selectedSort = v);
                        },
                      ),
                    ),
                  ),
                ],
              );

              if (isWide) {
                return Row(
                  children: [
                    Expanded(child: searchField),
                    const SizedBox(width: 14),
                    filtersRow,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  searchField,
                  const SizedBox(height: 10),
                  SingleChildScrollView(scrollDirection: Axis.horizontal, child: filtersRow),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 18),

        // 6. Job Cards Grid (Matching Images 3 & 4)
        if (filtered.isEmpty)
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.work_outline_rounded, size: 36, color: Color(0xFF94A3B8)),
                  const SizedBox(height: 8),
                  Text(
                    "No job opportunities match current filters",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Try unchecking 'Only eligible for me' or clearing the search query.",
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final colCount = w >= 1060 ? 3 : (w >= 680 ? 2 : 1);

              if (colCount == 1) {
                return Column(
                  children: filtered
                      .map((job) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildJobCard(job),
                          ))
                      .toList(),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: colCount == 3 ? 0.96 : 1.05,
                ),
                itemBuilder: (context, index) => _buildJobCard(filtered[index]),
              );
            },
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  // --- READINESS HERO CARD (IMAGE 3) ---
  Widget _buildReadinessHeroCard() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 760;

                final scoreCircle = Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "69",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "OUT OF 100",
                        style: GoogleFonts.poppins(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF94A3B8),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                );

                final contentInfo = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Text(
                            "Almost ready",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "• Computer Science & Engineering (Sem 3) • CGPA 1.7",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Boost your readiness by 6 points to unlock all Tier-1 drives",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Your profile is verified with ATS Resume (72%), Quizzes (72%), and Mock Interview (17%).",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final actionButtons = Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _heroActionBtn(
                      icon: Icons.auto_awesome,
                      label: "Practice AI Interview",
                      onTap: () => _navigateToRoute('/interview', widget.onOpenInterview),
                    ),
                    _heroActionBtn(
                      icon: Icons.description_outlined,
                      label: "ATS Resume Builder",
                      onTap: () => _navigateToRoute('/resume', widget.onOpenResume),
                    ),
                    _heroActionBtn(
                      icon: Icons.trending_up,
                      label: "Readiness Breakdown",
                      onTap: () => _navigateToRoute('/placement-readiness', widget.onOpenReadiness),
                    ),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      scoreCircle,
                      const SizedBox(width: 16),
                      Expanded(child: contentInfo),
                      const SizedBox(width: 16),
                      actionButtons,
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        scoreCircle,
                        const SizedBox(width: 14),
                        Expanded(child: contentInfo),
                      ],
                    ),
                    const SizedBox(height: 14),
                    actionButtons,
                  ],
                );
              },
            ),
          ),

          // Bottom alert strip inside Hero card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFBEB),
              border: Border(top: BorderSide(color: Color(0xFFFEF3C7))),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Color(0xFFB45309)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Action recommended to boost matching: Score 50+ in a mock interview • Reach a total of 70",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB45309),
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

  void _navigateToRoute(String routeName, VoidCallback? fallbackCallback) {
    if (fallbackCallback != null) {
      fallbackCallback();
      return;
    }
    try {
      Navigator.pushNamed(context, routeName);
    } catch (_) {
      Widget screen;
      if (routeName == '/interview') {
        screen = const MockInterviewScreen();
      } else if (routeName == '/resume') {
        screen = const ResumeBuilderScreen();
      } else {
        screen = const PlacementScreen();
      }
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    }
  }

  Widget _heroActionBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 14, color: const Color(0xFF1E1B4B)),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E1B4B)),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // --- 5 KPI STAT CARDS (IMAGE 3) ---
  Widget _buildKpiRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;

        final cards = [
          _buildKpiCard("Openings", "13", "Verified opportunities", Icons.business_center_outlined),
          _buildKpiCard("Eligible For You", "0", "You meet all rules", Icons.check_circle_outline, checkColor: const Color(0xFF059669)),
          _buildKpiCard("Campus Drives", "10", "Scheduled recruitment", Icons.school_outlined),
          _buildKpiCard("Applications", "1", "1 shortlisted", Icons.send_outlined),
          _buildKpiCard("Avg Package", "₹14.5 LPA", "Peak: ₹32.5 LPA", Icons.bolt_outlined, isBoldVal: true),
        ];

        if (isWide) {
          return Row(
            children: cards
                .map((c) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: c,
                      ),
                    ))
                .toList(),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: cards
                .map((c) => Container(
                      width: 175,
                      margin: const EdgeInsets.only(right: 10),
                      child: c,
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildKpiCard(String title, String val, String sub, IconData icon, {Color? checkColor, bool isBoldVal = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B), fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 16, color: checkColor ?? const Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            val,
            style: GoogleFonts.poppins(
              fontSize: isBoldVal ? 17 : 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- TAB PILL (IMAGE 3) ---
  Widget _buildTabPill(int index, String label, int count) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedTab = index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withValues(alpha: 0.25) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$count",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- JOB CARD (IMAGES 3 & 4) ---
  Widget _buildJobCard(JobOpportunity job) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Avatar + Title + Company + Bookmark icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: job.avatarBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      job.avatar,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: job.avatarColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.role,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          job.company,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.bookmark_border_rounded, size: 18, color: Color(0xFF94A3B8)),
                ],
              ),
              const SizedBox(height: 10),

              // Package, Match %, and Type Badges
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      job.package,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFEFF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "${job.matchScore}% Match",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0891B2),
                      ),
                    ),
                  ),
                  if (job.type.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E8FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        job.type,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7C3AED),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Venue
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.venue,
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Dates
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 13, color: Color(0xFF94A3B8)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "Drive: ${job.driveDate} • Deadline: ${job.deadline}",
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Skills Chips
              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: [
                  ...job.verifiedSkills.map((sk) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFDCFCE7)),
                      ),
                      child: Text(
                        "✓ $sk",
                        style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w500, color: const Color(0xFF15803D)),
                      ),
                    );
                  }),
                  ...job.otherSkills.map((sk) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        sk,
                        style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF475569)),
                      ),
                    );
                  }),
                  if (job.extraSkillsCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "+${job.extraSkillsCount}",
                        style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Eligibility Warning Alert
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.info_outline, size: 13, color: Color(0xFFB45309)),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.alertMessage,
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFB45309)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action Buttons: View Details | Locked (Gap) / Shortlisted
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E293B),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _showJobDetailsModal(job),
                  child: Text(
                    "View Details",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: job.isShortlisted
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF059669)),
                            const SizedBox(width: 4),
                            Text(
                              "Shortlisted",
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF059669)),
                            ),
                          ],
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF818CF8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => _showJobDetailsModal(job),
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

  // --- JOB DETAILS MODAL (MATCHING IMAGE 5) ---
  void _showJobDetailsModal(JobOpportunity job) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${job.role} — ${job.company}",
                        style: GoogleFonts.poppins(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Top Strip: Package, Match %, Campus Drive & Eligibility Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                job.package,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "${job.matchScore}% Match",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFD97706),
                                  ),
                                ),
                              ),
                              if (job.type.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    job.type,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2563EB),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Venue: ${job.venue} • Drive Date: ${job.driveDate} • Openings: ${job.openings}",
                            style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF818CF8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Eligibility Criteria Not Met",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Eligibility Check Card (Matching Image 5)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF8F5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFF0ECE1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ELIGIBILITY CHECK",
                        style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF64748B), letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 10),
                      LayoutBuilder(
                        builder: (context, c) {
                          final isRow = c.maxWidth >= 480;
                          final col1 = _eligibilityCheckItem(
                            icon: Icons.info_outline,
                            iconColor: const Color(0xFFD97706),
                            title: "Readiness Score",
                            desc: "Needs 60% (You have 69%)",
                          );
                          final col2 = _eligibilityCheckItem(
                            icon: Icons.check_circle_outline,
                            iconColor: const Color(0xFF059669),
                            title: "Department",
                            desc: "Computer Science & Engineering",
                          );
                          final col3 = _eligibilityCheckItem(
                            icon: Icons.check_circle_outline,
                            iconColor: const Color(0xFF059669),
                            title: "Academic Standing",
                            desc: "CGPA 1.7 / 10",
                          );

                          if (isRow) {
                            return Row(
                              children: [
                                Expanded(child: col1),
                                const SizedBox(width: 8),
                                Expanded(child: col2),
                                const SizedBox(width: 8),
                                Expanded(child: col3),
                              ],
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              col1,
                              const SizedBox(height: 8),
                              col2,
                              const SizedBox(height: 8),
                              col3,
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Role Overview
                Text(
                  "ROLE OVERVIEW",
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569), letterSpacing: 0.5),
                ),
                const SizedBox(height: 6),
                Text(
                  job.overview,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), height: 1.45),
                ),
                const SizedBox(height: 16),

                // Key Responsibilities
                Text(
                  "KEY RESPONSIBILITIES",
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569), letterSpacing: 0.5),
                ),
                const SizedBox(height: 6),
                ...job.responsibilities.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("•  ", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                              r,
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16),

                // Selection Process (Matching Image 5)
                Text(
                  "SELECTION PROCESS",
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569), letterSpacing: 0.5),
                ),
                const SizedBox(height: 8),
                ...job.selectionRounds.asMap().entries.map((entry) {
                  final idx = entry.key + 1;
                  final roundText = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "$idx",
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            roundText,
                            style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),

                // Skill Matching Analysis (Matching Image 5)
                Text(
                  "SKILL MATCHING ANALYSIS",
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569), letterSpacing: 0.5),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ...job.verifiedSkills.map((sk) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: Text(
                          "✓ $sk",
                          style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF047857)),
                        ),
                      );
                    }),
                    ...job.otherSkills.map((sk) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF8F5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFF0ECE1)),
                        ),
                        child: Text(
                          sk,
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 24),

                // Bottom actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _navigateToRoute('/interview', widget.onOpenInterview);
                      },
                      icon: const Icon(Icons.auto_awesome, size: 15, color: Color(0xFF312E81)),
                      label: Text(
                        "Practice company mock interview",
                        style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF312E81)),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF334155),
                        elevation: 0,
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: Text("Close", style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600)),
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

  Widget _eligibilityCheckItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 15, color: iconColor),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
              ),
              Text(
                desc,
                style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
