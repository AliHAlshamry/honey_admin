import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../api/api_utils.dart';
import '../models/direct_order_model.dart';
import '../models/item_model.dart';
import '../models/serializers.dart';
import '../utils/constants/app_strings.dart';

///helper :
class SelectedItem {
  final ItemModel item;
  final TextEditingController quantityController;

  SelectedItem(this.item, {int initialQuantity = 1})
      : quantityController = TextEditingController(text: initialQuantity.toString());
}

class DirectController extends GetxController {
  // Order Type
  final RxString orderType = 'REGULAR'.obs;

  // Form Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final townController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final noteController = TextEditingController();
  final itemNameController = TextEditingController();
  final itemQtyController = TextEditingController();
  final customPriceController = TextEditingController();

  final Rxn<double> selectedPrice = Rxn<double>();
  final RxList<ItemModel> items = <ItemModel>[].obs;
  final quantityController = TextEditingController();
  final RxBool loading = false.obs;

  // Validation
  RxBool isValid = false.obs;
  final RxList<SelectedItem> selectedItems = <SelectedItem>[].obs;

  final RxBool notValidPhoneNumber = false.obs;

  void toggleItemSelection(ItemModel item) {
    final existingIndex = selectedItems.indexWhere((si) => si.item.id == item.id);
    if (existingIndex >= 0) {
      selectedItems[existingIndex].quantityController.dispose();
      selectedItems.removeAt(existingIndex);
    } else {
      selectedItems.add(SelectedItem(item));
    }
    validateForm();
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(validateForm);
    phoneController.addListener(validateForm);
    townController.addListener(validateForm);
    cityController.addListener(validateForm);
    itemNameController.addListener(validateForm);
    itemQtyController.addListener(validateForm);
    customPriceController.addListener(validateForm);
    ever(orderType, (_) => validateForm());
    ever(selectedPrice, (_) => validateForm());
    fetchItems();
  }

  void setOrderType(String type) {
    orderType.value = type;
    selectedPrice.value = null;
    customPriceController.clear();
  }

  void selectPrice(double price) {
    selectedPrice.value = price;
  }

  void validateForm() {
    if (orderType.value == 'REGULAR') {
      bool quantitiesValid = selectedItems.every((si) =>
          si.quantityController.text.isNotEmpty &&
          int.tryParse(si.quantityController.text) != null &&
          int.parse(si.quantityController.text) > 0);

      isValid.value = nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          selectedItems.isNotEmpty &&
          quantitiesValid;
    } else {
      isValid.value = nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          itemNameController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          itemQtyController.text.isNotEmpty &&
          customPriceController.text.isNotEmpty &&
          cityController.text.isNotEmpty;
    }
  }

  void clearAllFields() {
    nameController.clear();
    phoneController.clear();
    townController.clear();
    cityController.clear();
    addressController.clear();
    noteController.clear();
    itemNameController.clear();
    itemQtyController.clear();
    customPriceController.clear();
    quantityController.clear();

    selectedPrice.value = null;
    selectedItems.clear();
  }

  Future<void> fetchItems() async {
    try {
      loading(true);
      EasyLoading.show(status: AppStrings.loading);
      final response = await ApiUtils().get(endpoint: 'https://api.honey-comb.store/oms/items');
      final itemListResponse = serializers.deserializeWith(
        ItemListResponse.serializer,
        response.data,
      );
      items.assignAll(itemListResponse?.data ?? []);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load items');
    }finally{
      loading(false);
      EasyLoading.dismiss();
    }
  }

  Future<void> submitOrder() async {
    try {
      String phoneNumber = '+964${phoneController.text.substring(1)}';
      final order = DirectOrderModel((b) => b
        ..orderType = orderType.value
        ..custName = nameController.text
        ..custPhone = phoneNumber
        ..custTown = townController.text
        ..custCity = cityController.text
        ..addressDetails = addressController.text
        ..note = noteController.text
        ..orderItems.replace(selectedItems.map((si) => OrderItemModel((i) => i
          ..name = si.item.name
          ..qty = int.parse(si.quantityController.text)
          ..price = double.parse(si.item.orginalPrice)))));

      final response = await ApiUtils().post(
        endpoint: 'https://api.honey-comb.store/oms/orders',
        data: serializers.serializeWith(DirectOrderModel.serializer, order) as Map<String, dynamic>,
      );

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar(AppStrings.success, AppStrings.orderCreated);
        clearAllFields();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create order');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    townController.dispose();
    cityController.dispose();
    addressController.dispose();
    noteController.dispose();
    itemNameController.dispose();
    itemQtyController.dispose();
    customPriceController.dispose();
    for (var item in selectedItems) {
      item.quantityController.dispose();
    }
    super.onClose();
  }
}
