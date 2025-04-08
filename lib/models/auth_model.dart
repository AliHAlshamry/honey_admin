import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'auth_model.g.dart';

abstract class Auth implements Built<Auth, AuthBuilder> {
  static Serializer<Auth> get serializer => _$authSerializer;

  int? get id;

  String? get name;

  String? get city;

  String? get address;

  String? get token;

  String? get accessToken;

  double? get latitude;

  double? get langtude;

  String? get phone;

  String? get password;

  String? get refreshToken;

  Auth._();

  factory Auth([void Function(AuthBuilder)? updates]) = _$Auth;

  String toJson() {
    return jsonEncode(serializers.serializeWith(Auth.serializer, this));
  }

  static Auth? fromJson(String json) {
    return serializers.deserializeWith(Auth.serializer, jsonDecode(json));
  }

}
