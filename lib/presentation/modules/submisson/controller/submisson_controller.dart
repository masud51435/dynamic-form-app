import 'dart:convert';
import 'package:dynamicformapp/data/models/form_model.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

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
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      final dir = await getExternalStoragePublicDirectory();
      final fileName =
          '${form.formName.replaceAll(" ", "_")}_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = File('${dir.path}/$fileName');

      final Map<String, dynamic> export = {
        'formName': form.formName,
        'submittedAt': DateTime.now().toIso8601String(),
        'fields': values,
      };

      await file.writeAsString(jsonEncode(export));
      Get.snackbar("Saved", "Saved to ${file.path}");
    } else if (status.isPermanentlyDenied) {
      Get.snackbar("Permission Denied", "Storage permission is permanently denied. Please enable it in app settings.",
          duration: Duration(seconds: 5));
      await openAppSettings();
    } else {
      Get.snackbar("Permission Denied", "Storage permission is required to save the file.");
    }
  }

  Future<Directory> getExternalStoragePublicDirectory() async {
    if (Platform.isAndroid) {
      return Directory("/storage/emulated/0/Download");
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }
}
