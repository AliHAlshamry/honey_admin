import '../../controllers/auth_controller.dart';
import '../../controllers/direct_controller.dart';
import 'package:get/get.dart';

import '../../controllers/governorates_controller.dart';
import '../../controllers/items_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemController());
    Get.put(DirectController());
    Get.put(GovernoratesController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
