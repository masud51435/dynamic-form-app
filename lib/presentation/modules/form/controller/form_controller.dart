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

        // Check for required fields
        if (props.required == true) {
          if (value == null || value.toString().isEmpty) {
            fieldErrors[field.key] = 'This field is required.';
            continue; // Skip other checks if the field is empty
          }
        }

        // Text field validation
        if (props.type == 'text') {
          if (props.minLength != null && (value?.length ?? 0) < props.minLength!) {
            fieldErrors[field.key] = 'Must be at least ${props.minLength} characters.';
          } else if (props.maxLength != null && (value?.length ?? 0) > props.maxLength!) {
            fieldErrors[field.key] = 'Cannot be more than ${props.maxLength} characters.';
          }
        }

        // Dropdown validation
        else if (props.type == 'dropDownList' && (value == null || value == '')) {
          fieldErrors[field.key] = 'Please make a selection.';
        }

        // Checkbox list validation
        else if (props.type == 'checkBoxList' && (value == null || (value as List).isEmpty)) {
          fieldErrors[field.key] = 'Please select at least one option.';
        }

        // Yes/No validation
        else if (props.type == 'yesno' && (value == null || value == '')) {
          fieldErrors[field.key] = 'Please select an option.';
        }

        // Image picker validation
        else if (props.type == 'image' && (imageFiles[field.key] == null || imageFiles[field.key]!.isEmpty)) {
          fieldErrors[field.key] = 'Please pick an image.';
        }
      }
    }
    update();
    return fieldErrors.values.every((e) => e == null);
  }
}
