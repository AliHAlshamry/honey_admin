import 'package:get/get.dart';

import 'package:flutter/material.dart';
class FilterController extends GetxController {
  final minInput = '0'.obs;
  final maxInput = '0'.obs;
  final minPriceTextController = TextEditingController();
  final maxPriceTextController = TextEditingController();

  double get minPrice => double.tryParse(minInput.value) ?? 0.0;

  double get maxPrice => double.tryParse(maxInput.value) ?? 0.0;

  bool get isValid =>
      double.tryParse(minInput.value) != null && double.tryParse(maxInput.value) != null && minPrice <= maxPrice;
}