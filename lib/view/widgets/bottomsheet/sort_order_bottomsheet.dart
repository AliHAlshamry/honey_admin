import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/sort_controller.dart';
import '../../../utils/constants/text_styles.dart';

class SortOrderBottomSheet extends StatelessWidget {
  final void Function(String sortBy, String sortOrder) onSortSelected;

  final SortController ctrl;

  const SortOrderBottomSheet({super.key, required this.onSortSelected, required this.ctrl});


  @override
  Widget build(BuildContext context) {

    // the two dimensions
    final sortByValues = ['name', 'totalPrice', 'updatedAt', 'currentStatus', 'city'];
    final sortByLabels = ['name'.tr, 'price'.tr, 'creating_time'.tr, 'according_status'.tr, 'city'.tr];
    final orderValues = ['asc', 'desc'];
    final orderLabels = ['asc'.tr, 'desc'.tr];

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // — Sort-By Section —
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('sort'.tr, style: TextStyles.textBold18),
          ),
          const Divider(height: 1, thickness: 1),
          ListView.builder(
            itemCount: sortByValues.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder:
                (_, i) => Obx(() {
              final val = sortByValues[i];
              return _buildSortOption(
                context,
                sortByLabels[i],
                ctrl.selectedSortBy.value == val,
                    () => ctrl.changeSortBy(val),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('sortOrder'.tr, style: TextStyles.textBold18),
          ),
          const Divider(height: 1, thickness: 1),
          ListView.builder(
            itemCount: orderValues.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder:
                (_, i) => Obx(() {
              final val = orderValues[i];
              return _buildSortOption(
                context,
                orderLabels[i],
                ctrl.selectedSortOrder.value == val,
                    () => ctrl.changeSortOrder(val),
              );
            }),
          ),

          // — Apply Button —
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  onSortSelected(ctrl.selectedSortBy.value, ctrl.selectedSortOrder.value);
                  Navigator.pop(context);
                },
                child: Text('apply'.tr),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal)),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade400, width: 1.5),
              ),
              child:
              isSelected
                  ? Container(
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}