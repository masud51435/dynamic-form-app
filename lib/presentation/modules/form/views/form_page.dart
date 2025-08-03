import 'package:dynamicformapp/core/constants/app_colors.dart';
import 'package:dynamicformapp/presentation/modules/form/controller/form_controller.dart';
import 'package:dynamicformapp/presentation/modules/form/views/widgets/field_widget_factory.dart';
import 'package:dynamicformapp/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FormPage extends GetView<FormController> {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.form.formName)),
      body: GetBuilder<FormController>(
        builder: (_) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...controller.form.sections.map((section) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      ...section.fields.map((field) {
                        return FieldWidgetFactory.build(
                          field: field,
                          value: controller.fieldValues[field.key],
                          error: controller.fieldErrors[field.key],
                          onChanged: (val) =>
                              controller.updateField(field.key, val),
                          onImagePicked: (images) =>
                              controller.updateImage(field.key, images),
                        );
                      }),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
                ElevatedButton(
                  onPressed: () {
                    if (controller.validateForm()) {
                      Get.toNamed(
                        Routes.SUBMISSION,
                        arguments: {
                          'form': controller.form,
                          'values': controller.fieldValues,
                          'images': controller.imageFiles,
                        },
                      );
                    } else {
                      Get.snackbar(
                        "Validation",
                        "Please fix errors before submitting.",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    fixedSize: const Size(double.maxFinite, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
