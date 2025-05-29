import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:honey_admin/view/screens/direct_order_screen/widgets/custom_svg_icon.dart';

import '../../../../controllers/direct_controller.dart';
import '../../../../utils/constants/app_strings.dart';

class CustomerInfoFields extends GetView<DirectController> {
  const CustomerInfoFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller.nameController,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.customerNameText,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_profile.svg'),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (val) {
              if (!val.startsWith('07') && val.length == 11) {
                controller.notValidPhoneNumber.value = true;
              } else {
                controller.notValidPhoneNumber.value = false;
              }
            },
            maxLines: 1,
            maxLength: 11,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
              labelText: AppStrings.phoneNumberText,
              prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_phone.svg'),
              errorText: controller.notValidPhoneNumber.value ? 'الرجاء ادخال رقم هاتف صالح' : null,
            ),
          ),
        ),
      ],
    );
  }
}
