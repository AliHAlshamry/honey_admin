import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honey_admin/controllers/items_controller.dart';
import 'package:honey_admin/models/order_dto.dart';
import 'package:honey_admin/utils/constants/api_urls.dart';

import '../api/api_utils.dart';
import '../models/item_model.dart';
import '../models/serializers.dart';
import '../utils/constants/app_strings.dart';
import 'governorates_controller.dart';

class CartController extends GetxController {
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

  final RxList<ItemModel> items = <ItemModel>[].obs;
  final RxList<ItemModel> products = <ItemModel>[].obs;
  final RxBool loading = false.obs;
  final RxBool loadingItems = false.obs;
  final RxDouble totalPrice = 0.0.obs;
  final cartController = Get.find<ItemController>();

  // Validation
  RxBool isValid = false.obs;
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
      Scrollable.ensureVisible(context, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
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

  void validateForm() {
    isValid.value =
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        governoratesController.selectedDistrictId.value != '' &&
        checkSelectedItems();
  }

  void clearAllFields() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    noteController.clear();
    itemNameController.clear();
    itemQtyController.clear();
    customPriceController.clear();
    cityController.clear();
    townController.clear();
  }

  Future<void> fetchItems({bool isPagination = false}) async {
    if (loadingItems.value) return;

    try {
      loadingItems(true);
      if (!isPagination) {
        _currentPage = 1;
        hasMoreItems = true;
        products.clear();
      }

      final response = await ApiUtils().get(
        endpoint: ApiUrls.itemsUrl,
        queryParameters: {'skip': _currentPage, 'take': _pageSize},
      );

      final itemListResponse = serializers.deserializeWith(ItemListResponse.serializer, response.data);

      final List<ItemModel> newItems = (itemListResponse?.data ?? <ItemModel>[]).toList();

      if (newItems.isNotEmpty) {
        products.addAll(newItems);
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
      String phoneNumber = '+964${phoneController.text.substring(1)}';
      final dto = OrderDto.fromControllerData(
        custName: nameController.text,
        custPhone: phoneNumber,
        cityId: governoratesController.selectedDistrictId.value,
        address: addressController.text,
        note: noteController.text,
        cartItems: cartController.items,
      );

      final payload = dto.toJson();

      final response = await ApiUtils().post(
        endpoint: ApiUrls.ordersUrl,
        data: payload,
      );

      if (response.statusCode == 201) {
        // Clear all form fields
        clearAllFields();

        // Clear all cart items and custom products
        itemController.clear();

        // Clear CartController lists
        items.clear();
        products.clear();

        // Reset pagination
        _currentPage = 1;
        hasMoreItems = true;

        // Refetch items from the beginning
        await fetchItems();

        // Update total price
        itemController.updateTotalPrice();

        // Reset GovernoratesController state
        governoratesController.clear();

        // Reset validation
        isValid.value = false;

        // Show success message and go back
        Get.back();
        Get.snackbar(AppStrings.success, AppStrings.orderCreated);
      }
    } catch (e) {
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
    cartController.items.clear();
    super.onClose();
  }

  bool checkSelectedItems() {
    return
        itemController.items.isNotEmpty;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
