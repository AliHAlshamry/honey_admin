import 'package:get/get.dart';

class SortController extends GetxController {
  final selectedSortBy = 'name'.obs;
  final selectedSortOrder = 'asc'.obs;

  void changeSortBy(String by) => selectedSortBy.value = by;

  void changeSortOrder(String ord) => selectedSortOrder.value = ord;
}