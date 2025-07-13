import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../api/api_utils.dart';
import '../api/end_points.dart';
import '../models/order_model.dart';
import '../models/serializers.dart';
import '../models/status_model.dart';

class OrdersController extends GetxController {
  /// Holds the fetched categories
  final RxList<StatusModel> ordersStatus = <StatusModel>[].obs;

  /// Pagination controller
  final PagingController<int, OrderModel> pagingController = PagingController(firstPageKey: 1);

  /// Pagination info
  final RxInt totalCount = 0.obs;
  final RxInt pageCount = 0.obs;

  final RxString keywords = ''.obs;
  final sortBy = Rx<String?>(null);
  final sortOrder = 'asc'.obs;

  /// New filter properties
  final RxString selectedOrderType = ''.obs; // '', 'regular', 'custom'
  final RxString selectedStatus = ''.obs; // '', 'pending', 'preparing', 'delivering', 'complete'

  /// Loading flag
  final RxBool isLoading = false.obs;

  // Remove the old selectedStatus as it's replaced by the new one
  // final Rxn<StatusModel> selectedStatus = Rxn<StatusModel>();

  /// Filter options
  final List<String> orderTypes = ['REGULAR', 'MANUAL'];
  final List<String> orderStatuses = ['pending', 'preparing', 'delivery', 'delivered', 'cancelled', 'ready'];

  @override
  void onInit() {
    super.onInit();
    //fetchStatus();

    // Listen for changes in filters and refresh pagination
    ever<String>(selectedOrderType, (_) => refreshPagination());
    ever<String>(selectedStatus, (_) => refreshPagination());

    // Setup pagination listener
    pagingController.addPageRequestListener((pageKey) {
      fetchOrders(pageKey);
    });
  }

  Future<List<StatusModel>> fetchStatus() async {
    isLoading.value = true;
    try {
      ordersStatus.clear();
      final response = await ApiUtils().get(endpoint: EndPoints.status);

      if (response.statusCode == 200) {
        final rawList = response.data as List<dynamic>;

        final items =
        rawList
            .cast<Map<String, dynamic>>()
            .map((json) => serializers.deserializeWith(StatusModel.serializer, json))
            .whereType<StatusModel>()
            .toList();

        ordersStatus.assignAll(items);
        return items;
      } else {
        printError(info: 'Unexpected status: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      printError(info: 'DioError in fetchStatus: ${e.message}');
      return [];
    } catch (e) {
      printError(info: 'Error in fetchStatus: $e');
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper method to get English order type for backend
  String _getEnglishOrderType(String orderType) {
    switch (orderType.toLowerCase()) {
      case 'regular':
        return 'REGULAR';
      case 'MANUAL':
        return 'MANUAL';
      default:
        return orderType.toUpperCase();
    }
  }

  /// Helper method to get English status for backend
  String _getEnglishStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'PENDING';
      case 'preparing':
        return 'PREPARING';
      case 'ready':
        return 'READY';
      case 'delivery':
        return 'DELIVERY';
      case 'delivered':
        return 'DELIVERED';
      case 'cancelled':
        return 'CANCELLED';
      default:
        return status.toUpperCase();
    }
  }

  Future<void> fetchOrders(int pageKey) async {
    try {
      final Map<String, String> queryParams = {
        "skip": pageKey.toString(),
        "take": "20",
        'sortDirection': sortOrder.value,
      };

      // Add conditional parameters
      if (keywords.value.isNotEmpty) {
        queryParams["search"] = keywords.value;
      }

      if (sortBy.value != null) {
        queryParams['sortBy'] = sortBy.value!;
      }

      // Add new filter parameters with English values
      if (selectedOrderType.value.isNotEmpty) {
        queryParams['orderType'] = _getEnglishOrderType(selectedOrderType.value);
      }

      if (selectedStatus.value.isNotEmpty) {
        queryParams['status'] = _getEnglishStatus(selectedStatus.value);
      }
      debugPrint(queryParams.toString());

      final response = await ApiUtils().get(
        endpoint: EndPoints.ordersUser,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final payload = Map<String, dynamic>.from(response.data);
        final items =
        (payload['data'] as List)
            .cast<Map<String, dynamic>>()
            .map((json) => serializers.deserializeWith(OrderModel.serializer, json))
            .whereType<OrderModel>()
            .toList();

        final int totalCount = payload['totalCount'] as int;
        this.totalCount.value = totalCount;
        pageCount.value = payload['pageCount'] as int;

        final isLastPage = (pageKey * items.length) >= totalCount;
        if (isLastPage) {
          pagingController.appendLastPage(items);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(items, nextPageKey);
        }
      } else {
        pagingController.error = 'Server error: ${response.statusCode}';
      }
    } on DioException catch (e) {
      pagingController.error = 'DioError: ${e.message}';
    } catch (e) {
      pagingController.error = 'Error: $e';
    }
  }

  Future<void> cancelOrder (String orderId, String? representativeId) async{
    try {
      final Map<String, String> queryParams = {
        "status" : "CANCELLED"
      };

      debugPrint('${EndPoints.orders}$orderId/status');

      final response = await ApiUtils().patch(
        endpoint: '${EndPoints.orders}$orderId/status',
        body: queryParams
      );

      if (response.statusCode == 200) {
        pagingController.refresh();
      } else {
        pagingController.error = 'Server error: ${response.statusCode}';
      }
    } on DioException catch (e) {
      pagingController.error = 'DioError: ${e.message}';
      debugPrint('$e');
    } catch (e) {
      debugPrint('$e');
      pagingController.error = 'Error: $e';
    }
  }

  void refreshPagination() {
    pagingController.refresh();
  }

  void updateSearch(String newKeywords) {
    keywords.value = newKeywords;
    refreshPagination();
  }

  void updateSort(String? newSortBy, String newSortOrder) {
    sortBy.value = newSortBy;
    sortOrder.value = newSortOrder;
    refreshPagination();
  }

  /// New filter methods
  void updateOrderType(String orderType) {
    selectedOrderType.value = orderType;
    // refreshPagination is called automatically by the listener
  }

  void updateStatus(String status) {
    selectedStatus.value = status;
    // refreshPagination is called automatically by the listener
  }

  void clearOrderTypeFilter() {
    selectedOrderType.value = '';
  }

  void clearStatusFilter() {
    selectedStatus.value = '';
  }

  void clearAllFilters() {
    selectedOrderType.value = '';
    selectedStatus.value = '';
    keywords.value = '';
    sortBy.value = null;
    sortOrder.value = 'asc';
    refreshPagination();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}