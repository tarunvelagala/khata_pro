import 'package:pdf/pdf.dart';

abstract final class ReportPdfColors {
  static const grey     = PdfColor.fromInt(0xFF757575);
  static const red      = PdfColor.fromInt(0xFFB3261E);
  static const green    = PdfColor.fromInt(0xFF386A20);
  static const headerBg = PdfColor.fromInt(0xFFF3EDF7);
  static const rowAlt   = PdfColor.fromInt(0xFFFAF9FD);
  static const divider  = PdfColor.fromInt(0xFFCAC4D0);
}
