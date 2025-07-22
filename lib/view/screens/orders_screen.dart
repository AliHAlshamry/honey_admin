import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:honey_admin/generated/assets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../controllers/orders_controller.dart';
import '../../controllers/sort_controller.dart';
import '../../models/order_model.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_strings.dart';
import '../widgets/bottomsheet/filter_product_bottom_sheet.dart';
import '../widgets/bottomsheet/sort_bottom_sheet.dart';
import '../widgets/cards/order_card.dart';
import '../widgets/search_text_field.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // FILTER AND SORT BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Filter Button
                  TextButton.icon(
                    onPressed: () => _showFilterBottomSheet(),
                    icon: const Icon(Icons.filter_list),
                    label: Text(AppStrings.filterBy),
                  ),
                  const SizedBox(width: 8),
                  // Sort Button
                  TextButton.icon(
                    onPressed: () => _showSortBottomSheet(),
                    icon: const Icon(Icons.sort),
                    label: Text(AppStrings.sort),
                  ),
                ],
              ),

              // ACTIVE FILTERS DISPLAY
              Obx(() {
                final hasFilters = controller.selectedStatus.value.isNotEmpty;

                if (!hasFilters) return const SizedBox.shrink();

                return Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  children: [
                    if (controller.selectedStatus.value.isNotEmpty)
                      _buildFilterChip(
                        '${AppStrings.status}: ${AppStrings.getOrderStatus(controller.selectedStatus.value)}',
                            () => controller.clearStatusFilter(),
                      ),
                    if (hasFilters)
                      _buildClearAllChip(),
                  ],
                );
              }),

              // SEARCH FIELD
              SearchWidget(
                padding: const EdgeInsets.only(bottom: 8),
                hintText: AppStrings.searchHint,
                onChanged: (value) {
                  debugPrint('Search query changed: $value');
                  controller.updateSearch(value);
                },
                onSubmitted: (value) {
                  debugPrint('Search submitted: $value');
                  controller.updateSearch(value);
                },
                backgroundColor: Colors.white,
                borderRadius: 12.0,
              ),

              // ORDERS LIST
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: RefreshIndicator(
                  onRefresh: ()=> controller.refreshOrders(),
                  child: PagedListView<int, OrderModel>(
                    pagingController: controller.pagingController,
                    padding: const EdgeInsets.all(0),
                    physics: const BouncingScrollPhysics(),
                    builderDelegate: PagedChildBuilderDelegate<OrderModel>(
                      itemBuilder: (context, order, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: OrderCard(order: order),
                        );
                      },
                      firstPageErrorIndicatorBuilder: (context) => Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppStrings.errorFetchOrders, textAlign: TextAlign.center),
                            ElevatedButton(
                              onPressed: () => controller.pagingController.refresh(),
                              child: Text(AppStrings.retry),
                            ),
                          ],
                        ),
                      ),
                      newPageErrorIndicatorBuilder: (context) => Center(
                        child: Column(
                          children: [
                            Text(AppStrings.errorLoadingMoreOrders),
                            ElevatedButton(
                              onPressed: () => controller.pagingController.retryLastFailedRequest(),
                              child: Text(AppStrings.retry),
                            ),
                          ],
                        ),
                      ),
                      firstPageProgressIndicatorBuilder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                      newPageProgressIndicatorBuilder: (context) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.imagesEmptyCart),
                            const SizedBox(height: 8),
                            Text(AppStrings.noOrders),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      deleteIcon: const Icon(Icons.close, size: 16),
      onDeleted: onRemove,
      labelPadding: EdgeInsets.symmetric(horizontal: 4),
      backgroundColor: Colors.white,
      padding: EdgeInsets.zero,
      side: BorderSide(color: AppColors.primaryColor, width: 0.5),
    );
  }

  Widget _buildClearAllChip() {
    return ActionChip(
      label: Text(
        AppStrings.clearAll,
        style: const TextStyle(fontSize: 12, color: Colors.red),
      ),
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.symmetric(horizontal: 4),
      avatar: const Icon(Icons.clear_all, size: 16, color: Colors.red),
      onPressed: () => controller.clearAllFilters(),
      backgroundColor: Colors.white,
    );
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.bgColor,
      FilterBottomSheet(
        controller: controller,
        onFiltersApplied: () {},
      ),
    );
  }

  void _showSortBottomSheet() {
    final ctrl = Get.put(SortController(), tag: 'local_sort_controller');
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.bgColor,
      SortBottomSheet(
        ctrl: ctrl,
        onSortSelected: (by, order) {
          controller.updateSort(by, order);
          controller.refreshPagination();
        },
      ),
    );
  }
}