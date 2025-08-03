import 'dart:io';
import 'package:dynamicformapp/core/constants/app_colors.dart';
import 'package:dynamicformapp/data/models/field_model.dart';
import 'package:dynamicformapp/presentation/common/app_dropdown_button.dart';
import 'package:dynamicformapp/presentation/common/app_text_field.dart';
import 'package:dynamicformapp/presentation/common/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FieldWidgetFactory {
  static Widget build({
    required FieldModel field,
    required dynamic value,
    required String? error,
    required Function(dynamic) onChanged,
    Function(List<File>)? onImagePicked,
  }) {
    final props = field.properties;
    switch (field.id) {
      case 1: // TextField
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTextField(
            initialValue: value,
            labelText: props.label,
            hintText: props.hintText,
            onChanged: onChanged,
            errorText: error,
          ),
        );
      case 2: // List (dropdown or checkbox)
        if (props.multiSelect == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                props.label,
                style: TextStyle(
                  fontSize: 16,
                  color: darkColor.withOpacity(0.3),
                ),
              ),
              ...(props.listItems ?? []).map((item) {
                return CheckboxListTile(
                  value: (value is List && value.contains(item['value']))
                      ? true
                      : false,
                  title: Text(item['name']),
                  activeColor: blueColor,
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
              }),
              if (error != null)
                Text(error, style: TextStyle(color: Colors.red)),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppDropdownButton(
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
            ),
          );
        }
      case 3: // Yes/No
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                props.label,
                style: TextStyle(
                  fontSize: 16,
                  color: darkColor.withOpacity(0.3),
                ),
              ),
              Row(
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
              if (error != null)
                Text(error, style: TextStyle(color: Colors.red)),
            ],
          ),
        );
      case 4: // Image picker
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                props.label,
                style: TextStyle(
                  fontSize: 16,
                  color: darkColor.withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 6),
              ImagePickerWidget(
                initialImages: value is List<File> ? value : [],
                onImagePicked: (files) {
                  onImagePicked?.call(files);
                },
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
