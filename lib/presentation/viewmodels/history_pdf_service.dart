import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../domain/entities/result_employee.dart';

class HistoryPdfService {
  final pw.Document _doc = pw.Document();

  Future<Uint8List> generatePdfBytes(List<ResultEmployee> items) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context ctx) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Historial de empleados',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '${DateTime.now().toString().split('.').first}',
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 8),
            if (items.isEmpty)
              pw.Center(
                child: pw.Text(
                  'No hay registros',
                  style: pw.TextStyle(fontSize: 12),
                ),
              )
            else
              pw.Table.fromTextArray(
                headers: ['Nombre', 'Salario', 'Bonus', 'Total'],
                data: items
                    .map(
                      (it) => [
                        it.name,
                        '\$${it.salary.toStringAsFixed(2)}',
                        '\$${it.bonus.toStringAsFixed(2)}',
                        '\$${it.finalSalary.toStringAsFixed(2)}',
                      ],
                    )
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                cellPadding: const pw.EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 8,
                ),
              ),
            pw.SizedBox(height: 12),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Total registros: ${items.length}',
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
          ];
        },
      ),
    );
    return doc.save();
  }

  Future<File> savePdfToFile(Uint8List bytes, {String? filename}) async {
    final fileName =
        filename ??
        'historial_empleados_${DateTime.now().millisecondsSinceEpoch}.pdf';

    Directory? targetDir;

    try {
      if (Platform.isAndroid) {
        // Intentar carpeta pública de Descargas
        final downloadsDir = Directory('/storage/emulated/0/Download');

        if (await downloadsDir.exists()) {
          targetDir = downloadsDir;
        } else {
          // Si por alguna razón no existe, usar carpeta externa de la app
          targetDir = await getExternalStorageDirectory();
        }
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        // Escritorio
        targetDir = await getDownloadsDirectory();
      } else if (Platform.isIOS) {
        // iOS → Documents
        targetDir = await getApplicationDocumentsDirectory();
      } else {
        targetDir = await getApplicationDocumentsDirectory();
      }
    } catch (_) {
      // Último fallback
      targetDir = await getApplicationDocumentsDirectory();
    }

    final file = File('${targetDir!.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File> exportPdf(List<ResultEmployee> items, {String? filename}) async {
    final bytes = await generatePdfBytes(items);
    final file = await savePdfToFile(bytes, filename: filename);
    return file;
  }

  Future<void> sharePdf(
    List<ResultEmployee> items, {
    String filename = 'historial_empleados.pdf',
  }) async {
    final bytes = await generatePdfBytes(items);
    await Printing.sharePdf(bytes: bytes, filename: filename);
  }
}
