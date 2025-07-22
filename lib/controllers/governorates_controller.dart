import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:honey_admin/models/governorate_model.dart';
import 'package:honey_admin/utils/constants/api_urls.dart';

import '../api/api_utils.dart';
import '../utils/constants/app_strings.dart';

class GovernoratesController extends GetxController {
  final RxBool loading = false.obs;
  final RxBool districtsLoading = false.obs;
  final RxList<GovernorateModel> governorates = <GovernorateModel>[].obs;
  final RxList<GovernorateModel> districts = <GovernorateModel>[].obs;
  // Add properties to store selected IDs
  final RxString selectedGovernorateId = ''.obs;
  final RxString selectedDistrictId = ''.obs;
  int _currentPage = 1;
  final int _pageSize = 18;
  bool _hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchGovernorates('GOV');
  }

  Future<void> fetchGovernorates(String level, {String? parentId}) async {
    try {
      loading(true);
      EasyLoading.show(status: AppStrings.loading);
      final response = await ApiUtils().get(
        endpoint: ApiUrls.governoratesUrl,
        queryParameters: {"level": level, if (parentId != null) 'parentId': parentId, 'skip': 1, 'take': 18},
      );
      final items = List<GovernorateModel>.from(
        response.data['data'].map((e) => GovernorateModel.fromJson(jsonEncode(e))),
      );
      governorates.assignAll(items);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load items');
    } finally {
      loading(false);
      EasyLoading.dismiss();
    }
  }
  Future<void> fetchDistricts(
      String level, {
        String? parentId,
        String? searchQuery,
        bool isPagination = false,
      }) async {
    try {
      if (!isPagination) {
        districts.clear();
        _currentPage = 1; // reset to first page when not pagination
        _hasMore = true;
        districtsLoading(true);
      } else {
        if (!_hasMore) return; // no more pages to load
      }

      final Map<String, dynamic> queryParams = {
        "level": level,
        if (parentId != null) 'parentId': parentId,
        'skip': _currentPage,
        'take': _pageSize,
        if (searchQuery != null && searchQuery.isNotEmpty) 'search': searchQuery,
      };

      final response = await ApiUtils().get(
        endpoint: ApiUrls.governoratesUrl,
        queryParameters: queryParams,
      );

      if (response.data != null && response.data['data'] != null) {
        final items = List<GovernorateModel>.from(
          response.data['data'].map((e) => GovernorateModel.fromJson(jsonEncode(e))),
        );

        if (items.isNotEmpty) {
          districts.addAll(items);
          _currentPage++; // increase page number
          if (items.length < _pageSize) {
            _hasMore = false; // if received less than page size, no more pages
          }
        } else {
          _hasMore = false;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load districts');
    } finally {
      districtsLoading(false);
      EasyLoading.dismiss();
    }
  }

  // Method to set selected governorate
  void setSelectedGovernorate(GovernorateModel governorate) {
    selectedGovernorateId.value = governorate.id;
    // Clear district selection when governorate changes
    selectedDistrictId.value = '';
  }

  // Method to set selected district
  void setSelectedDistrict(GovernorateModel district) {
    selectedDistrictId.value = district.id;
  }

  /// Clear all selections and districts
  void clear() {
    selectedGovernorateId.value = '';
    selectedDistrictId.value = '';
    districts.clear();
    loading.value = false;
    districtsLoading.value = false;
    // Reset pagination
    _currentPage = 1;
    _hasMore = true;
  }

  /// Clear everything including governorates (complete reset)
  void clearAll() {
    clear();
    governorates.clear();
  }
}
