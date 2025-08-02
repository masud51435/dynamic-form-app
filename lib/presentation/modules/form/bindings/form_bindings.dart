import 'package:dynamicformapp/presentation/modules/form/controller/form_controller.dart';
import 'package:get/get.dart';


class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormController());
  }
}
