import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../l10n/app_localizations.dart';
import '../domain/models/bill_data.dart';
import 'pdf_colors.dart';

abstract final class BillPdfBuilder {
  static Future<Uint8List> build(
    BillData data,
    AppLocalizations l10n,
  ) async {
    final regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
    );
    final bold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
    );

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: regular, bold: bold),
    );

    const grey     = ReportPdfColors.grey;
    const red      = ReportPdfColors.red;
    const green    = ReportPdfColors.green;
    const divider  = ReportPdfColors.divider;
    const rowAlt   = ReportPdfColors.rowAlt;
    const headerBg = ReportPdfColors.headerBg;

    final moneyFmt = NumberFormat('#,##,##0.00', 'en_IN');
    final dateFmt  = DateFormat('d MMM yy');
    String rs(double v) => '₹ ${moneyFmt.format(v)}';

    final periodLabel = _periodLabel(data, l10n, dateFmt);
    final businessName = data.businessName;
    final customer     = data.customer;
    final now          = DateFormat('d MMM yyyy').format(DateTime.now());

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (ctx) => [
          // ── Letterhead ──────────────────────────────────────────────
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    businessName,
                    style: pw.TextStyle(font: bold, fontSize: 18),
                  ),
                ],
              ),
              pw.Text(
                now,
                style: pw.TextStyle(font: regular, fontSize: 10, color: grey),
              ),
            ],
          ),
          pw.SizedBox(height: 2),
          pw.Divider(color: divider, height: 16),

          // ── Statement heading ────────────────────────────────────────
          pw.Text(
            l10n.billScreenTitle,
            style: pw.TextStyle(font: bold, fontSize: 14),
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            children: [
              pw.Text(
                '${customer.name}${customer.shopName != null ? ' · ${customer.shopName}' : ''}',
                style: pw.TextStyle(font: regular, fontSize: 11, color: grey),
              ),
              pw.Spacer(),
              pw.Text(
                periodLabel,
                style: pw.TextStyle(font: regular, fontSize: 10, color: grey),
              ),
            ],
          ),
          pw.SizedBox(height: 12),

          // ── Transaction table ────────────────────────────────────────
          if (data.rows.isEmpty)
            pw.Text(
              l10n.billEmpty,
              style: pw.TextStyle(font: regular, color: grey),
            )
          else ...[
            pw.Table(
              border: pw.TableBorder.symmetric(
                outside: const pw.BorderSide(color: divider, width: 0.5),
                inside:  const pw.BorderSide(color: divider, width: 0.25),
              ),
              columnWidths: {
                0: const pw.FixedColumnWidth(56),
                1: const pw.FlexColumnWidth(3),
                2: const pw.FixedColumnWidth(70),
                3: const pw.FixedColumnWidth(70),
              },
              children: [
                // Header row
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: headerBg),
                  children: [
                    _cell(l10n.billColDate,  font: bold,    bold: true),
                    _cell(l10n.billColNote,  font: bold,    bold: true),
                    _cell(l10n.billColGave,  font: bold,    bold: true, align: pw.Alignment.centerRight),
                    _cell(l10n.billColGot,   font: bold,    bold: true, align: pw.Alignment.centerRight),
                  ],
                ),
                // Transaction rows
                ...data.rows.asMap().entries.map((e) {
                  final i   = e.key;
                  final row = e.value;
                  return pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: i.isOdd ? rowAlt : PdfColors.white,
                    ),
                    children: [
                      _cell(dateFmt.format(row.date), font: regular, color: grey),
                      _cell(row.note ?? '—', font: regular),
                      _cell(
                        row.isCredit ? rs(row.amount) : '',
                        font: regular,
                        align: pw.Alignment.centerRight,
                        color: red,
                      ),
                      _cell(
                        row.isCredit ? '' : rs(row.amount),
                        font: regular,
                        align: pw.Alignment.centerRight,
                        color: green,
                      ),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 12),

            // ── Totals ───────────────────────────────────────────────
            pw.Row(
              children: [
                _summaryCard(l10n.billTotalGave, data.totalGave, red,   rs, regular, bold),
                pw.SizedBox(width: 8),
                _summaryCard(l10n.billTotalGot,  data.totalGot,  green, rs, regular, bold),
                pw.SizedBox(width: 8),
                _balanceCard(data, l10n, rs, regular, bold, red, green),
              ],
            ),
          ],
        ],
      ),
    );

    return doc.save();
  }

  static String _periodLabel(
    BillData data,
    AppLocalizations l10n,
    DateFormat fmt,
  ) {
    return switch (data.period) {
      BillPeriod.thisMonth => l10n.billPeriodMonth,
      BillPeriod.thisYear  => l10n.billPeriodYear,
      BillPeriod.allTime   => l10n.billPeriodAll,
      BillPeriod.custom    => data.dateRange != null
          ? l10n.billPeriodLabel(
              fmt.format(data.dateRange!.from),
              fmt.format(data.dateRange!.to),
            )
          : l10n.billPeriodCustom,
    };
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
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(label,
                  style: pw.TextStyle(font: regular, fontSize: 8, color: PdfColors.grey600)),
              pw.SizedBox(height: 3),
              pw.Text(fmt(amount),
                  style: pw.TextStyle(font: bold, fontSize: 11, color: color)),
            ],
          ),
        ),
      );

  static pw.Widget _balanceCard(
    BillData data,
    AppLocalizations l10n,
    String Function(double) fmt,
    pw.Font regular,
    pw.Font bold,
    PdfColor red,
    PdfColor green,
  ) {
    final net   = data.netBalance;
    final color = net >= 0 ? green : red;
    final label = net >= 0 ? l10n.billYouAreOwed : l10n.billYouOwe;
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(8),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(label,
                style: pw.TextStyle(font: regular, fontSize: 8, color: PdfColors.grey600)),
            pw.SizedBox(height: 3),
            pw.Text(fmt(net.abs()),
                style: pw.TextStyle(font: bold, fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }

  static pw.Widget _cell(
    String text, {
    required pw.Font font,
    bool bold = false,
    pw.Alignment align = pw.Alignment.centerLeft,
    PdfColor? color,
  }) =>
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: pw.Align(
          alignment: align,
          child: pw.Text(
            text,
            style: pw.TextStyle(font: font, fontSize: 9, color: color),
          ),
        ),
      );
}
