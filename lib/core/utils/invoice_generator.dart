import 'dart:io';
import 'dart:typed_data';
import 'package:dynamicformapp/data/models/form_model.dart';
import 'package:dynamicformapp/core/utils/form_data_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceGenerator {
  static Future<Uint8List> generateInvoice(
    FormModel form,
    Map<String, dynamic> fieldValues,
    Map<String, List<File>> imageFiles,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 1.5 * PdfPageFormat.cm,
          marginTop: 1.5 * PdfPageFormat.cm,
          marginLeft: 1.5 * PdfPageFormat.cm,
          marginRight: 1.5 * PdfPageFormat.cm,
        ),
        build: (context) => [
          pw.Center(
            child: pw.Text(
              form.formName,
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue800,
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          ...form.sections.map(
            (section) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              decoration: pw.BoxDecoration(
                color: PdfColors.white,
                borderRadius: pw.BorderRadius.circular(12),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    section.name,
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    ),
                  ),
                  pw.Divider(height: 20, thickness: 1),
                  ...section.fields.map((field) {
                    final key = field.key;
                    final label = field.properties.label;
                    final value = fieldValues[key];

                    if (field.id == 4 && imageFiles.containsKey(key)) {
                      return _buildImageField(label, imageFiles[key]!);
                    }

                    final displayValue = (field.id == 2)
                        ? FormDataHelper.getDisplayValue(
                            value,
                            field.properties.listItems,
                          )
                        : value.toString();

                    return _buildTextField(label, displayValue);
                  }),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Generated on: ${DateTime.now().toLocal().toString().split('.').first}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildTextField(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.black,
              ),
            ),
          ),
          pw.SizedBox(width: 12),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              value,
              style: const pw.TextStyle(color: PdfColors.black, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildImageField(String label, List<File> images) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
          pw.SizedBox(height: 8),
          images.isNotEmpty
              ? pw.Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: images
                      .map(
                        (imgFile) => pw.ClipRRect(
                          horizontalRadius: 8,
                          verticalRadius: 8,
                          child: pw.Image(
                            pw.MemoryImage(imgFile.readAsBytesSync()),
                            height: 100,
                            width: 100,
                            fit: pw.BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                )
              : pw.Text('No image selected'),
        ],
      ),
    );
  }
}
