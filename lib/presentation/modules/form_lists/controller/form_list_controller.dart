import 'dart:convert';
import 'package:dynamicformapp/data/models/form_model.dart' show FormModel;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FormListController extends GetxController {
  RxList<FormModel> forms = <FormModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadForms();
  }

  Future<void> loadForms() async {
    final paths = [
      'assets/forms/form_1.json',
      'assets/forms/form_2.json',
      'assets/forms/form_3.json',
    ];

    for (final path in paths) {
      final data = await rootBundle.loadString(path);
      final form = FormModel.fromJson(jsonDecode(data));
      forms.add(form);
    }
  }
}
