import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// STUDENT FEES & PAYMENTS SCREEN
// Matches Image 1 (Paid View with Receipt Table),
// Image 2 (Payment Receipt Modal),
// Image 3 (Due View with Pay Online & Paid Offline Verification Form),
// Image 4 (Empty Payment History View).
// =============================================================================

class PrincipalStudentFeesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalStudentFeesScreen({super.key, this.onBack});

  @override
  State<PrincipalStudentFeesScreen> createState() => _PrincipalStudentFeesScreenState();
}

typedef StudentFeesScreen = PrincipalStudentFeesScreen;

class _PrincipalStudentFeesScreenState extends State<PrincipalStudentFeesScreen> {
  // State: whether fee is marked as Paid (Image 1) or Due (Image 3)
  bool _isPaid = true;

  // Offline payment form controllers & state
  String _selectedPaymentMode = "Cash";
  DateTime _paidOnDate = DateTime(2026, 11, 4);
  final TextEditingController _receiptNumberCtrl = TextEditingController(text: "10001");
  String? _receiptFileName;
  bool _isSubmittingVerification = false;

  // Payment History records
  final List<Map<String, dynamic>> _paymentHistory = [
    {
      "date": "13 Oct 2026",
      "year": "2026-27",
      "method": "Offline · Cash",
      "amount": "₹1,500.00",
      "status": "Paid",
      "receiptNumber": "CIQ/2026-27/D84FF862F8",
      "student": "Anand Kumar",
      "reference": "10001 · paid 2026-10-13",
      "receiptDate": "20 Oct 2026",
    },
  ];

