import 'package:get/get.dart';

import 'controller/quran_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FetchController>(() => FetchController());
  }
}
