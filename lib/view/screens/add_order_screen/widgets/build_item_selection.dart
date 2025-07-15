import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honey_admin/controllers/items_controller.dart';

import '../../../../controllers/cart_controller.dart';
import '../../../../models/item_model.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_strings.dart';
import '../../../widgets/dailogs/custom_product_dialog.dart';
import '../../../widgets/product_item.dart';
import 'pagination_items_list.dart';

class BuildCustomItem extends GetView<CartController> {
  BuildCustomItem({super.key});

  final ItemController itemController = Get.find<ItemController>();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (itemController.customItems.isNotEmpty)
              ListTile(
                title: Text(AppStrings.customItems, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                contentPadding: EdgeInsets.zero,
                minTileHeight: 0,
                trailing: TextButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        //side: BorderSide(color: AppColors.primaryColor, width: 0.5),
                        //borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  onPressed: () => Get.dialog(CustomProductDialog()),
                  child: Text(AppStrings.addNewProduct),
                ),
              ),
            Obx(
              () => SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemController.customItems.length,
                  itemBuilder: (context, index) {
                    final item = itemController.customItems[index];
                    return GestureDetector(
                      onTap: () {
                        final customProduct = itemController.getCustomProduct(item.product.id);
                        if (customProduct != null) {
                          Get.dialog(CustomProductDialog(customProduct: customProduct));
                        }
                      },
                      onLongPress: () => confirmDeletionDialog(item.product),
                      child: CartItem(quantity: itemController.customItems[index].qty, product: item.product),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void confirmDeletionDialog(ItemModel item) {
    final ItemController itemController = Get.find<ItemController>();
    Get.defaultDialog(
      title: AppStrings.deleteItem,
      content: Text(AppStrings.deleteItemHint),
      confirm: OutlinedButton(
        onPressed: () {
          itemController.removeItem(item);
          Get.close(1);
        },
        style: OutlinedButton.styleFrom(backgroundColor: AppColors.yellow500Color, foregroundColor: Colors.white),
        child: Text(AppStrings.delete),
      ),
      cancel: TextButton(onPressed: () => Get.close(1), child: Text(AppStrings.cancel)),
    );
  }
}

class BuildItemSelection extends GetView<CartController> {
  const BuildItemSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        final ItemController itemController = Get.find<ItemController>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(AppStrings.availableItems, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              contentPadding: EdgeInsets.zero,
              minTileHeight: 0,
              trailing:
                  itemController.customItems.isEmpty
                      ? TextButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              //side: BorderSide(color: AppColors.primaryColor, width: 0.5),
                              //borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                        onPressed: () => Get.dialog(CustomProductDialog()),
                        child: Text(AppStrings.addCustomProduct),
                      )
                      : null,
            ),
            PaginatedItemsList(),
          ],
        );
      },
    );
  }
}
