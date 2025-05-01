import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/direct_controller.dart';
import '../../../controllers/items_controller.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/text_styles.dart';
import '../../widgets/text_price.dart';
import 'widgets/build_address_field.dart';
import 'widgets/build_item_info_fields.dart';
import 'widgets/build_item_selection.dart';
import 'widgets/customer_info_fields.dart';
import 'widgets/order_type_selector.dart';

class DirectOrderScreen extends GetView<DirectController> {
  const DirectOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          !controller.loading.value
              ? Scaffold(
                backgroundColor: AppColors.bgColor,
                appBar: AppBar(
                  title: Text(AppStrings.directOrder),
                  actions: [
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) {
                        return [const PopupMenuItem<int>(value: 0, child: Text(AppStrings.logoutStr))];
                      },
                      onSelected: (value) async {
                        final AuthController authController;
                        if (Get.isRegistered()) {
                          authController = Get.find<AuthController>();
                        } else {
                          authController = Get.put(AuthController());
                        }
                        if (value == 0) {
                          debugPrint('logout');
                          EasyLoading.show(status: AppStrings.logout);
                          authController.signOut();
                          EasyLoading.dismiss();
                        }
                      },
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                    () => ListView(
                      controller: controller.scrollController,
                      children: [
                        OrderTypeSelector(),
                        CustomerInfoFields(),
                        AddressFields(),
                        if (controller.orderType.value != 'REGULAR') BuildItemInfoFields(),
                        if (controller.orderType.value == 'REGULAR') BuildItemSelection(),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: bottomNavBarWidget(),
              )
              : const Scaffold(body: Center()),
    );
  }

  Widget bottomNavBarWidget() {
    final itemController = Get.find<ItemController>();
    return // Obx(
    //() =>
    ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(32.0), topLeft: Radius.circular(32.0)),
      child: Container(
        color: AppColors.cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (itemController.totalPrice.value != 0.0)
              //total price
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(AppStrings.total, style: TextStyles.textRegular12),
              ),
            if (itemController.totalPrice.value != 0.0)
              // price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(() {
                  controller.validateForm();
                  return TextPrice(price: itemController.totalPrice.value, style: TextStyles.textBold20);
                }),
              ),
            Padding(padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 32.0), child: _buildSubmitButton()),
          ],
        ),
      ),
    ) //,
    //)
    ;
  }

  Widget _buildSubmitButton() {
    return Obx(
      () => ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(!controller.isValid.value ? Colors.grey : AppColors.yellow500Color),
        ),
        onPressed: controller.isValid.value ? () => controller.submitOrder() : null,
        child: Text(AppStrings.createOrder, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}