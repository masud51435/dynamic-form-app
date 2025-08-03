import 'package:dynamicformapp/core/utils/invoice_generator.dart';
import 'package:dynamicformapp/data/models/form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SubmissionController extends GetxController {
  late FormModel form;
  late Map<String, dynamic> values;
  late Map<String, List<File>> images;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    form = args['form'];
    values = args['values'];
    images = args['images'];
  }

  Future<void> saveToFile() async {
    final fileName = 'invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';

    try {
      // Generate PDF bytes
      final pdfBytes = await InvoiceGenerator.generateInvoice(
        form,
        values,
        images,
      );

      // Save to app's private storage (always works)
      final appDir = await getApplicationDocumentsDirectory();
      final privateFile = File('${appDir.path}/$fileName');
      await privateFile.writeAsBytes(pdfBytes);
      debugPrint('Saved to private storage: ${privateFile.path}');

      // For Android, try to save to Downloads folder
      if (Platform.isAndroid) {
        try {
          final downloadsDir = Directory('/storage/emulated/0/Download');
          if (await downloadsDir.exists()) {
            final publicFile = File('${downloadsDir.path}/$fileName');
            await publicFile.writeAsBytes(pdfBytes);
            debugPrint('Saved to Downloads: ${publicFile.path}');
          }
        } catch (e) {
          debugPrint('Could not save to Downloads: $e');
        }
      }

      Get.snackbar("Saved Successfully", "Invoice saved as $fileName");

      // Optionally open the file
      if (Platform.isAndroid) {
        try {
          final externalDir = await getExternalStorageDirectory();
          OpenFile.open('${externalDir!.path}/$fileName');
        } catch (e) {
          debugPrint('Could not open file: $e');
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save invoice: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }
}
