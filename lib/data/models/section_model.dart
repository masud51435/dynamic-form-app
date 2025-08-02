import 'field_model.dart';

class SectionModel {
  final String name;
  final String key;
  final List<FieldModel> fields;

  SectionModel({
    required this.name,
    required this.key,
    required this.fields,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      name: json['name'],
      key: json['key'],
      fields: (json['fields'] as List)
          .map((e) => FieldModel.fromJson(e))
          .toList(),
    );
  }
}
