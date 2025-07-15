import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_item_model.g.dart';

abstract class ProductItemModel
    implements Built<ProductItemModel, ProductItemModelBuilder> {
  static Serializer<ProductItemModel> get serializer =>
      _$productItemModelSerializer;

  /// "INTERNAL" or "EXTERNAL"
  String get sourceType;

  /// If sourceType == INTERNAL, this will be a UUID string.
  /// If sourceType == EXTERNAL, this will be a human-readable name (e.g. "Wireless Mouse").
  String get identifier;

  int get qty;

  /// Only present when sourceType == "EXTERNAL"
  double? get price;

  /// Optional notes (e.g. "Urgent", "Buy from local store")
  String? get notes;

  ProductItemModel._();
  factory ProductItemModel([void Function(ProductItemModelBuilder) updates]) =
  _$ProductItemModel;

  /// Create from a JSON-like map
  static ProductItemModel fromMap(Map<String, dynamic> map) {
    return ProductItemModel((b) => b
      ..sourceType = map['sourceType'] as String
      ..identifier = map['identifier'] as String
      ..qty = map['qty'] as int
      ..price = map['price'] != null
          ? (map['price'] as num).toDouble()
          : null
      ..notes = map['notes'] as String?);
  }

  /// Convert to JSON-like map
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{
      'sourceType': sourceType,
      'identifier': identifier,
      'qty': qty,
    };
    if (price != null) result['price'] = price;
    if (notes != null) result['notes'] = notes;
    return result;
  }
}
