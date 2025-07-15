import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:honey_admin/models/product_item_model.dart';

import '../controllers/items_controller.dart';
import 'serializers.dart';

part 'order_dto.g.dart';

abstract class OrderDto implements Built<OrderDto, OrderDtoBuilder> {
  static Serializer<OrderDto> get serializer => _$orderDtoSerializer;

  String get custName;
  String get custPhone;
  String get cityId;
  String get addressDetails;
  String? get note;
  BuiltList<ProductItemModel> get items;

  OrderDto._();
  factory OrderDto([void Function(OrderDtoBuilder) updates]) = _$OrderDto;

  static OrderDto fromControllerData({
    required String custName,
    required String custPhone,
    required String cityId,
    required String address,
    String? note,
    required List<CartEntry> cartItems,
  }) {
    return OrderDto((b) => b
      ..custName = custName
      ..custPhone = custPhone
      ..cityId = cityId
      ..addressDetails = address
      ..note = note
      ..items = ListBuilder<ProductItemModel>(
        cartItems.map((cartItem) {
          return ProductItemModel((p) => p
            ..sourceType = cartItem.sourceType
            ..identifier = cartItem.identifier
            ..qty = cartItem.qty
            ..price = cartItem.sourceType == 'EXTERNAL' ? double.parse(cartItem.product.discountedPrice ?? cartItem.product.orginalPrice) : null
            );
        }),
      ));
  }

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrderDto.serializer, this)
    as Map<String, dynamic>;
  }

  static OrderDto? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(OrderDto.serializer, json);
  }
}
