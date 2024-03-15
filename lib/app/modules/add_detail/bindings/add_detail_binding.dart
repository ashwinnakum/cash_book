import 'package:get/get.dart';

import '../controllers/add_detail_controller.dart';

class AddDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDetailController>(
      () => AddDetailController(),
    );
  }
}
