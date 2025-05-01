import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'governorate_model.g.dart';

abstract class GovernorateModel implements Built<GovernorateModel, GovernorateModelBuilder> {
  static Serializer<GovernorateModel> get serializer => _$governorateModelSerializer;

  String get id;

  String get name;

  String get level;

  GovernorateModel._();

  factory GovernorateModel([void Function(GovernorateModelBuilder)? updates]) = _$GovernorateModel;

  String toJson() {
    return jsonEncode(serializers.serializeWith(GovernorateModel.serializer, this));
  }

  static GovernorateModel? fromJson(String json) {
    return serializers.deserializeWith(GovernorateModel.serializer, jsonDecode(json));
  }

}
