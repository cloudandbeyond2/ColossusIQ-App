import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalCollegeWebsiteScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalCollegeWebsiteScreen({super.key, this.onBack});

  @override
  State<PrincipalCollegeWebsiteScreen> createState() =>
      _PrincipalCollegeWebsiteScreenState();
}

class _PrincipalCollegeWebsiteScreenState
    extends State<PrincipalCollegeWebsiteScreen> {
  // Form Controllers
  late final TextEditingController _heroTaglineController;
  late final TextEditingController _announcementController;
  late final TextEditingController _aboutController;
  late final TextEditingController _principalMessageController;
  late final TextEditingController _highlightsController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _officeHoursController;

  bool _showUpcomingEvents = true;
  bool _showPhotoGallery = true;

  @override
  void initState() {
    super.initState();
    _heroTaglineController = TextEditingController(
      text: "Engineering minds that build tomorrow",
    );
    _announcementController = TextEditingController(
      text: "Admissions 2026–27 are open — apply online",
    );
    _aboutController = TextEditingController(
      text:
          "Anna Institute of Technology, established in 2001 in Chennai, is an AICTE-approved engineering college affiliated to Tamil Nadu Technical University. We offer undergraduate and postgraduate programmes in computing, electronics, mechanical and civil engineering, with industry-linked labs, an active incubation cell and strong placement outcomes.",
    );
    _principalMessageController = TextEditingController(
      text:
          "Welcome to Anna Institute of Technology. Our commitment is to every learner's growth — academic, professional and personal. I invite you to explore our programmes and campus life.\n— Dr. Lakshmi Sundaram, Principal",
    );
    _highlightsController = TextEditingController(
      text:
          "AICTE approved\nNBA-accredited programmes\n92% placement (2025)\nIncubation cell",
    );
    _addressController = TextEditingController(
      text: "Anna Institute of Technology, Chennai, Tamil Nadu",
    );
    _phoneController = TextEditingController(text: "9686876285");
    _emailController = TextEditingController(text: "office@ait.edu.in");
    _officeHoursController = TextEditingController(
      text: "Mon–Sat, 9:00 AM – 5:00 PM",
    );
  }

  @override
  void dispose() {
    _heroTaglineController.dispose();
    _announcementController.dispose();
    _aboutController.dispose();
    _principalMessageController.dispose();
    _highlightsController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _officeHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm canvas background
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 950;
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

                // 2. MAIN BODY (2 columns on Desktop, Stacked on Mobile)
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT FORM COLUMN (~68%)
                      Expanded(
                        flex: 68,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeroCard(),
                            const SizedBox(height: 20),
                            _buildAboutCard(),
                            const SizedBox(height: 20),
                            _buildContactCard(),
                            const SizedBox(height: 24),
                            _buildBottomActionButtons(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 22),
                      // RIGHT SIDEBAR COLUMN (~32%)
                      Expanded(
                        flex: 32,
                        child: Column(
                          children: [
                            _buildPublicPagesCard(),
                            const SizedBox(height: 20),
                            _buildWhatAppearsCard(),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroCard(),
                      const SizedBox(height: 20),
                      _buildAboutCard(),
                      const SizedBox(height: 20),
                      _buildContactCard(),
                      const SizedBox(height: 20),
                      _buildPublicPagesCard(),
                      const SizedBox(height: 20),
                      _buildWhatAppearsCard(),
                      const SizedBox(height: 24),
                      _buildBottomActionButtons(),
                    ],
                  ),
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
              right: 18,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.school_outlined,
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
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "College Website",
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
                          "College Website",
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

                  // Header Row with Icon, Badges, Title & Subtitle
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
                            Icons.school_rounded,
                            size: 28,
                            color: Color(0xFFFBBF24), // Amber/gold graduation cap
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
                                    "COLLEGE WEBSITE",
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
                              "College Website",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Edit your public college page — hero image, tagline, about, principal's message, highlights and contact.",
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
  // 2. HERO CARD (Tags, Illustration preview, upload buttons, announcement)
  // ===========================================================================
  Widget _buildHeroCard() {
    return _buildSectionCard(
      icon: Icons.image_outlined,
      iconColor: const Color(0xFFD97706),
      iconBgColor: const Color(0xFFFEF3C7),
      title: "Hero",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel("Hero tagline", isRequired: true),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _heroTaglineController,
            hintText: "Enter hero tagline...",
          ),
          const SizedBox(height: 18),

          _buildFieldLabel("Hero image", isRequired: true),
          const SizedBox(height: 8),

          // Illustration Preview Container
          Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: CustomPaint(
                painter: _CampusIllustrationPainter(),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Action Buttons under Image
          Wrap(
            spacing: 12,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Upload image
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Image upload picker opened"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.file_upload_outlined, size: 16),
                label: Text(
                  "Upload image",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4338CA),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // Campus library
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Campus library opened"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.grid_view_rounded, size: 16),
                label: Text(
                  "Campus library",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // Remove
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Hero image reset to default"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.close_rounded,
                    size: 16, color: Color(0xFF64748B)),
                label: Text(
                  "Remove",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Helper instruction text
          Text(
            "PNG, JPEG or WebP, up to 2 MB. Files are checked before and after upload.\nWide images (about 1600×800) look best. PNG, JPEG or WebP up to 2 MB.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),

          // Announcement banner
          _buildFieldLabel("Announcement banner", isRequired: false),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _announcementController,
            hintText: "Enter announcement...",
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. ABOUT CARD (About college, principal's message, highlights)
  // ===========================================================================
  Widget _buildAboutCard() {
    return _buildSectionCard(
      icon: Icons.menu_book_outlined,
      iconColor: const Color(0xFF4F46E5),
      iconBgColor: const Color(0xFFEEF2FF),
      title: "About",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel("About the college", isRequired: true),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _aboutController,
            maxLines: 4,
            hintText: "Write institutional background...",
          ),
          const SizedBox(height: 18),

          _buildFieldLabel("Principal's message", isRequired: false),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _principalMessageController,
            maxLines: 4,
            hintText: "Write message from the principal...",
          ),
          const SizedBox(height: 18),

          _buildFieldLabel("Highlights (one per line)", isRequired: false),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _highlightsController,
            maxLines: 4,
            hintText: "AICTE approved\nNBA-accredited programmes\n...",
          ),
          const SizedBox(height: 8),
          Text(
            "Shown as badges, e.g. NAAC A+, NIRF ranked, 1,100-bed hospital.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. CONTACT CARD (Address, Phone, Email, Office hours, Toggles)
  // ===========================================================================
  Widget _buildContactCard() {
    return _buildSectionCard(
      icon: Icons.location_on_outlined,
      iconColor: const Color(0xFF0D9488),
      iconBgColor: const Color(0xFFCCFBF1),
      title: "Contact",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTwoCol = constraints.maxWidth >= 600;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel("Address", isRequired: true),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _addressController,
                maxLines: 3,
                hintText: "Enter full address...",
              ),
              const SizedBox(height: 18),

              // Enquiry phone & email
              if (isTwoCol)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Enquiry phone", isRequired: true),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _phoneController,
                            hintText: "Phone number",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Enquiry email", isRequired: true),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _emailController,
                            hintText: "Email address",
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else ...[
                _buildFieldLabel("Enquiry phone", isRequired: true),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _phoneController,
                  hintText: "Phone number",
                ),
                const SizedBox(height: 14),
                _buildFieldLabel("Enquiry email", isRequired: true),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _emailController,
                  hintText: "Email address",
                ),
              ],
              const SizedBox(height: 18),

              // Office hours & Show upcoming events toggle
              if (isTwoCol)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Office hours", isRequired: false),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _officeHoursController,
                            hintText: "Working hours",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: _buildTogglePill(
                          title: "Show upcoming events",
                          value: _showUpcomingEvents,
                          onChanged: (val) {
                            setState(() => _showUpcomingEvents = val);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              else ...[
                _buildFieldLabel("Office hours", isRequired: false),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _officeHoursController,
                  hintText: "Working hours",
                ),
                const SizedBox(height: 14),
                _buildTogglePill(
                  title: "Show upcoming events",
                  value: _showUpcomingEvents,
                  onChanged: (val) {
                    setState(() => _showUpcomingEvents = val);
                  },
                ),
              ],
              const SizedBox(height: 16),

              // Show photo gallery toggle
              _buildTogglePill(
                title: "Show photo gallery",
                value: _showPhotoGallery,
                onChanged: (val) {
                  setState(() => _showPhotoGallery = val);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 5. BOTTOM ACTION BUTTONS (Save website & View public page)
  // ===========================================================================
  Widget _buildBottomActionButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Save website (Lavender-purple pill)
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      "College website changes saved successfully!",
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF0F766E),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          icon: const Icon(Icons.save_outlined, size: 18),
          label: Text(
            "Save website",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9499E2),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // View public page
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Redirecting to institutional public portal..."),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.open_in_new_rounded, size: 16),
          label: Text(
            "View public page",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF334155),
            side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. RIGHT SIDEBAR CARD: YOUR PUBLIC PAGES
  // ===========================================================================
  Widget _buildPublicPagesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
            "Your public pages",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),

          // College home page
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Opening College home page preview"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.public_rounded,
                      size: 17, color: Color(0xFF2563EB)),
                  const SizedBox(width: 10),
                  Text(
                    "College home page",
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Student & staff login
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Opening Student & staff login preview"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.login_rounded,
                      size: 17, color: Color(0xFF2563EB)),
                  const SizedBox(width: 10),
                  Text(
                    "Student & staff login",
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          Text(
            "Share the login link with your students and staff — it signs them straight in to your college.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 7. RIGHT SIDEBAR CARD: WHAT APPEARS ON THE PAGE
  // ===========================================================================
  Widget _buildWhatAppearsCard() {
    final items = [
      "Hero image, tagline and announcement",
      "About, principal's message and highlights",
      "Programmes and departments of your stream",
      "Published events and gallery photos",
      "Contact details and an Apply button (when admissions are open)",
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
            "What appears on the page",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "•  ",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF475569),
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // HELPER WIDGETS
  // ===========================================================================

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required Widget child,
  }) {
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
          // Header with icon & title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(icon, size: 18, color: iconColor),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          // Body content
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label, {required bool isRequired}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        if (isRequired)
          Text(
            " *",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFEF4444),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    int maxLines = 1,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: const Color(0xFF1E293B),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: const Color(0xFF94A3B8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildTogglePill({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF99F6E4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: const Color(0xFF0F766E),
            activeThumbColor: Colors.white,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// CAMPUS ILLUSTRATION PAINTER
// Draws the exact dusk/night campus building with clock tower, moon & lawns
// =============================================================================
class _CampusIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Dusk Sky Gradient
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF28256E), Color(0xFF3B3386), Color(0xFF5E4989)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // 2. Soft Clouds
    final cloudPaint = Paint()
      ..color = const Color(0xFF4F4685).withValues(alpha: 0.65);

    // Left cloud
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(w * 0.22, h * 0.22), width: w * 0.18, height: 18),
        const Radius.circular(12),
      ),
      cloudPaint,
    );
    // Right upper cloud
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(w * 0.46, h * 0.16), width: w * 0.12, height: 14),
        const Radius.circular(10),
      ),
      cloudPaint,
    );

    // 3. Warm Golden Moon
    final moonCenter = Offset(w * 0.72, h * 0.32);
    final moonRadius = h * 0.18;
    final moonPaint = Paint()..color = const Color(0xFFE5BE81);
    canvas.drawCircle(moonCenter, moonRadius, moonPaint);

    // 4. Lawn Ground Curves
    final groundBaseY = h * 0.88;

    // Background Hill
    final hillPath = Path()
      ..moveTo(0, groundBaseY)
      ..quadraticBezierTo(w * 0.5, groundBaseY - 30, w, groundBaseY)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(hillPath, Paint()..color = const Color(0xFF1E3A2B));

    // Foreground Lawn
    final lawnPath = Path()
      ..moveTo(0, groundBaseY + 10)
      ..quadraticBezierTo(w * 0.5, groundBaseY - 14, w, groundBaseY + 10)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(lawnPath, Paint()..color = const Color(0xFF2D5A3D));

    // 5. Shrubs / Trees flanking building
    final shrubPaint = Paint()..color = const Color(0xFF234431);
    // Left bush
    canvas.drawCircle(Offset(w * 0.17, groundBaseY + 2), 40, shrubPaint);
    // Right bush
    canvas.drawCircle(Offset(w * 0.76, groundBaseY + 2), 40, shrubPaint);

    // 6. Central Building
    final bldgWidth = (w * 0.56).clamp(240.0, 520.0);
    final bldgLeft = (w - bldgWidth) / 2;
    final bldgBottom = h * 0.94;
    final bldgHeight = h * 0.52;
    final bldgTop = bldgBottom - bldgHeight;

    // Building Base / Wall (Cream / Ivory)
    final wallPaint = Paint()..color = const Color(0xFFF1F5F9);
    final wallShadowPaint = Paint()..color = const Color(0xFFE2E8F0);

    // Left Wing
    final wingWidth = bldgWidth * 0.34;
    canvas.drawRect(
      Rect.fromLTWH(bldgLeft, bldgTop + 25, wingWidth, bldgHeight - 25),
      wallPaint,
    );
    // Left Wing shadow
    canvas.drawRect(
      Rect.fromLTWH(bldgLeft, bldgTop + 25, 6, bldgHeight - 25),
      wallShadowPaint,
    );

    // Right Wing
    canvas.drawRect(
      Rect.fromLTWH(bldgLeft + bldgWidth - wingWidth, bldgTop + 25, wingWidth,
          bldgHeight - 25),
      wallPaint,
    );
    // Right Wing shadow
    canvas.drawRect(
      Rect.fromLTWH(bldgLeft + bldgWidth - 6, bldgTop + 25, 6, bldgHeight - 25),
      wallShadowPaint,
    );

    // Center Portico / Tower Base
    final centerWidth = bldgWidth * 0.32;
    final centerLeft = bldgLeft + (bldgWidth - centerWidth) / 2;
    canvas.drawRect(
      Rect.fromLTWH(centerLeft, bldgTop, centerWidth, bldgHeight),
      wallPaint,
    );

    // Red Gable Roof on Center Tower
    final roofPaint = Paint()..color = const Color(0xFFB91C1C);
    final roofHeight = 34.0;
    final roofPath = Path()
      ..moveTo(centerLeft - 8, bldgTop)
      ..lineTo(centerLeft + centerWidth / 2, bldgTop - roofHeight)
      ..lineTo(centerLeft + centerWidth + 8, bldgTop)
      ..close();
    canvas.drawPath(roofPath, roofPaint);

    // Roof Spire / Finial
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerLeft + centerWidth / 2, bldgTop - roofHeight - 10),
        width: 14,
        height: 20,
      ),
      Paint()..color = const Color(0xFF1E293B),
    );
    // Small gold flag
    final flagPath = Path()
      ..moveTo(centerLeft + centerWidth / 2, bldgTop - roofHeight - 20)
      ..lineTo(centerLeft + centerWidth / 2 + 14, bldgTop - roofHeight - 16)
      ..lineTo(centerLeft + centerWidth / 2, bldgTop - roofHeight - 12)
      ..close();
    canvas.drawPath(flagPath, Paint()..color = const Color(0xFFFBBF24));

    // Clock on Tower
    final clockCenter =
        Offset(centerLeft + centerWidth / 2, bldgTop + roofHeight * 0.85);
    final clockRadius = 14.0;
    // Clock outer face
    canvas.drawCircle(
        clockCenter, clockRadius, Paint()..color = const Color(0xFF0F172A));
    // Clock hands
    final handPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(clockCenter, Offset(clockCenter.dx, clockCenter.dy - 7), handPaint);
    canvas.drawLine(
        clockCenter, Offset(clockCenter.dx + 5, clockCenter.dy + 2), handPaint);

    // Arched Main Entrance Door (Brown Wood)
    final doorWidth = centerWidth * 0.44;
    final doorHeight = 44.0;
    final doorLeft = centerLeft + (centerWidth - doorWidth) / 2;
    final doorBottom = bldgBottom;
    final doorTop = doorBottom - doorHeight;

    final doorPath = Path()
      ..moveTo(doorLeft, doorBottom)
      ..lineTo(doorLeft, doorTop + doorWidth / 2)
      ..arcToPoint(
        Offset(doorLeft + doorWidth, doorTop + doorWidth / 2),
        radius: Radius.circular(doorWidth / 2),
      )
      ..lineTo(doorLeft + doorWidth, doorBottom)
      ..close();
    canvas.drawPath(doorPath, Paint()..color = const Color(0xFF78350F));

    // Entrance Pathway (Light cream travertine)
    final pathWay = Path()
      ..moveTo(doorLeft - 4, doorBottom)
      ..lineTo(w * 0.44, h)
      ..lineTo(w * 0.56, h)
      ..lineTo(doorLeft + doorWidth + 4, doorBottom)
      ..close();
    canvas.drawPath(pathWay, Paint()..color = const Color(0xFFCBD5E1));

    // Neoclassical Pillars / Columns framing entrance
    final pillarPaint = Paint()..color = const Color(0xFFE2E8F0);
    canvas.drawRect(
      Rect.fromLTWH(doorLeft - 8, doorTop + 6, 6, doorHeight - 6),
      pillarPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(doorLeft + doorWidth + 2, doorTop + 6, 6, doorHeight - 6),
      pillarPaint,
    );

    // Arched Windows on Center Tower (above door)
    _drawArchedWindow(
      canvas,
      Offset(centerLeft + centerWidth * 0.28, bldgTop + 54),
      12,
      20,
    );
    _drawArchedWindow(
      canvas,
      Offset(centerLeft + centerWidth * 0.72, bldgTop + 54),
      12,
      20,
    );

    // Arched Windows on Left Wing (2 pairs)
    _drawArchedWindow(
      canvas,
      Offset(bldgLeft + wingWidth * 0.32, bldgTop + 45),
      14,
      24,
    );
    _drawArchedWindow(
      canvas,
      Offset(bldgLeft + wingWidth * 0.72, bldgTop + 45),
      14,
      24,
    );
    _drawSquareWindow(
      canvas,
      Offset(bldgLeft + wingWidth * 0.32, bldgTop + 85),
      14,
      20,
    );
    _drawSquareWindow(
      canvas,
      Offset(bldgLeft + wingWidth * 0.72, bldgTop + 85),
      14,
      20,
    );

    // Arched Windows on Right Wing (2 pairs)
    final rightWingLeft = bldgLeft + bldgWidth - wingWidth;
    _drawArchedWindow(
      canvas,
      Offset(rightWingLeft + wingWidth * 0.28, bldgTop + 45),
      14,
      24,
    );
    _drawArchedWindow(
      canvas,
      Offset(rightWingLeft + wingWidth * 0.68, bldgTop + 45),
      14,
      24,
    );
    _drawSquareWindow(
      canvas,
      Offset(rightWingLeft + wingWidth * 0.28, bldgTop + 85),
      14,
      20,
    );
    _drawSquareWindow(
      canvas,
      Offset(rightWingLeft + wingWidth * 0.68, bldgTop + 85),
      14,
      20,
    );
  }

  void _drawArchedWindow(
      Canvas canvas, Offset center, double width, double height) {
    final left = center.dx - width / 2;
    final top = center.dy - height / 2;
    final path = Path()
      ..moveTo(left, top + height)
      ..lineTo(left, top + width / 2)
      ..arcToPoint(
        Offset(left + width, top + width / 2),
        radius: Radius.circular(width / 2),
      )
      ..lineTo(left + width, top + height)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF1E293B));
  }

  void _drawSquareWindow(
      Canvas canvas, Offset center, double width, double height) {
    final left = center.dx - width / 2;
    final top = center.dy - height / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, width, height),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFF1E293B),
    );
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
