import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/orders_controller.dart';
import '../../../utils/constants/text_styles.dart';
import '../../../utils/constants/app_strings.dart';

class FilterBottomSheet extends StatelessWidget {
  final OrdersController controller;
  final VoidCallback onFiltersApplied;

  const FilterBottomSheet({
    super.key,
    required this.controller,
    required this.onFiltersApplied,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.filterBy, style: TextStyles.textBold18),
                TextButton(
                  onPressed: () {
                    controller.clearAllFilters();
                  },
                  child: Text(
                    AppStrings.clearAll,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),

          // Order Type Section
          const SizedBox(height: 16),

          // Status Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(AppStrings.status, style: TextStyles.textBold16),
          ),
          const SizedBox(height: 8),

          // Status Options
          Obx(() => Column(
            children: [
              _buildFilterOption(
                context,
                AppStrings.all,
                controller.selectedStatus.value.isEmpty,
                    () => controller.updateStatus(''),
              ),
              ...controller.orderStatuses.map((status) => _buildFilterOption(
                context,
                AppStrings.getOrderStatus(status),
                controller.selectedStatus.value == status,
                    () => controller.updateStatus(status),
              )),
            ],
          )),

          const SizedBox(height: 24),

          // Apply Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  onFiltersApplied();
                  Navigator.pop(context);
                },
                child: Text(AppStrings.apply),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(
      BuildContext context,
      String label,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Container(
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
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