import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalRolesPermissionsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalRolesPermissionsScreen({super.key, this.onBack});

  @override
  State<PrincipalRolesPermissionsScreen> createState() =>
      _PrincipalRolesPermissionsScreenState();
}

class _PrincipalRolesPermissionsScreenState
    extends State<PrincipalRolesPermissionsScreen> {
  int _selectedRoleIndex = 5; // Default: College Principal (index 5)
  bool _onlyPrincipalPermissions = false;
  final TextEditingController _searchPermissionsController =
      TextEditingController();

  final List<Map<String, dynamic>> _roles = [
    {
      "name": "Student",
      "permissions": "3 permissions",
      "desc": "Al mentor, learning, exams, projects and career readiness.",
      "users": "2 users",
      "modules": "50 of 53 modules open",
      "icon": Icons.school_outlined,
      "iconColor": Color(0xFF3B82F6),
      "iconBg": Color(0xFFEFF6FF),
    },
    {
      "name": "Faculty",
      "permissions": "7 permissions",
      "desc": "Teaching copilot, assessments, evaluation and skill development.",
      "users": "1 user",
      "modules": "34 of 38 modules open",
      "icon": Icons.co_present_outlined,
      "iconColor": Color(0xFFD97706),
      "iconBg": Color(0xFFFEF3C7),
    },
    {
      "name": "Head of Department",
      "permissions": "9 permissions",
      "desc":
          "Department intelligence, faculty, academics and placement readiness.",
      "users": "0 users",
      "modules": "31 of 38 modules open",
      "icon": Icons.groups_outlined,
      "iconColor": Color(0xFF0D9488),
      "iconBg": Color(0xFFCCFBF1),
    },
    {
      "name": "Placement Officer",
      "permissions": "3 permissions",
      "desc": "Drives, eligibility, job matching and placement analytics.",
      "users": "0 users",
      "modules": "10 of 10 modules open",
      "icon": Icons.business_center_outlined,
      "iconColor": Color(0xFF2563EB),
      "iconBg": Color(0xFFDBEAFE),
    },
    {
      "name": "Incubation Head",
      "permissions": "3 permissions",
      "desc": "Ideas, startups, hackathons, mentors and funding readiness.",
      "users": "0 users",
      "modules": "7 of 7 modules open",
      "icon": Icons.rocket_launch_outlined,
      "iconColor": Color(0xFFEA580C),
      "iconBg": Color(0xFFFFEDD5),
    },
    {
      "name": "College Principal",
      "permissions": "16 permissions",
      "desc":
          "College command center, admissions, staff, users, analytics and early warning.",
      "users": "1 user",
      "modules": "39 of 43 modules open",
      "icon": Icons.account_balance_outlined,
      "iconColor": Color(0xFFE11D48),
      "iconBg": Color(0xFFFFE4E6),
    },
    {
      "name": "Recruiter",
      "permissions": "1 permissions",
      "desc": "Verified talent search, shortlisting and assessments.",
      "users": "0 users",
      "modules": "3 of 3 modules open",
      "icon": Icons.person_search_outlined,
      "iconColor": Color(0xFF475569),
      "iconBg": Color(0xFFF1F5F9),
    },
    {
      "name": "University Super Admin",
      "permissions": "20 permissions",
      "desc":
          "All colleges: onboarding, suspension, module control, cross-college analytics, AI governance and audit.",
      "users": "0 users",
      "modules": "78 of 84 modules open",
      "icon": Icons.verified_user_outlined,
      "iconColor": Color(0xFF4F46E5),
      "iconBg": Color(0xFFEEF2FF),
    },
  ];

  final List<Map<String, dynamic>> _modulesProgress = [
    {"name": "Institution", "current": 10, "total": 10, "color": Color(0xFF0D9488)},
    {"name": "Overview", "current": 1, "total": 1, "color": Color(0xFF0D9488)},
    {"name": "Academics", "current": 2, "total": 3, "color": Color(0xFFB45309)},
    {"name": "Clinical & Hospital", "current": 0, "total": 3, "color": Color(0xFFCBD5E1)},
    {"name": "Assessment", "current": 3, "total": 3, "color": Color(0xFF0D9488)},
    {"name": "AI Course & Certification", "current": 3, "total": 3, "color": Color(0xFF0D9488)},
    {"name": "Campus Life", "current": 4, "total": 4, "color": Color(0xFF0D9488)},
    {"name": "Department", "current": 2, "total": 2, "color": Color(0xFF0D9488)},
    {"name": "Placement", "current": 2, "total": 2, "color": Color(0xFF0D9488)},
    {"name": "Admissions", "current": 2, "total": 2, "color": Color(0xFF0D9488)},
    {"name": "College Website", "current": 2, "total": 2, "color": Color(0xFF0D9488)},
    {"name": "Staff & Users", "current": 3, "total": 3, "color": Color(0xFF0D9488)},
    {"name": "Platform", "current": 4, "total": 4, "color": Color(0xFF0D9488)},
    {"name": "University", "current": 1, "total": 1, "color": Color(0xFF0D9488)},
  ];

  final List<Map<String, dynamic>> _closedModules = [
    {
      "name": "CBCS & Electives",
      "sub": "Academics · Not part of this college's stream",
    },
    {
      "name": "Clinical Rotations",
      "sub": "Clinical & Hospital · Not part of this college's stream",
    },
    {
      "name": "Teaching Hospital",
      "sub": "Clinical & Hospital · Not part of this college's stream",
    },
    {
      "name": "NMC / Council Compliance",
      "sub": "Clinical & Hospital · Not part of this college's stream",
    },
  ];

  // RBAC Permission Matrix Data (Sections & Permissions)
  final List<Map<String, dynamic>> _matrixSections = [
    {
      "category": "Learning & assessment",
      "items": [
        {
          "name": "Use AI mentor / copilots",
          "code": "ai:chat",
          "student": true,
          "faculty": true,
          "hod": true,
          "placement": true,
          "incubation": true,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Attempt tests",
          "code": "assessment:attempt",
          "student": true,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": false,
        },
        {
          "name": "Create assessments",
          "code": "assessment:create",
          "student": false,
          "faculty": true,
          "hod": true,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Approve / override AI marks",
          "code": "assessment:override-score",
          "student": false,
          "faculty": true,
          "hod": true,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "View own student record",
          "code": "student:read-own",
          "student": true,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": false,
        },
        {
          "name": "View student records",
          "code": "student:read-any",
          "student": false,
          "faculty": true,
          "hod": true,
          "placement": true,
          "incubation": true,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Publish exam-prep content",
          "code": "prep:publish",
          "student": false,
          "faculty": true,
          "hod": true,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
      ],
    },
    {
      "category": "Administration",
      "items": [
        {
          "name": "Manage admissions",
          "code": "admissions:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage staff",
          "code": "staff:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage users & roles",
          "code": "users:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage courses",
          "code": "courses:manage",
          "student": false,
          "faculty": false,
          "hod": true,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage events",
          "code": "events:manage",
          "student": false,
          "faculty": true,
          "hod": true,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage college website",
          "code": "website:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage knowledge base",
          "code": "knowledge:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Authorize certificates",
          "code": "certificates:authorize",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
      ],
    },
    {
      "category": "Outcomes",
      "items": [
        {
          "name": "Manage placements",
          "code": "placement:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": true,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": false,
        },
        {
          "name": "Manage incubation",
          "code": "incubation:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": true,
          "principal": false,
          "recruiter": false,
          "admin": false,
        },
        {
          "name": "Search verified talent",
          "code": "talent:search",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": true,
          "admin": false,
        },
        {
          "name": "Institution analytics",
          "code": "institution:analytics",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
      ],
    },
    {
      "category": "Platform & governance",
      "items": [
        {
          "name": "Manage colleges",
          "code": "colleges:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage tenants",
          "code": "tenant:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "AI governance",
          "code": "ai:governance",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Read audit log",
          "code": "audit:read",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": true,
          "recruiter": false,
          "admin": true,
        },
        {
          "name": "Manage billing",
          "code": "billing:manage",
          "student": false,
          "faculty": false,
          "hod": false,
          "placement": false,
          "incubation": false,
          "principal": false,
          "recruiter": false,
          "admin": true,
        },
      ],
    },
  ];

  @override
  void dispose() {
    _searchPermissionsController.dispose();
    super.dispose();
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
                const SizedBox(height: 16),

                // 2. STATUS & REFRESH BAR
                _buildStatusBar(),
                const SizedBox(height: 16),

                // 3. TWO WARNING / ETHICAL ADVISORY BANNERS
                _buildAlertBanners(constraints.maxWidth),
                const SizedBox(height: 20),

                // 4. 8 ROLE CARDS
                _buildRoleCardsGrid(constraints.maxWidth),
                const SizedBox(height: 20),

                // 5. SELECTED ROLE DETAIL PANEL (e.g. College Principal)
                _buildSelectedRoleDetailPanel(constraints.maxWidth),
                const SizedBox(height: 24),

                // 6. PERMISSION MATRIX CARD
                _buildPermissionMatrixCard(),
                const SizedBox(height: 20),

                // 7. RECENT ROLE AND ACCESS CHANGES (Audit Log Card)
                _buildRecentChangesCard(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
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
                  Icons.key_outlined,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
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
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
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
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Staff & Users",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Roles & Permissions",
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

                  // Header Row with Key Icon, Badges, Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF26336A).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.key_rounded,
                            size: 28,
                            color: Color(0xFFFBBF24), // Amber gold key
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
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E293B)
                                        .withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    "STAFF & USERS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Roles & Permissions",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "What each role can see and do across the platform (RBAC matrix).",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFCBD5E1),
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
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. STATUS & REFRESH BAR
  // ===========================================================================
  Widget _buildStatusBar() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF16A34A),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                "Anna Institute of Technology · live · updated 01:57:38 pm",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Syncing latest permissions with API..."),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.refresh_rounded, size: 16),
          label: Text(
            "Refresh",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF1E293B),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. TWO ALERT BANNERS
  // ===========================================================================
  Widget _buildAlertBanners(double maxWidth) {
    final isDesktop = maxWidth >= 860;

    final banner1 = _buildSingleAlertBanner(
      boldText: "1 active account does not require MFA.",
      bodyText:
          " Switch on multi-factor authentication for these users in User Management, starting with anyone who can manage users or admissions.",
    );

    final banner2 = _buildSingleAlertBanner(
      boldText:
          "No active Head of Department, Placement Officer, College Principal account.",
      bodyText:
          " Approvals and queues for these roles have no owner in this college.",
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: banner1),
          const SizedBox(width: 16),
          Expanded(child: banner2),
        ],
      );
    } else {
      return Column(
        children: [
          banner1,
          const SizedBox(height: 12),
          banner2,
        ],
      );
    }
  }

  Widget _buildSingleAlertBanner({
    required String boldText,
    required String bodyText,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB), // Soft warm peach amber
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Color(0xFFD97706),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF92400E),
                  height: 1.45,
                ),
                children: [
                  TextSpan(
                    text: boldText,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: bodyText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. 8 ROLE CARDS
  // ===========================================================================
  Widget _buildRoleCardsGrid(double maxWidth) {
    int crossAxisCount = 4;
    if (maxWidth < 650) {
      crossAxisCount = 1;
    } else if (maxWidth < 1000) {
      crossAxisCount = 2;
    }

    final cardWidth =
        (maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(_roles.length, (index) {
        final r = _roles[index];
        final isSelected = _selectedRoleIndex == index;

        return InkWell(
          onTap: () {
            setState(() => _selectedRoleIndex = index);
          },
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: cardWidth,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFE2E8F0),
                width: isSelected ? 1.8 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isSelected ? 0.05 : 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Icon + Role Name + Permissions count
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: r["iconBg"] as Color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          r["icon"] as IconData,
                          size: 17,
                          color: r["iconColor"] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r["name"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            r["permissions"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  r["desc"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),

                // Bottom Status: X user(s) · Y of Z modules open
                Row(
                  children: [
                    Text(
                      r["users"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      "  ${r["modules"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ===========================================================================
  // 5. SELECTED ROLE DETAIL PANEL (Image 3)
  // ===========================================================================
  Widget _buildSelectedRoleDetailPanel(double maxWidth) {
    final selectedRole = _roles[_selectedRoleIndex];
    final isDesktop = maxWidth >= 900;

    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Role title, subtitle & Users button
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedRole["name"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        selectedRole["desc"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Managing users for ${selectedRole["name"]}"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.people_outline_rounded, size: 16),
                  label: Text("Users",
                      style: GoogleFonts.poppins(fontSize: 12.5)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E293B),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // 3 Columns: Accounts | Modules open | Granted but closed
          Padding(
            padding: const EdgeInsets.all(20),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Accounts (~28%)
                      Expanded(
                        flex: 28,
                        child: _buildAccountsColumn(),
                      ),
                      const SizedBox(width: 24),
                      // Column 2: Modules open (~42%)
                      Expanded(
                        flex: 42,
                        child: _buildModulesProgressColumn(),
                      ),
                      const SizedBox(width: 24),
                      // Column 3: Granted but closed (~30%)
                      Expanded(
                        flex: 30,
                        child: _buildGrantedClosedColumn(),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAccountsColumn(),
                      const SizedBox(height: 24),
                      _buildModulesProgressColumn(),
                      const SizedBox(height: 24),
                      _buildGrantedClosedColumn(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Accounts",
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "0 active · 0 invited · 1 suspended",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        // User Entry
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Imran Pillai",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Artificial Intelligence & Data Science",
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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Suspended",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFDC2626),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModulesProgressColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Modules open: 39 of 43",
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 14),
        ..._modulesProgress.map((m) {
          final cur = m["current"] as int;
          final tot = m["total"] as int;
          final color = m["color"] as Color;
          final frac = tot > 0 ? (cur / tot) : 0.0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      m["name"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    Text(
                      "$cur/$tot",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: frac,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildGrantedClosedColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Granted but closed",
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 14),
        ..._closedModules.map((c) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c["name"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  c["sub"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ===========================================================================
  // 6. PERMISSION MATRIX CARD (Images 4 & 5)
  // ===========================================================================
  Widget _buildPermissionMatrixCard() {
    final query = _searchPermissionsController.text.trim().toLowerCase();

    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Manage Users
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Permission matrix",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Enforced by the API on every request; the interface hides what you can't use.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Opening User Management RBAC console..."),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.people_outline_rounded, size: 16),
                  label: Text("Manage users",
                      style: GoogleFonts.poppins(fontSize: 12.5)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E293B),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Search and Filter row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Wrap(
              spacing: 16,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 260,
                  height: 38,
                  child: TextField(
                    controller: _searchPermissionsController,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      hintText: "Search permissions",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _onlyPrincipalPermissions = !_onlyPrincipalPermissions;
                    });
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Checkbox(
                        value: _onlyPrincipalPermissions,
                        onChanged: (val) {
                          setState(() {
                            _onlyPrincipalPermissions = val ?? false;
                          });
                        },
                        activeColor: const Color(0xFF131B4D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Text(
                        "Only what College Principal can do  ",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      Text(
                        "26 of 26 permissions",
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
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Scrollable Permission Matrix Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Container(
                    height: 52,
                    color: const Color(0xFFFAFAFA),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 372,
                          child: Text(
                            "PERMISSION",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                        _buildMatrixColHeader("STUDENT", "2 users"),
                        _buildMatrixColHeader("FACULTY", "1 user"),
                        _buildMatrixColHeader("HOD", "0 users"),
                        _buildMatrixColHeader("PLACEMENT", "0 users"),
                        _buildMatrixColHeader("INCUBATION", "0 users"),
                        _buildMatrixColHeader("PRINCIPAL", "1 user",
                            isHighlighted: true),
                        _buildMatrixColHeader("RECRUITER", "0 users"),
                        _buildMatrixColHeader("ADMIN", "0 users"),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),

                  // Categories & Rows
                  ..._matrixSections.map((sec) {
                    final catName = sec["category"] as String;
                    final items =
                        (sec["items"] as List<Map<String, dynamic>>).where((it) {
                      if (_onlyPrincipalPermissions &&
                          !(it["principal"] as bool)) {
                        return false;
                      }
                      if (query.isNotEmpty) {
                        final name = (it["name"] as String).toLowerCase();
                        final code = (it["code"] as String).toLowerCase();
                        return name.contains(query) || code.contains(query);
                      }
                      return true;
                    }).toList();

                    if (items.isEmpty) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Header Row
                        Container(
                          width: 1140,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: const Color(0xFFF8FAFC),
                          child: Text(
                            catName,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                        // Items in Category
                        ...items.map((it) {
                          return Container(
                            height: 48,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Color(0xFFF1F5F9)),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Permission Name & Code
                                SizedBox(
                                  width: 372,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          it["name"] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0F172A),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        it["code"] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10.5,
                                          color: const Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Role checkboxes/dashes
                                _buildCheckCell(it["student"] as bool),
                                _buildCheckCell(it["faculty"] as bool),
                                _buildCheckCell(it["hod"] as bool),
                                _buildCheckCell(it["placement"] as bool),
                                _buildCheckCell(it["incubation"] as bool),
                                _buildCheckCell(it["principal"] as bool,
                                    isHighlighted: true),
                                _buildCheckCell(it["recruiter"] as bool),
                                _buildCheckCell(it["admin"] as bool),
                              ],
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixColHeader(String title, String subtitle,
      {bool isHighlighted = false}) {
    return Container(
      width: 96,
      height: 52,
      color: isHighlighted ? const Color(0xFFF1F5F9) : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: isHighlighted
                  ? const Color(0xFF1E293B)
                  : const Color(0xFF64748B),
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckCell(bool isChecked, {bool isHighlighted = false}) {
    return Container(
      width: 96,
      height: 48,
      color: isHighlighted ? const Color(0xFFF8FAFC) : Colors.transparent,
      child: Center(
        child: isChecked
            ? Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFFCCFBF1), // Mint teal box
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: Color(0xFF0D9488), // Teal check
                  ),
                ),
              )
            : const Text(
                "–",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFCBD5E1),
                ),
              ),
      ),
    );
  }

  // ===========================================================================
  // 7. RECENT ROLE AND ACCESS CHANGES (Audit Log Card)
  // ===========================================================================
  Widget _buildRecentChangesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent role and access changes",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "From the audit log",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No role or access changes recorded yet.",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF64748B),
            ),
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
