import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:honey_admin/controllers/auth_controller.dart';

import '../../controllers/direct_controller.dart';
import '../../models/item_model.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_strings.dart';

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
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        children: [
                          _buildOrderTypeSelector(),
                          _buildCustomerInfoFields(),
                          _buildAddressFields(),
                          if (controller.orderType.value != 'REGULAR') _buildItemInfoFields(),
                          if (controller.orderType.value == 'REGULAR') _buildItemSelection(),
                          SizedBox(height: 16),
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              : const Scaffold(body: Center()),
    );
  }

  Widget _buildOrderTypeSelector() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: RadioListTile<String>(
              title: const Text(AppStrings.regular, style: TextStyle(fontSize: 12)),
              value: 'REGULAR',
              groupValue: controller.orderType.value,
              onChanged: (value) => controller.setOrderType(value!),
            ),
          ),
          Expanded(
            child: RadioListTile<String>(
              title: Text(AppStrings.manual, style: TextStyle(fontSize: 12)),
              value: 'MANUAL',
              contentPadding: EdgeInsets.all(0),
              groupValue: controller.orderType.value,
              onChanged: (value) => controller.setOrderType(value!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfoFields() {
    return Column(
      children: [
        TextField(
          controller: controller.nameController,
          decoration: InputDecoration(
            labelText: AppStrings.customerNameText,
            prefixIcon: _buildIcon('./assets/icons/ic_profile.svg'),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (val){
            if(!val.startsWith('07') && val.length == 11){
              controller.notValidPhoneNumber.value = true;
            }else{
              controller.notValidPhoneNumber.value = false;
            }
          },
          maxLines: 1,
          maxLength: 11,
          decoration: InputDecoration(
            labelText: AppStrings.phoneNumberText,
            prefixIcon: _buildIcon('./assets/icons/ic_phone.svg'),
            errorText: controller.notValidPhoneNumber.value ? 'الرجاء ادخال رقم هاتف صالح' : null
          ),
        ),
      ],
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: [
        SizedBox(height: 8),
        TextField(
          controller: controller.cityController,
          decoration: InputDecoration(labelText: AppStrings.city),
          maxLines: 1,
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller.townController,
          decoration: InputDecoration(labelText: AppStrings.town),
          maxLines: 1,
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller.addressController,
          decoration: InputDecoration(labelText: AppStrings.addressDetails),
          maxLines: 1,
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller.noteController,
          decoration: InputDecoration(labelText: AppStrings.orderNotes),
          maxLines: 2,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildItemInfoFields() {
    return Column(
      children: [
        TextField(
          controller: controller.itemNameController,
          decoration: InputDecoration(labelText: AppStrings.itemName),
          maxLines: 1,
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller.customPriceController,
          decoration: InputDecoration(labelText: AppStrings.price),
          maxLines: 1,
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller.itemQtyController,
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: InputDecoration(labelText: AppStrings.quantity),
        ),
      ],
    );
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

  Widget _buildIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(
        assetPath,
        height: 24,
        width: 24,
        colorFilter: const ColorFilter.mode(AppColors.grey400Color, BlendMode.srcIn),
      ),
    );
  }

  Widget _buildItemSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        const Text(AppStrings.availableItems, style: TextStyle(fontSize: 16)),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return Obx(
                () => CheckboxListTile(
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppStrings.price} ${item.orginalPrice} ${item.pricingCurrency.toLowerCase() == 'iqd' ? AppStrings.iqd : item.pricingCurrency}',
                      ),
                      if (controller.selectedItems.any((si) => si.item.id == item.id)) _buildQuantityField(item),
                    ],
                  ),
                  /*secondary: item.attachments.isNotEmpty
                  ? Image.network(item.attachments.first.url)
                  : null,*/
                  value: controller.selectedItems.any((si) => si.item.id == item.id),
                  onChanged: (_) => controller.toggleItemSelection(item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityField(ItemModel item) {
    final selectedItem = controller.selectedItems.firstWhere((si) => si.item.id == item.id);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: selectedItem.quantityController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: AppStrings.quantity,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        onChanged: (_) => controller.validateForm(),
      ),
    );
  }
}
