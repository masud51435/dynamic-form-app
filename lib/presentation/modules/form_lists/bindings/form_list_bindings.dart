import 'package:dynamicformapp/presentation/modules/form_lists/controller/form_list_controller.dart';
import 'package:get/get.dart';

class FormListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormListController());
  }
}
