import 'dart:convert';
import 'package:dynamicformapp/data/models/form_model.dart';
import 'package:get/get.dart';
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
    final dir = await getApplicationDocumentsDirectory();
    final fileName = '${form.formName.replaceAll(" ", "_")}_${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File('${dir.path}/$fileName');

    final Map<String, dynamic> export = {
      'formName': form.formName,
      'submittedAt': DateTime.now().toIso8601String(),
      'fields': values,
    };

    await file.writeAsString(jsonEncode(export));
    Get.snackbar("Saved", "Saved to ${file.path}");
  }
}
