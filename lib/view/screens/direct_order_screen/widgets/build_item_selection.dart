import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/direct_controller.dart';
import '../../../../utils/constants/app_strings.dart';
import 'pagination_items_list.dart';

class BuildItemSelection extends GetView<DirectController> {
  const BuildItemSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(AppStrings.availableItems, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            PaginatedItemsList(),
          ],
        );
      },
    );
  }
}
