import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'direct_order_model.g.dart';

abstract class OrderItemModel implements Built<OrderItemModel, OrderItemModelBuilder> {
  static Serializer<OrderItemModel> get serializer => _$orderItemModelSerializer;

  String get name;
  int get qty;
  double get price;

  OrderItemModel._();
  factory OrderItemModel([void Function(OrderItemModelBuilder) updates]) = _$OrderItemModel;
}

abstract class DirectOrderModel implements Built<DirectOrderModel, DirectOrderModelBuilder> {
  static Serializer<DirectOrderModel> get serializer => _$directOrderModelSerializer;

  String get orderType;
  String get custName;
  String get custPhone;
  String get custTown;
  String get custCity;
  String? get addressDetails;
  String? get note;
  BuiltList<OrderItemModel> get orderItems;

  DirectOrderModel._();

  String toJson() {
    return jsonEncode(serializers.serializeWith(DirectOrderModel.serializer, this));
  }

  static DirectOrderModel? fromJson(String json) {
    return serializers.deserializeWith(DirectOrderModel.serializer, jsonDecode(json));
  }

  factory DirectOrderModel([void Function(DirectOrderModelBuilder) updates]) = _$DirectOrderModel;
}