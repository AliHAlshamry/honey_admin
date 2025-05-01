import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honey_admin/view/widgets/custom_inkwell.dart';

import '../../../../controllers/direct_controller.dart';
import '../../../../controllers/governorates_controller.dart';
import '../../../../utils/constants/app_strings.dart';
import 'custom_svg_icon.dart';
import 'location_selector_widget.dart';

class AddressFields extends GetView<DirectController> {
  const AddressFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        CitySelectorWidget(
          cityController: controller.cityController,
          onPress: () {
            // Show bottom sheet with governorates list
            final governoratesController = Get.find<GovernoratesController>();
            showGovernoratesBottomSheet(
              context,
              governoratesController,
              controller.cityController,
              controller.townController,
            );
          },
        ),
        const SizedBox(height: 8),
        DistrictsSelectorWidget(townController: controller.townController),
        const SizedBox(height: 8),
        TextField(
          controller: controller.addressController,
          decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.addressDetails,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_location.svg'),
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.noteController,
          decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.orderNotes,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_edit.svg'),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class CitySelectorWidget extends StatelessWidget {
  final TextEditingController cityController;
  final VoidCallback onPress;

  const CitySelectorWidget({super.key, required this.onPress, required this.cityController});

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      onTap: onPress,
      child: AbsorbPointer(
        // AbsorbPointer prevents the TextField from receiving input directly
        child: TextField(
          controller: cityController,
          decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: AppStrings.city,
            prefixIcon: CustomSvgIcon(assetsPath: './assets/icons/ic_route.svg'),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}

void showGovernoratesBottomSheet(
  BuildContext context,
  GovernoratesController governoratesController,
  TextEditingController cityController,
  TextEditingController townController,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('اختر المحافظة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Obx(() {
              if (governoratesController.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (governoratesController.governorates.isEmpty) {
                return const Center(child: Text('No governorates available'));
              }

              return Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: governoratesController.governorates.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final governorate = governoratesController.governorates[index];
                    return ListTile(
                      title: Text(governorate.name),
                      onTap: () {
                        // Set the selected governorate's name to the text field
                        cityController.text = governorate.name;
                        governoratesController.selectedGovernorateId.value = governorate.id;
                        governoratesController.fetchDistricts('DIST', parentId: governorate.id); //TODO make it enum
                        governoratesController.selectedDistrictId.value = '';
                        governoratesController.districts.clear();
                        townController.clear();
                        // Close the bottom sheet
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      );
    },
  );
}
