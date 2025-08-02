import 'package:dynamicformapp/presentation/modules/form/bindings/form_bindings.dart';
import 'package:dynamicformapp/presentation/modules/form/views/form_page.dart';
import 'package:dynamicformapp/presentation/modules/form_lists/bindings/form_list_bindings.dart';
import 'package:dynamicformapp/presentation/modules/form_lists/views/form_list_page.dart';
import 'package:dynamicformapp/presentation/modules/submisson/bindings/submisson_bindings.dart';
import 'package:dynamicformapp/presentation/modules/submisson/views/submisson_page.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.FORM_LIST;

  static final routes = [
    GetPage(
      name: Routes.FORM_LIST,
      page: () => FormListPage(),
      binding: FormListBinding(),
    ),
    GetPage(
      name: Routes.FORM,
      page: () => FormPage(),
      binding: FormBinding(),
    ),
    GetPage(
      name: Routes.SUBMISSION,
      page: () => SubmissionPage(),
      binding: SubmissionBinding(),
    ),
  ];
}