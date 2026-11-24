import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum PhotoGalleryViewMode {
  list,
  addPhoto,
  editPhoto,
  viewPhoto,
}

class PrincipalPhotoGalleryScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalPhotoGalleryScreen({super.key, this.onBack});

  @override
  State<PrincipalPhotoGalleryScreen> createState() =>
      _PrincipalPhotoGalleryScreenState();
}

class _PrincipalPhotoGalleryScreenState
    extends State<PrincipalPhotoGalleryScreen> {
  // Navigation mode: list, addPhoto, editPhoto
  PhotoGalleryViewMode _viewMode = PhotoGalleryViewMode.list;

  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  final List<String> _filterCategories = [
    "All",
    "Published",
    "Draft",
  ];

  // Records matching Image 1
  late List<Map<String, dynamic>> _photos;
  Map<String, dynamic>? _selectedPhoto;

  // Form State for Add / Edit (Images 2, 3, 4, 5)
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  String _selectedCategory = "Labs & Library";
  String _selectedStatus = "Published";
  bool _featureOnHome = false;
  String _selectedPresetKey = "laboratory";
  bool _showLibraryGrid = false;

  final List<String> _categoryOptions = [
    "Select..",
    "Labs & Library",
    "Campus",
    "Academics",
    "Sports",
    "Events",
  ];

  final List<String> _statusOptions = [
    "Draft",
    "Published",
  ];

  // 8 Preset Illustrations in Campus Library (Image 3)
  final List<Map<String, String>> _campusPresets = [
    {"key": "main_building", "title": "Main building"},
    {"key": "hospital", "title": "Teaching hospital"},
    {"key": "library", "title": "Library"},
    {"key": "laboratory", "title": "Laboratory"},
    {"key": "classroom", "title": "Classroom"},
    {"key": "sports", "title": "Sports ground"},
    {"key": "cultural", "title": "Cultural festival"},
    {"key": "graduation", "title": "Graduation day"},
  ];

  @override
  void initState() {
    super.initState();
    _photos = [
      {
        "id": "GAL-1002",
        "presetKey": "laboratory",
        "title": "Laboratories",
        "category": "Labs & Library",
        "caption": "",
        "featureOnHome": false,
        "status": "Published",
        "statusType": "published",
        "updated": "21 Oct 2026",
        "version": 2,
      },
      {
        "id": "GAL-1015",
        "presetKey": "campus_photo",
        "title": "Test",
        "category": "Campus",
        "caption": "Campus main building front view.",
        "featureOnHome": false,
        "status": "Published",
        "statusType": "published",
        "updated": "29 Sept 2026",
        "version": 1,
      },
      {
        "id": "GAL-1001",
        "presetKey": "main_building",
        "title": "Main building",
        "category": "Campus",
        "caption": "Administrative block and principal office.",
        "featureOnHome": true,
        "status": "Published",
        "statusType": "published",
        "updated": "29 Sept 2026",
        "version": 3,
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _titleController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _initFormForAdd() {
    _titleController.clear();
    _captionController.clear();
    _selectedCategory = "Select..";
    _selectedStatus = "Draft";
    _featureOnHome = false;
    _selectedPresetKey = "";
    _showLibraryGrid = false;
  }

  void _initFormForEdit(Map<String, dynamic> photo) {
    _selectedPhoto = photo;
    _titleController.text = photo["title"] as String? ?? "";
    _captionController.text = photo["caption"] as String? ?? "";
    _selectedCategory = photo["category"] as String? ?? "Labs & Library";
    _selectedStatus = photo["status"] as String? ?? "Published";
    _featureOnHome = photo["featureOnHome"] as bool? ?? false;
    _selectedPresetKey = photo["presetKey"] as String? ?? "laboratory";
    _showLibraryGrid = false;
  }

  int _calculateRequiredFieldsFilled() {
    int filled = 0;
    if (_selectedPresetKey.isNotEmpty) filled++;
    if (_titleController.text.trim().isNotEmpty) filled++;
    if (_selectedCategory.isNotEmpty && _selectedCategory != "Select..") {
      filled++;
    }
    if (_selectedStatus.isNotEmpty) filled++;
    return filled;
  }

  void _savePhotoChanges() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a photo title"),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_viewMode == PhotoGalleryViewMode.editPhoto && _selectedPhoto != null) {
      setState(() {
        _selectedPhoto!["title"] = title;
        _selectedPhoto!["presetKey"] = _selectedPresetKey.isNotEmpty
            ? _selectedPresetKey
            : "laboratory";
        _selectedPhoto!["category"] = _selectedCategory != "Select.."
            ? _selectedCategory
            : "Labs & Library";
        _selectedPhoto!["caption"] = _captionController.text.trim();
        _selectedPhoto!["featureOnHome"] = _featureOnHome;
        _selectedPhoto!["status"] = _selectedStatus;
        _selectedPhoto!["statusType"] = _selectedStatus.toLowerCase();
        _selectedPhoto!["updated"] = "24 Nov 2026";
        _selectedPhoto!["version"] =
            (_selectedPhoto!["version"] as int? ?? 1) + 1;
        _viewMode = PhotoGalleryViewMode.list;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Photo ${_selectedPhoto!["id"]} updated successfully!"),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    } else {
      // Add Photo
      final newId = "GAL-${1016 + _photos.length}";
      final newPhoto = {
        "id": newId,
        "presetKey": _selectedPresetKey.isNotEmpty
            ? _selectedPresetKey
            : "main_building",
        "title": title,
        "category": _selectedCategory != "Select.."
            ? _selectedCategory
            : "Campus",
        "caption": _captionController.text.trim(),
        "featureOnHome": _featureOnHome,
        "status": _selectedStatus,
        "statusType": _selectedStatus.toLowerCase(),
        "updated": "24 Nov 2026",
        "version": 1,
      };

      setState(() {
        _photos.insert(0, newPhoto);
        _viewMode = PhotoGalleryViewMode.list;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Photo '$title' added to gallery ($newId)!"),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    }
  }

  int _getCountForCategory(String category) {
    if (category == "All") return _photos.length;
    return _photos
        .where((p) =>
            (p["status"] as String? ?? "").toLowerCase() ==
            category.toLowerCase())
        .length;
  }

  List<Map<String, dynamic>> _getFilteredPhotos() {
    final query = _searchController.text.trim().toLowerCase();
    final selectedCat = _filterCategories[_selectedFilterIndex].toLowerCase();

    return _photos.where((p) {
      final status = (p["status"] as String? ?? "").toLowerCase();
      if (selectedCat != "all" && status != selectedCat) {
        return false;
      }

      if (query.isNotEmpty) {
        final title = (p["title"] as String? ?? "").toLowerCase();
        final id = (p["id"] as String? ?? "").toLowerCase();
        final cat = (p["category"] as String? ?? "").toLowerCase();
        return title.contains(query) || id.contains(query) || cat.contains(query);
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5),
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
                // 1. HERO BLUEPRINT BANNER
                _buildHeroBanner(constraints.maxWidth),
                const SizedBox(height: 18),

                // 2. VIEW CONTENT
                if (_viewMode == PhotoGalleryViewMode.addPhoto)
                  _buildAddPhotoView(constraints.maxWidth)
                else if (_viewMode == PhotoGalleryViewMode.editPhoto &&
                    _selectedPhoto != null)
                  _buildEditPhotoView(constraints.maxWidth)
                else if (_viewMode == PhotoGalleryViewMode.viewPhoto &&
                    _selectedPhoto != null)
                  _buildViewPhotoDetails(constraints.maxWidth)
                else ...[
                  // Filter Pills Bar (All 3, Published 3, Draft 0)
                  _buildFilterPills(),
                  const SizedBox(height: 16),

                  // Search Card with records badge
                  _buildSearchAndCounterCard(),
                  const SizedBox(height: 14),

                  // Table of Photos
                  _buildPhotosTable(constraints.maxWidth),
                ],
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
  Widget _buildHeroBanner(double maxWidth) {
    final isCompact = maxWidth < 700;

    String title;
    String subtitle;
    List<Widget> crumbs;

    if (_viewMode == PhotoGalleryViewMode.addPhoto) {
      title = "Add photo";
      subtitle = "Fill in the details below. Fields marked * are required.";
      crumbs = [
        _buildBreadcrumbText("Home"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("College Website"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Add photo"),
        _buildBreadcrumbSeparator(),
        Text(
          "New photo",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ];
    } else if (_viewMode == PhotoGalleryViewMode.editPhoto &&
        _selectedPhoto != null) {
      final photoId = _selectedPhoto!["id"] as String;
      title = "Edit photo · $photoId";
      subtitle =
          "Update the details below. Changes are validated, versioned and recorded in the audit log.";
      crumbs = [
        _buildBreadcrumbText("Home", onTap: () => setState(() => _viewMode = PhotoGalleryViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("College Website", onTap: () => setState(() => _viewMode = PhotoGalleryViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("Edit photo · $photoId"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText(photoId),
        _buildBreadcrumbSeparator(),
        Text(
          "Edit",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ];
    } else if (_viewMode == PhotoGalleryViewMode.viewPhoto &&
        _selectedPhoto != null) {
      final photoId = _selectedPhoto!["id"] as String;
      final photoTitle = _selectedPhoto!["title"] as String;
      final photoCategory = _selectedPhoto!["category"] as String;
      title = photoTitle;
      subtitle = photoCategory;
      crumbs = [
        _buildBreadcrumbText("Home", onTap: () => setState(() => _viewMode = PhotoGalleryViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("College Website", onTap: () => setState(() => _viewMode = PhotoGalleryViewMode.list)),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText(photoTitle),
        _buildBreadcrumbSeparator(),
        Text(
          photoId,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ];
    } else {
      title = "Photo Gallery";
      subtitle =
          "Upload and publish campus photos shown on the public college website.";
      crumbs = [
        _buildBreadcrumbText("Home"),
        _buildBreadcrumbSeparator(),
        _buildBreadcrumbText("College Website"),
        _buildBreadcrumbSeparator(),
        Text(
          "Photo Gallery",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ];
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2865),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: crumbs,
                  ),
                  const SizedBox(height: 14),

                  if (isCompact)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroTitleBlock(title, subtitle),
                        const SizedBox(height: 14),
                        _buildHeroActionButton(),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildHeroTitleBlock(title, subtitle)),
                        const SizedBox(width: 16),
                        _buildHeroActionButton(),
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

  Widget _buildBreadcrumbText(String text, {VoidCallback? onTap}) {
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
      );
    }
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 11.5,
        fontWeight: FontWeight.w400,
        color: Colors.white.withValues(alpha: 0.75),
      ),
    );
  }

  Widget _buildBreadcrumbSeparator() {
    return Icon(Icons.chevron_right_rounded,
        size: 13, color: Colors.white.withValues(alpha: 0.5));
  }

  Widget _buildHeroTitleBlock(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF2E3B7D),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.file_upload_outlined,
              color: Color(0xFFFBBF24),
              size: 22,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E3B7D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "COLLEGE WEBSITE",
                      style: GoogleFonts.poppins(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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
                title,
                softWrap: true,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                softWrap: true,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFFCBD5E1),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroActionButton() {
    if (_viewMode == PhotoGalleryViewMode.viewPhoto && _selectedPhoto != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _initFormForEdit(_selectedPhoto!);
              setState(() => _viewMode = PhotoGalleryViewMode.editPhoto);
            },
            icon: const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF0F172A)),
            label: Text(
              "Edit",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEAB308),
              foregroundColor: const Color(0xFF0F172A),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: () => _confirmDelete(_selectedPhoto!),
            icon: const Icon(Icons.delete_outline_rounded, size: 14, color: Colors.white),
            label: Text(
              "Delete",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      );
    }

    if (_viewMode == PhotoGalleryViewMode.addPhoto ||
        _viewMode == PhotoGalleryViewMode.editPhoto) {
      return OutlinedButton.icon(
        onPressed: () => setState(() => _viewMode = PhotoGalleryViewMode.list),
        icon:
            const Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white),
        label: Text(
          "Back to gallery",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF64748B)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: () {
        _initFormForAdd();
        setState(() => _viewMode = PhotoGalleryViewMode.addPhoto);
      },
      icon: const Icon(Icons.add_rounded, size: 16, color: Color(0xFF0F172A)),
      label: Text(
        "Add photo",
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFBBF24),
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. FILTER PILLS (Image 1)
  // ===========================================================================
  Widget _buildFilterPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_filterCategories.length, (index) {
          final cat = _filterCategories[index];
          final count = _getCountForCategory(cat);
          final isSelected = _selectedFilterIndex == index;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => setState(() => _selectedFilterIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2E3B7D) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2E3B7D)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cat,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.22)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "$count",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
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
  // 3. SEARCH & COUNTER CARD (Image 1)
  // ===========================================================================
  Widget _buildSearchAndCounterCard() {
    final filteredCount = _getFilteredPhotos().length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 18, color: Color(0xFF94A3B8)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF0F172A),
              ),
              decoration: InputDecoration(
                hintText: "Search by name, ID or title...",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_rounded,
                  size: 16, color: Color(0xFF94A3B8)),
              onPressed: () => setState(() => _searchController.clear()),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              "$filteredCount records",
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. PHOTOS DATA TABLE (Image 1)
  // ===========================================================================
  Widget _buildPhotosTable(double screenWidth) {
    final photos = _getFilteredPhotos();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: DataTable(
                horizontalMargin: 16,
                columnSpacing: 26,
                headingRowHeight: 44,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF7F4EE)),
                columns: [
                  _buildTableColumnHeader("ID"),
                  _buildTableColumnHeader("IMAGE"),
                  _buildTableColumnHeader("TITLE"),
                  _buildTableColumnHeader("CATEGORY"),
                  _buildTableColumnHeader("STATUS"),
                  _buildTableColumnHeader("UPDATED"),
                  _buildTableColumnHeader("ACTIONS"),
                ],
                rows: photos.map((p) => _buildTableRow(p)).toList(),
              ),
            ),
          ),
          // Footer pagination row matching Image 1
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Page 1 of 1",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text("< Prev",
                          style: GoogleFonts.poppins(fontSize: 11.5)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text("Next >",
                          style: GoogleFonts.poppins(fontSize: 11.5)),
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

  DataColumn _buildTableColumnHeader(String label) {
    return DataColumn(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  DataRow _buildTableRow(Map<String, dynamic> p) {
    final status = p["status"] as String? ?? "Published";
    final isPublished = status == "Published";

    return DataRow(
      cells: [
        // ID
        DataCell(
          Text(
            p["id"] as String,
            style: GoogleFonts.sourceCodePro(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
        // Image Thumbnail
        DataCell(
          Container(
            width: 58,
            height: 38,
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: _buildPresetThumbnail(p["presetKey"] as String? ?? "main_building"),
            ),
          ),
        ),
        // Title
        DataCell(
          InkWell(
            onTap: () {
              setState(() {
                _selectedPhoto = p;
                _viewMode = PhotoGalleryViewMode.viewPhoto;
              });
            },
            child: Text(
              p["title"] as String,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
        ),
        // Category Pill (Soft blue/purple pill in Image 1)
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              p["category"] as String,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4F46E5),
              ),
            ),
          ),
        ),
        // Status Pill (Soft teal pill in Image 1)
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: isPublished
                  ? const Color(0xFFCCFBF1)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isPublished
                    ? const Color(0xFF0D9488)
                    : const Color(0xFF64748B),
              ),
            ),
          ),
        ),
        // Updated
        DataCell(
          Text(
            p["updated"] as String,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
        // Actions
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility_outlined,
                    size: 17, color: Color(0xFF2563EB)),
                tooltip: "View Details",
                onPressed: () {
                  setState(() {
                    _selectedPhoto = p;
                    _viewMode = PhotoGalleryViewMode.viewPhoto;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    size: 17, color: Color(0xFFD97706)),
                tooltip: "Edit Photo",
                onPressed: () {
                  _initFormForEdit(p);
                  setState(() => _viewMode = PhotoGalleryViewMode.editPhoto);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 17, color: Color(0xFFEF4444)),
                tooltip: "Delete Record",
                onPressed: () => _confirmDelete(p),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. VIEW PHOTO DETAILS (Matching User Reference Image)
  // ===========================================================================
  Widget _buildViewPhotoDetails(double maxWidth) {
    if (_selectedPhoto == null) {
      return const SizedBox();
    }
    final photo = _selectedPhoto!;
    final isStacked = maxWidth < 950;

    final leftCard = _buildPhotoDetailsCard(photo);
    final rightColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildIdentityCard(photo),
        const SizedBox(height: 16),
        _buildRecordHistoryCard(photo),
        const SizedBox(height: 16),
        _buildBackToGalleryButton(),
      ],
    );

    if (isStacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          leftCard,
          const SizedBox(height: 20),
          rightColumn,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: leftCard),
        const SizedBox(width: 20),
        SizedBox(width: 290, child: rightColumn),
      ],
    );
  }

  Widget _buildPhotoDetailsCard(Map<String, dynamic> photo) {
    final title = photo["title"] as String? ?? "—";
    final category = photo["category"] as String? ?? "Labs & Library";
    final caption = (photo["caption"] as String? ?? "").trim();
    final featureOnHome = photo["featureOnHome"] as bool? ?? false;
    final status = photo["status"] as String? ?? "Published";
    final presetKey = photo["presetKey"] as String? ?? "laboratory";

    return Container(
      padding: const EdgeInsets.all(24),
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
            "Photo",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "IMAGE",
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 72,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: _buildPresetThumbnail(presetKey),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, colConstraints) {
              final isNarrow = colConstraints.maxWidth < 500;
              final col1 = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailField("TITLE", title),
                  const SizedBox(height: 22),
                  _buildDetailField(
                    "CAPTION",
                    caption.isNotEmpty ? caption : "—",
                  ),
                  const SizedBox(height: 22),
                  _buildDetailField(
                    "FEATURE ON THE COLLEGE HOME PAGE",
                    featureOnHome ? "Yes" : "No",
                  ),
                ],
              );

              final col2 = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CATEGORY",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4F46E5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    "STATUS",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFBF1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D9488),
                      ),
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    col1,
                    const SizedBox(height: 22),
                    col2,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: col1),
                  const SizedBox(width: 24),
                  Expanded(child: col2),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: const Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildIdentityCard(Map<String, dynamic> photo) {
    final title = photo["title"] as String? ?? "Photo";
    final initial =
        title.trim().isNotEmpty ? title.trim()[0].toUpperCase() : "P";
    final id = photo["id"] as String? ?? "";
    final status = photo["status"] as String? ?? "Published";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2865),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            id,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFCCFBF1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0D9488),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFDDD6FE)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.account_balance_outlined,
                  size: 12,
                  color: Color(0xFF7C3AED),
                ),
                const SizedBox(width: 5),
                Text(
                  "Anna Institute of Technology",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF7C3AED),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordHistoryCard(Map<String, dynamic> photo) {
    final updated = photo["updated"] as String? ?? "21 Oct 2026";
    final version = photo["version"] ?? 2;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
            "Record history",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          _buildHistoryRow(
            icon: Icons.calendar_today_outlined,
            label: "Created",
            value: "29 Sept 2026",
          ),
          const SizedBox(height: 12),
          _buildHistoryRow(
            icon: Icons.history_rounded,
            label: "Last updated",
            value: updated,
          ),
          const SizedBox(height: 12),
          _buildHistoryRow(
            icon: Icons.layers_outlined,
            label: "Version",
            value: "$version",
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF5EE),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: const Color(0xFF78716C)),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildBackToGalleryButton() {
    return InkWell(
      onTap: () => setState(() => _viewMode = PhotoGalleryViewMode.list),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back, size: 14, color: Color(0xFF334155)),
            const SizedBox(width: 8),
            Text(
              "Back to Gallery",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. ADD PHOTO VIEW (Images 2 & 3)
  // ===========================================================================
  Widget _buildAddPhotoView(double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    final leftFormContent = _buildPhotoStep1Card(isEdit: false);
    final rightSidebarContent = _buildSidebarSummaryCard(isEdit: false);

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: leftFormContent),
          const SizedBox(width: 20),
          Expanded(flex: 3, child: rightSidebarContent),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        rightSidebarContent,
        const SizedBox(height: 18),
        leftFormContent,
      ],
    );
  }

  // ===========================================================================
  // 6. EDIT PHOTO VIEW (Images 4 & 5)
  // ===========================================================================
  Widget _buildEditPhotoView(double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    // College affiliation alert banner
    final collegeNoticeBanner = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_outlined,
              size: 16, color: Color(0xFF7E22CE)),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF581C87),
                ),
                children: [
                  const TextSpan(text: "Belongs to "),
                  TextSpan(
                    text: "Anna Institute of Technology",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(
                      text: " — records cannot be moved between colleges."),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final leftFormContent = _buildPhotoStep1Card(isEdit: true);
    final rightSidebarContent = _buildSidebarSummaryCard(isEdit: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        collegeNoticeBanner,
        const SizedBox(height: 16),
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 7, child: leftFormContent),
              const SizedBox(width: 20),
              Expanded(flex: 3, child: rightSidebarContent),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              rightSidebarContent,
              const SizedBox(height: 18),
              leftFormContent,
            ],
          ),
      ],
    );
  }

  // Step 1: Photo Card (Images 2, 3, 4, 5)
  Widget _buildPhotoStep1Card({required bool isEdit}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // Header with Icon
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.person_outline_rounded,
                      size: 16, color: Color(0xFF4F46E5)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Photo",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    "Step 1 of 1",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Image * field label
          Text(
            "Image *",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          // Dropzone or Image Preview container
          _buildImagePreviewOrDropzone(),
          const SizedBox(height: 10),

          // Action buttons: Upload image & Campus library (+ Remove if has image)
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedPresetKey = "main_building";
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mock upload: Campus image loaded"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.upload_rounded,
                    size: 15, color: Colors.white),
                label: Text(
                  "Upload image",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _showLibraryGrid = !_showLibraryGrid;
                  });
                },
                icon: Icon(Icons.grid_view_rounded,
                    size: 15,
                    color: _showLibraryGrid
                        ? const Color(0xFFD97706)
                        : const Color(0xFF334155)),
                label: Text(
                  "Campus library",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _showLibraryGrid
                        ? const Color(0xFFD97706)
                        : const Color(0xFF334155),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  side: BorderSide(
                    color: _showLibraryGrid
                        ? const Color(0xFFFBBF24)
                        : const Color(0xFFCBD5E1),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              if (_selectedPresetKey.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedPresetKey = "";
                    });
                  },
                  icon: const Icon(Icons.close_rounded,
                      size: 14, color: Color(0xFF64748B)),
                  label: Text(
                    "Remove",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "PNG, JPEG or WebP, up to 2 MB. Files are checked before and after upload.",
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 14),

          // Campus library drawer if open (Image 3)
          if (_showLibraryGrid) ...[
            _buildCampusLibraryDrawer(),
            const SizedBox(height: 16),
          ],

          // Title * and Category *
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormTextField(
                  label: "Title *",
                  hint: "Laboratories",
                  controller: _titleController,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildFormDropdown(
                  label: "Category *",
                  value: _selectedCategory,
                  items: _categoryOptions,
                  onChanged: (v) => setState(() => _selectedCategory = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Caption
          _buildFormTextArea(
            label: "Caption",
            hint: "",
            controller: _captionController,
          ),
          const SizedBox(height: 16),

          // Feature on the college home page Switch & Status * Dropdown
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Feature on the college home page",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      Switch(
                        value: _featureOnHome,
                        activeThumbColor: const Color(0xFF1E2865),
                        onChanged: (v) => setState(() => _featureOnHome = v),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormDropdown(
                      label: "Status *",
                      value: _selectedStatus,
                      items: _statusOptions,
                      onChanged: (v) => setState(() => _selectedStatus = v!),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Only published photos appear on the public college website.",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Image Preview or Dropzone area (Images 2, 4)
  Widget _buildImagePreviewOrDropzone() {
    if (_selectedPresetKey.isNotEmpty) {
      return Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: _buildPresetThumbnail(_selectedPresetKey),
        ),
      );
    }

    // Empty Dashed Grid Dropzone (Image 2)
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFCBD5E1),
          style: BorderStyle.solid,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _DropzoneGridPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.image_outlined,
                    size: 38, color: Color(0xFF64748B)),
                const SizedBox(height: 8),
                Text(
                  "Drop an image here, upload one, or pick from the library",
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
    );
  }

  // Campus Library 8 Presets Grid (Image 3)
  Widget _buildCampusLibraryDrawer() {
    return Container(
      width: double.infinity,
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
            "Select from Campus Library",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardW = constraints.maxWidth >= 700
                  ? (constraints.maxWidth - 36) / 4
                  : constraints.maxWidth >= 450
                      ? (constraints.maxWidth - 12) / 2
                      : constraints.maxWidth;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _campusPresets.map((preset) {
                  final isSelected = _selectedPresetKey == preset["key"];

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPresetKey = preset["key"]!;
                        if (_titleController.text.isEmpty) {
                          _titleController.text = preset["title"]!;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: cardW,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(7)),
                            child: SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: _buildPresetThumbnail(preset["key"]!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Text(
                              preset["title"]!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFF2563EB)
                                    : const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // Right Sidebar Summary Card (Images 2, 4)
  Widget _buildSidebarSummaryCard({required bool isEdit}) {
    final filledCount = _calculateRequiredFieldsFilled();
    const totalRequired = 4;
    final progress = filledCount / totalRequired;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isEdit ? "Editing photo" : "New photo",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Required fields progress indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Required fields",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "$filledCount/$totalRequired",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: filledCount == totalRequired
                      ? const Color(0xFF0D9488)
                      : const Color(0xFF1E2865),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(
                filledCount == totalRequired
                    ? const Color(0xFF0D9488)
                    : const Color(0xFF1E2865),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Validation Note
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle_outline_rounded,
                  size: 15, color: Color(0xFF0D9488)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Validated in the browser and on the server",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Audit log / Version note
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.history_rounded,
                  size: 15, color: Color(0xFF64748B)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEdit
                      ? "Version ${_selectedPhoto?["version"] ?? 2} — conflicting edits are blocked"
                      : "Every change is audit-logged",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Primary button: Save changes (lavender) OR Create photo (navy)
          ElevatedButton.icon(
            onPressed: _savePhotoChanges,
            icon: Icon(
              isEdit ? Icons.save_outlined : Icons.check_rounded,
              size: 16,
              color: Colors.white,
            ),
            label: Text(
              isEdit ? "Save changes" : "Create photo",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isEdit
                  ? const Color(0xFF9399D4)
                  : const Color(0xFF1E2865),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Cancel button
          OutlinedButton(
            onPressed: () {
              setState(() => _viewMode = PhotoGalleryViewMode.list);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FORM FIELD HELPERS
  // ===========================================================================
  Widget _buildFormTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    VoidCallback? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: (_) => onChanged?.call(),
          style:
              GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF94A3B8),
            ),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
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
      ],
    );
  }

  Widget _buildFormDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : items.first,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF0F172A),
              ),
              items: items.map((it) {
                return DropdownMenuItem<String>(
                  value: it,
                  child: Text(
                    it,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: it.startsWith("Select")
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormTextArea({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 3,
          style:
              GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: 11.5, color: const Color(0xFF94A3B8)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
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
      ],
    );
  }

  // ===========================================================================
  // PRESET THUMBNAILS (Images 1, 3, 4)
  // ===========================================================================
  Widget _buildPresetThumbnail(String key) {
    switch (key) {
      case "laboratory":
        return CustomPaint(painter: _LaboratoryIllustrationPainter());
      case "campus_photo":
        return CustomPaint(painter: _CampusPhotoIllustrationPainter());
      case "main_building":
        return CustomPaint(painter: _MainBuildingIllustrationPainter());
      case "hospital":
        return CustomPaint(painter: _HospitalIllustrationPainter());
      case "library":
        return CustomPaint(painter: _LibraryIllustrationPainter());
      case "classroom":
        return CustomPaint(painter: _ClassroomIllustrationPainter());
      case "sports":
        return CustomPaint(painter: _SportsIllustrationPainter());
      case "cultural":
        return CustomPaint(painter: _CulturalIllustrationPainter());
      case "graduation":
        return CustomPaint(painter: _GraduationIllustrationPainter());
      default:
        return CustomPaint(painter: _MainBuildingIllustrationPainter());
    }
  }

  // ===========================================================================
  // MODALS: DELETE
  // ===========================================================================
  void _confirmDelete(Map<String, dynamic> photo) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete Photo?",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text(
          "Are you sure you want to remove '${photo["title"]}' (${photo["id"]}) from the photo gallery? This action cannot be undone.",
          style: GoogleFonts.poppins(fontSize: 12.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _photos.removeWhere((p) => p["id"] == photo["id"]);
                if (_viewMode == PhotoGalleryViewMode.viewPhoto) {
                  _viewMode = PhotoGalleryViewMode.list;
                  _selectedPhoto = null;
                }
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Photo '${photo["title"]}' deleted"),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// VECTOR ILLUSTRATION PAINTERS FOR CAMPUS PRESETS (Images 1, 3, 4)
// =============================================================================

// 1. Laboratory Illustration (Computers, Oscilloscope, Waveform)
class _LaboratoryIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background wall
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFFF1F5F9));

    // Wave chart on wall
    final chartRect = Rect.fromLTWH(w * 0.1, h * 0.08, w * 0.8, h * 0.28);
    canvas.drawRRect(
      RRect.fromRectAndRadius(chartRect, const Radius.circular(4)),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(chartRect, const Radius.circular(4)),
      Paint()
        ..color = const Color(0xFFE2E8F0)
        ..style = PaintingStyle.stroke,
    );
    final wavePath = Path()
      ..moveTo(chartRect.left + 10, chartRect.top + 20)
      ..lineTo(chartRect.left + 50, chartRect.top + 8)
      ..lineTo(chartRect.left + 90, chartRect.top + 24)
      ..lineTo(chartRect.left + 140, chartRect.top + 10)
      ..lineTo(chartRect.left + 190, chartRect.top + 18)
      ..lineTo(chartRect.right - 10, chartRect.top + 12);
    canvas.drawPath(
      wavePath,
      Paint()
        ..color = const Color(0xFF4F46E5)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    // Workbench Table
    final tableY = h * 0.72;
    canvas.drawRect(Rect.fromLTWH(w * 0.05, tableY, w * 0.9, h * 0.08),
        Paint()..color = const Color(0xFF1E2865));
    // Table legs
    canvas.drawRect(Rect.fromLTWH(w * 0.1, tableY, w * 0.03, h - tableY),
        Paint()..color = const Color(0xFF1E2865));
    canvas.drawRect(Rect.fromLTWH(w * 0.6, tableY, w * 0.03, h - tableY),
        Paint()..color = const Color(0xFF1E2865));

    // Monitor 1 (Teal)
    final m1 = Rect.fromLTWH(w * 0.12, tableY - (h * 0.32), w * 0.18, h * 0.28);
    canvas.drawRRect(RRect.fromRectAndRadius(m1, const Radius.circular(3)),
        Paint()..color = const Color(0xFF14B8A6));
    canvas.drawRect(Rect.fromLTWH(m1.center.dx - 2, m1.bottom, 4, 10),
        Paint()..color = const Color(0xFF0F766E));

    // Monitor 2 (Blue)
    final m2 = Rect.fromLTWH(w * 0.35, tableY - (h * 0.34), w * 0.20, h * 0.30);
    canvas.drawRRect(RRect.fromRectAndRadius(m2, const Radius.circular(3)),
        Paint()..color = const Color(0xFF818CF8));
    canvas.drawRect(Rect.fromLTWH(m2.center.dx - 2, m2.bottom, 4, 10),
        Paint()..color = const Color(0xFF4338CA));

    // Electronics device (Green box with dial)
    final dev = Rect.fromLTWH(w * 0.65, tableY - (h * 0.24), w * 0.22, h * 0.20);
    canvas.drawRRect(RRect.fromRectAndRadius(dev, const Radius.circular(4)),
        Paint()..color = const Color(0xFF0D9488));
    canvas.drawCircle(Offset(dev.left + 15, dev.center.dy), 6,
        Paint()..color = const Color(0xFFFBBF24));

    // Two students underneath/seated
    canvas.drawCircle(Offset(w * 0.28, tableY + 22), 12,
        Paint()..color = const Color(0xFFB45309));
    canvas.drawCircle(Offset(w * 0.52, tableY + 22), 12,
        Paint()..color = const Color(0xFFD97706));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 2. Brick Campus Photo Illustration (Row 2 in Image 1)
class _CampusPhotoIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sky
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFF38BDF8));

    // Red brick Victorian college building with arch windows
    final bldg = Rect.fromLTWH(w * 0.15, h * 0.25, w * 0.7, h * 0.75);
    canvas.drawRect(bldg, Paint()..color = const Color(0xFF991B1B));

    // Towers on left & right
    canvas.drawRect(Rect.fromLTWH(w * 0.12, h * 0.12, w * 0.16, h * 0.88),
        Paint()..color = const Color(0xFF7F1D1D));
    canvas.drawRect(Rect.fromLTWH(w * 0.72, h * 0.12, w * 0.16, h * 0.88),
        Paint()..color = const Color(0xFF7F1D1D));

    // Central Dome / Clock
    canvas.drawCircle(Offset(w * 0.5, h * 0.25), w * 0.12,
        Paint()..color = const Color(0xFF991B1B));
    canvas.drawCircle(Offset(w * 0.5, h * 0.25), 6,
        Paint()..color = const Color(0xFFFEF3C7));

    // Windows
    final winPaint = Paint()..color = const Color(0xFFFEF08A);
    for (double y = h * 0.38; y < h * 0.8; y += 18) {
      for (double x = w * 0.32; x < w * 0.68; x += 16) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(x, y, 8, 12), const Radius.circular(2)),
          winPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 3. Main Building Illustration (Dusk sky, moon, building)
class _MainBuildingIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Dusk Sky
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF312E81));

    // Moon
    canvas.drawCircle(Offset(w * 0.75, h * 0.3), 14,
        Paint()..color = const Color(0xFFFDE68A));

    // Ground
    canvas.drawRect(Rect.fromLTWH(0, h * 0.75, w, h * 0.25),
        Paint()..color = const Color(0xFF065F46));

    // Building
    final bldg = Rect.fromLTWH(w * 0.25, h * 0.35, w * 0.5, h * 0.45);
    canvas.drawRect(bldg, Paint()..color = const Color(0xFFF8FAFC));

    // Roof Triangle
    final roof = Path()
      ..moveTo(w * 0.22, h * 0.35)
      ..lineTo(w * 0.5, h * 0.18)
      ..lineTo(w * 0.78, h * 0.35)
      ..close();
    canvas.drawPath(roof, Paint()..color = const Color(0xFFDC2626));

    // Clock
    canvas.drawCircle(Offset(w * 0.5, h * 0.28), 6,
        Paint()..color = const Color(0xFFFDE68A));

    // Door
    canvas.drawRect(Rect.fromLTWH(w * 0.46, h * 0.62, w * 0.08, h * 0.18),
        Paint()..color = const Color(0xFF1E293B));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 4. Hospital Illustration
class _HospitalIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sky
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF67E8F9));

    // Building
    final bldg = Rect.fromLTWH(w * 0.15, h * 0.28, w * 0.65, h * 0.58);
    canvas.drawRect(bldg, Paint()..color = Colors.white);

    // Red Cross on top
    canvas.drawRect(Rect.fromLTWH(w * 0.46, h * 0.34, 12, 4),
        Paint()..color = const Color(0xFFDC2626));
    canvas.drawRect(Rect.fromLTWH(w * 0.46 + 4, h * 0.30, 4, 12),
        Paint()..color = const Color(0xFFDC2626));

    // Ambulance on right
    final amb = Rect.fromLTWH(w * 0.76, h * 0.70, w * 0.18, h * 0.18);
    canvas.drawRRect(RRect.fromRectAndRadius(amb, const Radius.circular(3)),
        Paint()..color = Colors.white);
    canvas.drawCircle(Offset(amb.left + 6, amb.bottom), 3,
        Paint()..color = Colors.black87);
    canvas.drawCircle(Offset(amb.right - 6, amb.bottom), 3,
        Paint()..color = Colors.black87);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 5. Library Illustration
class _LibraryIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Warm background
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFFD97706).withValues(alpha: 0.3));

    // Bookshelf left
    canvas.drawRect(Rect.fromLTWH(w * 0.08, h * 0.15, w * 0.18, h * 0.75),
        Paint()..color = const Color(0xFF78350F));
    // Bookshelf right
    canvas.drawRect(Rect.fromLTWH(w * 0.74, h * 0.15, w * 0.18, h * 0.75),
        Paint()..color = const Color(0xFF78350F));

    // Arched Window center
    final win = Rect.fromLTWH(w * 0.38, h * 0.12, w * 0.24, h * 0.5);
    canvas.drawRRect(
        RRect.fromRectAndCorners(win,
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20)),
        Paint()..color = const Color(0xFFBAE6FD));

    // Table with 2 students
    canvas.drawRect(Rect.fromLTWH(w * 0.32, h * 0.65, w * 0.36, h * 0.2),
        Paint()..color = const Color(0xFF92400E));
    canvas.drawCircle(Offset(w * 0.40, h * 0.62), 8,
        Paint()..color = const Color(0xFFB45309));
    canvas.drawCircle(Offset(w * 0.60, h * 0.62), 8,
        Paint()..color = const Color(0xFFD97706));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 6. Classroom Illustration
