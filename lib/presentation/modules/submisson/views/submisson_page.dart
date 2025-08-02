import 'package:dynamicformapp/presentation/modules/submisson/controller/submisson_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmissionPage extends GetView<SubmissionController> {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Submission Review")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ...controller.form.sections.map((section) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  ...section.fields.map((field) {
                    final key = field.key;
                    final label = field.properties.label;
                    final value = controller.values[key];

                    if (field.id == 4 && controller.images.containsKey(key)) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            spacing: 8,
                            children: controller.images[key]!
                                .map(
                                  (img) => Image.file(
                                    img,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: Text(label)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 6,
                            child: Text(
                              value is List
                                  ? value.join(", ")
                                  : value.toString(),
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const Divider(thickness: 1),
                ],
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: controller.saveToFile,
              icon: const Icon(Icons.save),
              label: const Text("Save to Device"),
            ),
          ],
        ),
      ),
    );
  }
}
