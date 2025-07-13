import 'package:get/get.dart';

import '../../models/item_model.dart';

class ItemController extends GetxController with StateMixin<Map<ItemModel, double>> {
  late RxMap<ItemModel, double> item;
  final RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    item = <ItemModel, double>{}.obs;
    if (item.isEmpty) {
      change(item, status: RxStatus.empty());
    }
  }

  void incrementQuantity(ItemModel product, {double? quantity}) {
    bool needsUpdate = false;
    if (item.isEmpty) needsUpdate = true;
    if (!item.containsKey(product)) {
      item.addAll({product: quantity ?? 1});
    } else {
      item[product] = item[product]! + (quantity ?? 1);
    }
    if (needsUpdate) change(item, status: RxStatus.success());
    updateTotalPrice();
  }

  void addToCart(ItemModel product) {
    bool needsUpdate = false;
    if (item.isEmpty) needsUpdate = true;
    if (!item.containsKey(product)) {
      item.addAll({product: 1});
    } else {
      item[product] = item[product]! + 1;
    }
    if (needsUpdate) change(item, status: RxStatus.success());
    updateTotalPrice();
  }

  void decrementQuantity(ItemModel product) {
    if (item.containsKey(product) && item[product]! > 0) {
      item[product] = item[product]! - 1;
      if (item[product] == 0) {
        //remove(product);
      }
    }
    updateTotalPrice();
  }

  void updateTotalPrice() {
    double total = 0.0;
    item.forEach((item, quantity) {
      total += double.parse(item.discountedPrice ?? item.orginalPrice).round() * quantity.round();
    });
    totalPrice.value = total;
    update();
  }

  RxInt get subTotalPrice {
    int total = 0;
    item.forEach((item, quantity) {
      total += double.parse(item.discountedPrice ?? item.orginalPrice).round() * quantity.round();
    });
    return total.obs;
  }

  void remove(ItemModel product) {
    item.remove(product);
    if (item.isEmpty) {
      change(item, status: RxStatus.empty());
    }
    updateTotalPrice();
    item.refresh();
  }

  void clearData() {
    item.clear();
  }
}
