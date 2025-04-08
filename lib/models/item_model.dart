// item_model.dart
import 'serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'item_model.g.dart';

abstract class AttachmentModel implements Built<AttachmentModel, AttachmentModelBuilder> {
  static Serializer<AttachmentModel> get serializer => _$attachmentModelSerializer;

  String get id;
  String get url;
  bool get isPrimary;

  AttachmentModel._();
  factory AttachmentModel([void Function(AttachmentModelBuilder) updates]) = _$AttachmentModel;
}

abstract class ItemModel implements Built<ItemModel, ItemModelBuilder> {
  static Serializer<ItemModel> get serializer => _$itemModelSerializer;

  String get id;
  String get name;
  String get description;
  String get sku;
  String get stockStatus;
  int get qty;
  String get orginalPrice;
  String get discount;
  String? get discountedPrice;
  String get pricingCurrency;
  String get visibilityStatus;
  DateTime get createdAt;
  BuiltList<AttachmentModel> get attachments;

  ItemModel._();
  factory ItemModel([void Function(ItemModelBuilder) updates]) = _$ItemModel;
}

abstract class ItemListResponse implements Built<ItemListResponse, ItemListResponseBuilder> {
  static Serializer<ItemListResponse> get serializer => _$itemListResponseSerializer;

  BuiltList<ItemModel> get data;
  int get totalCount;
  int get pageCount;

  static ItemListResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ItemListResponse.serializer, json)!;
  }
  ItemListResponse._();
  factory ItemListResponse([void Function(ItemListResponseBuilder) updates]) = _$ItemListResponse;
}