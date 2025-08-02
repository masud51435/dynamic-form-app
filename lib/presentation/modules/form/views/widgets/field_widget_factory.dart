import 'dart:io';
import 'package:dynamicformapp/data/models/field_model.dart';
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
          child: TextFormField(
            initialValue: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: props.label,
              hintText: props.hintText,
              errorText: error,
            ),
          ),
        );
      case 2: // List (dropdown or checkbox)
        if (props.multiSelect == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(props.label),
              ...(props.listItems ?? []).map((item) {
                return CheckboxListTile(
                  value: (value is List && value.contains(item['value']))
                      ? true
                      : false,
                  title: Text(item['name']),
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
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: props.label,
                errorText: error,
              ),
              value: value == "" ? null : value,
              onChanged: onChanged,
              items: (props.listItems ?? [])
                  .map(
                    (item) => DropdownMenuItem(
                      value: item['value'],
                      child: Text(item['name']),
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
              Text(props.label),
              Row(
                children: ['Yes', 'No', 'NA'].map((opt) {
                  return Row(
                    children: [
                      Radio(
                        value: opt,
                        groupValue: value,
                        onChanged: onChanged,
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
              Text(props.label),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text("Pick Image"),
                onPressed: () async {
                  final picked = await ImagePicker().pickMultiImage();
                  if (picked.isNotEmpty) {
                    onImagePicked?.call(
                      picked.map((e) => File(e.path)).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 6),
              if (value is List<File>)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: value.map<Widget>((f) {
                    return Image.file(
                      f,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
