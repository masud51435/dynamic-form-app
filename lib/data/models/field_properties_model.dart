import 'dart:convert';

class FieldPropertiesModel {
  final String type;
  final String defaultValue;
  final String? hintText;
  final int? minLength;
  final int? maxLength;
  final String label;
  final bool? multiSelect;
  final List<Map<String, dynamic>>? listItems;
  final bool? required;

  FieldPropertiesModel({
    required this.type,
    required this.defaultValue,
    required this.label,
    this.hintText,
    this.minLength,
    this.maxLength,
    this.multiSelect,
    this.listItems,
    this.required,
  });

  factory FieldPropertiesModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>>? parsedListItems;
    if (json.containsKey('listItems') && json['listItems'] != null) {
      parsedListItems = (jsonDecode(json['listItems']) as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }

    return FieldPropertiesModel(
      type: json['type'],
      defaultValue: json['defaultValue'] ?? '',
      label: json['label'],
      hintText: json['hintText'],
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      multiSelect: json['multiSelect'],
      listItems: parsedListItems,
      required: json['required'],
    );
  }
}
