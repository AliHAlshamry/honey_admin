import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/direct_controller.dart';
import '../../../widgets/product_item.dart';

class PaginatedItemsList extends GetView<DirectController> {
  const PaginatedItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.items.length + (controller.hasMoreItems ? 1 : 0),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == controller.items.length && !controller.hasMoreItems) {
            SizedBox();
          } else if (index == controller.items.length) {
            return const Padding(padding: EdgeInsets.all(8), child: Center(child: CircularProgressIndicator()));
          }

          final item = controller.items[index];
          return CartItem(quantity: 0, product: item);
        },
      ),
    );
  }
}
