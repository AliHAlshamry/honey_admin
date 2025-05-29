import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honey_admin/controllers/items_controller.dart';
import 'package:honey_admin/utils/constants/api_urls.dart';

import '../api/api_utils.dart';
import '../models/direct_order_model.dart';
import '../models/item_model.dart';
import '../models/serializers.dart';
import '../utils/constants/app_strings.dart';
import 'governorates_controller.dart';

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
  final RxBool loadingItems = false.obs;

  // Validation
  RxBool isValid = false.obs;
  final RxList<SelectedItem> selectedItems = <SelectedItem>[].obs;
  late GovernoratesController governoratesController;
  late ItemController itemController;

  //pagination
  int _currentPage = 1;
  final int _pageSize = 20;
  bool hasMoreItems = true;
  final ScrollController scrollController = ScrollController();

  final RxBool notValidPhoneNumber = false.obs;

  final orderButtonKey = GlobalKey();

  void scrollToButton() {
    final context = orderButtonKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    if (Get.isRegistered<GovernoratesController>()) {
      governoratesController = Get.find<GovernoratesController>();
    } else {
      governoratesController = Get.put(GovernoratesController());
    }
    itemController = Get.find<ItemController>();
    ever(itemController.totalPrice, (_) => validateForm());
    nameController.addListener(validateForm);
    phoneController.addListener(validateForm);
    addressController.addListener(validateForm);
    itemNameController.addListener(validateForm);
    itemQtyController.addListener(validateForm);
    customPriceController.addListener(validateForm);
    noteController.addListener(validateForm);
    ever(orderType, (_) => validateForm());
    ever(selectedPrice, (_) => validateForm());
    await fetchItems();

    scrollController.addListener(() {
      debugPrint('Scroll position: ${scrollController.position.pixels} / ${scrollController.position.maxScrollExtent}');
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        if (!loadingItems.value && hasMoreItems) {
          debugPrint('Fetching more items...');
          fetchItems(isPagination: true);
        }
      }
    });
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
      isValid.value =
          nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          governoratesController.selectedDistrictId.value != '' &&
          checkSelectedItems();
    } else {
      isValid.value =
          nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          itemNameController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          itemQtyController.text.isNotEmpty &&
          customPriceController.text.isNotEmpty &&
          governoratesController.selectedDistrictId.value != '';
    }
  }

  void clearAllFields() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    noteController.clear();
    itemNameController.clear();
    itemQtyController.clear();
    customPriceController.clear();
    quantityController.clear();
    cityController.clear();
    townController.clear();
    selectedPrice.value = null;
    selectedItems.clear();
  }

  Future<void> fetchItems({bool isPagination = false}) async {
    if (loadingItems.value) return;

    try {
      loadingItems(true);
      if (!isPagination) {
        _currentPage = 1;
        hasMoreItems = true;
        items.clear();
      }

      final response = await ApiUtils().get(
        endpoint: ApiUrls.itemsUrl,
        queryParameters: {'skip': _currentPage, 'take': _pageSize},
      );

      final itemListResponse = serializers.deserializeWith(ItemListResponse.serializer, response.data);

      final List<ItemModel> newItems = (itemListResponse?.data ?? <ItemModel>[]).toList();

      if (newItems.isNotEmpty) {
        items.addAll(newItems);
        _currentPage++;
        if (newItems.length < _pageSize) {
          hasMoreItems = false;
        }
      } else {
        hasMoreItems = false;
        loadingItems(false);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load items');
    } finally {
      loadingItems(false);
    }
  }

  Future<void> submitOrder() async {
    try {
      final itemController = Get.find<ItemController>();
      String phoneNumber = '+964${phoneController.text.substring(1)}';
      List<OrderItemModel> orderItems;
      if (orderType.value != 'REGULAR') {
        orderItems = [
          OrderItemModel(
            (p0) =>
                p0
                  ..name = itemNameController.text
                  ..qty = int.parse(itemQtyController.text)
                  ..price = double.parse(customPriceController.text.replaceAll(',', '')),
          ),
        ];
      } else {
        orderItems =
            itemController.item.entries
                .where((entry) => entry.value > 0)
                .map(
                  (entry) => OrderItemModel(
                    (p0) =>
                        p0
                          ..name = entry.key.name
                          ..qty = entry.value.toInt()
                          ..price = double.parse(entry.key.discountedPrice ?? entry.key.orginalPrice),
                  ),
                )
                .toList();
      }
      final order = DirectOrderModel(
        (b) =>
            b
              ..orderType = orderType.value
              ..custName = nameController.text
              ..custPhone = phoneNumber
              ..cityId = governoratesController.selectedDistrictId.value
              ..addressDetails = addressController.text
              ..note = noteController.text
              ..orderItems.replace(orderItems),
      );

      final response = await ApiUtils().post(
        endpoint: ApiUrls.ordersUrl,
        data: serializers.serializeWith(DirectOrderModel.serializer, order) as Map<String, dynamic>,
      );

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar(AppStrings.success, AppStrings.orderCreated);
        clearAllFields();
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to create order');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
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

  bool checkSelectedItems() {
    List<OrderItemModel> orderItems =
        itemController.item.entries
            .where((entry) => entry.value > 0)
            .map(
              (entry) => OrderItemModel(
                (p0) =>
                    p0
                      ..name = entry.key.name
                      ..qty = entry.value.toInt()
                      ..price = double.parse(entry.key.discountedPrice ?? entry.key.orginalPrice),
              ),
            )
            .toList();
    return orderItems.isNotEmpty;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
