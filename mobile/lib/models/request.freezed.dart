// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestLocation _$RequestLocationFromJson(Map<String, dynamic> json) {
  return _RequestLocation.fromJson(json);
}

/// @nodoc
mixin _$RequestLocation {
  String get address => throw _privateConstructorUsedError;
  List<double> get coordinates => throw _privateConstructorUsedError;
  String get governorate => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String? get area => throw _privateConstructorUsedError;

  /// Serializes this RequestLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestLocationCopyWith<RequestLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestLocationCopyWith<$Res> {
  factory $RequestLocationCopyWith(
          RequestLocation value, $Res Function(RequestLocation) then) =
      _$RequestLocationCopyWithImpl<$Res, RequestLocation>;
  @useResult
  $Res call(
      {String address,
      List<double> coordinates,
      String governorate,
      String city,
      String? area});
}

/// @nodoc
class _$RequestLocationCopyWithImpl<$Res, $Val extends RequestLocation>
    implements $RequestLocationCopyWith<$Res> {
  _$RequestLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? coordinates = null,
    Object? governorate = null,
    Object? city = null,
    Object? area = freezed,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      governorate: null == governorate
          ? _value.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestLocationImplCopyWith<$Res>
    implements $RequestLocationCopyWith<$Res> {
  factory _$$RequestLocationImplCopyWith(_$RequestLocationImpl value,
          $Res Function(_$RequestLocationImpl) then) =
      __$$RequestLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      List<double> coordinates,
      String governorate,
      String city,
      String? area});
}

