import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/governorates_controller.dart';
import '../../../../utils/constants/app_strings.dart';
import '../../../widgets/custom_inkwell.dart';
import 'custom_svg_icon.dart';

class DistrictsSelectorWidget extends StatelessWidget {
  final TextEditingController townController;

  const DistrictsSelectorWidget({super.key, required this.townController});

  @override
  Widget build(BuildContext context) {
    final governoratesController = Get.find<GovernoratesController>();

    return CustomInkwell(
      onTap: () {
        if (governoratesController.selectedGovernorateId.isEmpty) {
          Get.snackbar('تنبيه', 'الرجاء اختيار المحافظة اولا');
          return;
        }
        _showDistrictsBottomSheet(context, governoratesController);
      },
      child: AbsorbPointer(
        child: TextField(
          controller: townController,
          decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.town,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_route.svg'),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  void _showDistrictsBottomSheet(BuildContext context, GovernoratesController governoratesController) {
    final searchController = TextEditingController();
    Timer? debounce;
    final ScrollController scrollController = ScrollController();

    // Search debounce handler
    void onSearchChanged(String query) {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 500), () {
        governoratesController.fetchDistricts(
          'DIST',
          parentId: governoratesController.selectedGovernorateId.value,
          searchQuery: query,
        );
      });
    }

    // Initial load
    governoratesController.fetchDistricts('DIST', parentId: governoratesController.selectedGovernorateId.value);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Scroll listener for pagination
            scrollController.addListener(() {
              if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
                if (!governoratesController.districtsLoading.value) {
                  governoratesController.fetchDistricts(
                    'DIST',
                    parentId: governoratesController.selectedGovernorateId.value,
                    searchQuery: searchController.text,
                    isPagination: true,
                  );
                }
              }
            });

            return Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('اختر المنطقة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Search Field
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'البحث عن منطقة',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    onChanged: onSearchChanged,
                  ),
                  const SizedBox(height: 16),

                  // Districts List
                  Expanded(
                    child: Obx(() {
                      if (governoratesController.districtsLoading.value && governoratesController.districts.isEmpty) {
                        // Initial loading
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (governoratesController.districts.isEmpty) {
                        return const Center(child: Text('No districts available'));
                      }

                      return ListView.separated(
                        controller: scrollController,
                        itemCount: governoratesController.districts.length + 1, // +1 for loading indicator
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          if (index == governoratesController.districts.length) {
                            // Loading indicator at the bottom
                            if (governoratesController.districtsLoading.value) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }

                          final district = governoratesController.districts[index];
                          return ListTile(
                            title: Text(district.name),
                            onTap: () {
                              townController.text = district.name;
                              governoratesController.setSelectedDistrict(district);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // Cleanup when the bottom sheet is closed
      debounce?.cancel();
      scrollController.dispose();
    });
  }
}
