import 'package:get/get.dart';

extension FromValidators on String? {
  String? get isValidPhone {
    if (this != null &&
        this!.isNotEmpty &&
        (this!.length == 11 || this!.length == 10)) {
      return null;
    } else {
      return 'invalidPhone'.tr;
    }
  }

  String? get isValidText {
    if (this != null && this!.isNotEmpty) {
      return null;
    } else {
      return 'required'.tr;
    }
  }
}
