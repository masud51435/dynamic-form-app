import 'package:dynamicformapp/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/form_list_controller.dart';

class FormListPage extends GetView<FormListController> {
  const FormListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Forms")),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.forms.length,
          itemBuilder: (context, index) {
            final form = controller.forms[index];
            return ListTile(
              title: Text(form.formName),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed(Routes.FORM, arguments: form);
              },
            );
          },
        );
      }),
    );
  }
}
