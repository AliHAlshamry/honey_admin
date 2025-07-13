import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'category_model.dart';
import 'product_image_model.dart';

part 'product_model.g.dart';

abstract class ProductModel implements Built<ProductModel, ProductModelBuilder> {
  static Serializer<ProductModel> get serializer => _$productModelSerializer;

  String get id;

  String get name;

  String get sku;

  String get price;

  int get qty;

  String get isPublished;

  String get specialServiceFee;

  String? get description;

  String get storeId;

  String? get categoryId;

  CategoryModel? get category;

  DateTime get createdAt;

  DateTime get updatedAt;

  BuiltList<ProductImageModel> get images;

  ProductModel._();

  factory ProductModel([void Function(ProductModelBuilder) updates]) = _$ProductModel;
}
