import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/cart_controller.dart';
import '../../../../utils/constants/app_strings.dart';
import 'custom_svg_icon.dart';

class BuildItemInfoFields extends GetView<CartController> {
  const BuildItemInfoFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller.itemNameController,
          decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.itemName,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_honey.svg'),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller.customPriceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            suffixText: AppStrings.iqd,
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.price,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_dollar.svg'),
          ),
          maxLines: 1,
          onChanged: (value) {
            double? price = double.tryParse(value.replaceAll(',', '').replaceAll('...', ''));

            if (price != null) {
              String formattedPrice = NumberFormat('#,###', 'en_US').format(price.round());

              if (formattedPrice.length > 12) {
                formattedPrice = '...${formattedPrice.substring(0, 24)}';
              }

              // Update controller with formatted text
              controller.customPriceController.value = TextEditingValue(
                text: formattedPrice,
                selection: TextSelection.collapsed(offset: formattedPrice.length),
              );
            }
          },
        ),

        SizedBox(height: 8),
        TextField(
          controller: controller.itemQtyController,
          keyboardType: TextInputType.number,
          maxLines: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.quantity,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_honey.svg'),
          ),
        ),
      ],
    );
  }
}
