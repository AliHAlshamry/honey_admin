import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import 'package:get/get.dart';

import '../../controllers/governorates_controller.dart';
import '../../controllers/items_controller.dart';
import '../../controllers/orders_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemController());
    Get.put(CartController());
    Get.put(GovernoratesController());
    Get.put(OrdersController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
