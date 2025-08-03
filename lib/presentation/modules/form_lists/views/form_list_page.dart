import 'package:dynamicformapp/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/form_list_controller.dart';

class FormListPage extends GetView<FormListController> {
  const FormListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Available Forms"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: controller.forms.length,
          itemBuilder: (context, index) {
            final form = controller.forms[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                title: Text(
                  form.formName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text("ID: ${form.id}"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                  size: 20,
                ),
                onTap: () {
                  Get.toNamed(Routes.FORM, arguments: form);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
