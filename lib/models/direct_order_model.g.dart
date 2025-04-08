// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_order_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrderItemModel> _$orderItemModelSerializer =
    new _$OrderItemModelSerializer();
Serializer<DirectOrderModel> _$directOrderModelSerializer =
    new _$DirectOrderModelSerializer();

class _$OrderItemModelSerializer
    implements StructuredSerializer<OrderItemModel> {
  @override
  final Iterable<Type> types = const [OrderItemModel, _$OrderItemModel];
  @override
  final String wireName = 'OrderItemModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    OrderItemModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'qty',
      serializers.serialize(object.qty, specifiedType: const FullType(int)),
      'price',
      serializers.serialize(
        object.price,
        specifiedType: const FullType(double),
      ),
    ];

    return result;
  }

  @override
  OrderItemModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new OrderItemModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'qty':
          result.qty =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'price':
          result.price =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )!
                  as double;
          break;
      }
    }

    return result.build();
  }
}

class _$DirectOrderModelSerializer
    implements StructuredSerializer<DirectOrderModel> {
  @override
  final Iterable<Type> types = const [DirectOrderModel, _$DirectOrderModel];
  @override
  final String wireName = 'DirectOrderModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    DirectOrderModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'orderType',
      serializers.serialize(
        object.orderType,
        specifiedType: const FullType(String),
      ),
      'custName',
      serializers.serialize(
        object.custName,
        specifiedType: const FullType(String),
      ),
      'custPhone',
      serializers.serialize(
        object.custPhone,
        specifiedType: const FullType(String),
      ),
      'custTown',
      serializers.serialize(
        object.custTown,
        specifiedType: const FullType(String),
      ),
      'custCity',
      serializers.serialize(
        object.custCity,
        specifiedType: const FullType(String),
      ),
      'orderItems',
      serializers.serialize(
        object.orderItems,
        specifiedType: const FullType(BuiltList, const [
          const FullType(OrderItemModel),
        ]),
      ),
    ];
    Object? value;
    value = object.addressDetails;
    if (value != null) {
      result
        ..add('addressDetails')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.note;
    if (value != null) {
      result
        ..add('note')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  DirectOrderModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new DirectOrderModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'orderType':
          result.orderType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'custName':
          result.custName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'custPhone':
          result.custPhone =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'custTown':
          result.custTown =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'custCity':
          result.custCity =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'addressDetails':
          result.addressDetails =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'note':
          result.note =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'orderItems':
          result.orderItems.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(OrderItemModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$OrderItemModel extends OrderItemModel {
  @override
  final String name;
  @override
  final int qty;
  @override
  final double price;

  factory _$OrderItemModel([void Function(OrderItemModelBuilder)? updates]) =>
      (new OrderItemModelBuilder()..update(updates))._build();

  _$OrderItemModel._({
    required this.name,
    required this.qty,
    required this.price,
  }) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'OrderItemModel', 'name');
    BuiltValueNullFieldError.checkNotNull(qty, r'OrderItemModel', 'qty');
    BuiltValueNullFieldError.checkNotNull(price, r'OrderItemModel', 'price');
  }

  @override
  OrderItemModel rebuild(void Function(OrderItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderItemModelBuilder toBuilder() =>
      new OrderItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderItemModel &&
        name == other.name &&
        qty == other.qty &&
        price == other.price;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, qty.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderItemModel')
          ..add('name', name)
          ..add('qty', qty)
          ..add('price', price))
        .toString();
  }
}

class OrderItemModelBuilder
    implements Builder<OrderItemModel, OrderItemModelBuilder> {
  _$OrderItemModel? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _qty;
  int? get qty => _$this._qty;
  set qty(int? qty) => _$this._qty = qty;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  OrderItemModelBuilder();

  OrderItemModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _qty = $v.qty;
      _price = $v.price;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderItemModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OrderItemModel;
  }

  @override
  void update(void Function(OrderItemModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderItemModel build() => _build();

  _$OrderItemModel _build() {
    final _$result =
        _$v ??
        new _$OrderItemModel._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'OrderItemModel',
            'name',
          ),
          qty: BuiltValueNullFieldError.checkNotNull(
            qty,
            r'OrderItemModel',
            'qty',
          ),
          price: BuiltValueNullFieldError.checkNotNull(
            price,
            r'OrderItemModel',
            'price',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$DirectOrderModel extends DirectOrderModel {
  @override
  final String orderType;
  @override
  final String custName;
  @override
  final String custPhone;
  @override
  final String custTown;
  @override
  final String custCity;
  @override
  final String? addressDetails;
  @override
  final String? note;
  @override
  final BuiltList<OrderItemModel> orderItems;

  factory _$DirectOrderModel([
    void Function(DirectOrderModelBuilder)? updates,
  ]) => (new DirectOrderModelBuilder()..update(updates))._build();

  _$DirectOrderModel._({
    required this.orderType,
    required this.custName,
    required this.custPhone,
    required this.custTown,
    required this.custCity,
    this.addressDetails,
    this.note,
    required this.orderItems,
  }) : super._() {
    BuiltValueNullFieldError.checkNotNull(
      orderType,
      r'DirectOrderModel',
      'orderType',
    );
    BuiltValueNullFieldError.checkNotNull(
      custName,
      r'DirectOrderModel',
      'custName',
    );
    BuiltValueNullFieldError.checkNotNull(
      custPhone,
      r'DirectOrderModel',
      'custPhone',
    );
    BuiltValueNullFieldError.checkNotNull(
      custTown,
      r'DirectOrderModel',
      'custTown',
    );
    BuiltValueNullFieldError.checkNotNull(
      custCity,
      r'DirectOrderModel',
      'custCity',
    );
    BuiltValueNullFieldError.checkNotNull(
      orderItems,
      r'DirectOrderModel',
      'orderItems',
    );
  }

  @override
  DirectOrderModel rebuild(void Function(DirectOrderModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DirectOrderModelBuilder toBuilder() =>
      new DirectOrderModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DirectOrderModel &&
        orderType == other.orderType &&
        custName == other.custName &&
        custPhone == other.custPhone &&
        custTown == other.custTown &&
        custCity == other.custCity &&
        addressDetails == other.addressDetails &&
        note == other.note &&
        orderItems == other.orderItems;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderType.hashCode);
    _$hash = $jc(_$hash, custName.hashCode);
    _$hash = $jc(_$hash, custPhone.hashCode);
    _$hash = $jc(_$hash, custTown.hashCode);
    _$hash = $jc(_$hash, custCity.hashCode);
    _$hash = $jc(_$hash, addressDetails.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, orderItems.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DirectOrderModel')
          ..add('orderType', orderType)
          ..add('custName', custName)
          ..add('custPhone', custPhone)
          ..add('custTown', custTown)
          ..add('custCity', custCity)
          ..add('addressDetails', addressDetails)
          ..add('note', note)
          ..add('orderItems', orderItems))
        .toString();
  }
}

class DirectOrderModelBuilder
    implements Builder<DirectOrderModel, DirectOrderModelBuilder> {
  _$DirectOrderModel? _$v;

  String? _orderType;
  String? get orderType => _$this._orderType;
  set orderType(String? orderType) => _$this._orderType = orderType;

  String? _custName;
  String? get custName => _$this._custName;
  set custName(String? custName) => _$this._custName = custName;

  String? _custPhone;
  String? get custPhone => _$this._custPhone;
  set custPhone(String? custPhone) => _$this._custPhone = custPhone;

  String? _custTown;
  String? get custTown => _$this._custTown;
  set custTown(String? custTown) => _$this._custTown = custTown;

  String? _custCity;
  String? get custCity => _$this._custCity;
  set custCity(String? custCity) => _$this._custCity = custCity;

  String? _addressDetails;
  String? get addressDetails => _$this._addressDetails;
  set addressDetails(String? addressDetails) =>
      _$this._addressDetails = addressDetails;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  ListBuilder<OrderItemModel>? _orderItems;
  ListBuilder<OrderItemModel> get orderItems =>
      _$this._orderItems ??= new ListBuilder<OrderItemModel>();
  set orderItems(ListBuilder<OrderItemModel>? orderItems) =>
      _$this._orderItems = orderItems;

  DirectOrderModelBuilder();

  DirectOrderModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderType = $v.orderType;
      _custName = $v.custName;
      _custPhone = $v.custPhone;
      _custTown = $v.custTown;
      _custCity = $v.custCity;
      _addressDetails = $v.addressDetails;
      _note = $v.note;
      _orderItems = $v.orderItems.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DirectOrderModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DirectOrderModel;
  }

  @override
  void update(void Function(DirectOrderModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DirectOrderModel build() => _build();

  _$DirectOrderModel _build() {
    _$DirectOrderModel _$result;
    try {
      _$result =
          _$v ??
          new _$DirectOrderModel._(
            orderType: BuiltValueNullFieldError.checkNotNull(
              orderType,
              r'DirectOrderModel',
              'orderType',
            ),
            custName: BuiltValueNullFieldError.checkNotNull(
              custName,
              r'DirectOrderModel',
              'custName',
            ),
            custPhone: BuiltValueNullFieldError.checkNotNull(
              custPhone,
              r'DirectOrderModel',
              'custPhone',
            ),
            custTown: BuiltValueNullFieldError.checkNotNull(
              custTown,
              r'DirectOrderModel',
              'custTown',
            ),
            custCity: BuiltValueNullFieldError.checkNotNull(
              custCity,
              r'DirectOrderModel',
              'custCity',
            ),
            addressDetails: addressDetails,
            note: note,
            orderItems: orderItems.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orderItems';
        orderItems.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'DirectOrderModel',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
