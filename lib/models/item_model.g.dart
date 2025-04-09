// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AttachmentModel> _$attachmentModelSerializer =
    new _$AttachmentModelSerializer();
Serializer<ItemModel> _$itemModelSerializer = new _$ItemModelSerializer();
Serializer<ItemListResponse> _$itemListResponseSerializer =
    new _$ItemListResponseSerializer();

class _$AttachmentModelSerializer
    implements StructuredSerializer<AttachmentModel> {
  @override
  final Iterable<Type> types = const [AttachmentModel, _$AttachmentModel];
  @override
  final String wireName = 'AttachmentModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    AttachmentModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'isPrimary',
      serializers.serialize(
        object.isPrimary,
        specifiedType: const FullType(bool),
      ),
    ];

    return result;
  }

  @override
  AttachmentModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new AttachmentModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'isPrimary':
          result.isPrimary =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ItemModelSerializer implements StructuredSerializer<ItemModel> {
  @override
  final Iterable<Type> types = const [ItemModel, _$ItemModel];
  @override
  final String wireName = 'ItemModel';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ItemModel object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'sku',
      serializers.serialize(object.sku, specifiedType: const FullType(String)),
      'stockStatus',
      serializers.serialize(
        object.stockStatus,
        specifiedType: const FullType(String),
      ),
      'orginalPrice',
      serializers.serialize(
        object.orginalPrice,
        specifiedType: const FullType(String),
      ),
      'discount',
      serializers.serialize(
        object.discount,
        specifiedType: const FullType(String),
      ),
      'pricingCurrency',
      serializers.serialize(
        object.pricingCurrency,
        specifiedType: const FullType(String),
      ),
      'visibilityStatus',
      serializers.serialize(
        object.visibilityStatus,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      ),
      'attachments',
      serializers.serialize(
        object.attachments,
        specifiedType: const FullType(BuiltList, const [
          const FullType(AttachmentModel),
        ]),
      ),
    ];
    Object? value;
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.qty;
    if (value != null) {
      result
        ..add('qty')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.discountedPrice;
    if (value != null) {
      result
        ..add('discountedPrice')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  ItemModel deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ItemModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'sku':
          result.sku =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'stockStatus':
          result.stockStatus =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'qty':
          result.qty =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'orginalPrice':
          result.orginalPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'discount':
          result.discount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'discountedPrice':
          result.discountedPrice =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'pricingCurrency':
          result.pricingCurrency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'visibilityStatus':
          result.visibilityStatus =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )!
                  as DateTime;
          break;
        case 'attachments':
          result.attachments.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(AttachmentModel),
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

class _$ItemListResponseSerializer
    implements StructuredSerializer<ItemListResponse> {
  @override
  final Iterable<Type> types = const [ItemListResponse, _$ItemListResponse];
  @override
  final String wireName = 'ItemListResponse';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    ItemListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'data',
      serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, const [
          const FullType(ItemModel),
        ]),
      ),
      'totalCount',
      serializers.serialize(
        object.totalCount,
        specifiedType: const FullType(int),
      ),
      'pageCount',
      serializers.serialize(
        object.pageCount,
        specifiedType: const FullType(int),
      ),
    ];

    return result;
  }

  @override
  ItemListResponse deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = new ItemListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(ItemModel),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'totalCount':
          result.totalCount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'pageCount':
          result.pageCount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
      }
    }

    return result.build();
  }
}

class _$AttachmentModel extends AttachmentModel {
  @override
  final String id;
  @override
  final String url;
  @override
  final bool isPrimary;

  factory _$AttachmentModel([void Function(AttachmentModelBuilder)? updates]) =>
      (new AttachmentModelBuilder()..update(updates))._build();

  _$AttachmentModel._({
    required this.id,
    required this.url,
    required this.isPrimary,
  }) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'AttachmentModel', 'id');
    BuiltValueNullFieldError.checkNotNull(url, r'AttachmentModel', 'url');
    BuiltValueNullFieldError.checkNotNull(
      isPrimary,
      r'AttachmentModel',
      'isPrimary',
    );
  }

  @override
  AttachmentModel rebuild(void Function(AttachmentModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AttachmentModelBuilder toBuilder() =>
      new AttachmentModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AttachmentModel &&
        id == other.id &&
        url == other.url &&
        isPrimary == other.isPrimary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, isPrimary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AttachmentModel')
          ..add('id', id)
          ..add('url', url)
          ..add('isPrimary', isPrimary))
        .toString();
  }
}

