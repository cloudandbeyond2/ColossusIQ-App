import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AdmissionsViewMode {
  list,
  viewDetail,
  addApplication,
  editApplication,
}

class PrincipalStudentAdmissionsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalStudentAdmissionsScreen({super.key, this.onBack});

  @override
  State<PrincipalStudentAdmissionsScreen> createState() =>
      _PrincipalStudentAdmissionsScreenState();
}

class _PrincipalStudentAdmissionsScreenState
    extends State<PrincipalStudentAdmissionsScreen> {
  // Navigation mode
  AdmissionsViewMode _viewMode = AdmissionsViewMode.list;

  // Selected student for detail view or edit view
  Map<String, dynamic>? _selectedRecord;

  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  // 10 Status Filter Categories matching Image 10 & admissions funnel
  final List<String> _filterCategories = [
    "All",
    "Enquiry",
    "Applied",
    "Documents verified",
    "Shortlisted",
    "Offer sent",
    "Fee paid",
    "Enrolled",
    "Rejected",
    "Withdrawn",
  ];

  // 7 sequential funnel stages for the Admission progress bar (Images 1 & 2)
  final List<String> _funnelStages = [
    "Enquiry",
    "Applied",
    "Documents verified",
    "Shortlisted",
    "Offer sent",
    "Fee paid",
    "Enrolled",
  ];

  // Complete mock student admissions dataset matching Images 1, 2, 3, 10
  late List<Map<String, dynamic>> _records;

  // ---------------------------------------------------------------------------
  // FORM CONTROLLERS & STATE FOR ADD / EDIT (Images 3, 4, 5)
  // ---------------------------------------------------------------------------
  // Step 1: Applicant Details
  final TextEditingController _formFullNameCtrl = TextEditingController();
  final TextEditingController _formDobCtrl = TextEditingController();
  String _formGender = "Female";
  final TextEditingController _formEmailCtrl = TextEditingController();
  final TextEditingController _formMobileCtrl = TextEditingController();
  final TextEditingController _formCityCtrl = TextEditingController();
  String _formState = "Tamil Nadu";

  // Step 2: Academic Record
  String _formBoard = "State Board";
  final TextEditingController _formHscCtrl = TextEditingController();
  final TextEditingController _formCutoffCtrl = TextEditingController();

  // Step 3: Programme & Quota
  String _formProgram = "B.E. Electronics & Communication";
  String _formQuota = "Government";
  String _formCommunity = "BC";
  bool _formScholarship = true;
  bool _formHostel = true;

  // Step 4: Parent / Guardian
  final TextEditingController _formParentNameCtrl = TextEditingController();
  final TextEditingController _formParentMobileCtrl = TextEditingController();
  final TextEditingController _formParentOccupationCtrl =
      TextEditingController();

  // Step 5: Admission Status & Documents
  String _formStatus = "Enrolled";
  final Map<String, bool> _formDocuments = {
    "10th mark sheet": true,
    "12th mark sheet": true,
    "Transfer certificate": true,
    "Community certificate": true,
    "Passport photo": true,
    "Counselling allotment order": true,
  };
  final TextEditingController _formNotesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _records = [
      {
        "id": "ADM-26-1038",
        "name": "Jayasri",
        "mobile": "7418596522",
        "displayMobile": "••••••6522",
        "email": "jaya1@gmail.com",
        "dob": "4 Mar 1996",
        "dobStandard": "03/04/1996",
        "gender": "Female",
        "city": "Trichy",
        "state": "Tamil Nadu",
        "board": "State Board",
        "hsc": "83",
        "cutoff": "140",
        "program": "B.E. Electronics & Communication",
        "quota": "Government",
        "community": "BC",
        "scholarship": true,
        "hostel": true,
        "parentName": "Thiyagarajan",
        "parentMobile": "7485961230",
        "parentOccupation": "Business",
        "status": "Enrolled",
        "statusType": "enrolled",
        "created": "5 Nov 2026",
        "updated": "5 Nov 2026",
        "version": 6,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": true,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": true,
        },
        "notes": "",
      },
      {
        "id": "ADM-26-1037",
        "name": "Jayasri",
        "mobile": "7418596522",
        "displayMobile": "••••••6522",
        "email": "jaya1@gmail.com",
        "dob": "4 Mar 1996",
        "dobStandard": "03/04/1996",
        "gender": "Female",
        "city": "Trichy",
        "state": "Tamil Nadu",
        "board": "State Board",
        "hsc": "83",
        "cutoff": "140",
        "program": "B.E. Electronics & Communication",
        "quota": "Government",
        "community": "BC",
        "scholarship": true,
        "hostel": true,
        "parentName": "Thiyagarajan",
        "parentMobile": "7485961230",
        "parentOccupation": "Business",
        "status": "Applied",
        "statusType": "applied",
        "created": "5 Nov 2026",
        "updated": "5 Nov 2026",
        "version": 3,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": false,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": false,
        },
        "notes": "Direct application submitted.",
      },
      {
        "id": "ADM-26-1035",
        "name": "Kalaiyarasan",
        "mobile": "9840121222",
        "displayMobile": "••••••1222",
        "email": "kalaiyarasan.civil@gmail.com",
        "dob": "22 Aug 2007",
        "dobStandard": "22/08/2007",
        "gender": "Male",
        "city": "Coimbatore",
        "state": "Tamil Nadu",
        "board": "State Board",
        "hsc": "95",
        "cutoff": "191",
        "program": "B.E. Civil Engineering",
        "quota": "Government",
        "community": "BC",
        "scholarship": true,
        "hostel": true,
        "parentName": "Palanisamy K",
        "parentMobile": "9840121220",
        "parentOccupation": "Agriculture",
        "status": "Enrolled",
        "statusType": "enrolled",
        "created": "4 Nov 2026",
        "updated": "4 Nov 2026",
        "version": 5,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": true,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": true,
        },
        "notes": "First generation graduate tuition waiver verified and approved.",
      },
      {
        "id": "ADM-26-1031",
        "name": "Yugaprasanna G",
        "mobile": "9791038495",
        "displayMobile": "••••••8495",
        "email": "yugaprasanna.g@outlook.com",
        "dob": "3 Nov 2007",
        "dobStandard": "03/11/2007",
        "gender": "Male",
        "city": "Madurai",
        "state": "Tamil Nadu",
        "board": "State Board",
        "hsc": "56",
        "cutoff": "138",
        "program": "B.E. Computer Science & Engineering",
        "quota": "Management Quota",
        "community": "BC",
        "scholarship": false,
        "hostel": true,
        "parentName": "Ganesan R",
        "parentMobile": "9791038400",
        "parentOccupation": "Business Proprietor",
        "status": "Applied",
        "statusType": "applied",
        "created": "6 Oct 2026",
        "updated": "6 Oct 2026",
        "version": 2,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": false,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": false,
        },
        "notes": "Application form submitted. Academic counseling scheduled.",
      },
      {
        "id": "ADM-26-1001",
        "name": "Anand Kumar",
        "mobile": "9841040101",
        "displayMobile": "••••••0101",
        "email": "anand.kumar.cs@gmail.com",
        "dob": "10 Feb 2008",
        "dobStandard": "10/02/2008",
        "gender": "Male",
        "city": "Chennai",
        "state": "Tamil Nadu",
        "board": "CBSE",
        "hsc": "85",
        "cutoff": "182",
        "program": "B.E. Computer Science & Engineering",
        "quota": "Government",
        "community": "BC",
        "scholarship": false,
        "hostel": false,
        "parentName": "Rajendran K",
        "parentMobile": "9841040100",
        "parentOccupation": "Software Architect",
        "status": "Enrolled",
        "statusType": "enrolled",
        "created": "6 Oct 2026",
        "updated": "6 Oct 2026",
        "version": 5,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": true,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": true,
        },
        "notes": "Full fee paid online. Student ID card generated.",
      },
      {
        "id": "ADM-26-1004",
        "name": "Nisha Balan",
        "mobile": "9841040111",
        "displayMobile": "••••••0111",
        "email": "nisha.balan@gmail.com",
        "dob": "29 Jul 2007",
        "dobStandard": "29/07/2007",
        "gender": "Female",
        "city": "Salem",
        "state": "Tamil Nadu",
        "board": "State Board",
        "hsc": "88.4",
        "cutoff": "184.5",
        "program": "B.E. Computer Science & Engineering",
        "quota": "Government",
        "community": "BC",
        "scholarship": false,
        "hostel": false,
        "parentName": "Balanathan S",
        "parentMobile": "9841040110",
        "parentOccupation": "Government Service",
        "status": "Withdrawn",
        "statusType": "withdrawn",
        "created": "5 Oct 2026",
        "updated": "5 Oct 2026",
        "version": 4,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": false,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": false,
        },
        "notes": "Candidate opted for NIT Trichy through CSAB counselling round.",
      },
      {
        "id": "ADM-26-1003",
        "name": "Karthik Raja",
        "mobile": "9841040103",
        "displayMobile": "••••••0103",
        "email": "karthik.raja.26@yahoo.com",
        "dob": "17 Apr 2008",
        "dobStandard": "17/04/2008",
        "gender": "Male",
        "city": "Trichy",
        "state": "Tamil Nadu",
        "board": "CBSE",
        "hsc": "91",
        "cutoff": "189",
        "program": "B.E. Computer Science & Engineering",
        "quota": "Government",
        "community": "OC",
        "scholarship": false,
        "hostel": true,
        "parentName": "Raja S",
        "parentMobile": "9841040102",
        "parentOccupation": "Banking Professional",
        "status": "Withdrawn",
        "statusType": "withdrawn",
        "created": "5 Oct 2026",
        "updated": "5 Oct 2026",
        "version": 4,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": false,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": false,
        },
        "notes": "Withdrawn upon admission to BITS Pilani campus.",
      },
      {
        "id": "ADM-26-1002",
        "name": "Divya Ramesh",
        "mobile": "9841040102",
        "displayMobile": "••••••0102",
        "email": "divya.ramesh@gmail.com",
        "dob": "8 Dec 2007",
        "dobStandard": "08/12/2007",
        "gender": "Female",
        "city": "Vellore",
        "state": "Tamil Nadu",
        "board": "State Board",
        "hsc": "88",
        "cutoff": "183",
        "program": "B.E. Computer Science & Engineering",
        "quota": "Government",
        "community": "MBC",
        "scholarship": false,
        "hostel": true,
        "parentName": "Ramesh Kumar V",
        "parentMobile": "9841040100",
        "parentOccupation": "Professor",
        "status": "Withdrawn",
        "statusType": "withdrawn",
        "created": "5 Oct 2026",
        "updated": "5 Oct 2026",
        "version": 4,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": false,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": false,
        },
        "notes": "Withdrawn due to relocation of family to Bangalore.",
      },
      {
        "id": "ADM-26-1000",
        "name": "bala",
        "mobile": "9840129861",
        "displayMobile": "••••••9861",
        "email": "bala.student@college.edu",
        "dob": "15 Jun 2005",
        "dobStandard": "15/06/2005",
        "gender": "Male",
        "city": "Chennai",
        "state": "Tamil Nadu",
        "board": "State Board",
        "hsc": "92",
        "cutoff": "188.5",
        "program": "B.E. Computer Science & Engineering",
        "quota": "Government",
        "community": "BC",
        "scholarship": false,
        "hostel": false,
        "parentName": "S. Murugan",
        "parentMobile": "9840129860",
        "parentOccupation": "Civil Engineer",
        "status": "Enrolled",
        "statusType": "enrolled",
        "created": "5 Oct 2026",
        "updated": "5 Oct 2026",
        "version": 5,
        "documents": {
          "10th mark sheet": true,
          "12th mark sheet": true,
          "Transfer certificate": true,
          "Community certificate": true,
          "Passport photo": true,
          "Counselling allotment order": true,
        },
        "notes": "Student enrolled with roll number 27549861.",
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _formFullNameCtrl.dispose();
    _formDobCtrl.dispose();
    _formEmailCtrl.dispose();
    _formMobileCtrl.dispose();
    _formCityCtrl.dispose();
    _formHscCtrl.dispose();
    _formCutoffCtrl.dispose();
    _formParentNameCtrl.dispose();
    _formParentMobileCtrl.dispose();
    _formParentOccupationCtrl.dispose();
    _formNotesCtrl.dispose();
    super.dispose();
  }

  // Populate form with existing student record for Editing (Image 3, 4, 5)
  void _populateFormForEdit(Map<String, dynamic> r) {
    _formFullNameCtrl.text = r["name"] as String? ?? "";
    _formDobCtrl.text =
        (r["dobStandard"] as String?) ?? (r["dob"] as String? ?? "03/04/1996");
    _formGender = r["gender"] as String? ?? "Female";
    _formEmailCtrl.text = r["email"] as String? ?? "";
    _formMobileCtrl.text = r["mobile"] as String? ?? "";
    _formCityCtrl.text = r["city"] as String? ?? "";
    _formState = r["state"] as String? ?? "Tamil Nadu";

    _formBoard = r["board"] as String? ?? "State Board";
    _formHscCtrl.text = r["hsc"] as String? ?? "";
    _formCutoffCtrl.text = r["cutoff"] as String? ?? "";

    _formProgram = r["program"] as String? ?? "B.E. Electronics & Communication";
    _formQuota = r["quota"] as String? ?? "Government";
    _formCommunity = r["community"] as String? ?? "BC";
    _formScholarship = r["scholarship"] as bool? ?? true;
    _formHostel = r["hostel"] as bool? ?? true;

    _formParentNameCtrl.text = r["parentName"] as String? ?? "";
    _formParentMobileCtrl.text = r["parentMobile"] as String? ?? "";
    _formParentOccupationCtrl.text = r["parentOccupation"] as String? ?? "";

    _formStatus = r["status"] as String? ?? "Enrolled";

    final existingDocs = (r["documents"] as Map<String, dynamic>?) ?? {};
    _formDocuments.updateAll((key, _) => existingDocs[key] == true);

    _formNotesCtrl.text = r["notes"] as String? ?? "";
  }

  void _resetForm() {
    _formFullNameCtrl.clear();
    _formDobCtrl.clear();
    _formGender = "Female";
    _formEmailCtrl.clear();
    _formMobileCtrl.clear();
    _formCityCtrl.clear();
    _formState = "Tamil Nadu";
    _formBoard = "State Board";
    _formHscCtrl.clear();
    _formCutoffCtrl.clear();
    _formProgram = "B.E. Electronics & Communication";
    _formQuota = "Government";
    _formCommunity = "BC";
    _formScholarship = true;
    _formHostel = true;
    _formParentNameCtrl.clear();
    _formParentMobileCtrl.clear();
    _formParentOccupationCtrl.clear();
    _formStatus = "Applied";
    _formDocuments.updateAll((key, _) => false);
    _formNotesCtrl.clear();
  }

  // Calculate required fields filled (out of 14)
  int _calculateRequiredFieldsFilled() {
    int filled = 0;
    if (_formFullNameCtrl.text.trim().isNotEmpty) filled++;
    if (_formDobCtrl.text.trim().isNotEmpty) filled++;
    if (_formGender.isNotEmpty && _formGender != "Select gender") filled++;
    if (_formEmailCtrl.text.trim().isNotEmpty) filled++;
    if (_formMobileCtrl.text.trim().isNotEmpty) filled++;
    if (_formState.isNotEmpty) filled++;
    if (_formBoard.isNotEmpty) filled++;
    if (_formHscCtrl.text.trim().isNotEmpty) filled++;
    if (_formProgram.isNotEmpty) filled++;
    if (_formQuota.isNotEmpty) filled++;
    if (_formCommunity.isNotEmpty) filled++;
    if (_formParentNameCtrl.text.trim().isNotEmpty) filled++;
    if (_formParentMobileCtrl.text.trim().isNotEmpty) filled++;
    if (_formStatus.isNotEmpty) filled++;
    return filled;
  }

  void _saveEditedApplication() {
    if (_selectedRecord == null) return;
    final name = _formFullNameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the applicant's full name"),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    final rawMobile = _formMobileCtrl.text.trim();
    final masked = rawMobile.length >= 4
        ? "••••••${rawMobile.substring(rawMobile.length - 4)}"
        : "••••••6522";

    setState(() {
      _selectedRecord!["name"] = name;
      _selectedRecord!["dobStandard"] = _formDobCtrl.text.trim();
      _selectedRecord!["dob"] = _formDobCtrl.text.trim();
      _selectedRecord!["gender"] = _formGender;
      _selectedRecord!["email"] = _formEmailCtrl.text.trim();
      _selectedRecord!["mobile"] = rawMobile;
      _selectedRecord!["displayMobile"] = masked;
      _selectedRecord!["city"] = _formCityCtrl.text.trim();
      _selectedRecord!["state"] = _formState;

      _selectedRecord!["board"] = _formBoard;
      _selectedRecord!["hsc"] = _formHscCtrl.text.trim();
      _selectedRecord!["cutoff"] = _formCutoffCtrl.text.trim();

      _selectedRecord!["program"] = _formProgram;
      _selectedRecord!["quota"] = _formQuota;
      _selectedRecord!["community"] = _formCommunity;
      _selectedRecord!["scholarship"] = _formScholarship;
      _selectedRecord!["hostel"] = _formHostel;

      _selectedRecord!["parentName"] = _formParentNameCtrl.text.trim();
      _selectedRecord!["parentMobile"] = _formParentMobileCtrl.text.trim();
      _selectedRecord!["parentOccupation"] =
          _formParentOccupationCtrl.text.trim();

      _selectedRecord!["status"] = _formStatus;
      _selectedRecord!["statusType"] =
          _formStatus.toLowerCase().replaceAll(" ", "_");

      _selectedRecord!["documents"] = Map<String, bool>.from(_formDocuments);
      _selectedRecord!["notes"] = _formNotesCtrl.text.trim();

      _selectedRecord!["updated"] = "5 Nov 2026";
      _selectedRecord!["version"] =
          (_selectedRecord!["version"] as int? ?? 5) + 1;

      _viewMode = AdmissionsViewMode.viewDetail;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Changes saved for ${_selectedRecord!["id"]}!"),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  void _submitNewApplication() {
    final name = _formFullNameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the applicant's full name"),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    final newId = "ADM-26-${1040 + _records.length}";
    final rawMobile = _formMobileCtrl.text.trim();
    final masked = rawMobile.length >= 4
        ? "••••••${rawMobile.substring(rawMobile.length - 4)}"
        : "••••••0000";

    final newRec = {
      "id": newId,
      "name": name,
      "mobile": rawMobile.isNotEmpty ? rawMobile : "7418596522",
      "displayMobile": masked,
      "email": _formEmailCtrl.text.trim().isNotEmpty
          ? _formEmailCtrl.text.trim()
          : "$name@example.com",
      "dob": _formDobCtrl.text.trim().isNotEmpty
          ? _formDobCtrl.text.trim()
          : "4 Mar 1996",
      "dobStandard": _formDobCtrl.text.trim().isNotEmpty
          ? _formDobCtrl.text.trim()
          : "03/04/1996",
      "gender": _formGender,
      "city": _formCityCtrl.text.trim().isNotEmpty
          ? _formCityCtrl.text.trim()
          : "Trichy",
      "state": _formState,
      "board": _formBoard,
      "hsc": _formHscCtrl.text.trim().isNotEmpty
          ? _formHscCtrl.text.trim()
          : "83",
      "cutoff": _formCutoffCtrl.text.trim().isNotEmpty
          ? _formCutoffCtrl.text.trim()
          : "140",
      "program": _formProgram,
      "quota": _formQuota,
      "community": _formCommunity,
      "scholarship": _formScholarship,
      "hostel": _formHostel,
      "parentName": _formParentNameCtrl.text.trim().isNotEmpty
          ? _formParentNameCtrl.text.trim()
          : "Thiyagarajan",
      "parentMobile": _formParentMobileCtrl.text.trim().isNotEmpty
          ? _formParentMobileCtrl.text.trim()
          : "7485961230",
      "parentOccupation": _formParentOccupationCtrl.text.trim().isNotEmpty
          ? _formParentOccupationCtrl.text.trim()
          : "Business",
      "status": _formStatus,
      "statusType": _formStatus.toLowerCase().replaceAll(" ", "_"),
      "created": "5 Nov 2026",
      "updated": "5 Nov 2026",
      "version": 1,
      "documents": Map<String, bool>.from(_formDocuments),
      "notes": _formNotesCtrl.text.trim(),
    };

    setState(() {
      _records.insert(0, newRec);
      _selectedRecord = newRec;
      _viewMode = AdmissionsViewMode.viewDetail;
      _resetForm();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Application created for $name ($newId)!"),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  int _getCountForCategory(String category) {
    if (category == "All") return _records.length;
    return _records.where((r) {
      final s = (r["status"] as String? ?? "").toLowerCase();
      final cat = category.toLowerCase();
      if (cat == "documents verified") {
        return s.contains("verified") || s.contains("documents");
      }
      return s == cat;
    }).length;
  }

  List<Map<String, dynamic>> _getFilteredRecords() {
    final query = _searchController.text.trim().toLowerCase();
    final selectedCat = _filterCategories[_selectedFilterIndex].toLowerCase();

    return _records.where((r) {
      final status = (r["status"] as String? ?? "").toLowerCase();
      bool matchesCategory = true;
      if (selectedCat != "all") {
        if (selectedCat == "documents verified") {
          matchesCategory =
              status.contains("verified") || status.contains("documents");
        } else {
          matchesCategory = status == selectedCat;
        }
      }

      if (!matchesCategory) return false;

      if (query.isNotEmpty) {
        final name = (r["name"] as String? ?? "").toLowerCase();
        final id = (r["id"] as String? ?? "").toLowerCase();
        final hsc = (r["hsc"] as String? ?? "").toLowerCase();
        final program = (r["program"] as String? ?? "").toLowerCase();
        final community = (r["community"] as String? ?? "").toLowerCase();
        return name.contains(query) ||
            id.contains(query) ||
            hsc.contains(query) ||
            program.contains(query) ||
            community.contains(query);
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double horizPadding = constraints.maxWidth >= 900
                ? 28.0
                : constraints.maxWidth >= 600
                    ? 18.0
                    : 12.0;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Hero Blueprint Banner (Adapts according to viewMode)
                  _buildHeroBlueprintBanner(constraints.maxWidth),
                  const SizedBox(height: 18),

                  // 2. View Rendering
                  if (_viewMode == AdmissionsViewMode.viewDetail &&
                      _selectedRecord != null) ...[
                    _buildApplicationDetailView(
                        _selectedRecord!, constraints.maxWidth),
                  ] else if (_viewMode == AdmissionsViewMode.editApplication &&
                      _selectedRecord != null) ...[
                    _buildEditApplicationView(
                        _selectedRecord!, constraints.maxWidth),
                  ] else if (_viewMode == AdmissionsViewMode.addApplication) ...[
                    _buildAddApplicationView(constraints.maxWidth),
                  ] else ...[
                    // Filter Pills Bar (All 9, Enquiry 0, Applied 2, Enrolled 4, Withdrawn 3...)
                    _buildFilterPillsBar(),
                    const SizedBox(height: 16),

                    // Search and Records Count Input Card
                    _buildSearchAndCounterCard(),
                    const SizedBox(height: 14),

                    // Admissions Table
                    _buildAdmissionsTable(constraints.maxWidth),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Adapts across List, Detail, Edit, Add)
  // ===========================================================================
  Widget _buildHeroBlueprintBanner(double screenWidth) {
    final isCompact = screenWidth < 700;

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
            // Blueprint Grid overlay pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  _buildBreadcrumbs(),
                  const SizedBox(height: 14),

                  // Title row with icon and CTA
                  if (isCompact)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroTitleBlock(),
                        const SizedBox(height: 16),
                        _buildHeroActionButtons(),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildHeroTitleBlock()),
                        const SizedBox(width: 16),
                        _buildHeroActionButtons(),
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

  Widget _buildBreadcrumbs() {
    final List<Widget> crumbs = [
      Text(
        "Home",
        style: GoogleFonts.poppins(
          fontSize: 11.5,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.75),
        ),
      ),
      Icon(Icons.chevron_right_rounded,
          size: 13, color: Colors.white.withValues(alpha: 0.5)),
      Text(
        "Admissions",
        style: GoogleFonts.poppins(
          fontSize: 11.5,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.75),
        ),
      ),
    ];

    if (_viewMode == AdmissionsViewMode.list) {
      crumbs.addAll([
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          "Student Admissions",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ]);
    } else if (_viewMode == AdmissionsViewMode.viewDetail &&
        _selectedRecord != null) {
      crumbs.addAll([
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          _selectedRecord!["name"] as String,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          _selectedRecord!["id"] as String,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ]);
    } else if (_viewMode == AdmissionsViewMode.editApplication &&
        _selectedRecord != null) {
      crumbs.addAll([
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          "Edit application · ${_selectedRecord!["id"]}",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          _selectedRecord!["id"] as String,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          "Edit",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ]);
    } else if (_viewMode == AdmissionsViewMode.addApplication) {
      crumbs.addAll([
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          "Add application",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        Icon(Icons.chevron_right_rounded,
            size: 13, color: Colors.white.withValues(alpha: 0.5)),
        Text(
          "New application",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFBBF24),
          ),
        ),
      ]);
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      runSpacing: 4,
      children: crumbs,
    );
  }

  Widget _buildHeroTitleBlock() {
    String title;
    String subtitle;
    IconData icon;

    if (_viewMode == AdmissionsViewMode.viewDetail && _selectedRecord != null) {
      title = _selectedRecord!["name"] as String;
      subtitle =
          "${_selectedRecord!["program"]} · ${_selectedRecord!["quota"]}";
      icon = Icons.person_outline_rounded;
    } else if (_viewMode == AdmissionsViewMode.editApplication &&
        _selectedRecord != null) {
      title = "Edit application · ${_selectedRecord!["id"]}";
      subtitle =
          "Update the details below. Changes are validated, versioned and recorded in the audit log.";
      icon = Icons.person_add_alt_1_rounded;
    } else if (_viewMode == AdmissionsViewMode.addApplication) {
      title = "Add application";
      subtitle =
          "Enquiry -> application -> document verification -> shortlist -> offer -> fee -> enrolment.";
      icon = Icons.person_add_alt_1_rounded;
    } else {
      title = "Student Admissions";
      subtitle =
          "Enquiry -> application -> document verification -> shortlist -> offer -> fee -> enrolment.";
      icon = Icons.badge_outlined;
    }

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
          child: Center(
            child: Icon(
              icon,
              color: const Color(0xFFFBBF24),
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
                      "ADMISSIONS",
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

  Widget _buildHeroActionButtons() {
    if (_viewMode == AdmissionsViewMode.viewDetail && _selectedRecord != null) {
      return Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _populateFormForEdit(_selectedRecord!);
              setState(() => _viewMode = AdmissionsViewMode.editApplication);
            },
            icon: const Icon(Icons.edit_rounded,
                size: 15, color: Color(0xFF0F172A)),
            label: Text(
              "Edit",
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => _confirmDelete(_selectedRecord!),
            icon: const Icon(Icons.delete_outline_rounded,
                size: 15, color: Colors.white),
            label: Text(
              "Delete",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      );
    }

    if (_viewMode == AdmissionsViewMode.editApplication ||
        _viewMode == AdmissionsViewMode.addApplication) {
      return OutlinedButton.icon(
        onPressed: () => setState(() {
          if (_viewMode == AdmissionsViewMode.editApplication &&
              _selectedRecord != null) {
            _viewMode = AdmissionsViewMode.viewDetail;
          } else {
            _viewMode = AdmissionsViewMode.list;
          }
        }),
        icon:
            const Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white),
        label: Text(
          "Back",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF64748B)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    // Default: List view button
    return ElevatedButton.icon(
      onPressed: () {
        _resetForm();
        setState(() => _viewMode = AdmissionsViewMode.addApplication);
      },
      icon: const Icon(Icons.add_rounded, size: 16, color: Color(0xFF0F172A)),
      label: Text(
        "+ Add application",
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. VIEW APPLICATION DETAILS VIEW (Images 1 & 2)
  // ===========================================================================
  Widget _buildApplicationDetailView(
      Map<String, dynamic> r, double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    // Admission Progress Card (Image 1)
    final admissionProgressCard = _buildAdmissionProgressBar(r);

    // Left Column Content: 5 Detail Cards (Images 1 & 2)
    final leftCards = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildViewApplicantDetailsCard(r),
        const SizedBox(height: 16),
        _buildViewAcademicRecordCard(r),
        const SizedBox(height: 16),
        _buildViewProgrammeAndQuotaCard(r),
        const SizedBox(height: 16),
        _buildViewParentGuardianCard(r),
        const SizedBox(height: 16),
        _buildViewAdmissionStatusCard(r),
      ],
    );

    // Right Column Content: Identity Card, Record History, Back Button (Images 1 & 2)
    final rightCards = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildViewAvatarIdentityCard(r),
        const SizedBox(height: 16),
        _buildViewRecordHistoryCard(r),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => setState(() => _viewMode = AdmissionsViewMode.list),
          icon: const Icon(Icons.arrow_back_rounded,
              size: 15, color: Color(0xFF475569)),
          label: Text(
            "Back to Student Admissions",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Full width Admission progress bar (Image 1)
        admissionProgressCard,
        const SizedBox(height: 18),

        // 2-Column Responsive Body
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 7, child: leftCards),
              const SizedBox(width: 20),
              Expanded(flex: 3, child: rightCards),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              rightCards,
              const SizedBox(height: 18),
              leftCards,
            ],
          ),
      ],
    );
  }

  // Admission progress bar (Image 1)
  Widget _buildAdmissionProgressBar(Map<String, dynamic> r) {
    final status = (r["status"] as String? ?? "Applied");
    final int currentStageIndex = _funnelStages.contains(status)
        ? _funnelStages.indexOf(status)
        : 1;

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
          Text(
            "Admission progress",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Stage ${currentStageIndex + 1} of 7",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // 7 Pills Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(_funnelStages.length, (idx) {
                final stageName = _funnelStages[idx];
                final isCompleted = idx < currentStageIndex;
                final isCurrent = idx == currentStageIndex;

                Color bg;
                Color textColor;
                Color borderColor;

                if (isCurrent) {
                  bg = const Color(0xFF1E2865);
                  textColor = Colors.white;
                  borderColor = const Color(0xFF1E2865);
                } else if (isCompleted) {
                  bg = const Color(0xFFCCFBF1).withValues(alpha: 0.6);
                  textColor = const Color(0xFF0D9488);
                  borderColor = const Color(0xFF99F6E4);
                } else {
                  bg = const Color(0xFFF8FAFC);
                  textColor = const Color(0xFF94A3B8);
                  borderColor = const Color(0xFFE2E8F0);
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: borderColor),
                    ),
                    child: Text(
                      isCompleted
                          ? "✓ $stageName"
                          : isCurrent
                              ? "${idx + 1} $stageName"
                              : stageName,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight:
                            isCurrent ? FontWeight.w700 : FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Card 1: Applicant Details (Image 1)
  Widget _buildViewApplicantDetailsCard(Map<String, dynamic> r) {
    return _buildWhiteSectionCard(
      title: "Applicant details",
      child: Column(
        children: [
          _buildTwoColRow(
            label1: "FULL NAME (AS IN 12TH MARK SHEET)",
            val1: r["name"] as String? ?? "—",
            label2: "DATE OF BIRTH",
            val2: r["dob"] as String? ?? "—",
          ),
          const SizedBox(height: 14),
          _buildTwoColRow(
            label1: "GENDER",
            val1: r["gender"] as String? ?? "—",
            label2: "EMAIL",
            val2: r["email"] as String? ?? "—",
          ),
          const SizedBox(height: 14),
          _buildTwoColRow(
            label1: "MOBILE NUMBER",
            val1: r["mobile"] as String? ?? "—",
            label2: "CITY / TOWN",
            val2: r["city"] as String? ?? "—",
          ),
          const SizedBox(height: 14),
          _buildTwoColRow(
            label1: "STATE",
            val1: r["state"] as String? ?? "—",
            label2: "",
            val2: "",
          ),
        ],
      ),
    );
  }

  // Card 2: Academic Record (Image 1)
  Widget _buildViewAcademicRecordCard(Map<String, dynamic> r) {
    return _buildWhiteSectionCard(
      title: "Academic record",
      child: Column(
        children: [
          _buildTwoColRow(
            label1: "12TH BOARD",
            val1: r["board"] as String? ?? "—",
            label2: "12TH / HSC PERCENTAGE",
            val2: r["hsc"] as String? ?? "—",
          ),
          const SizedBox(height: 14),
          _buildTwoColRow(
            label1: "TNEA COUNSELLING CUT-OFF (OUT OF 200)",
            val1: r["cutoff"] as String? ?? "—",
            label2: "",
            val2: "",
          ),
        ],
      ),
    );
  }

  // Card 3: Programme & Quota (Image 2)
  Widget _buildViewProgrammeAndQuotaCard(Map<String, dynamic> r) {
    return _buildWhiteSectionCard(
      title: "Programme & quota",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDataFieldDisplay(
              "PROGRAMME APPLIED FOR", r["program"] as String? ?? "—"),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDataFieldDisplay(
                    "QUOTA", r["quota"] as String? ?? "—"),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "COMMUNITY / CATEGORY",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        r["community"] as String? ?? "BC",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4F46E5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildPillField(
                  label: "APPLYING FOR SCHOLARSHIP",
                  val: r["scholarship"] == true ? "Yes" : "No",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPillField(
                  label: "HOSTEL ACCOMMODATION REQUIRED",
                  val: r["hostel"] == true ? "Yes" : "No",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card 4: Parent / Guardian (Image 2)
  Widget _buildViewParentGuardianCard(Map<String, dynamic> r) {
    return _buildWhiteSectionCard(
      title: "Parent / guardian",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTwoColRow(
            label1: "PARENT / GUARDIAN NAME",
            val1: r["parentName"] as String? ?? "—",
            label2: "PARENT / GUARDIAN MOBILE",
            val2: r["parentMobile"] as String? ?? "—",
          ),
          const SizedBox(height: 14),
          _buildDataFieldDisplay(
              "OCCUPATION", r["parentOccupation"] as String? ?? "—"),
        ],
      ),
    );
  }

  // Card 5: Admission Status & Documents (Image 2)
  Widget _buildViewAdmissionStatusCard(Map<String, dynamic> r) {
    final docs = (r["documents"] as Map<String, dynamic>?) ?? {};
    final status = r["status"] as String? ?? "Applied";

    return _buildWhiteSectionCard(
      title: "Admission status",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "STATUS",
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
          const SizedBox(height: 14),

          Text(
            "DOCUMENTS VERIFIED",
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: docs.keys.map((d) {
              final isVerified = docs[d] == true;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: isVerified
                      ? const Color(0xFFEEF2FF)
                      : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isVerified
                        ? const Color(0xFFC7D2FE)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  "${isVerified ? "✓ " : ""}$d",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isVerified
                        ? const Color(0xFF4338CA)
                        : const Color(0xFF94A3B8),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          Text(
            "INTERNAL NOTES",
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            r["notes"] != null && (r["notes"] as String).isNotEmpty
                ? r["notes"] as String
                : "—",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  // Right Side: Avatar & Identity Card (Image 1)
  Widget _buildViewAvatarIdentityCard(Map<String, dynamic> r) {
    final String initial =
        (r["name"] as String? ?? "J").substring(0, 1).toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Indigo Avatar Box with Initial
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2865),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                initial,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            r["name"] as String? ?? "—",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            r["id"] as String? ?? "—",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
            decoration: BoxDecoration(
              color: const Color(0xFFCCFBF1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              r["status"] as String? ?? "Enrolled",
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0D9488),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Anna Institute of Technology Tag (Image 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: const Color(0xFFD8B4FE).withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_balance_rounded,
                    size: 13, color: Color(0xFF7E22CE)),
                const SizedBox(width: 5),
                Text(
                  "Anna Institute of Technology",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF7E22CE),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Right Side: Record history Card (Image 1)
  Widget _buildViewRecordHistoryCard(Map<String, dynamic> r) {
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
          Text(
            "Record history",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Created
          _buildRecordHistoryRow(
            icon: Icons.calendar_today_outlined,
            label: "Created",
            value: r["created"] as String? ?? "5 Nov 2026",
          ),
          const SizedBox(height: 12),

          // Last updated
          _buildRecordHistoryRow(
            icon: Icons.history_rounded,
            label: "Last updated",
            value: r["updated"] as String? ?? "5 Nov 2026",
          ),
          const SizedBox(height: 12),

          // Version
          _buildRecordHistoryRow(
            icon: Icons.layers_outlined,
            label: "Version",
            value: "${r["version"] ?? 6}",
          ),
        ],
      ),
    );
  }

  Widget _buildRecordHistoryRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF64748B)),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. EDIT APPLICATION VIEW (Images 3, 4, 5)
  // ===========================================================================
  Widget _buildEditApplicationView(Map<String, dynamic> r, double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    // College banner: "Belongs to Anna Institute of Technology — records cannot be moved between colleges."
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

    // Left Column Content: 5 Step Cards (Images 3, 4, 5)
    final leftFormContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Step 1: Applicant details
        _buildStep1ApplicantDetails(),
        const SizedBox(height: 16),

        // Step 2: Academic record
        _buildStep2AcademicRecord(),
        const SizedBox(height: 16),

        // Step 3: Programme & quota
        _buildStep3ProgrammeAndQuota(),
        const SizedBox(height: 16),

        // Step 4: Parent / guardian
        _buildStep4ParentGuardian(),
        const SizedBox(height: 16),

        // Step 5: Admission status with Document Grid (Image 5)
        _buildStep5AdmissionStatus(isEdit: true),
      ],
    );

    // Right Sidebar Card (Image 3)
    final rightSidebarCard = _buildEditingSidebarCard(r);

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
              Expanded(flex: 3, child: rightSidebarCard),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              rightSidebarCard,
              const SizedBox(height: 18),
              leftFormContent,
            ],
          ),
      ],
    );
  }

  // Editing Sidebar Card (Image 3)
  Widget _buildEditingSidebarCard(Map<String, dynamic> r) {
    final filledCount = _calculateRequiredFieldsFilled();
    const totalRequired = 14;

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
            "Editing application",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Required fields indicator
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
                  color: const Color(0xFF0D9488),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: filledCount / totalRequired,
              minHeight: 5,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
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

          // Version conflict note
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.history_rounded,
                  size: 15, color: Color(0xFF64748B)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Version ${r["version"] ?? 6} — conflicting edits are blocked",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Save changes button (Lavender / Indigo in Image 3)
          ElevatedButton.icon(
            onPressed: _saveEditedApplication,
            icon: const Icon(Icons.save_outlined, size: 16, color: Colors.white),
            label: Text(
              "Save changes",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9399D4),
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
              setState(() => _viewMode = AdmissionsViewMode.viewDetail);
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
  // 4. ADD APPLICATION VIEW
  // ===========================================================================
  Widget _buildAddApplicationView(double screenWidth) {
    final bool isWide = screenWidth >= 1020;

    final leftFormContent = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStep1ApplicantDetails(),
        const SizedBox(height: 16),
        _buildStep2AcademicRecord(),
        const SizedBox(height: 16),
        _buildStep3ProgrammeAndQuota(),
        const SizedBox(height: 16),
        _buildStep4ParentGuardian(),
        const SizedBox(height: 16),
        _buildStep5AdmissionStatus(isEdit: false),
      ],
    );

    final rightSidebarContent = _buildNewApplicationSummaryCard();

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

  Widget _buildNewApplicationSummaryCard() {
    final filledCount = _calculateRequiredFieldsFilled();
    const totalRequired = 14;

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
            "New application",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Record a new student candidate from enquiry through enrolment.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Required fields",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
              Text(
                "$filledCount / $totalRequired",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: filledCount == totalRequired
                      ? const Color(0xFF10B981)
                      : const Color(0xFF1E2865),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: filledCount / totalRequired,
              minHeight: 6,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(
                filledCount == totalRequired
                    ? const Color(0xFF10B981)
                    : const Color(0xFFFBBF24),
              ),
            ),
          ),
          const SizedBox(height: 18),

          ElevatedButton.icon(
            onPressed: _submitNewApplication,
            icon: const Icon(Icons.check_rounded, size: 16, color: Colors.white),
            label: Text(
              "Create application",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              setState(() => _viewMode = AdmissionsViewMode.list);
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
  // FORM STEP CARDS (Images 3, 4, 5)
  // ===========================================================================
  // Step 1: Applicant Details (Image 3)
  Widget _buildStep1ApplicantDetails() {
    return _buildStepCardWithIcon(
      stepTitle: "Applicant details",
      stepSubtitle: "Step 1 of 5",
      icon: Icons.person_outline_rounded,
      iconBg: const Color(0xFFEEF2FF),
      iconColor: const Color(0xFF4F46E5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormTextField(
                  label: "Full name (as in 12th mark sheet) *",
                  hint: "e.g. Jayasri",
                  controller: _formFullNameCtrl,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildFormTextField(
                  label: "Date of birth *",
                  hint: "DD/MM/YYYY",
                  controller: _formDobCtrl,
                  suffixIcon: Icons.calendar_today_outlined,
                  onChanged: () => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormDropdown(
                  label: "Gender *",
                  value: _formGender,
                  items: const ["Female", "Male", "Other"],
                  onChanged: (v) => setState(() => _formGender = v!),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildFormTextField(
                  label: "Email *",
                  hint: "jaya1@gmail.com",
                  controller: _formEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: () => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormTextField(
                  label: "Mobile number *",
                  hint: "7418596522",
                  controller: _formMobileCtrl,
                  keyboardType: TextInputType.phone,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildFormTextField(
                  label: "City / town",
                  hint: "Trichy",
                  controller: _formCityCtrl,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildFormDropdown(
            label: "State *",
            value: _formState,
            items: const [
              "Tamil Nadu",
              "Kerala",
              "Karnataka",
              "Andhra Pradesh",
              "Telangana",
              "Maharashtra",
              "Other",
            ],
            onChanged: (v) => setState(() => _formState = v!),
          ),
        ],
      ),
    );
  }

  // Step 2: Academic Record (Image 4)
  Widget _buildStep2AcademicRecord() {
    return _buildStepCardWithIcon(
      stepTitle: "Academic record",
      stepSubtitle: "Step 2 of 5",
      icon: Icons.school_outlined,
      iconBg: const Color(0xFFFEF3C7),
      iconColor: const Color(0xFFD97706),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormDropdown(
                  label: "12th board *",
                  value: _formBoard,
                  items: const ["State Board", "CBSE", "ICSE / ISC", "Other"],
                  onChanged: (v) => setState(() => _formBoard = v!),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildFormTextField(
                  label: "12th / HSC percentage *",
                  hint: "83",
                  controller: _formHscCtrl,
                  keyboardType: TextInputType.number,
                  onChanged: () => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildFormTextField(
            label: "TNEA counselling cut-off (out of 200)",
            hint: "140",
            controller: _formCutoffCtrl,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  // Step 3: Programme & Quota (Image 4)
  Widget _buildStep3ProgrammeAndQuota() {
    return _buildStepCardWithIcon(
      stepTitle: "Programme & quota",
      stepSubtitle: "Step 3 of 5",
      icon: Icons.assignment_outlined,
      iconBg: const Color(0xFFECFDF5),
      iconColor: const Color(0xFF059669),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormDropdown(
            label: "Programme applied for *",
            value: _formProgram,
            items: const [
              "B.E. Electronics & Communication",
              "B.E. Computer Science & Engineering",
              "B.Tech Information Technology",
              "B.Tech Artificial Intelligence & Data Science",
              "B.E. Mechanical Engineering",
              "B.E. Civil Engineering",
            ],
            onChanged: (v) => setState(() => _formProgram = v!),
          ),
          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormDropdown(
                  label: "Quota *",
                  value: _formQuota,
                  items: const [
                    "Government",
                    "Management Quota",
                    "Sports Quota",
                    "NRI Quota",
                  ],
                  onChanged: (v) => setState(() => _formQuota = v!),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildFormDropdown(
                  label: "Community / category *",
                  value: _formCommunity,
                  items: const ["BC", "OC", "BCM", "MBC", "SC", "SCA", "ST"],
                  onChanged: (v) => setState(() => _formCommunity = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Side-by-side Switches (Image 4)
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Applying for scholarship",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF166534),
                          ),
                        ),
                      ),
                      Switch(
                        value: _formScholarship,
                        activeThumbColor: const Color(0xFF059669),
                        onChanged: (v) => setState(() => _formScholarship = v),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Hostel accommodation required",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF166534),
                          ),
                        ),
                      ),
                      Switch(
                        value: _formHostel,
                        activeThumbColor: const Color(0xFF059669),
                        onChanged: (v) => setState(() => _formHostel = v),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Step 4: Parent / Guardian (Image 4 & 5)
  Widget _buildStep4ParentGuardian() {
    return _buildStepCardWithIcon(
      stepTitle: "Parent / guardian",
      stepSubtitle: "Step 4 of 5",
      icon: Icons.people_outline_rounded,
      iconBg: const Color(0xFFEFF6FF),
      iconColor: const Color(0xFF2563EB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildFormTextField(
                  label: "Parent / guardian name *",
                  hint: "Thiyagarajan",
                  controller: _formParentNameCtrl,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildFormTextField(
                  label: "Parent / guardian mobile *",
                  hint: "7485961230",
                  controller: _formParentMobileCtrl,
                  keyboardType: TextInputType.phone,
                  onChanged: () => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildFormTextField(
            label: "Occupation",
            hint: "Business",
            controller: _formParentOccupationCtrl,
          ),
        ],
      ),
    );
  }

  // Step 5: Admission status with Document Grid (Image 5)
  Widget _buildStep5AdmissionStatus({required bool isEdit}) {
    return _buildStepCardWithIcon(
      stepTitle: "Admission status",
      stepSubtitle: "Step 5 of 5",
      icon: Icons.verified_user_outlined,
      iconBg: const Color(0xFFFEF3C7),
      iconColor: const Color(0xFFD97706),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormDropdown(
            label: "Status *",
            value: _formStatus,
            items: const [
              "Enrolled",
              "Applied",
              "Documents verified",
              "Shortlisted",
              "Offer sent",
              "Fee paid",
              "Rejected",
              "Withdrawn",
            ],
            onChanged: (v) => setState(() => _formStatus = v!),
          ),
          const SizedBox(height: 16),

          Text(
            "Documents verified",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),

          // 2-Column Grid of Document Verification Checkboxes (Image 5)
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoCol = constraints.maxWidth >= 550;
              final docList = _formDocuments.keys.toList();

              if (!isTwoCol) {
                return Column(
                  children: docList
                      .map((docKey) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _buildDocumentCheckTile(docKey),
                          ))
                      .toList(),
                );
              }

              return Column(
                children: [
                  for (int i = 0; i < docList.length; i += 2)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(child: _buildDocumentCheckTile(docList[i])),
                          const SizedBox(width: 12),
                          if (i + 1 < docList.length)
                            Expanded(
                                child: _buildDocumentCheckTile(docList[i + 1]))
                          else
                            const Spacer(),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Internal notes
          Text(
            "Internal notes",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _formNotesCtrl,
            maxLines: 3,
            style:
                GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: "Visible to admission staff only...",
              hintStyle: GoogleFonts.poppins(
                  fontSize: 11.5, color: const Color(0xFF94A3B8)),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
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
          const SizedBox(height: 4),
          Text(
            "Visible to admission staff only. Do not store Aadhaar or bank numbers here.",
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // Document Checkbox Container Card (Image 5)
  Widget _buildDocumentCheckTile(String docKey) {
    final isChecked = _formDocuments[docKey] ?? false;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => setState(() => _formDocuments[docKey] = !isChecked),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isChecked ? const Color(0xFF94A3B8) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: isChecked,
                activeColor: const Color(0xFF1E2865),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                onChanged: (v) =>
                    setState(() => _formDocuments[docKey] = v ?? false),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                docKey,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Card wrapper with icon badge (Image 3, 4, 5)
  Widget _buildStepCardWithIcon({
    required String stepTitle,
    required String stepSubtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required Widget child,
  }) {
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
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(icon, size: 16, color: iconColor),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stepTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    stepSubtitle,
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
          child,
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. LIST VIEW: FILTER PILLS, SEARCH & TABLE (Image 10)
  // ===========================================================================
  Widget _buildFilterPillsBar() {
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
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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

  Widget _buildSearchAndCounterCard() {
    final filteredCount = _getFilteredRecords().length;

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
                hintText: "Search by name, ID or 12th / hsc percentage...",
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

  Widget _buildAdmissionsTable(double screenWidth) {
    final records = _getFilteredRecords();

    if (records.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            const Icon(Icons.inbox_outlined, size: 40, color: Color(0xFFCBD5E1)),
            const SizedBox(height: 12),
            Text(
              "No admission records found",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Try adjusting your filters or search keywords",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      );
    }

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: DataTable(
            horizontalMargin: 16,
            columnSpacing: 22,
            headingRowHeight: 44,
            dataRowMinHeight: 52,
            dataRowMaxHeight: 56,
            headingRowColor: WidgetStateProperty.all(const Color(0xFFF7F4EE)),
            columns: [
              _buildTableColumnHeader("ID"),
              _buildTableColumnHeader("FULL NAME"),
              _buildTableColumnHeader("MOBILE NUMBER"),
              _buildTableColumnHeader("12TH / HSC PERCENTAGE"),
              _buildTableColumnHeader("PROGRAMME APPLIED FOR"),
              _buildTableColumnHeader("COMMUNITY / CATEGORY"),
              _buildTableColumnHeader("STATUS"),
              _buildTableColumnHeader("UPDATED"),
              _buildTableColumnHeader("ACTIONS"),
            ],
            rows: records.map((r) => _buildTableRow(r)).toList(),
          ),
        ),
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

  DataRow _buildTableRow(Map<String, dynamic> r) {
    final status = r["status"] as String? ?? "Applied";
    final isEnrolled = status == "Enrolled";
    final isApplied = status == "Applied";
    final isWithdrawn = status == "Withdrawn" || status == "Rejected";

    Color badgeBg;
    Color badgeText;
    if (isEnrolled) {
      badgeBg = const Color(0xFFCCFBF1);
      badgeText = const Color(0xFF0D9488);
    } else if (isApplied) {
      badgeBg = const Color(0xFFEEF2FF);
      badgeText = const Color(0xFF4F46E5);
    } else if (isWithdrawn) {
      badgeBg = const Color(0xFFFFE4E6);
      badgeText = const Color(0xFFE11D48);
    } else {
      badgeBg = const Color(0xFFFEF3C7);
      badgeText = const Color(0xFFD97706);
    }

    return DataRow(
      cells: [
        // ID
        DataCell(
          InkWell(
            onTap: () {
              setState(() {
                _selectedRecord = r;
                _viewMode = AdmissionsViewMode.viewDetail;
              });
            },
            child: Text(
              r["id"] as String,
              style: GoogleFonts.sourceCodePro(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2563EB),
              ),
            ),
          ),
        ),
        // Full Name
        DataCell(
          InkWell(
            onTap: () {
              setState(() {
                _selectedRecord = r;
                _viewMode = AdmissionsViewMode.viewDetail;
              });
            },
            child: Text(
              r["name"] as String,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
        ),
        // Mobile Number
        DataCell(
          Text(
            r["displayMobile"] as String? ?? r["mobile"] as String,
            style: GoogleFonts.sourceCodePro(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
        // 12th / HSC Percentage
        DataCell(
          Center(
            child: Text(
              r["hsc"] as String,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
        ),
        // Programme
        DataCell(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              r["program"] as String,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF334155),
              ),
            ),
          ),
        ),
        // Community / Category
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              r["community"] as String,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF475569),
              ),
            ),
          ),
        ),
        // Status
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: badgeText,
              ),
            ),
          ),
        ),
        // Updated
        DataCell(
          Text(
            r["updated"] as String,
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
                    _selectedRecord = r;
                    _viewMode = AdmissionsViewMode.viewDetail;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    size: 17, color: Color(0xFFD97706)),
                tooltip: "Edit Application",
                onPressed: () {
                  _populateFormForEdit(r);
                  setState(() {
                    _selectedRecord = r;
                    _viewMode = AdmissionsViewMode.editApplication;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 17, color: Color(0xFFEF4444)),
                tooltip: "Delete Record",
                onPressed: () => _confirmDelete(r),
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
  // REUSABLE FIELD DISPLAY HELPERS (For Detail View Cards)
  // ===========================================================================
  Widget _buildWhiteSectionCard({
    required String title,
    required Widget child,
  }) {
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
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildTwoColRow({
    required String label1,
    required String val1,
    required String label2,
    required String val2,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildDataFieldDisplay(label1, val1)),
        const SizedBox(width: 16),
        Expanded(
          child: label2.isNotEmpty
              ? _buildDataFieldDisplay(label2, val2)
              : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildDataFieldDisplay(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          softWrap: true,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildPillField({required String label, required String val}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFCCFBF1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            val,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0D9488),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // FORM FIELD WIDGETS
  // ===========================================================================
  Widget _buildFormTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
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
          keyboardType: keyboardType,
          onChanged: (_) => onChanged?.call(),
          style:
              GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF94A3B8),
            ),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, size: 16, color: const Color(0xFF64748B))
                : null,
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

  void _confirmDelete(Map<String, dynamic> r) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Delete Application?",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text(
          "Are you sure you want to remove the application record for ${r["name"]} (${r["id"]})? This action cannot be undone.",
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
                _records.removeWhere((item) => item["id"] == r["id"]);
                _viewMode = AdmissionsViewMode.list;
                _selectedRecord = null;
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Application ${r["id"]} removed"),
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
// BLUEPRINT GRID PAINTER
// =============================================================================
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