  @override
  void dispose() {
    _receiptNumberCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickReceiptFile() async {
    try {
      final PlatformFile? file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'webp', 'pdf'],
      );

      if (file != null) {
        final sizeBytes = file.lengthSync() ?? (await file.length()) ?? 0;
        const int maxBytes = 2 * 1024 * 1024; // 2 MB

        if (sizeBytes > maxBytes) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "File exceeds 2 MB limit (${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB). Please select a smaller receipt photo.",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                backgroundColor: const Color(0xFFDC2626),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return;
        }

        setState(() {
          _receiptFileName = file.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error picking file: $e", style: GoogleFonts.poppins(color: Colors.white)),
            backgroundColor: const Color(0xFFDC2626),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _submitOfflineVerification() {
    if (_receiptNumberCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter receipt / transaction / DD number", style: GoogleFonts.poppins(color: Colors.white)),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isSubmittingVerification = true;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        final newRecord = {
          "date": "${_paidOnDate.day} ${_getMonthName(_paidOnDate.month)} ${_paidOnDate.year}",
          "year": "2026-27",
          "method": "Offline · $_selectedPaymentMode",
          "amount": "₹1,500.00",
          "status": "Paid",
          "receiptNumber": "CIQ/2026-27/${math.Random().nextInt(99999999).toRadixString(16).toUpperCase().padLeft(8, '0')}",
          "student": "Anand Kumar",
          "reference": "${_receiptNumberCtrl.text.trim()} · paid ${_paidOnDate.year}-${_paidOnDate.month.toString().padLeft(2, '0')}-${_paidOnDate.day.toString().padLeft(2, '0')}",
          "receiptDate": "${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}",
        };

        setState(() {
          _isSubmittingVerification = false;
          _isPaid = true;
          _paymentHistory.insert(0, newRecord);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Offline payment recorded & verified successfully!", style: GoogleFonts.poppins(color: Colors.white)),
            backgroundColor: const Color(0xFF0D9488),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  String _getMonthName(int month) {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[(month - 1).clamp(0, 11)];
  }

  void _showReceiptDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PAYMENT RECEIPT",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ColossusIQ app fee",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F4EA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Paid",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  item["amount"] ?? "₹1,500.00",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 18),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                _receiptRow("Receipt number", item["receiptNumber"] ?? "CIQ/2026-27/D84FF862F8"),
                _receiptRow("Student", item["student"] ?? "Anand Kumar"),
                _receiptRow("Academic year", item["year"] ?? "2026-27"),
                _receiptRow("Paid with", item["method"] ?? "Offline · Cash"),
                _receiptRow("Reference", item["reference"] ?? "10001 · paid 2026-10-13"),
                _receiptRow("Date", item["receiptDate"] ?? "20 Oct 2026", isLast: true),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        "Close",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Receipt ${item["receiptNumber"] ?? "CIQ/2026-27/D84FF862F8"} printed successfully!",
                                style: GoogleFonts.poppins(color: Colors.white)),
                            backgroundColor: const Color(0xFF2A3B8F),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.print_rounded, size: 16),
                      label: Text(
                        "Print",
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A3B8F),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

  Widget _receiptRow(String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Fees & Payments",
      category: "Overview",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Overview  ›  Fees & Payments",
          category: "OVERVIEW",
          phase: "MVP",
          isMvp: true,
          icon: Icons.credit_card_rounded,
          title: "Fees & Payments",
          subtitle: "Pay your yearly app fee online or record an offline payment, and download your receipts.",
          watermarkIcon: Icons.credit_card_rounded,
        ),
        const SizedBox(height: 20),

        // Top Fee Summary Card (App fee · academic year 2026-27)
        _buildTopFeeCard(),
        const SizedBox(height: 20),

        // When Due: 2-Column Section (Pay Online + Paid Offline)
        if (!_isPaid) ...[
          _buildDueColumnsSection(),
          const SizedBox(height: 20),
        ],

        // Payment History Card
        _buildPaymentHistoryCard(),
        const SizedBox(height: 40),
      ],
    );
  }

  // 1. Top Card: App fee academic year
  Widget _buildTopFeeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "App fee · academic year 2026-27",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "₹1,500.00",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isPaid
                      ? "Due by 31 Oct 2026"
                      : "Due by 31 Oct 2026 · unpaid accounts lock after 15 Nov 2026",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Tooltip(
            message: "Click to toggle between Paid and Due preview",
            child: InkWell(
              onTap: () => setState(() => _isPaid = !_isPaid),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: _isPaid ? const Color(0xFFE6F4EA) : const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _isPaid ? "Paid" : "Due",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _isPaid ? const Color(0xFF0F766E) : const Color(0xFFC2410C),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. Due State: 2 Columns (Pay online + Paid offline)
  Widget _buildDueColumnsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildPayOnlineCard()),
              const SizedBox(width: 20),
              Expanded(child: _buildPaidOfflineCard()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildPayOnlineCard(),
              const SizedBox(height: 20),
              _buildPaidOfflineCard(),
            ],
          );
        }
      },
    );
  }

  // Pay online card
  Widget _buildPayOnlineCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
          Text(
            "Pay online",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "You will be taken to the gateway's secure page. Card and UPI details are never entered on this site.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F5EE), // Light khaki/beige from screenshot
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFEFECE2)),
            ),
            child: Text(
              "Online payment is not available yet. Pay at the college office or by bank transfer and record it on the right.",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Paid offline card
  Widget _buildPaidOfflineCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
          Text(
            "Paid offline?",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Paid by cash, DD, cheque or bank transfer? Record it here with a photo of the receipt. The University verifies it and clears your account.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 440;
              final howPaidField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("How you paid", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B))),
                  const SizedBox(height: 6),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPaymentMode,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF64748B)),
                        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedPaymentMode = val);
                        },
                        items: const [
                          DropdownMenuItem(value: "Cash", child: Text("Cash")),
                          DropdownMenuItem(value: "DD", child: Text("DD")),
                          DropdownMenuItem(value: "Cheque", child: Text("Cheque")),
                          DropdownMenuItem(value: "Bank transfer", child: Text("Bank transfer")),
                        ],
                      ),
                    ),
                  ),
                ],
              );

              final paidOnField = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Paid on", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B))),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _paidOnDate,
                        firstDate: DateTime(2025),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => _paidOnDate = picked);
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_paidOnDate.month.toString().padLeft(2, '0')}/${_paidOnDate.day.toString().padLeft(2, '0')}/${_paidOnDate.year}",
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                          ),
                          const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  children: [
                    howPaidField,
                    const SizedBox(height: 14),
                    paidOnField,
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: howPaidField),
                  const SizedBox(width: 14),
                  Expanded(child: paidOnField),
                ],
              );
            },
          ),
          const SizedBox(height: 14),
          Text("Receipt / transaction / DD number", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B))),
          const SizedBox(height: 6),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _receiptNumberCtrl,
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text("Photo of the receipt", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B))),
          const SizedBox(height: 6),
          Row(
            children: [
              OutlinedButton(
                onPressed: _pickReceiptFile,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                ),
                child: Text("Choose File", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _receiptFileName ?? "No file chosen",
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "PNG, JPEG or WebP, up to 2 MB.",
            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: _isSubmittingVerification ? null : _submitOfflineVerification,
              icon: _isSubmittingVerification
                  ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.file_upload_outlined, size: 16),
              label: Text("Send for verification", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500)),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF475569),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Payment history card (Image 1 & 4)
  Widget _buildPaymentHistoryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
          Text(
            "Payment history",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Every payment you have made or started, with receipts for completed ones.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          if (_paymentHistory.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "No payments yet.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF64748B),
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final double tableWidth = math.max(constraints.maxWidth, 680.0);
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      children: [
                        // Table Header
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: _tableHeader("DATE")),
                              Expanded(flex: 2, child: _tableHeader("YEAR")),
                              Expanded(flex: 3, child: _tableHeader("METHOD")),
                              Expanded(flex: 2, child: _tableHeader("AMOUNT")),
                              Expanded(flex: 2, child: _tableHeader("STATUS")),
                              const SizedBox(width: 100), // Action column
                            ],
                          ),
                        ),
                        const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                        // Table Rows
                        ..._paymentHistory.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["date"] ?? "",
                                    style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["year"] ?? "",
                                    style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    item["method"] ?? "",
                                    style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    item["amount"] ?? "",
                                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE6F4EA),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        item["status"] ?? "Paid",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F766E),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: OutlinedButton.icon(
                                    onPressed: () => _showReceiptDialog(item),
                                    icon: const Icon(Icons.receipt_long_outlined, size: 14),
                                    label: Text("Receipt", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFF1E293B),
                                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      minimumSize: Size.zero,
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
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: const Color(0xFF64748B),
      ),
    );
  }
}
