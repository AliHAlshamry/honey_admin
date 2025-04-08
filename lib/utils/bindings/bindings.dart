import '../../controllers/auth_controller.dart';
import '../../controllers/direct_controller.dart';
import 'package:get/get.dart';
import '../../controllers/items_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DirectController());
    //Get.put(ItemsController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

class DirectBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DirectController());
    Get.put(ItemsController());
  }
}
