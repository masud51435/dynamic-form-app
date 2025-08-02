import 'package:get/get.dart';
import '../controller/submisson_controller.dart';


class SubmissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubmissionController());
  }
}
