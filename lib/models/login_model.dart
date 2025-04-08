import 'dart:convert';

import '../../models/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_model.g.dart';

abstract class Login implements Built<Login, LoginBuilder> {
  static Serializer<Login> get serializer => _$loginSerializer;

  String? get result;


  Login._();

  factory Login([void Function(LoginBuilder)? updates]) = _$Login;

  String toJson() {
    return jsonEncode(serializers.serializeWith(Login.serializer, this));
  }

  static Login? fromJson(String json) {
    return serializers.deserializeWith(Login.serializer, jsonDecode(json));
  }

}
