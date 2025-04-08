// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (new Serializers().toBuilder()
          ..add(AttachmentModel.serializer)
          ..add(Auth.serializer)
          ..add(DirectOrderModel.serializer)
          ..add(ItemListResponse.serializer)
          ..add(ItemModel.serializer)
          ..add(Login.serializer)
          ..add(OrderItemModel.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AttachmentModel)]),
            () => new ListBuilder<AttachmentModel>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ItemModel)]),
            () => new ListBuilder<ItemModel>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(OrderItemModel)]),
            () => new ListBuilder<OrderItemModel>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
