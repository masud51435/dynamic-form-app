import 'dart:io';
import 'package:dynamicformapp/core/constants/app_colors.dart';
import 'package:dynamicformapp/data/models/field_model.dart';
import 'package:dynamicformapp/presentation/common/app_dropdown_button.dart';
import 'package:dynamicformapp/presentation/common/app_text_field.dart';
import 'package:dynamicformapp/presentation/common/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldWidgetFactory {
  static Widget build({
    required FieldModel field,
    required dynamic value,
    required String? error,
    required Function(dynamic) onChanged,
    Function(List<File>)? onImagePicked,
  }) {
    final props = field.properties;
    Widget fieldWidget;

    switch (field.id) {
      case 1: // TextField
        fieldWidget = AppTextField(
          initialValue: value,
          labelText: props.label,
          hintText: props.hintText,
          onChanged: onChanged,
          errorText: error,
        );
        break;
      case 2: // List (dropdown or checkbox)
        if (props.multiSelect == true) {
          fieldWidget = _buildCheckboxList(
            label: props.label,
            items: props.listItems ?? [],
            value: value,
            onChanged: onChanged,
            error: error,
          );
        } else {
          fieldWidget = AppDropdownButton(
            labelText: props.label,
            errorText: error,
            hintText: props.hintText,
            value: value == "" ? null : value,
            onChanged: onChanged,
            items: (props.listItems ?? [])
                .map(
                  (item) => AppDropdownMenuItem(
                    name: item['name'],
                    value: item['value'],
                  ),
                )
                .toList(),
          );
        }
        break;
      case 3: // Yes/No
        fieldWidget = _buildRadioGroup(
          label: props.label,
          value: value,
          onChanged: onChanged,
          error: error,
        );
        break;
      case 4: // Image picker
        fieldWidget = _buildImagePicker(
          label: props.label,
          value: value,
          onImagePicked: onImagePicked,
        );
        break;
      default:
        fieldWidget = const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: fieldWidget,
    );
  }

  static Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.ubuntu(
          color: darkColor.withOpacity(0.6),
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Widget _buildCheckboxList({
    required String label,
    required List<Map<String, dynamic>> items,
    required dynamic value,
    required Function(dynamic) onChanged,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: error != null ? Colors.red : Colors.grey[300]!),
          ),
          child: Column(
            children: items.map((item) {
              return CheckboxListTile(
                value: (value is List && value.contains(item['value'])),
                title: Text(item['name']),
                activeColor: blueColor,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? checked) {
                  List current = List.from((value is List) ? value : []);
                  if (checked == true) {
                    if (!current.contains(item['value'])) {
                      current.add(item['value']);
                    }
                  } else {
                    current.remove(item['value']);
                  }
                  onChanged(current);
                },
              );
            }).toList(),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
            child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }

  static Widget _buildRadioGroup({
    required String label,
    required dynamic value,
    required Function(dynamic) onChanged,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: error != null ? Colors.red : Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Yes', 'No', 'NA'].map((opt) {
              return Row(
                children: [
                  Radio(
                    value: opt,
                    groupValue: value,
                    onChanged: onChanged,
                    fillColor: MaterialStateProperty.all(blueColor),
                  ),
                  Text(opt),
                ],
              );
            }).toList(),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
            child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }

  static Widget _buildImagePicker({
    required String label,
    required dynamic value,
    Function(List<File>)? onImagePicked,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        ImagePickerWidget(
          initialImages: value is List<File> ? value : [],
          onImagePicked: (files) {
            onImagePicked?.call(files);
          },
        ),
      ],
    );
  }
}