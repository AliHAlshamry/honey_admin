// items_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../api/api_utils.dart';
import '../../models/item_model.dart';
import '../models/serializers.dart';

class ItemsController extends GetxController {
  final RxList<ItemModel> items = <ItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await ApiUtils().get(
        endpoint: 'https://api.honey-comb.store/oms/items',
      );
      // Deserialize the response using built_value serializers
      final itemListResponse = serializers.deserializeWith(
        ItemListResponse.serializer,
        response.data,
      );

      if (itemListResponse != null) {
        items.assignAll(itemListResponse.data.cast<ItemModel>().toList());
      }

    } on DioException catch (e) {
      error.value = 'Failed to load items: ${e.response?.data ?? e.message}';
    } finally {
      isLoading.value = false;
    }
  }
}