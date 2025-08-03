import 'package:dynamicformapp/core/utils/form_data_helper.dart';
import 'package:dynamicformapp/presentation/modules/submisson/controller/submisson_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionPage extends GetView<SubmissionController> {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Submission Review"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ...controller.form.sections.map((section) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const Divider(height: 20, thickness: 1),
                    ...section.fields.map((field) {
                      final key = field.key;
                      final label = field.properties.label;
                      final value = controller.values[key];

                      if (field.id == 4 && controller.images.containsKey(key)) {
                        return _buildImageField(label, controller.images[key]!);
                      }

                      final displayValue = (field.id == 2)
                          ? FormDataHelper.getDisplayValue(
                              value,
                              field.properties.listItems,
                            )
                          : value.toString();

                      return _buildTextField(label, displayValue);
                    }),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              fixedSize: const Size(double.maxFinite, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: controller.saveToFile,
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text(
              "Save to Device",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageField(String label, List<dynamic> images) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: images
                .map(
                  (img) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      img,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
