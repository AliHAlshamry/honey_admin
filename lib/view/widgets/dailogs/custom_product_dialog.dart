import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../../controllers/items_controller.dart';
import '../../../models/custom_product_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/text_styles.dart';
import '../../../utils/enum.dart';
import '../toast_custom_message.dart';


class CustomProductDialog extends StatelessWidget {
  CustomProductDialog({super.key, this.customProduct});

  final CustomProductModel? customProduct;
  //final CartController cartController = Get.find<CartController>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  final descriptionController = TextEditingController();

  // Add image reactive variable
  final Rx<File?> selectedImage = Rx<File?>(null);

  @override
  Widget build(BuildContext context) {
    if (customProduct != null) {
      nameController.text = customProduct!.name;
      priceController.text = customProduct!.price;
      qtyController.text = customProduct!.availableQty.toString();
      descriptionController.text = customProduct!.description ?? '';
      // Set existing image if available
      if (customProduct!.imagePath != null) {
        selectedImage.value = File(customProduct!.imagePath!);
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView( // Add scroll view for longer content
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    customProduct != null
                        ? AppStrings.editCustomProduct
                        : AppStrings.addCustomProduct,
                    style: TextStyles.textSemiBold16,
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Product Image Section
             /* Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: CustomInkwell(
                    onTap: () => _showImagePicker(),
                    child: Obx(() {
                      if (selectedImage.value != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            selectedImage.value!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'upload_image'.tr,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),*/
              const SizedBox(height: 20),

              // Product Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppStrings.productName,
                  hintText: AppStrings.enterProductName,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),

              // Price and Quantity Row
              Row(
                children: [
                  // Price
                  Expanded(
                    child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: AppStrings.price,
                        hintText: '0.00',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixText: AppStrings.iqd,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Quantity
                  Expanded(
                    child: TextFormField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppStrings.quantity,
                        hintText: '1',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description (Optional)
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: AppStrings.enterProductDescriptionHint,
                  hintText: AppStrings.enterDescription,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(AppStrings.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Save Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveCustomProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        customProduct != null ? AppStrings.update : AppStrings.add,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCustomProduct() {
    final CartController cartController = Get.find<CartController>();
    if (nameController.text.trim().isEmpty) {
      showCustomMessage(title: AppStrings.error, subtitle: AppStrings.enterNameHint, status: MessageType.error);
      return;
    }

    if (priceController.text.trim().isEmpty || double.tryParse(priceController.text) == null) {
      showCustomMessage(title: AppStrings.error, subtitle: AppStrings.enterPriceHint, status: MessageType.error);
      return;
    }

    if (qtyController.text.trim().isEmpty || int.tryParse(qtyController.text) == null || int.parse(qtyController.text) < 1) {
      showCustomMessage(title: AppStrings.error, subtitle: AppStrings.enterQuantityHint, status: MessageType.error);
      return;
    }

    final name = nameController.text.trim();
    final price = priceController.text.trim();
    final qty = int.parse(qtyController.text);
    final description = descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim();
    final imagePath = selectedImage.value?.path; // Get image path
    final controller = Get.find<ItemController>();
    if (customProduct != null) {
      final cartItem = cartController.editCustomProduct(
        customProduct!.id,
        name,
        price,
        qty,
        description: description,
        imagePath: imagePath, // Pass image path
      );
      if (cartItem != null) {
        controller.remove(cartItem.item);
        controller.incrementQuantity(cartItem.item, quantity: qty.toDouble());
      }
      Get.back();
      showCustomMessage(title: AppStrings.update, subtitle: AppStrings.updateProductSuccessfully);
    } else {
      final cartItem = cartController.addCustomProduct(
        name,
        price,
        qty,
        description: description,
        imagePath: imagePath, // Pass image path
      );
      if (cartItem != null) {
        controller.remove(cartItem.item);
        controller.incrementQuantity(cartItem.item, quantity: qty.toDouble());
      }
      Get.back();
      showCustomMessage(title: AppStrings.success, subtitle: AppStrings.addedProductSuccessfully);
    }
  }
}