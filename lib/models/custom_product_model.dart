import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

import 'item_model.dart';

part 'custom_product_model.g.dart';

abstract class CustomProductModel implements Built<CustomProductModel, CustomProductModelBuilder> {
  static Serializer<CustomProductModel> get serializer => _$customProductModelSerializer;

  String get id;

  String get name;

  String get price;

  int get availableQty;

  String? get description;

  String? get imagePath;

  CustomProductModel._();

  factory CustomProductModel([void Function(CustomProductModelBuilder) updates]) = _$CustomProductModel;
}

extension CustomProductConversion on CustomProductModel {
  ItemModel toItemModel() {
    return ItemModel(
          (b) => b
        ..id = id
        ..name = name
        ..sku = id
        ..stockStatus = 'IN_STOCK'
        ..qty = availableQty
        ..orginalPrice = price
        ..discount = '0'
        ..discountedPrice = price
        ..pricingCurrency = 'IQD' // or your default currency
        ..visibilityStatus = 'VISIBLE'
        ..description = description ?? ''
        ..createdAt = DateTime.now()
        ..attachments.replace(
          BuiltList<AttachmentModel>([
            if (imagePath != null)
              AttachmentModel(
                    (a) => a
                  ..id = ''
                  ..url = imagePath!
                  ..isPrimary = true,
              ),
          ]),
        ),
    );
  }
}