/// @nodoc
class __$$RequestLocationImplCopyWithImpl<$Res>
    extends _$RequestLocationCopyWithImpl<$Res, _$RequestLocationImpl>
    implements _$$RequestLocationImplCopyWith<$Res> {
  __$$RequestLocationImplCopyWithImpl(
      _$RequestLocationImpl _value, $Res Function(_$RequestLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? coordinates = null,
    Object? governorate = null,
    Object? city = null,
    Object? area = freezed,
  }) {
    return _then(_$RequestLocationImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      governorate: null == governorate
          ? _value.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestLocationImpl implements _RequestLocation {
  const _$RequestLocationImpl(
      {required this.address,
      required final List<double> coordinates,
      required this.governorate,
      required this.city,
      this.area})
      : _coordinates = coordinates;

  factory _$RequestLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestLocationImplFromJson(json);

  @override
  final String address;
  final List<double> _coordinates;
  @override
  List<double> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  final String governorate;
  @override
  final String city;
  @override
  final String? area;

  @override
  String toString() {
    return 'RequestLocation(address: $address, coordinates: $coordinates, governorate: $governorate, city: $city, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestLocationImpl &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates) &&
            (identical(other.governorate, governorate) ||
                other.governorate == governorate) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      address,
      const DeepCollectionEquality().hash(_coordinates),
      governorate,
      city,
      area);

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestLocationImplCopyWith<_$RequestLocationImpl> get copyWith =>
      __$$RequestLocationImplCopyWithImpl<_$RequestLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestLocationImplToJson(
      this,
    );
  }
}

abstract class _RequestLocation implements RequestLocation {
  const factory _RequestLocation(
      {required final String address,
      required final List<double> coordinates,
      required final String governorate,
      required final String city,
      final String? area}) = _$RequestLocationImpl;

  factory _RequestLocation.fromJson(Map<String, dynamic> json) =
      _$RequestLocationImpl.fromJson;

  @override
  String get address;
  @override
  List<double> get coordinates;
  @override
  String get governorate;
  @override
  String get city;
  @override
  String? get area;

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestLocationImplCopyWith<_$RequestLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestBudget _$RequestBudgetFromJson(Map<String, dynamic> json) {
  return _RequestBudget.fromJson(json);
}

/// @nodoc
mixin _$RequestBudget {
  double get min => throw _privateConstructorUsedError;
  double get max => throw _privateConstructorUsedError;

  /// Serializes this RequestBudget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestBudgetCopyWith<RequestBudget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestBudgetCopyWith<$Res> {
  factory $RequestBudgetCopyWith(
          RequestBudget value, $Res Function(RequestBudget) then) =
      _$RequestBudgetCopyWithImpl<$Res, RequestBudget>;
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class _$RequestBudgetCopyWithImpl<$Res, $Val extends RequestBudget>
    implements $RequestBudgetCopyWith<$Res> {
  _$RequestBudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_value.copyWith(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestBudgetImplCopyWith<$Res>
    implements $RequestBudgetCopyWith<$Res> {
  factory _$$RequestBudgetImplCopyWith(
          _$RequestBudgetImpl value, $Res Function(_$RequestBudgetImpl) then) =
      __$$RequestBudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class __$$RequestBudgetImplCopyWithImpl<$Res>
    extends _$RequestBudgetCopyWithImpl<$Res, _$RequestBudgetImpl>
    implements _$$RequestBudgetImplCopyWith<$Res> {
  __$$RequestBudgetImplCopyWithImpl(
      _$RequestBudgetImpl _value, $Res Function(_$RequestBudgetImpl) _then)
      : super(_value, _then);

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_$RequestBudgetImpl(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestBudgetImpl implements _RequestBudget {
  const _$RequestBudgetImpl({required this.min, required this.max});

  factory _$RequestBudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestBudgetImplFromJson(json);

  @override
  final double min;
  @override
  final double max;

  @override
  String toString() {
    return 'RequestBudget(min: $min, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestBudgetImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestBudgetImplCopyWith<_$RequestBudgetImpl> get copyWith =>
      __$$RequestBudgetImplCopyWithImpl<_$RequestBudgetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestBudgetImplToJson(
      this,
    );
  }
}

abstract class _RequestBudget implements RequestBudget {
  const factory _RequestBudget(
      {required final double min,
      required final double max}) = _$RequestBudgetImpl;

  factory _RequestBudget.fromJson(Map<String, dynamic> json) =
      _$RequestBudgetImpl.fromJson;

  @override
  double get min;
  @override
  double get max;

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestBudgetImplCopyWith<_$RequestBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PreferredTime _$PreferredTimeFromJson(Map<String, dynamic> json) {
  return _PreferredTime.fromJson(json);
}

/// @nodoc
mixin _$PreferredTime {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;

  /// Serializes this PreferredTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreferredTimeCopyWith<PreferredTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferredTimeCopyWith<$Res> {
  factory $PreferredTimeCopyWith(
          PreferredTime value, $Res Function(PreferredTime) then) =
      _$PreferredTimeCopyWithImpl<$Res, PreferredTime>;
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class _$PreferredTimeCopyWithImpl<$Res, $Val extends PreferredTime>
    implements $PreferredTimeCopyWith<$Res> {
  _$PreferredTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferredTimeImplCopyWith<$Res>
    implements $PreferredTimeCopyWith<$Res> {
  factory _$$PreferredTimeImplCopyWith(
          _$PreferredTimeImpl value, $Res Function(_$PreferredTimeImpl) then) =
      __$$PreferredTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class __$$PreferredTimeImplCopyWithImpl<$Res>
    extends _$PreferredTimeCopyWithImpl<$Res, _$PreferredTimeImpl>
    implements _$$PreferredTimeImplCopyWith<$Res> {
  __$$PreferredTimeImplCopyWithImpl(
      _$PreferredTimeImpl _value, $Res Function(_$PreferredTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$PreferredTimeImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferredTimeImpl implements _PreferredTime {
  const _$PreferredTimeImpl({required this.start, required this.end});

  factory _$PreferredTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferredTimeImplFromJson(json);

  @override
  final String start;
  @override
  final String end;

  @override
  String toString() {
    return 'PreferredTime(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferredTimeImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferredTimeImplCopyWith<_$PreferredTimeImpl> get copyWith =>
      __$$PreferredTimeImplCopyWithImpl<_$PreferredTimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferredTimeImplToJson(
      this,
    );
  }
}

abstract class _PreferredTime implements PreferredTime {
  const factory _PreferredTime(
      {required final String start,
      required final String end}) = _$PreferredTimeImpl;

  factory _PreferredTime.fromJson(Map<String, dynamic> json) =
      _$PreferredTimeImpl.fromJson;

  @override
  String get start;
  @override
  String get end;

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreferredTimeImplCopyWith<_$PreferredTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return _Quote.fromJson(json);
}

/// @nodoc
mixin _$Quote {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  CraftsmanSummary get craftsman => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get estimatedDuration => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get validUntil => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get submittedAt => throw _privateConstructorUsedError;

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteCopyWith<Quote> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteCopyWith<$Res> {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) then) =
      _$QuoteCopyWithImpl<$Res, Quote>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      CraftsmanSummary craftsman,
      double amount,
      String? estimatedDuration,
      String? notes,
      DateTime? validUntil,
      String status,
      DateTime submittedAt});

  $CraftsmanSummaryCopyWith<$Res> get craftsman;
}

/// @nodoc
class _$QuoteCopyWithImpl<$Res, $Val extends Quote>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? craftsman = null,
    Object? amount = null,
    Object? estimatedDuration = freezed,
    Object? notes = freezed,
    Object? validUntil = freezed,
    Object? status = null,
    Object? submittedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      craftsman: null == craftsman
          ? _value.craftsman
          : craftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanSummaryCopyWith<$Res> get craftsman {
    return $CraftsmanSummaryCopyWith<$Res>(_value.craftsman, (value) {
      return _then(_value.copyWith(craftsman: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuoteImplCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$$QuoteImplCopyWith(
          _$QuoteImpl value, $Res Function(_$QuoteImpl) then) =
      __$$QuoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      CraftsmanSummary craftsman,
      double amount,
      String? estimatedDuration,
      String? notes,
      DateTime? validUntil,
      String status,
      DateTime submittedAt});

  @override
  $CraftsmanSummaryCopyWith<$Res> get craftsman;
}

/// @nodoc
class __$$QuoteImplCopyWithImpl<$Res>
    extends _$QuoteCopyWithImpl<$Res, _$QuoteImpl>
    implements _$$QuoteImplCopyWith<$Res> {
  __$$QuoteImplCopyWithImpl(
      _$QuoteImpl _value, $Res Function(_$QuoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? craftsman = null,
    Object? amount = null,
    Object? estimatedDuration = freezed,
    Object? notes = freezed,
    Object? validUntil = freezed,
    Object? status = null,
    Object? submittedAt = null,
  }) {
    return _then(_$QuoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      craftsman: null == craftsman
          ? _value.craftsman
          : craftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteImpl implements _Quote {
  const _$QuoteImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.craftsman,
      required this.amount,
      this.estimatedDuration,
      this.notes,
      this.validUntil,
      this.status = 'pending',
      required this.submittedAt});

  factory _$QuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final CraftsmanSummary craftsman;
  @override
  final double amount;
  @override
  final String? estimatedDuration;
  @override
  final String? notes;
  @override
  final DateTime? validUntil;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime submittedAt;

  @override
  String toString() {
    return 'Quote(id: $id, craftsman: $craftsman, amount: $amount, estimatedDuration: $estimatedDuration, notes: $notes, validUntil: $validUntil, status: $status, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.craftsman, craftsman) ||
                other.craftsman == craftsman) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, craftsman, amount,
      estimatedDuration, notes, validUntil, status, submittedAt);

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteImplCopyWith<_$QuoteImpl> get copyWith =>
      __$$QuoteImplCopyWithImpl<_$QuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteImplToJson(
      this,
    );
  }
}

abstract class _Quote implements Quote {
  const factory _Quote(
      {@JsonKey(name: '_id') required final String id,
      required final CraftsmanSummary craftsman,
      required final double amount,
      final String? estimatedDuration,
      final String? notes,
      final DateTime? validUntil,
      final String status,
      required final DateTime submittedAt}) = _$QuoteImpl;

  factory _Quote.fromJson(Map<String, dynamic> json) = _$QuoteImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  CraftsmanSummary get craftsman;
  @override
  double get amount;
  @override
  String? get estimatedDuration;
  @override
  String? get notes;
  @override
  DateTime? get validUntil;
  @override
  String get status;
  @override
  DateTime get submittedAt;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteImplCopyWith<_$QuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CraftsmanSummary _$CraftsmanSummaryFromJson(Map<String, dynamic> json) {
  return _CraftsmanSummary.fromJson(json);
}

/// @nodoc
mixin _$CraftsmanSummary {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  int? get completedJobs => throw _privateConstructorUsedError;

  /// Serializes this CraftsmanSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CraftsmanSummaryCopyWith<CraftsmanSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CraftsmanSummaryCopyWith<$Res> {
  factory $CraftsmanSummaryCopyWith(
          CraftsmanSummary value, $Res Function(CraftsmanSummary) then) =
      _$CraftsmanSummaryCopyWithImpl<$Res, CraftsmanSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String displayName,
      double? rating,
      String? profileImage,
      int? completedJobs});
}

/// @nodoc
class _$CraftsmanSummaryCopyWithImpl<$Res, $Val extends CraftsmanSummary>
    implements $CraftsmanSummaryCopyWith<$Res> {
  _$CraftsmanSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? rating = freezed,
    Object? profileImage = freezed,
    Object? completedJobs = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      completedJobs: freezed == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CraftsmanSummaryImplCopyWith<$Res>
    implements $CraftsmanSummaryCopyWith<$Res> {
  factory _$$CraftsmanSummaryImplCopyWith(_$CraftsmanSummaryImpl value,
          $Res Function(_$CraftsmanSummaryImpl) then) =
      __$$CraftsmanSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String displayName,
      double? rating,
      String? profileImage,
      int? completedJobs});
}

/// @nodoc
class __$$CraftsmanSummaryImplCopyWithImpl<$Res>
    extends _$CraftsmanSummaryCopyWithImpl<$Res, _$CraftsmanSummaryImpl>
    implements _$$CraftsmanSummaryImplCopyWith<$Res> {
  __$$CraftsmanSummaryImplCopyWithImpl(_$CraftsmanSummaryImpl _value,
      $Res Function(_$CraftsmanSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? rating = freezed,
    Object? profileImage = freezed,
    Object? completedJobs = freezed,
  }) {
    return _then(_$CraftsmanSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      completedJobs: freezed == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CraftsmanSummaryImpl implements _CraftsmanSummary {
  const _$CraftsmanSummaryImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.displayName,
      this.rating,
      this.profileImage,
      this.completedJobs});

  factory _$CraftsmanSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CraftsmanSummaryImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String displayName;
  @override
  final double? rating;
  @override
  final String? profileImage;
  @override
  final int? completedJobs;

  @override
  String toString() {
    return 'CraftsmanSummary(id: $id, displayName: $displayName, rating: $rating, profileImage: $profileImage, completedJobs: $completedJobs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CraftsmanSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.completedJobs, completedJobs) ||
                other.completedJobs == completedJobs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, displayName, rating, profileImage, completedJobs);

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CraftsmanSummaryImplCopyWith<_$CraftsmanSummaryImpl> get copyWith =>
      __$$CraftsmanSummaryImplCopyWithImpl<_$CraftsmanSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CraftsmanSummaryImplToJson(
      this,
    );
  }
}

abstract class _CraftsmanSummary implements CraftsmanSummary {
  const factory _CraftsmanSummary(
      {@JsonKey(name: '_id') required final String id,
      required final String displayName,
      final double? rating,
      final String? profileImage,
      final int? completedJobs}) = _$CraftsmanSummaryImpl;

  factory _CraftsmanSummary.fromJson(Map<String, dynamic> json) =
      _$CraftsmanSummaryImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get displayName;
  @override
  double? get rating;
  @override
  String? get profileImage;
  @override
  int? get completedJobs;

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CraftsmanSummaryImplCopyWith<_$CraftsmanSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerSummary _$CustomerSummaryFromJson(Map<String, dynamic> json) {
  return _CustomerSummary.fromJson(json);
}

/// @nodoc
mixin _$CustomerSummary {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  /// Serializes this CustomerSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerSummaryCopyWith<CustomerSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerSummaryCopyWith<$Res> {
  factory $CustomerSummaryCopyWith(
          CustomerSummary value, $Res Function(CustomerSummary) then) =
      _$CustomerSummaryCopyWithImpl<$Res, CustomerSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? phone,
      String? avatar});
}

/// @nodoc
class _$CustomerSummaryCopyWithImpl<$Res, $Val extends CustomerSummary>
    implements $CustomerSummaryCopyWith<$Res> {
  _$CustomerSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerSummaryImplCopyWith<$Res>
    implements $CustomerSummaryCopyWith<$Res> {
  factory _$$CustomerSummaryImplCopyWith(_$CustomerSummaryImpl value,
          $Res Function(_$CustomerSummaryImpl) then) =
      __$$CustomerSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? phone,
      String? avatar});
}

/// @nodoc
class __$$CustomerSummaryImplCopyWithImpl<$Res>
    extends _$CustomerSummaryCopyWithImpl<$Res, _$CustomerSummaryImpl>
    implements _$$CustomerSummaryImplCopyWith<$Res> {
  __$$CustomerSummaryImplCopyWithImpl(
      _$CustomerSummaryImpl _value, $Res Function(_$CustomerSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_$CustomerSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerSummaryImpl implements _CustomerSummary {
  const _$CustomerSummaryImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      this.phone,
      this.avatar});

  factory _$CustomerSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerSummaryImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'CustomerSummary(id: $id, name: $name, phone: $phone, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, avatar);

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerSummaryImplCopyWith<_$CustomerSummaryImpl> get copyWith =>
      __$$CustomerSummaryImplCopyWithImpl<_$CustomerSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerSummaryImplToJson(
      this,
    );
  }
}

abstract class _CustomerSummary implements CustomerSummary {
  const factory _CustomerSummary(
      {@JsonKey(name: '_id') required final String id,
      required final String name,
      final String? phone,
      final String? avatar}) = _$CustomerSummaryImpl;

  factory _CustomerSummary.fromJson(Map<String, dynamic> json) =
      _$CustomerSummaryImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get avatar;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerSummaryImplCopyWith<_$CustomerSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategorySummary _$CategorySummaryFromJson(Map<String, dynamic> json) {
  return _CategorySummary.fromJson(json);
}

/// @nodoc
mixin _$CategorySummary {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this CategorySummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategorySummaryCopyWith<CategorySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySummaryCopyWith<$Res> {
  factory $CategorySummaryCopyWith(
          CategorySummary value, $Res Function(CategorySummary) then) =
      _$CategorySummaryCopyWithImpl<$Res, CategorySummary>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      String? icon});
}

/// @nodoc
class _$CategorySummaryCopyWithImpl<$Res, $Val extends CategorySummary>
    implements $CategorySummaryCopyWith<$Res> {
  _$CategorySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategorySummaryImplCopyWith<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  factory _$$CategorySummaryImplCopyWith(_$CategorySummaryImpl value,
          $Res Function(_$CategorySummaryImpl) then) =
      __$$CategorySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      String? icon});
}

/// @nodoc
class __$$CategorySummaryImplCopyWithImpl<$Res>
    extends _$CategorySummaryCopyWithImpl<$Res, _$CategorySummaryImpl>
    implements _$$CategorySummaryImplCopyWith<$Res> {
  __$$CategorySummaryImplCopyWithImpl(
      _$CategorySummaryImpl _value, $Res Function(_$CategorySummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? icon = freezed,
  }) {
    return _then(_$CategorySummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _value.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategorySummaryImpl implements _CategorySummary {
  const _$CategorySummaryImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      required this.nameAr,
      this.icon});

  factory _$CategorySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorySummaryImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String nameAr;
  @override
  final String? icon;

  @override
  String toString() {
    return 'CategorySummary(id: $id, name: $name, nameAr: $nameAr, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameAr, icon);

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySummaryImplCopyWith<_$CategorySummaryImpl> get copyWith =>
      __$$CategorySummaryImplCopyWithImpl<_$CategorySummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorySummaryImplToJson(
      this,
    );
  }
}

abstract class _CategorySummary implements CategorySummary {
  const factory _CategorySummary(
      {@JsonKey(name: '_id') required final String id,
      required final String name,
      required final String nameAr,
      final String? icon}) = _$CategorySummaryImpl;

  factory _CategorySummary.fromJson(Map<String, dynamic> json) =
      _$CategorySummaryImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String get nameAr;
  @override
  String? get icon;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategorySummaryImplCopyWith<_$CategorySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AcceptedQuote _$AcceptedQuoteFromJson(Map<String, dynamic> json) {
  return _AcceptedQuote.fromJson(json);
}

/// @nodoc
mixin _$AcceptedQuote {
  double get amount => throw _privateConstructorUsedError;
  String? get estimatedDuration => throw _privateConstructorUsedError;

  /// Serializes this AcceptedQuote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcceptedQuoteCopyWith<AcceptedQuote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptedQuoteCopyWith<$Res> {
  factory $AcceptedQuoteCopyWith(
          AcceptedQuote value, $Res Function(AcceptedQuote) then) =
      _$AcceptedQuoteCopyWithImpl<$Res, AcceptedQuote>;
  @useResult
  $Res call({double amount, String? estimatedDuration});
}

/// @nodoc
class _$AcceptedQuoteCopyWithImpl<$Res, $Val extends AcceptedQuote>
    implements $AcceptedQuoteCopyWith<$Res> {
  _$AcceptedQuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? estimatedDuration = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AcceptedQuoteImplCopyWith<$Res>
    implements $AcceptedQuoteCopyWith<$Res> {
  factory _$$AcceptedQuoteImplCopyWith(
          _$AcceptedQuoteImpl value, $Res Function(_$AcceptedQuoteImpl) then) =
      __$$AcceptedQuoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, String? estimatedDuration});
}

/// @nodoc
class __$$AcceptedQuoteImplCopyWithImpl<$Res>
    extends _$AcceptedQuoteCopyWithImpl<$Res, _$AcceptedQuoteImpl>
    implements _$$AcceptedQuoteImplCopyWith<$Res> {
  __$$AcceptedQuoteImplCopyWithImpl(
      _$AcceptedQuoteImpl _value, $Res Function(_$AcceptedQuoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? estimatedDuration = freezed,
  }) {
    return _then(_$AcceptedQuoteImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AcceptedQuoteImpl implements _AcceptedQuote {
  const _$AcceptedQuoteImpl({required this.amount, this.estimatedDuration});

  factory _$AcceptedQuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcceptedQuoteImplFromJson(json);

  @override
  final double amount;
  @override
  final String? estimatedDuration;

  @override
  String toString() {
    return 'AcceptedQuote(amount: $amount, estimatedDuration: $estimatedDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptedQuoteImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, estimatedDuration);

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptedQuoteImplCopyWith<_$AcceptedQuoteImpl> get copyWith =>
      __$$AcceptedQuoteImplCopyWithImpl<_$AcceptedQuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcceptedQuoteImplToJson(
      this,
    );
  }
}

abstract class _AcceptedQuote implements AcceptedQuote {
  const factory _AcceptedQuote(
      {required final double amount,
      final String? estimatedDuration}) = _$AcceptedQuoteImpl;

  factory _AcceptedQuote.fromJson(Map<String, dynamic> json) =
      _$AcceptedQuoteImpl.fromJson;

  @override
  double get amount;
  @override
  String? get estimatedDuration;

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcceptedQuoteImplCopyWith<_$AcceptedQuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusHistoryEntry _$StatusHistoryEntryFromJson(Map<String, dynamic> json) {
  return _StatusHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$StatusHistoryEntry {
  String get status => throw _privateConstructorUsedError;
  DateTime get changedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this StatusHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusHistoryEntryCopyWith<StatusHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusHistoryEntryCopyWith<$Res> {
  factory $StatusHistoryEntryCopyWith(
          StatusHistoryEntry value, $Res Function(StatusHistoryEntry) then) =
      _$StatusHistoryEntryCopyWithImpl<$Res, StatusHistoryEntry>;
  @useResult
  $Res call({String status, DateTime changedAt, String? notes});
}

/// @nodoc
class _$StatusHistoryEntryCopyWithImpl<$Res, $Val extends StatusHistoryEntry>
    implements $StatusHistoryEntryCopyWith<$Res> {
  _$StatusHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? changedAt = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusHistoryEntryImplCopyWith<$Res>
    implements $StatusHistoryEntryCopyWith<$Res> {
  factory _$$StatusHistoryEntryImplCopyWith(_$StatusHistoryEntryImpl value,
          $Res Function(_$StatusHistoryEntryImpl) then) =
      __$$StatusHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, DateTime changedAt, String? notes});
}

/// @nodoc
class __$$StatusHistoryEntryImplCopyWithImpl<$Res>
    extends _$StatusHistoryEntryCopyWithImpl<$Res, _$StatusHistoryEntryImpl>
    implements _$$StatusHistoryEntryImplCopyWith<$Res> {
  __$$StatusHistoryEntryImplCopyWithImpl(_$StatusHistoryEntryImpl _value,
      $Res Function(_$StatusHistoryEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? changedAt = null,
    Object? notes = freezed,
  }) {
    return _then(_$StatusHistoryEntryImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusHistoryEntryImpl implements _StatusHistoryEntry {
  const _$StatusHistoryEntryImpl(
      {required this.status, required this.changedAt, this.notes});

  factory _$StatusHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusHistoryEntryImplFromJson(json);

  @override
  final String status;
  @override
  final DateTime changedAt;
  @override
  final String? notes;

  @override
  String toString() {
    return 'StatusHistoryEntry(status: $status, changedAt: $changedAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusHistoryEntryImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, changedAt, notes);

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusHistoryEntryImplCopyWith<_$StatusHistoryEntryImpl> get copyWith =>
      __$$StatusHistoryEntryImplCopyWithImpl<_$StatusHistoryEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _StatusHistoryEntry implements StatusHistoryEntry {
  const factory _StatusHistoryEntry(
      {required final String status,
      required final DateTime changedAt,
      final String? notes}) = _$StatusHistoryEntryImpl;

  factory _StatusHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$StatusHistoryEntryImpl.fromJson;

  @override
  String get status;
  @override
  DateTime get changedAt;
  @override
  String? get notes;

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusHistoryEntryImplCopyWith<_$StatusHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceRequest _$ServiceRequestFromJson(Map<String, dynamic> json) {
  return _ServiceRequest.fromJson(json);
}

/// @nodoc
mixin _$ServiceRequest {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get requestNumber => throw _privateConstructorUsedError;
  CustomerSummary get customer => throw _privateConstructorUsedError;
  CategorySummary get category => throw _privateConstructorUsedError;
  String? get subcategory => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  RequestLocation get location => throw _privateConstructorUsedError;
  DateTime? get preferredDate => throw _privateConstructorUsedError;
  PreferredTime? get preferredTime => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  RequestBudget? get budget => throw _privateConstructorUsedError;
  RequestUrgency get urgency => throw _privateConstructorUsedError;
  RequestStatus get status => throw _privateConstructorUsedError;
  List<Quote> get quotes => throw _privateConstructorUsedError;
  CraftsmanSummary? get assignedCraftsman => throw _privateConstructorUsedError;
  AcceptedQuote? get acceptedQuote => throw _privateConstructorUsedError;
  List<StatusHistoryEntry> get statusHistory =>
      throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get arrivedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  String? get cancelledBy => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;
  double? get actualAmount => throw _privateConstructorUsedError;
  String? get completionNotes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ServiceRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceRequestCopyWith<ServiceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRequestCopyWith<$Res> {
  factory $ServiceRequestCopyWith(
          ServiceRequest value, $Res Function(ServiceRequest) then) =
      _$ServiceRequestCopyWithImpl<$Res, ServiceRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestNumber,
      CustomerSummary customer,
      CategorySummary category,
      String? subcategory,
      String title,
      String description,
      RequestLocation location,
      DateTime? preferredDate,
      PreferredTime? preferredTime,
      List<String> images,
      RequestBudget? budget,
      RequestUrgency urgency,
      RequestStatus status,
      List<Quote> quotes,
      CraftsmanSummary? assignedCraftsman,
      AcceptedQuote? acceptedQuote,
      List<StatusHistoryEntry> statusHistory,
      DateTime? startedAt,
      DateTime? arrivedAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      String? cancelledBy,
      String? cancellationReason,
      double? actualAmount,
      String? completionNotes,
      DateTime createdAt,
      DateTime updatedAt});

  $CustomerSummaryCopyWith<$Res> get customer;
  $CategorySummaryCopyWith<$Res> get category;
  $RequestLocationCopyWith<$Res> get location;
  $PreferredTimeCopyWith<$Res>? get preferredTime;
  $RequestBudgetCopyWith<$Res>? get budget;
  $CraftsmanSummaryCopyWith<$Res>? get assignedCraftsman;
  $AcceptedQuoteCopyWith<$Res>? get acceptedQuote;
}

/// @nodoc
class _$ServiceRequestCopyWithImpl<$Res, $Val extends ServiceRequest>
    implements $ServiceRequestCopyWith<$Res> {
  _$ServiceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestNumber = null,
    Object? customer = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? preferredDate = freezed,
    Object? preferredTime = freezed,
    Object? images = null,
    Object? budget = freezed,
    Object? urgency = null,
    Object? status = null,
    Object? quotes = null,
    Object? assignedCraftsman = freezed,
    Object? acceptedQuote = freezed,
    Object? statusHistory = null,
    Object? startedAt = freezed,
    Object? arrivedAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancelledBy = freezed,
    Object? cancellationReason = freezed,
    Object? actualAmount = freezed,
    Object? completionNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestNumber: null == requestNumber
          ? _value.requestNumber
          : requestNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerSummary,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategorySummary,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _value.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      quotes: null == quotes
          ? _value.quotes
          : quotes // ignore: cast_nullable_to_non_nullable
              as List<Quote>,
      assignedCraftsman: freezed == assignedCraftsman
          ? _value.assignedCraftsman
          : assignedCraftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary?,
      acceptedQuote: freezed == acceptedQuote
          ? _value.acceptedQuote
          : acceptedQuote // ignore: cast_nullable_to_non_nullable
              as AcceptedQuote?,
      statusHistory: null == statusHistory
          ? _value.statusHistory
          : statusHistory // ignore: cast_nullable_to_non_nullable
              as List<StatusHistoryEntry>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivedAt: freezed == arrivedAt
          ? _value.arrivedAt
          : arrivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledBy: freezed == cancelledBy
          ? _value.cancelledBy
          : cancelledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      actualAmount: freezed == actualAmount
          ? _value.actualAmount
          : actualAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      completionNotes: freezed == completionNotes
          ? _value.completionNotes
          : completionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerSummaryCopyWith<$Res> get customer {
    return $CustomerSummaryCopyWith<$Res>(_value.customer, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategorySummaryCopyWith<$Res> get category {
    return $CategorySummaryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestLocationCopyWith<$Res> get location {
    return $RequestLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PreferredTimeCopyWith<$Res>? get preferredTime {
    if (_value.preferredTime == null) {
      return null;
    }

    return $PreferredTimeCopyWith<$Res>(_value.preferredTime!, (value) {
      return _then(_value.copyWith(preferredTime: value) as $Val);
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBudgetCopyWith<$Res>? get budget {
    if (_value.budget == null) {
      return null;
    }

    return $RequestBudgetCopyWith<$Res>(_value.budget!, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanSummaryCopyWith<$Res>? get assignedCraftsman {
    if (_value.assignedCraftsman == null) {
      return null;
    }

    return $CraftsmanSummaryCopyWith<$Res>(_value.assignedCraftsman!, (value) {
      return _then(_value.copyWith(assignedCraftsman: value) as $Val);
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcceptedQuoteCopyWith<$Res>? get acceptedQuote {
    if (_value.acceptedQuote == null) {
      return null;
    }

    return $AcceptedQuoteCopyWith<$Res>(_value.acceptedQuote!, (value) {
      return _then(_value.copyWith(acceptedQuote: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServiceRequestImplCopyWith<$Res>
    implements $ServiceRequestCopyWith<$Res> {
  factory _$$ServiceRequestImplCopyWith(_$ServiceRequestImpl value,
          $Res Function(_$ServiceRequestImpl) then) =
      __$$ServiceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestNumber,
      CustomerSummary customer,
      CategorySummary category,
      String? subcategory,
      String title,
      String description,
      RequestLocation location,
      DateTime? preferredDate,
      PreferredTime? preferredTime,
      List<String> images,
      RequestBudget? budget,
      RequestUrgency urgency,
      RequestStatus status,
      List<Quote> quotes,
      CraftsmanSummary? assignedCraftsman,
      AcceptedQuote? acceptedQuote,
      List<StatusHistoryEntry> statusHistory,
      DateTime? startedAt,
      DateTime? arrivedAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      String? cancelledBy,
      String? cancellationReason,
      double? actualAmount,
      String? completionNotes,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $CustomerSummaryCopyWith<$Res> get customer;
  @override
  $CategorySummaryCopyWith<$Res> get category;
  @override
  $RequestLocationCopyWith<$Res> get location;
  @override
  $PreferredTimeCopyWith<$Res>? get preferredTime;
  @override
  $RequestBudgetCopyWith<$Res>? get budget;
  @override
  $CraftsmanSummaryCopyWith<$Res>? get assignedCraftsman;
  @override
  $AcceptedQuoteCopyWith<$Res>? get acceptedQuote;
}

/// @nodoc
class __$$ServiceRequestImplCopyWithImpl<$Res>
    extends _$ServiceRequestCopyWithImpl<$Res, _$ServiceRequestImpl>
    implements _$$ServiceRequestImplCopyWith<$Res> {
  __$$ServiceRequestImplCopyWithImpl(
      _$ServiceRequestImpl _value, $Res Function(_$ServiceRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestNumber = null,
    Object? customer = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? preferredDate = freezed,
    Object? preferredTime = freezed,
    Object? images = null,
    Object? budget = freezed,
    Object? urgency = null,
    Object? status = null,
    Object? quotes = null,
    Object? assignedCraftsman = freezed,
    Object? acceptedQuote = freezed,
    Object? statusHistory = null,
    Object? startedAt = freezed,
    Object? arrivedAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancelledBy = freezed,
    Object? cancellationReason = freezed,
    Object? actualAmount = freezed,
    Object? completionNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ServiceRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestNumber: null == requestNumber
          ? _value.requestNumber
          : requestNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerSummary,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategorySummary,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _value.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      quotes: null == quotes
          ? _value._quotes
          : quotes // ignore: cast_nullable_to_non_nullable
              as List<Quote>,
      assignedCraftsman: freezed == assignedCraftsman
          ? _value.assignedCraftsman
          : assignedCraftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary?,
      acceptedQuote: freezed == acceptedQuote
          ? _value.acceptedQuote
          : acceptedQuote // ignore: cast_nullable_to_non_nullable
              as AcceptedQuote?,
      statusHistory: null == statusHistory
          ? _value._statusHistory
          : statusHistory // ignore: cast_nullable_to_non_nullable
              as List<StatusHistoryEntry>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivedAt: freezed == arrivedAt
          ? _value.arrivedAt
          : arrivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledBy: freezed == cancelledBy
          ? _value.cancelledBy
          : cancelledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      actualAmount: freezed == actualAmount
          ? _value.actualAmount
          : actualAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      completionNotes: freezed == completionNotes
          ? _value.completionNotes
          : completionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceRequestImpl extends _ServiceRequest {
  const _$ServiceRequestImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.requestNumber,
      required this.customer,
      required this.category,
      this.subcategory,
      required this.title,
      required this.description,
      required this.location,
      this.preferredDate,
      this.preferredTime,
      final List<String> images = const [],
      this.budget,
      this.urgency = RequestUrgency.normal,
      this.status = RequestStatus.pending,
      final List<Quote> quotes = const [],
      this.assignedCraftsman,
      this.acceptedQuote,
      final List<StatusHistoryEntry> statusHistory = const [],
      this.startedAt,
      this.arrivedAt,
      this.completedAt,
      this.cancelledAt,
      this.cancelledBy,
      this.cancellationReason,
      this.actualAmount,
      this.completionNotes,
      required this.createdAt,
      required this.updatedAt})
      : _images = images,
        _quotes = quotes,
        _statusHistory = statusHistory,
        super._();

  factory _$ServiceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceRequestImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String requestNumber;
  @override
  final CustomerSummary customer;
  @override
  final CategorySummary category;
  @override
  final String? subcategory;
  @override
  final String title;
  @override
  final String description;
  @override
  final RequestLocation location;
  @override
  final DateTime? preferredDate;
  @override
  final PreferredTime? preferredTime;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final RequestBudget? budget;
  @override
  @JsonKey()
  final RequestUrgency urgency;
  @override
  @JsonKey()
  final RequestStatus status;
  final List<Quote> _quotes;
  @override
  @JsonKey()
  List<Quote> get quotes {
    if (_quotes is EqualUnmodifiableListView) return _quotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quotes);
  }

  @override
  final CraftsmanSummary? assignedCraftsman;
  @override
  final AcceptedQuote? acceptedQuote;
  final List<StatusHistoryEntry> _statusHistory;
  @override
  @JsonKey()
  List<StatusHistoryEntry> get statusHistory {
    if (_statusHistory is EqualUnmodifiableListView) return _statusHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statusHistory);
  }

  @override
  final DateTime? startedAt;
  @override
  final DateTime? arrivedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? cancelledAt;
  @override
  final String? cancelledBy;
  @override
  final String? cancellationReason;
  @override
  final double? actualAmount;
  @override
  final String? completionNotes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ServiceRequest(id: $id, requestNumber: $requestNumber, customer: $customer, category: $category, subcategory: $subcategory, title: $title, description: $description, location: $location, preferredDate: $preferredDate, preferredTime: $preferredTime, images: $images, budget: $budget, urgency: $urgency, status: $status, quotes: $quotes, assignedCraftsman: $assignedCraftsman, acceptedQuote: $acceptedQuote, statusHistory: $statusHistory, startedAt: $startedAt, arrivedAt: $arrivedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, cancelledBy: $cancelledBy, cancellationReason: $cancellationReason, actualAmount: $actualAmount, completionNotes: $completionNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestNumber, requestNumber) ||
                other.requestNumber == requestNumber) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subcategory, subcategory) ||
                other.subcategory == subcategory) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.preferredDate, preferredDate) ||
                other.preferredDate == preferredDate) &&
            (identical(other.preferredTime, preferredTime) ||
                other.preferredTime == preferredTime) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._quotes, _quotes) &&
            (identical(other.assignedCraftsman, assignedCraftsman) ||
                other.assignedCraftsman == assignedCraftsman) &&
            (identical(other.acceptedQuote, acceptedQuote) ||
                other.acceptedQuote == acceptedQuote) &&
            const DeepCollectionEquality()
                .equals(other._statusHistory, _statusHistory) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.arrivedAt, arrivedAt) ||
                other.arrivedAt == arrivedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancelledBy, cancelledBy) ||
                other.cancelledBy == cancelledBy) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason) &&
            (identical(other.actualAmount, actualAmount) ||
                other.actualAmount == actualAmount) &&
            (identical(other.completionNotes, completionNotes) ||
                other.completionNotes == completionNotes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        requestNumber,
        customer,
        category,
        subcategory,
        title,
        description,
        location,
        preferredDate,
        preferredTime,
        const DeepCollectionEquality().hash(_images),
        budget,
        urgency,
        status,
        const DeepCollectionEquality().hash(_quotes),
        assignedCraftsman,
        acceptedQuote,
        const DeepCollectionEquality().hash(_statusHistory),
        startedAt,
        arrivedAt,
        completedAt,
        cancelledAt,
        cancelledBy,
        cancellationReason,
        actualAmount,
        completionNotes,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceRequestImplCopyWith<_$ServiceRequestImpl> get copyWith =>
      __$$ServiceRequestImplCopyWithImpl<_$ServiceRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceRequestImplToJson(
      this,
    );
  }
}

abstract class _ServiceRequest extends ServiceRequest {
  const factory _ServiceRequest(
      {@JsonKey(name: '_id') required final String id,
      required final String requestNumber,
      required final CustomerSummary customer,
      required final CategorySummary category,
      final String? subcategory,
      required final String title,
      required final String description,
      required final RequestLocation location,
      final DateTime? preferredDate,
      final PreferredTime? preferredTime,
      final List<String> images,
      final RequestBudget? budget,
      final RequestUrgency urgency,
      final RequestStatus status,
      final List<Quote> quotes,
      final CraftsmanSummary? assignedCraftsman,
      final AcceptedQuote? acceptedQuote,
      final List<StatusHistoryEntry> statusHistory,
      final DateTime? startedAt,
      final DateTime? arrivedAt,
      final DateTime? completedAt,
      final DateTime? cancelledAt,
      final String? cancelledBy,
      final String? cancellationReason,
      final double? actualAmount,
      final String? completionNotes,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ServiceRequestImpl;
  const _ServiceRequest._() : super._();

  factory _ServiceRequest.fromJson(Map<String, dynamic> json) =
      _$ServiceRequestImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get requestNumber;
  @override
  CustomerSummary get customer;
  @override
  CategorySummary get category;
  @override
  String? get subcategory;
  @override
  String get title;
  @override
  String get description;
  @override
  RequestLocation get location;
  @override
  DateTime? get preferredDate;
  @override
  PreferredTime? get preferredTime;
  @override
  List<String> get images;
  @override
  RequestBudget? get budget;
  @override
  RequestUrgency get urgency;
  @override
  RequestStatus get status;
  @override
  List<Quote> get quotes;
  @override
  CraftsmanSummary? get assignedCraftsman;
  @override
  AcceptedQuote? get acceptedQuote;
  @override
  List<StatusHistoryEntry> get statusHistory;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get arrivedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get cancelledAt;
  @override
  String? get cancelledBy;
  @override
  String? get cancellationReason;
  @override
  double? get actualAmount;
  @override
  String? get completionNotes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceRequestImplCopyWith<_$ServiceRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateRequestData _$CreateRequestDataFromJson(Map<String, dynamic> json) {
  return _CreateRequestData.fromJson(json);
}

/// @nodoc
mixin _$CreateRequestData {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get subcategory => throw _privateConstructorUsedError;
  RequestLocation get location => throw _privateConstructorUsedError;
  DateTime? get preferredDate => throw _privateConstructorUsedError;
  PreferredTime? get preferredTime => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  RequestBudget? get budget => throw _privateConstructorUsedError;
  RequestUrgency get urgency => throw _privateConstructorUsedError;

  /// Serializes this CreateRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateRequestDataCopyWith<CreateRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateRequestDataCopyWith<$Res> {
  factory $CreateRequestDataCopyWith(
          CreateRequestData value, $Res Function(CreateRequestData) then) =
      _$CreateRequestDataCopyWithImpl<$Res, CreateRequestData>;
  @useResult
  $Res call(
      {String title,
      String description,
      String category,
      String? subcategory,
      RequestLocation location,
      DateTime? preferredDate,
      PreferredTime? preferredTime,
      List<String> images,
      RequestBudget? budget,
      RequestUrgency urgency});

  $RequestLocationCopyWith<$Res> get location;
  $PreferredTimeCopyWith<$Res>? get preferredTime;
  $RequestBudgetCopyWith<$Res>? get budget;
}

/// @nodoc
class _$CreateRequestDataCopyWithImpl<$Res, $Val extends CreateRequestData>
    implements $CreateRequestDataCopyWith<$Res> {
  _$CreateRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? location = null,
    Object? preferredDate = freezed,
    Object? preferredTime = freezed,
    Object? images = null,
    Object? budget = freezed,
    Object? urgency = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _value.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
    ) as $Val);
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestLocationCopyWith<$Res> get location {
    return $RequestLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PreferredTimeCopyWith<$Res>? get preferredTime {
    if (_value.preferredTime == null) {
      return null;
    }

    return $PreferredTimeCopyWith<$Res>(_value.preferredTime!, (value) {
      return _then(_value.copyWith(preferredTime: value) as $Val);
    });
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBudgetCopyWith<$Res>? get budget {
    if (_value.budget == null) {
      return null;
    }

    return $RequestBudgetCopyWith<$Res>(_value.budget!, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateRequestDataImplCopyWith<$Res>
    implements $CreateRequestDataCopyWith<$Res> {
  factory _$$CreateRequestDataImplCopyWith(_$CreateRequestDataImpl value,
          $Res Function(_$CreateRequestDataImpl) then) =
      __$$CreateRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      String category,
      String? subcategory,
      RequestLocation location,
      DateTime? preferredDate,
      PreferredTime? preferredTime,
      List<String> images,
      RequestBudget? budget,
      RequestUrgency urgency});

  @override
  $RequestLocationCopyWith<$Res> get location;
  @override
  $PreferredTimeCopyWith<$Res>? get preferredTime;
  @override
  $RequestBudgetCopyWith<$Res>? get budget;
}

/// @nodoc
class __$$CreateRequestDataImplCopyWithImpl<$Res>
    extends _$CreateRequestDataCopyWithImpl<$Res, _$CreateRequestDataImpl>
    implements _$$CreateRequestDataImplCopyWith<$Res> {
  __$$CreateRequestDataImplCopyWithImpl(_$CreateRequestDataImpl _value,
      $Res Function(_$CreateRequestDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? location = null,
    Object? preferredDate = freezed,
    Object? preferredTime = freezed,
    Object? images = null,
    Object? budget = freezed,
    Object? urgency = null,
  }) {
    return _then(_$CreateRequestDataImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _value.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateRequestDataImpl implements _CreateRequestData {
  const _$CreateRequestDataImpl(
      {required this.title,
      required this.description,
      required this.category,
      this.subcategory,
      required this.location,
      this.preferredDate,
      this.preferredTime,
      final List<String> images = const [],
      this.budget,
      this.urgency = RequestUrgency.normal})
      : _images = images;

  factory _$CreateRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateRequestDataImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final String category;
  @override
  final String? subcategory;
  @override
  final RequestLocation location;
  @override
  final DateTime? preferredDate;
  @override
  final PreferredTime? preferredTime;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final RequestBudget? budget;
  @override
  @JsonKey()
  final RequestUrgency urgency;

  @override
  String toString() {
    return 'CreateRequestData(title: $title, description: $description, category: $category, subcategory: $subcategory, location: $location, preferredDate: $preferredDate, preferredTime: $preferredTime, images: $images, budget: $budget, urgency: $urgency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateRequestDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subcategory, subcategory) ||
                other.subcategory == subcategory) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.preferredDate, preferredDate) ||
                other.preferredDate == preferredDate) &&
            (identical(other.preferredTime, preferredTime) ||
                other.preferredTime == preferredTime) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.urgency, urgency) || other.urgency == urgency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      category,
      subcategory,
      location,
      preferredDate,
      preferredTime,
      const DeepCollectionEquality().hash(_images),
      budget,
      urgency);

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateRequestDataImplCopyWith<_$CreateRequestDataImpl> get copyWith =>
      __$$CreateRequestDataImplCopyWithImpl<_$CreateRequestDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateRequestDataImplToJson(
      this,
    );
  }
}

abstract class _CreateRequestData implements CreateRequestData {
  const factory _CreateRequestData(
      {required final String title,
      required final String description,
      required final String category,
      final String? subcategory,
      required final RequestLocation location,
      final DateTime? preferredDate,
      final PreferredTime? preferredTime,
      final List<String> images,
      final RequestBudget? budget,
      final RequestUrgency urgency}) = _$CreateRequestDataImpl;

  factory _CreateRequestData.fromJson(Map<String, dynamic> json) =
      _$CreateRequestDataImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get category;
  @override
  String? get subcategory;
  @override
  RequestLocation get location;
  @override
  DateTime? get preferredDate;
  @override
  PreferredTime? get preferredTime;
  @override
  List<String> get images;
  @override
  RequestBudget? get budget;
  @override
  RequestUrgency get urgency;

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateRequestDataImplCopyWith<_$CreateRequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubmitQuoteData _$SubmitQuoteDataFromJson(Map<String, dynamic> json) {
  return _SubmitQuoteData.fromJson(json);
}

/// @nodoc
mixin _$SubmitQuoteData {
  double get amount => throw _privateConstructorUsedError;
  String? get estimatedDuration => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get validUntil => throw _privateConstructorUsedError;

  /// Serializes this SubmitQuoteData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmitQuoteDataCopyWith<SubmitQuoteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitQuoteDataCopyWith<$Res> {
  factory $SubmitQuoteDataCopyWith(
          SubmitQuoteData value, $Res Function(SubmitQuoteData) then) =
      _$SubmitQuoteDataCopyWithImpl<$Res, SubmitQuoteData>;
  @useResult
  $Res call(
      {double amount,
      String? estimatedDuration,
      String? notes,
      DateTime? validUntil});
}

/// @nodoc
class _$SubmitQuoteDataCopyWithImpl<$Res, $Val extends SubmitQuoteData>
    implements $SubmitQuoteDataCopyWith<$Res> {
  _$SubmitQuoteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? estimatedDuration = freezed,
    Object? notes = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmitQuoteDataImplCopyWith<$Res>
    implements $SubmitQuoteDataCopyWith<$Res> {
  factory _$$SubmitQuoteDataImplCopyWith(_$SubmitQuoteDataImpl value,
          $Res Function(_$SubmitQuoteDataImpl) then) =
      __$$SubmitQuoteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double amount,
      String? estimatedDuration,
      String? notes,
      DateTime? validUntil});
}

/// @nodoc
class __$$SubmitQuoteDataImplCopyWithImpl<$Res>
    extends _$SubmitQuoteDataCopyWithImpl<$Res, _$SubmitQuoteDataImpl>
    implements _$$SubmitQuoteDataImplCopyWith<$Res> {
  __$$SubmitQuoteDataImplCopyWithImpl(
      _$SubmitQuoteDataImpl _value, $Res Function(_$SubmitQuoteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? estimatedDuration = freezed,
    Object? notes = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(_$SubmitQuoteDataImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _value.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmitQuoteDataImpl implements _SubmitQuoteData {
  const _$SubmitQuoteDataImpl(
      {required this.amount,
      this.estimatedDuration,
      this.notes,
      this.validUntil});

  factory _$SubmitQuoteDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmitQuoteDataImplFromJson(json);

  @override
  final double amount;
  @override
  final String? estimatedDuration;
  @override
  final String? notes;
  @override
  final DateTime? validUntil;

  @override
  String toString() {
    return 'SubmitQuoteData(amount: $amount, estimatedDuration: $estimatedDuration, notes: $notes, validUntil: $validUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitQuoteDataImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, estimatedDuration, notes, validUntil);

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitQuoteDataImplCopyWith<_$SubmitQuoteDataImpl> get copyWith =>
      __$$SubmitQuoteDataImplCopyWithImpl<_$SubmitQuoteDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmitQuoteDataImplToJson(
      this,
    );
  }
}

abstract class _SubmitQuoteData implements SubmitQuoteData {
  const factory _SubmitQuoteData(
      {required final double amount,
      final String? estimatedDuration,
      final String? notes,
      final DateTime? validUntil}) = _$SubmitQuoteDataImpl;

  factory _SubmitQuoteData.fromJson(Map<String, dynamic> json) =
      _$SubmitQuoteDataImpl.fromJson;

  @override
  double get amount;
  @override
  String? get estimatedDuration;
  @override
  String? get notes;
  @override
  DateTime? get validUntil;

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitQuoteDataImplCopyWith<_$SubmitQuoteDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestListResponse _$RequestListResponseFromJson(Map<String, dynamic> json) {
  return _RequestListResponse.fromJson(json);
}

/// @nodoc
mixin _$RequestListResponse {
  List<ServiceRequest> get data => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this RequestListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestListResponseCopyWith<RequestListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestListResponseCopyWith<$Res> {
  factory $RequestListResponseCopyWith(
          RequestListResponse value, $Res Function(RequestListResponse) then) =
      _$RequestListResponseCopyWithImpl<$Res, RequestListResponse>;
  @useResult
  $Res call(
      {List<ServiceRequest> data,
      int page,
      int totalPages,
      int total,
      int limit});
}

/// @nodoc
class _$RequestListResponseCopyWithImpl<$Res, $Val extends RequestListResponse>
    implements $RequestListResponseCopyWith<$Res> {
  _$RequestListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? totalPages = null,
    Object? total = null,
    Object? limit = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ServiceRequest>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestListResponseImplCopyWith<$Res>
    implements $RequestListResponseCopyWith<$Res> {
  factory _$$RequestListResponseImplCopyWith(_$RequestListResponseImpl value,
          $Res Function(_$RequestListResponseImpl) then) =
      __$$RequestListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ServiceRequest> data,
      int page,
      int totalPages,
      int total,
      int limit});
}

/// @nodoc
class __$$RequestListResponseImplCopyWithImpl<$Res>
    extends _$RequestListResponseCopyWithImpl<$Res, _$RequestListResponseImpl>
    implements _$$RequestListResponseImplCopyWith<$Res> {
  __$$RequestListResponseImplCopyWithImpl(_$RequestListResponseImpl _value,
      $Res Function(_$RequestListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? totalPages = null,
    Object? total = null,
    Object? limit = null,
  }) {
    return _then(_$RequestListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ServiceRequest>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestListResponseImpl implements _RequestListResponse {
  const _$RequestListResponseImpl(
      {required final List<ServiceRequest> data,
      required this.page,
      required this.totalPages,
      required this.total,
      required this.limit})
      : _data = data;

  factory _$RequestListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestListResponseImplFromJson(json);

  final List<ServiceRequest> _data;
  @override
  List<ServiceRequest> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int page;
  @override
  final int totalPages;
  @override
  final int total;
  @override
  final int limit;

  @override
  String toString() {
    return 'RequestListResponse(data: $data, page: $page, totalPages: $totalPages, total: $total, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      page,
      totalPages,
      total,
      limit);

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestListResponseImplCopyWith<_$RequestListResponseImpl> get copyWith =>
      __$$RequestListResponseImplCopyWithImpl<_$RequestListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestListResponseImplToJson(
      this,
    );
  }
}

abstract class _RequestListResponse implements RequestListResponse {
  const factory _RequestListResponse(
      {required final List<ServiceRequest> data,
      required final int page,
      required final int totalPages,
      required final int total,
      required final int limit}) = _$RequestListResponseImpl;

  factory _RequestListResponse.fromJson(Map<String, dynamic> json) =
      _$RequestListResponseImpl.fromJson;

  @override
  List<ServiceRequest> get data;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  int get total;
  @override
  int get limit;

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestListResponseImplCopyWith<_$RequestListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
