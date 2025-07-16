import 'package:get/get.dart';

class SortController extends GetxController {
  final selectedSortBy = 'updatedAt'.obs;
  final selectedSortOrder = 'desc'.obs;

  void changeSortBy(String by) => selectedSortBy.value = by;

  void changeSortOrder(String ord) => selectedSortOrder.value = ord;
}