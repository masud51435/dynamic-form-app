import 'dart:io';

import 'package:dynamicformapp/data/models/form_model.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  late FormModel form;
  Map<String, dynamic> fieldValues = {};
  Map<String, String?> fieldErrors = {};
  Map<String, List<File>> imageFiles = {};

  @override
  void onInit() {
    super.onInit();
    form = Get.arguments as FormModel;
    for (var section in form.sections) {
      for (var field in section.fields) {
        final props = field.properties;
        if (field.id == 2 && props.multiSelect == true) {
          //Multi-select checkbox list
          fieldValues[field.key] = <dynamic>[];
        } else {
          fieldValues[field.key] = props.defaultValue;
        }
      }
    }
  }

  void updateField(String key, dynamic value) {
    fieldValues[key] = value;
    fieldErrors[key] = null;
    update();
  }

  void updateImage(String key, List<File> files) {
    imageFiles[key] = files;
    update();
  }

  bool validateForm() {
    fieldErrors.clear();
    for (var section in form.sections) {
      for (var field in section.fields) {
        final value = fieldValues[field.key];
        final props = field.properties;
        if (props.type == 'text') {
          if ((props.minLength != null &&
                  (value?.length ?? 0) < props.minLength!) ||
              (props.maxLength != null &&
                  (value?.length ?? 0) > props.maxLength!)) {
            fieldErrors[field.key] = 'Invalid input length';
          }
        } else if (props.type == 'dropDownList' &&
            (value == null || value == '')) {
          fieldErrors[field.key] = 'Required';
        } else if (props.type == 'checkBoxList' &&
            (value == null || (value as List).isEmpty)) {
          fieldErrors[field.key] = 'Select at least one';
        } else if (props.type == 'yesno' && (value == null || value == '')) {
          fieldErrors[field.key] = 'Required';
        }
      }
    }
    update();
    return fieldErrors.isEmpty;
  }
}
