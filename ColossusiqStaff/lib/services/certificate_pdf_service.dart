import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// =============================================================================
// CERTIFICATE PDF & PRINTING SERVICE
// Generates publication-grade vector PDF certificates with:
// - AIT Crest & NAAC Accredited Badge
// - Authentic double navy & gold border
// - Scannable vector QR Code
// - Digital Gold Seal
// - Dr. Lakshmi Sundaram Principal signature
// =============================================================================
class CertificatePdfService {
  /// Builds the PDF byte data for the certificate
  static Future<Uint8List> generateCertificatePdf({
    required String recipient,
    required String type,
    required String event,
    required String date,
    required String certId,
    required String citation,
    String rollNumber = "110124001 · Computer Science & Engineering",
  }) async {
    final pdf = pw.Document(
      title: 'Certificate - $recipient ($certId)',
      author: 'Anna Institute of Technology',
    );

    String ribbonText = "OF ${(type).toUpperCase()}";
    if (type.toLowerCase().contains("merit")) {
      ribbonText = "OF MERIT";
    } else if (type.toLowerCase().contains("appreciation")) {
      ribbonText = "OF APPRECIATION";
    } else if (type.toLowerCase().contains("participation")) {
      ribbonText = "OF PARTICIPATION";
    } else if (type.toLowerCase().contains("excellence")) {
      ribbonText = "OF EXCELLENCE";
    } else if (type.toLowerCase().contains("internship")) {
      ribbonText = "OF INTERNSHIP COMPLETION";
    } else if (type.toLowerCase().contains("workshop") || type.toLowerCase().contains("training")) {
      ribbonText = "OF COMPLETION";
    } else if (type.toLowerCase().contains("achievement")) {
      ribbonText = "OF ACHIEVEMENT";
    }

    final verifyUrl = "https://colossus-iq-new.vercel.app/verify/$certId";

    // Load standard fonts
    final fontRegular = await PdfGoogleFonts.poppinsRegular();
    final fontBold = await PdfGoogleFonts.poppinsBold();
    final fontSemiBold = await PdfGoogleFonts.poppinsSemiBold();
    final fontItalic = await PdfGoogleFonts.playfairDisplayItalic();
    final fontScript = await PdfGoogleFonts.greatVibesRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('#FFFDF8'), // Ivory parchment
              border: pw.Border.all(color: PdfColor.fromHex('#1E2865'), width: 3),
            ),
            padding: const pw.EdgeInsets.all(8),
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex('#D4AF37'), width: 1.5),
              ),
              padding: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 18),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Top Header Row: AIT Crest | Institute Details | NAAC Badge
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // Left AIT Crest
                      pw.Container(
                        width: 44,
                        height: 44,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          border: pw.Border.all(color: PdfColor.fromHex('#D4AF37'), width: 1.5),
                        ),
                        child: pw.Center(
                          child: pw.Container(
                            width: 36,
                            height: 36,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(color: PdfColor.fromHex('#D4AF37'), width: 0.8),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                "AIT",
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 12,
                                  color: PdfColor.fromHex('#1E2865'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Center Institute Information
                      pw.Column(
                        children: [
                          pw.Text(
                            "ANNA INSTITUTE OF TECHNOLOGY",
                            style: pw.TextStyle(
                              font: fontBold,
                              fontSize: 16,
                              letterSpacing: 1.5,
                              color: PdfColor.fromHex('#1E2865'),
                            ),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            "Affiliated to Tamil Nadu Technical University",
                            style: pw.TextStyle(
                              font: fontSemiBold,
                              fontSize: 9.5,
                              color: PdfColor.fromHex('#475569'),
                            ),
                          ),
                          pw.Text(
                            "Chennai, Tamil Nadu · Phone 9840012345 · office@ait.edu.in",
                            style: pw.TextStyle(
                              font: fontRegular,
                              fontSize: 8,
                              color: PdfColor.fromHex('#64748B'),
                            ),
                          ),
                        ],
                      ),

                      // Right NAAC Badge
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(4),
                          border: pw.Border.all(color: PdfColor.fromHex('#D4AF37'), width: 1),
                        ),
                        child: pw.Column(
                          children: [
                            pw.Text(
                              "NAAC",
                              style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 8,
                                color: PdfColor.fromHex('#1E293B'),
                              ),
                            ),
                            pw.Text(
                              "ACCREDITED",
                              style: pw.TextStyle(
                                font: fontBold,
                                fontSize: 7,
                                color: PdfColor.fromHex('#D97706'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // 2. Main Title: CERTIFICATE
                  pw.Column(
                    children: [
                      pw.Text(
                        "CERTIFICATE",
                        style: pw.TextStyle(
                          font: fontBold,
                          fontSize: 26,
                          letterSpacing: 4.0,
                          color: PdfColor.fromHex('#1E2865'),
                        ),
                      ),
                      pw.SizedBox(height: 4),

                      // Ribbon Banner
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex('#B45309'),
                          borderRadius: pw.BorderRadius.circular(4),
                        ),
                        child: pw.Text(
                          ribbonText,
                          style: pw.TextStyle(
                            font: fontBold,
                            fontSize: 10,
                            letterSpacing: 2.0,
                            color: PdfColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 3. Recipient & Citation
                  pw.Column(
                    children: [
                      pw.Text(
                        "This is to certify that",
                        style: pw.TextStyle(
                          font: fontItalic,
                          fontSize: 12,
                          color: PdfColor.fromHex('#64748B'),
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        recipient,
                        style: pw.TextStyle(
                          font: fontItalic,
                          fontSize: 24,
                          color: PdfColor.fromHex('#78350F'),
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        rollNumber,
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 9.5,
                          color: PdfColor.fromHex('#64748B'),
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Container(
                        width: 500,
                        child: pw.Text(
                          citation,
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: fontRegular,
                            fontSize: 11,
                            color: PdfColor.fromHex('#334155'),
                            lineSpacing: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 4. Three Info Pill Boxes: EVENT, HELD ON, DATE OF ISSUE
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      _buildPdfPill("EVENT", event, fontBold, fontSemiBold),
                      pw.SizedBox(width: 8),
                      _buildPdfPill("HELD ON", date, fontBold, fontSemiBold),
                      pw.SizedBox(width: 8),
                      _buildPdfPill("DATE OF ISSUE", date, fontBold, fontSemiBold),
                    ],
                  ),

                  // 5. Bottom Signatures & Verification Row
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: QR Code & Verification
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 44,
                            height: 44,
                            color: PdfColors.white,
                            padding: const pw.EdgeInsets.all(2),
                            child: pw.BarcodeWidget(
                              barcode: pw.Barcode.qrCode(),
                              data: verifyUrl,
                              width: 40,
                              height: 40,
                            ),
                          ),
                          pw.SizedBox(width: 8),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "SCAN TO VERIFY",
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 7.5,
                                  color: PdfColor.fromHex('#92400E'),
                                ),
                              ),
                              pw.Text(
                                certId,
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 8.5,
                                  color: PdfColor.fromHex('#0F172A'),
                                ),
                              ),
                              pw.Text(
                                "localhost:3000/verify",
                                style: pw.TextStyle(
                                  font: fontRegular,
                                  fontSize: 7,
                                  color: PdfColor.fromHex('#64748B'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Center: Gold Seal Medallion
                      pw.Container(
                        width: 50,
                        height: 50,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          color: PdfColor.fromHex('#F59E0B'),
                        ),
                        child: pw.Center(
                          child: pw.Container(
                            width: 42,
                            height: 42,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(color: PdfColor.fromHex('#78350F'), width: 1),
                            ),
                            child: pw.Center(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    "[V]",
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: 10,
                                      color: PdfColor.fromHex('#78350F'),
                                    ),
                                  ),
                                  pw.Text(
                                    "VERIFIED",
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: 5.5,
                                      letterSpacing: 0.5,
                                      color: PdfColor.fromHex('#78350F'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Right: Seal Stamp & Dr. Lakshmi Sundaram Signature
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 40,
                            height: 40,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(color: PdfColor.fromHex('#334155'), width: 1),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                "AIT\nSEAL",
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 7,
                                  color: PdfColor.fromHex('#334155'),
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Text(
                                "Dr. Lakshmi Sundaram",
                                style: pw.TextStyle(
                                  font: fontScript,
                                  fontSize: 20,
                                  color: PdfColor.fromHex('#1E2865'),
                                ),
                              ),
                              pw.Container(
                                width: 110,
                                height: 0.8,
                                color: PdfColor.fromHex('#CBD5E1'),
                                margin: const pw.EdgeInsets.symmetric(vertical: 2),
                              ),
                              pw.Text(
                                "Dr. Lakshmi Sundaram",
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 9,
                                  color: PdfColor.fromHex('#0F172A'),
                                ),
                              ),
                              pw.Text(
                                "Principal, Anna Institute of Technology",
                                style: pw.TextStyle(
                                  font: fontRegular,
                                  fontSize: 7.5,
                                  color: PdfColor.fromHex('#64748B'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildPdfPill(
    String label,
    String value,
    pw.Font fontBold,
    pw.Font fontSemiBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(4),
        border: pw.Border.all(color: PdfColor.fromHex('#CBD5E1'), width: 0.8),
        color: PdfColors.white,
      ),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(
            "$label ",
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 7.5,
              color: PdfColor.fromHex('#92400E'),
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              font: fontSemiBold,
              fontSize: 8.5,
              color: PdfColor.fromHex('#0F172A'),
            ),
          ),
        ],
      ),
    );
  }

  /// Triggers Print / Save as PDF dialog
  static Future<void> printOrSavePdf({
    required String recipient,
    required String type,
    required String event,
    required String date,
    required String certId,
    required String citation,
    String rollNumber = "110124001 · Computer Science & Engineering",
  }) async {
    await Printing.layoutPdf(
      name: 'Certificate_${recipient.replaceAll(" ", "_")}_$certId',
      onLayout: (PdfPageFormat format) async {
        return generateCertificatePdf(
          recipient: recipient,
          type: type,
          event: event,
          date: date,
          certId: certId,
          citation: citation,
          rollNumber: rollNumber,
        );
      },
    );
  }

  /// Downloads / shares the PDF file directly
  static Future<void> downloadPdfDirectly({
    required String recipient,
    required String type,
    required String event,
    required String date,
    required String certId,
    required String citation,
    String rollNumber = "110124001 · Computer Science & Engineering",
  }) async {
    final bytes = await generateCertificatePdf(
      recipient: recipient,
      type: type,
      event: event,
      date: date,
      certId: certId,
      citation: citation,
      rollNumber: rollNumber,
    );

    await Printing.sharePdf(
      bytes: bytes,
      filename: 'Certificate_${recipient.replaceAll(" ", "_")}_$certId.pdf',
    );
  }
}

