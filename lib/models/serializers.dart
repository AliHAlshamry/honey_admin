import 'package:built_collection/built_collection.dart';

import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/iso_8601_duration_serializer.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'auth_model.dart';
import 'direct_order_model.dart';
import 'governorate_model.dart';
import 'item_model.dart';
import 'login_model.dart';

part 'serializers.g.dart';

@SerializersFor([
  JsonObject,
  MapJsonObject,
  Login,
  Auth,
  DirectOrderModel,
  OrderItemModel,
  ItemListResponse,
  ItemModel,
  AttachmentModel,
  GovernorateModel
])
final Serializers serializers = (_$serializers.toBuilder()
  ..add(Iso8601DateTimeSerializer())
  ..addBuilderFactory(
    FullType(BuiltList, [FullType(ItemModel)]),
        () => ListBuilder<ItemModel>(),
  )
  ..addBuilderFactory(
    FullType(BuiltList, [FullType(AttachmentModel)]),
        () => ListBuilder<AttachmentModel>(),
  )
  ..add(Iso8601DateTimeSerializer())
  ..add(Iso8601DurationSerializer())
  ..addPlugin(StandardJsonPlugin()))
    .build();

