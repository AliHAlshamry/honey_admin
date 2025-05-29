import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/direct_controller.dart';
import '../../../../utils/constants/app_strings.dart';

class OrderTypeSelector extends GetView<DirectController> {
  const OrderTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
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
              title: const Text(AppStrings.manual, style: TextStyle(fontSize: 12)),
              value: 'MANUAL',
              contentPadding: EdgeInsets.zero,
              groupValue: controller.orderType.value,
              onChanged: (value) => controller.setOrderType(value!),
            ),
          ),
        ],
      ),
    );
  }
}