class _ClassroomIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFFF1F5F9));

    // Blackboard
    final board = Rect.fromLTWH(w * 0.12, h * 0.15, w * 0.55, h * 0.5);
    canvas.drawRRect(RRect.fromRectAndRadius(board, const Radius.circular(4)),
        Paint()..color = const Color(0xFF064E3B));
    canvas.drawCircle(Offset(board.center.dx + 20, board.center.dy), 14,
        Paint()
          ..color = Colors.white70
          ..style = PaintingStyle.stroke);

    // Teacher
    canvas.drawCircle(Offset(w * 0.78, h * 0.42), 8,
        Paint()..color = const Color(0xFFB45309));
    canvas.drawLine(Offset(w * 0.78, h * 0.45), Offset(w * 0.65, h * 0.35),
        Paint()
          ..color = const Color(0xFFB45309)
          ..strokeWidth = 2);

    // Students at bottom
    for (double x = w * 0.18; x <= w * 0.62; x += 22) {
      canvas.drawCircle(Offset(x, h * 0.8), 7,
          Paint()..color = const Color(0xFFB45309));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 7. Sports Ground Illustration
class _SportsIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Sky
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF7DD3FC));

    // Stadium Oval Field
    final field = Rect.fromLTWH(w * 0.08, h * 0.25, w * 0.84, h * 0.68);
    canvas.drawOval(field, Paint()..color = const Color(0xFF15803D));

    // Cricket Pitch
    final pitch = Rect.fromLTWH(w * 0.44, h * 0.45, w * 0.12, h * 0.32);
    canvas.drawRect(pitch, Paint()..color = const Color(0xFFFEF3C7));

    // Players
    canvas.drawCircle(Offset(w * 0.42, h * 0.52), 5,
        Paint()..color = Colors.white);
    canvas.drawCircle(Offset(w * 0.58, h * 0.68), 5,
        Paint()..color = Colors.white);
    // Ball
    canvas.drawCircle(Offset(w * 0.52, h * 0.56), 2.5,
        Paint()..color = const Color(0xFFDC2626));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 8. Cultural Festival Illustration
