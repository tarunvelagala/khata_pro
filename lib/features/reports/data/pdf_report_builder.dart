import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../l10n/app_localizations.dart';
import '../domain/models/report_data.dart';
import 'pdf_colors.dart';

abstract final class PdfReportBuilder {
  static Future<Uint8List> build(
    ReportData data,
    AppLocalizations l10n,
  ) async {
    // Load NotoSans — covers ₹ (U+20B9) and all 8 app locales.
    final regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
    );
    final bold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
    );

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: regular, bold: bold),
    );

    final periodLabel = switch (data.period) {
      ReportPeriod.thisMonth => l10n.reportsFilterMonth,
      ReportPeriod.thisYear  => l10n.reportsFilterYear,
      ReportPeriod.allTime   => l10n.reportsFilterAll,
    };

    final fmt = NumberFormat('#,##,##0.00', 'en_IN');
    String rs(double v) => '₹ ${fmt.format(v)}';

    const grey     = ReportPdfColors.grey;
    const red      = ReportPdfColors.red;
    const green    = ReportPdfColors.green;
    const headerBg = ReportPdfColors.headerBg;
    const rowAlt   = ReportPdfColors.rowAlt;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (ctx) => [
          // ── Header ──────────────────────────────────────────────────
          pw.Text(
            l10n.reportsPdfTitle,
            style: pw.TextStyle(font: bold, fontSize: 22),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            l10n.reportsPdfPeriod(periodLabel),
            style: pw.TextStyle(font: regular, fontSize: 12, color: grey),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            DateFormat('d MMM yyyy').format(DateTime.now()),
            style: pw.TextStyle(font: regular, fontSize: 10, color: grey),
          ),
          pw.Divider(height: 24),

          // ── Summary cards ────────────────────────────────────────────
          pw.Row(
            children: [
              _summaryCard(l10n.reportsTotalGave, data.totalGave, red,   rs, regular, bold),
              pw.SizedBox(width: 12),
              _summaryCard(l10n.reportsTotalGot,  data.totalGot,  green, rs, regular, bold),
              pw.SizedBox(width: 12),
              _summaryCard(
                l10n.reportsNetBalance,
                data.netBalance.abs(),
                data.netBalance >= 0 ? green : red,
                rs, regular, bold,
              ),
            ],
          ),
          pw.SizedBox(height: 20),

          // ── Customer table ───────────────────────────────────────────
          if (data.rows.isEmpty)
            pw.Text(
              l10n.reportsEmpty,
              style: pw.TextStyle(font: regular, color: grey),
            )
          else
            pw.Table(
              border: pw.TableBorder.symmetric(
                outside: const pw.BorderSide(color: grey, width: 0.5),
              ),
              columnWidths: {
                0: const pw.FlexColumnWidth(3),
                1: const pw.FlexColumnWidth(2),
                2: const pw.FlexColumnWidth(2),
                3: const pw.FlexColumnWidth(2),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: headerBg),
                  children: [
                    _cell(l10n.reportsColCustomer, bold: true,  font: bold),
                    _cell(l10n.reportsColGave,     bold: true,  font: bold, align: pw.Alignment.centerRight),
                    _cell(l10n.reportsColGot,      bold: true,  font: bold, align: pw.Alignment.centerRight),
                    _cell(l10n.reportsColNet,      bold: true,  font: bold, align: pw.Alignment.centerRight),
                  ],
                ),
                ...data.rows.asMap().entries.map((e) {
                  final i   = e.key;
                  final row = e.value;
                  final bg  = i.isOdd ? rowAlt : PdfColors.white;
                  final netColor = row.net >= 0 ? green : red;
                  return pw.TableRow(
                    decoration: pw.BoxDecoration(color: bg),
                    children: [
                      _cell(
                        row.shopName != null
                            ? '${row.customerName}\n${row.shopName}'
                            : row.customerName,
                        font: regular,
                      ),
                      _cell(rs(row.gave), font: regular, align: pw.Alignment.centerRight, color: red),
                      _cell(rs(row.got),  font: regular, align: pw.Alignment.centerRight, color: green),
                      _cell(rs(row.net.abs()), font: bold, align: pw.Alignment.centerRight, color: netColor),
                    ],
                  );
                }),
              ],
            ),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _summaryCard(
    String label,
    double amount,
    PdfColor color,
    String Function(double) fmt,
    pw.Font regular,
    pw.Font bold,
  ) =>
      pw.Expanded(
        child: pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(label,
                  style: pw.TextStyle(font: regular, fontSize: 9, color: PdfColors.grey600)),
              pw.SizedBox(height: 4),
              pw.Text(fmt(amount),
                  style: pw.TextStyle(font: bold, fontSize: 13, color: color)),
            ],
          ),
        ),
      );

  static pw.Widget _cell(
    String text, {
    required pw.Font font,
    bool bold = false,
    pw.Alignment align = pw.Alignment.centerLeft,
    PdfColor? color,
  }) =>
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: pw.Align(
          alignment: align,
          child: pw.Text(
            text,
            style: pw.TextStyle(font: font, fontSize: 10, color: color),
          ),
        ),
      );
}
