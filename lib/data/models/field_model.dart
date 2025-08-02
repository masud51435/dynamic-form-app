import 'field_properties_model.dart';

class FieldModel {
  final int id;
  final String key;
  final FieldPropertiesModel properties;

  FieldModel({
    required this.id,
    required this.key,
    required this.properties,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'],
      key: json['key'],
      properties: FieldPropertiesModel.fromJson(json['properties']),
    );
  }
}
