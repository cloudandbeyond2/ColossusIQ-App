import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/portal_page_body.dart';

class JobMatchRecord {
  final String company;
  final String role;
  final String package;
  final String location;
  final int matchPercentage;
  final String eligibility;
  final BadgeTone tone;

  const JobMatchRecord({
    required this.company,
    required this.role,
    required this.package,
    required this.location,
    required this.matchPercentage,
    required this.eligibility,
    required this.tone,
  });
}

/// Job Matching Screen [P2]
/// Matches ColossusIQ web UI design with Blueprint hero banner, filter search bar,
/// and notebook grid empty state / verified job matching cards.
class JobMatchingScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const JobMatchingScreen({super.key, this.onBack});

  @override
  State<JobMatchingScreen> createState() => _JobMatchingScreenState();
}

class _JobMatchingScreenState extends State<JobMatchingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";

  static const List<JobMatchRecord> _allJobs = [
    JobMatchRecord(
      company: "Amazon Web Services (AWS)",
      role: "Associate Cloud Architect",
      package: "₹14.5 LPA",
      location: "Bengaluru / Hyderabad",
      matchPercentage: 96,
      eligibility: "B.Tech CSE/IT, Min CGPA 8.0, AWS Certified preferred",
      tone: BadgeTone.teal,
    ),
    JobMatchRecord(
      company: "Cisco Systems",
      role: "Software Engineer - Enterprise Routing",
      package: "₹12.0 LPA",
      location: "Bengaluru",
      matchPercentage: 91,
      eligibility: "B.Tech CSE/ECE, Min CGPA 7.5, Networking skills verified",
      tone: BadgeTone.teal,
    ),
    JobMatchRecord(
      company: "Zoho Corporation",
      role: "Member Technical Staff (Core Backend)",
      package: "₹8.4 LPA",
      location: "Chennai / Tenkasi",
      matchPercentage: 88,
      eligibility: "All Engineering Branches, Strong Data Structures score",
      tone: BadgeTone.brand,
    ),
    JobMatchRecord(
      company: "Cognizant GenC Next",
      role: "Digital Specialist Engineer",
      package: "₹6.8 LPA",
      location: "Pan India",
      matchPercentage: 82,
      eligibility: "B.Tech CSE/ECE/EEE, Min CGPA 7.0, HackerEarth rank verified",
      tone: BadgeTone.brand,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<JobMatchRecord> get _filteredJobs {
    final query = _searchController.text.trim().toLowerCase();
    return _allJobs.where((job) {
      final matchesSearch = query.isEmpty ||
          job.company.toLowerCase().contains(query) ||
          job.role.toLowerCase().contains(query) ||
          job.location.toLowerCase().contains(query);

      if (!matchesSearch) return false;

      if (_selectedFilter == "90%+ Match") {
        return job.matchPercentage >= 90;
      } else if (_selectedFilter == "High Package (≥ ₹10 LPA)") {
        return job.package.contains("14") || job.package.contains("12");
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = _filteredJobs;

    return PortalPageBody(
      title: "Job Matching",
      category: "Placement",
      badge: const AppBadge(label: "PHASE 2", tone: BadgeTone.brand),
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Hero Glow Blueprint Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Placement  ›  Job Matching",
          category: "PLACEMENT",
          phase: "Phase 2",
          icon: Icons.handshake_outlined,
          watermarkIcon: Icons.handshake_outlined,
          title: "Job Matching",
          subtitle: "Open roles matched to verified student profiles and eligibility.",
        ),
        const SizedBox(height: 18),

        // 2. Search & Filter Bar Card matching Web UI
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEBEFF4), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF162044).withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 20, color: Color(0xFF9CA3AF)),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 13.5, color: AppColors.ink),
                  decoration: InputDecoration(
                    hintText: "Search job matching...",
                    hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: const Color(0xFF9CA3AF)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.close, size: 18, color: Color(0xFF9CA3AF)),
                  ),
                ),
              Container(
                height: 24,
                width: 1,
                color: const Color(0xFFE5E7EB),
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              // Filter Dropdown
              PopupMenuButton<String>(
                initialValue: _selectedFilter,
                onSelected: (val) => setState(() => _selectedFilter = val),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_list, size: 16, color: Color(0xFF6B7280)),
                    const SizedBox(width: 6),
                    Text(
                      _selectedFilter,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF6B7280)),
                  ],
                ),
                itemBuilder: (context) => [
                  _filterMenuItem("All"),
                  _filterMenuItem("90%+ Match"),
                  _filterMenuItem("High Package (≥ ₹10 LPA)"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Results Container:
        // Shows Notebook Empty Card if empty, or verified job list
        if (jobs.isEmpty)
          const NotebookEmptyCard(
            title: "No matching records",
            subtitle: "Try a different search or filter.",
            height: 190,
          )
        else
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Matched Verified Positions (${jobs.length})",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink3,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _searchController.text = "xyz_nomatch";
                      setState(() {});
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Simulate Empty",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: AppColors.ink3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...jobs.map((job) => _buildJobCard(job)),
            ],
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  PopupMenuItem<String> _filterMenuItem(String value) {
    return PopupMenuItem(
      value: value,
      child: Text(
        value,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: _selectedFilter == value ? FontWeight.w600 : FontWeight.w400,
          color: _selectedFilter == value ? AppColors.primaryBlue : AppColors.ink,
        ),
      ),
    );
  }

  Widget _buildJobCard(JobMatchRecord job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Company Name + Match Score Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  job.company,
                  style: GoogleFonts.poppins(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: job.matchPercentage >= 90
                      ? AppColors.successSoft
                      : AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${job.matchPercentage}% Verified Match",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: job.matchPercentage >= 90
                        ? AppColors.success
                        : AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Role
          Text(
            job.role,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),

          // Package & Location
          Row(
            children: [
              Text(
                "Package: ",
                style: GoogleFonts.poppins(fontSize: 12, color: AppColors.ink3),
              ),
              Text(
                job.package,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 14),
              Icon(Icons.location_on_outlined, size: 14, color: AppColors.ink3),
              const SizedBox(width: 2),
              Text(
                job.location,
                style: GoogleFonts.poppins(fontSize: 12, color: AppColors.ink3),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Eligibility
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.veryLightBlue,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border, width: 0.8),
            ),
            child: Row(
              children: [
                Icon(Icons.verified_outlined, size: 16, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    job.eligibility,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: AppColors.ink2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Action button
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Application submitted to ${job.company} via Verified Student Profile!"),
                    backgroundColor: AppColors.primaryBlue,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: Text(
                "Apply with Verified Profile",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