class AttachmentModelBuilder
    implements Builder<AttachmentModel, AttachmentModelBuilder> {
  _$AttachmentModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  bool? _isPrimary;
  bool? get isPrimary => _$this._isPrimary;
  set isPrimary(bool? isPrimary) => _$this._isPrimary = isPrimary;

  AttachmentModelBuilder();

  AttachmentModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _url = $v.url;
      _isPrimary = $v.isPrimary;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AttachmentModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AttachmentModel;
  }

  @override
  void update(void Function(AttachmentModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AttachmentModel build() => _build();

  _$AttachmentModel _build() {
    final _$result =
        _$v ??
        new _$AttachmentModel._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'AttachmentModel',
            'id',
          ),
          url: BuiltValueNullFieldError.checkNotNull(
            url,
            r'AttachmentModel',
            'url',
          ),
          isPrimary: BuiltValueNullFieldError.checkNotNull(
            isPrimary,
            r'AttachmentModel',
            'isPrimary',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$ItemModel extends ItemModel {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String sku;
  @override
  final String stockStatus;
  @override
  final int? qty;
  @override
  final String orginalPrice;
  @override
  final String discount;
  @override
  final String? discountedPrice;
  @override
  final String pricingCurrency;
  @override
  final String visibilityStatus;
  @override
  final DateTime createdAt;
  @override
  final BuiltList<AttachmentModel> attachments;

  factory _$ItemModel([void Function(ItemModelBuilder)? updates]) =>
      (new ItemModelBuilder()..update(updates))._build();

  _$ItemModel._({
    required this.id,
    required this.name,
    this.description,
    required this.sku,
    required this.stockStatus,
    this.qty,
    required this.orginalPrice,
    required this.discount,
    this.discountedPrice,
    required this.pricingCurrency,
    required this.visibilityStatus,
    required this.createdAt,
    required this.attachments,
  }) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'ItemModel', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'ItemModel', 'name');
    BuiltValueNullFieldError.checkNotNull(sku, r'ItemModel', 'sku');
    BuiltValueNullFieldError.checkNotNull(
      stockStatus,
      r'ItemModel',
      'stockStatus',
    );
    BuiltValueNullFieldError.checkNotNull(
      orginalPrice,
      r'ItemModel',
      'orginalPrice',
    );
    BuiltValueNullFieldError.checkNotNull(discount, r'ItemModel', 'discount');
    BuiltValueNullFieldError.checkNotNull(
      pricingCurrency,
      r'ItemModel',
      'pricingCurrency',
    );
    BuiltValueNullFieldError.checkNotNull(
      visibilityStatus,
      r'ItemModel',
      'visibilityStatus',
    );
    BuiltValueNullFieldError.checkNotNull(createdAt, r'ItemModel', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
      attachments,
      r'ItemModel',
      'attachments',
    );
  }

  @override
  ItemModel rebuild(void Function(ItemModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemModelBuilder toBuilder() => new ItemModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ItemModel &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        sku == other.sku &&
        stockStatus == other.stockStatus &&
        qty == other.qty &&
        orginalPrice == other.orginalPrice &&
        discount == other.discount &&
        discountedPrice == other.discountedPrice &&
        pricingCurrency == other.pricingCurrency &&
        visibilityStatus == other.visibilityStatus &&
        createdAt == other.createdAt &&
        attachments == other.attachments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, sku.hashCode);
    _$hash = $jc(_$hash, stockStatus.hashCode);
    _$hash = $jc(_$hash, qty.hashCode);
    _$hash = $jc(_$hash, orginalPrice.hashCode);
    _$hash = $jc(_$hash, discount.hashCode);
    _$hash = $jc(_$hash, discountedPrice.hashCode);
    _$hash = $jc(_$hash, pricingCurrency.hashCode);
    _$hash = $jc(_$hash, visibilityStatus.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ItemModel')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('sku', sku)
          ..add('stockStatus', stockStatus)
          ..add('qty', qty)
          ..add('orginalPrice', orginalPrice)
          ..add('discount', discount)
          ..add('discountedPrice', discountedPrice)
          ..add('pricingCurrency', pricingCurrency)
          ..add('visibilityStatus', visibilityStatus)
          ..add('createdAt', createdAt)
          ..add('attachments', attachments))
        .toString();
  }
}

class ItemModelBuilder implements Builder<ItemModel, ItemModelBuilder> {
  _$ItemModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _sku;
  String? get sku => _$this._sku;
  set sku(String? sku) => _$this._sku = sku;

  String? _stockStatus;
  String? get stockStatus => _$this._stockStatus;
  set stockStatus(String? stockStatus) => _$this._stockStatus = stockStatus;

  int? _qty;
  int? get qty => _$this._qty;
  set qty(int? qty) => _$this._qty = qty;

  String? _orginalPrice;
  String? get orginalPrice => _$this._orginalPrice;
  set orginalPrice(String? orginalPrice) => _$this._orginalPrice = orginalPrice;

  String? _discount;
  String? get discount => _$this._discount;
  set discount(String? discount) => _$this._discount = discount;

  String? _discountedPrice;
  String? get discountedPrice => _$this._discountedPrice;
  set discountedPrice(String? discountedPrice) =>
      _$this._discountedPrice = discountedPrice;

  String? _pricingCurrency;
  String? get pricingCurrency => _$this._pricingCurrency;
  set pricingCurrency(String? pricingCurrency) =>
      _$this._pricingCurrency = pricingCurrency;

  String? _visibilityStatus;
  String? get visibilityStatus => _$this._visibilityStatus;
  set visibilityStatus(String? visibilityStatus) =>
      _$this._visibilityStatus = visibilityStatus;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ListBuilder<AttachmentModel>? _attachments;
  ListBuilder<AttachmentModel> get attachments =>
      _$this._attachments ??= new ListBuilder<AttachmentModel>();
  set attachments(ListBuilder<AttachmentModel>? attachments) =>
      _$this._attachments = attachments;

  ItemModelBuilder();

  ItemModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _sku = $v.sku;
      _stockStatus = $v.stockStatus;
      _qty = $v.qty;
      _orginalPrice = $v.orginalPrice;
      _discount = $v.discount;
      _discountedPrice = $v.discountedPrice;
      _pricingCurrency = $v.pricingCurrency;
      _visibilityStatus = $v.visibilityStatus;
      _createdAt = $v.createdAt;
      _attachments = $v.attachments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ItemModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ItemModel;
  }

  @override
  void update(void Function(ItemModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ItemModel build() => _build();

  _$ItemModel _build() {
    _$ItemModel _$result;
    try {
      _$result =
          _$v ??
          new _$ItemModel._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'ItemModel', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'ItemModel',
              'name',
            ),
            description: description,
            sku: BuiltValueNullFieldError.checkNotNull(
              sku,
              r'ItemModel',
              'sku',
            ),
            stockStatus: BuiltValueNullFieldError.checkNotNull(
              stockStatus,
              r'ItemModel',
              'stockStatus',
            ),
            qty: qty,
            orginalPrice: BuiltValueNullFieldError.checkNotNull(
              orginalPrice,
              r'ItemModel',
              'orginalPrice',
            ),
            discount: BuiltValueNullFieldError.checkNotNull(
              discount,
              r'ItemModel',
              'discount',
            ),
            discountedPrice: discountedPrice,
            pricingCurrency: BuiltValueNullFieldError.checkNotNull(
              pricingCurrency,
              r'ItemModel',
              'pricingCurrency',
            ),
            visibilityStatus: BuiltValueNullFieldError.checkNotNull(
              visibilityStatus,
              r'ItemModel',
              'visibilityStatus',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'ItemModel',
              'createdAt',
            ),
            attachments: attachments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachments';
        attachments.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ItemModel',
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

class _$ItemListResponse extends ItemListResponse {
  @override
  final BuiltList<ItemModel> data;
  @override
  final int totalCount;
  @override
  final int pageCount;

  factory _$ItemListResponse([
    void Function(ItemListResponseBuilder)? updates,
  ]) => (new ItemListResponseBuilder()..update(updates))._build();

  _$ItemListResponse._({
    required this.data,
    required this.totalCount,
    required this.pageCount,
  }) : super._() {
    BuiltValueNullFieldError.checkNotNull(data, r'ItemListResponse', 'data');
    BuiltValueNullFieldError.checkNotNull(
      totalCount,
      r'ItemListResponse',
      'totalCount',
    );
    BuiltValueNullFieldError.checkNotNull(
      pageCount,
      r'ItemListResponse',
      'pageCount',
    );
  }

  @override
  ItemListResponse rebuild(void Function(ItemListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemListResponseBuilder toBuilder() =>
      new ItemListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ItemListResponse &&
        data == other.data &&
        totalCount == other.totalCount &&
        pageCount == other.pageCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, pageCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ItemListResponse')
          ..add('data', data)
          ..add('totalCount', totalCount)
          ..add('pageCount', pageCount))
        .toString();
  }
}

class ItemListResponseBuilder
    implements Builder<ItemListResponse, ItemListResponseBuilder> {
  _$ItemListResponse? _$v;

  ListBuilder<ItemModel>? _data;
  ListBuilder<ItemModel> get data =>
      _$this._data ??= new ListBuilder<ItemModel>();
  set data(ListBuilder<ItemModel>? data) => _$this._data = data;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  int? _pageCount;
  int? get pageCount => _$this._pageCount;
  set pageCount(int? pageCount) => _$this._pageCount = pageCount;

  ItemListResponseBuilder();

  ItemListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _totalCount = $v.totalCount;
      _pageCount = $v.pageCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ItemListResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ItemListResponse;
  }

  @override
  void update(void Function(ItemListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ItemListResponse build() => _build();

  _$ItemListResponse _build() {
    _$ItemListResponse _$result;
    try {
      _$result =
          _$v ??
          new _$ItemListResponse._(
            data: data.build(),
            totalCount: BuiltValueNullFieldError.checkNotNull(
              totalCount,
              r'ItemListResponse',
              'totalCount',
            ),
            pageCount: BuiltValueNullFieldError.checkNotNull(
              pageCount,
              r'ItemListResponse',
              'pageCount',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
          r'ItemListResponse',
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
