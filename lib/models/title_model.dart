
import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'title_model.g.dart';
/// Represents the localized title in both English and Arabic.
abstract class TitleModel implements Built<TitleModel, TitleModelBuilder> {
  static Serializer<TitleModel> get serializer => _$titleModelSerializer;

  String get en;
  String get ar;

  TitleModel._();
  factory TitleModel([void Function(TitleModelBuilder)? updates]) = _$TitleModel;

  String toJson() {
    return jsonEncode(serializers.serializeWith(TitleModel.serializer, this));
  }

  static TitleModel? fromJson(String json) {
    return serializers.deserializeWith(TitleModel.serializer, jsonDecode(json));
  }

  static TitleModel? fromMap(Map<String, dynamic> map) {
    return serializers.deserializeWith(TitleModel.serializer, map);
  }
}
