import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';
import 'title_model.dart';

part 'status_model.g.dart';

/// Represents a delivery status with count, localized title, and icon.
abstract class StatusModel implements Built<StatusModel, StatusModelBuilder> {
  static Serializer<StatusModel> get serializer => _$statusModelSerializer;

  String get status;

  int get count;

  TitleModel get title;

  String get icon;

  StatusModel._();

  factory StatusModel([void Function(StatusModelBuilder)? updates]) = _$StatusModel;

  String toJson() {
    return jsonEncode(serializers.serializeWith(StatusModel.serializer, this));
  }

  static StatusModel? fromJson(String json) {
    return serializers.deserializeWith(StatusModel.serializer, jsonDecode(json));
  }

  static StatusModel? fromMap(Map<String, dynamic> map) {
    return serializers.deserializeWith(StatusModel.serializer, map);
  }
}
