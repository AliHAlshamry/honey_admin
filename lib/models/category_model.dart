import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'category_model.g.dart';

abstract class CategoryModel implements Built<CategoryModel, CategoryModelBuilder> {
  static Serializer<CategoryModel> get serializer => _$categoryModelSerializer;

  String get id;

  String get name;

  String? get img;

  String get description;

  String get storeId;


  CategoryModel._();

  factory CategoryModel([void Function(CategoryModelBuilder) updates]) = _$CategoryModel;
}
