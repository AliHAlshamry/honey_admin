import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'order_model.g.dart';

abstract class OrderModel implements Built<OrderModel, OrderModelBuilder> {
  static Serializer<OrderModel> get serializer => _$orderModelSerializer;

  String get id;
  int get number;
  String get orderType;
  String get status;
  String get price;
  String get pricingCurrency;
  String get custName;
  String get custPhone;
  String get custGovernorate;
  String get custDistrict;
  String get addressDetails;
  String get note;
  String get userId;
  String? get deliveryRepresentativeId;
  DateTime get createdAt;
  DateTime get updatedAt;

  OrderModel._();

  factory OrderModel([void Function(OrderModelBuilder) updates]) = _$OrderModel;

  String toJson() {
    return jsonEncode(serializers.serializeWith(OrderModel.serializer, this));
  }

  static OrderModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
        OrderModel.serializer, jsonDecode(jsonString));
  }
}