class _CulturalIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Stage
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF0F172A));

    // Stage background & beams
    canvas.drawRect(Rect.fromLTWH(w * 0.15, h * 0.2, w * 0.7, h * 0.6),
        Paint()..color = const Color(0xFF4338CA));

    // Curtains
    final curtain = Paint()..color = const Color(0xFF991B1B);
    canvas.drawRect(Rect.fromLTWH(0, 0, w * 0.18, h * 0.8), curtain);
    canvas.drawRect(Rect.fromLTWH(w * 0.82, 0, w * 0.18, h * 0.8), curtain);

    // Dancers
    canvas.drawCircle(Offset(w * 0.44, h * 0.5), 6,
        Paint()..color = const Color(0xFFFBBF24));
    canvas.drawCircle(Offset(w * 0.56, h * 0.5), 6,
        Paint()..color = const Color(0xFF06B6D4));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 9. Graduation Day Illustration
class _GraduationIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Warm cream background
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFFFEF3C7).withValues(alpha: 0.5));

    // 3 Graduates
    final gradOffsets = [Offset(w * 0.28, h * 0.65), Offset(w * 0.50, h * 0.60), Offset(w * 0.72, h * 0.65)];
    for (final pos in gradOffsets) {
      // Head
      canvas.drawCircle(pos, 8, Paint()..color = const Color(0xFFB45309));
      // Mortarboard cap
      final cap = Path()
        ..moveTo(pos.dx - 12, pos.dy - 6)
        ..lineTo(pos.dx, pos.dy - 12)
        ..lineTo(pos.dx + 12, pos.dy - 6)
        ..lineTo(pos.dx, pos.dy)
        ..close();
      canvas.drawPath(cap, Paint()..color = const Color(0xFF0F172A));
    }

    // Confetti
    final confPaint = Paint()..color = const Color(0xFFFBBF24);
    canvas.drawCircle(Offset(w * 0.2, h * 0.25), 3, confPaint);
    canvas.drawCircle(Offset(w * 0.45, h * 0.18), 3, confPaint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.28), 3, confPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Dropzone Grid Painter
class _DropzoneGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1.0;

    const double step = 20.0;
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

// Blueprint Grid Painter
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const double step = 24.0;
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
