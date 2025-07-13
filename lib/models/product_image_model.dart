import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_image_model.g.dart';

abstract class ProductImageModel implements Built<ProductImageModel, ProductImageModelBuilder> {
  static Serializer<ProductImageModel> get serializer => _$productImageModelSerializer;

  String get id;

  String? get img;

  String get isPrimary;

  String get productId;

  ProductImageModel._();

  factory ProductImageModel([void Function(ProductImageModelBuilder) updates]) = _$ProductImageModel;
}
