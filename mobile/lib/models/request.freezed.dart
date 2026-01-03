// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestLocation {
  String get address;
  List<double> get coordinates;
  String get governorate;
  String get city;
  String? get area;

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestLocationCopyWith<RequestLocation> get copyWith =>
      _$RequestLocationCopyWithImpl<RequestLocation>(
          this as RequestLocation, _$identity);

  /// Serializes this RequestLocation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestLocation &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other.coordinates, coordinates) &&
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
      const DeepCollectionEquality().hash(coordinates),
      governorate,
      city,
      area);

  @override
  String toString() {
    return 'RequestLocation(address: $address, coordinates: $coordinates, governorate: $governorate, city: $city, area: $area)';
  }
}

/// @nodoc
abstract mixin class $RequestLocationCopyWith<$Res> {
  factory $RequestLocationCopyWith(
          RequestLocation value, $Res Function(RequestLocation) _then) =
      _$RequestLocationCopyWithImpl;
  @useResult
  $Res call(
      {String address,
      List<double> coordinates,
      String governorate,
      String city,
      String? area});
}

/// @nodoc
class _$RequestLocationCopyWithImpl<$Res>
    implements $RequestLocationCopyWith<$Res> {
  _$RequestLocationCopyWithImpl(this._self, this._then);

  final RequestLocation _self;
  final $Res Function(RequestLocation) _then;

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
    return _then(_self.copyWith(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _self.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      governorate: null == governorate
          ? _self.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RequestLocation implements RequestLocation {
  const _RequestLocation(
      {required this.address,
      required final List<double> coordinates,
      required this.governorate,
      required this.city,
      this.area})
      : _coordinates = coordinates;
  factory _RequestLocation.fromJson(Map<String, dynamic> json) =>
      _$RequestLocationFromJson(json);

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

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestLocationCopyWith<_RequestLocation> get copyWith =>
      __$RequestLocationCopyWithImpl<_RequestLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestLocationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestLocation &&
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

  @override
  String toString() {
    return 'RequestLocation(address: $address, coordinates: $coordinates, governorate: $governorate, city: $city, area: $area)';
  }
}

/// @nodoc
abstract mixin class _$RequestLocationCopyWith<$Res>
    implements $RequestLocationCopyWith<$Res> {
  factory _$RequestLocationCopyWith(
          _RequestLocation value, $Res Function(_RequestLocation) _then) =
      __$RequestLocationCopyWithImpl;
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
class __$RequestLocationCopyWithImpl<$Res>
    implements _$RequestLocationCopyWith<$Res> {
  __$RequestLocationCopyWithImpl(this._self, this._then);

  final _RequestLocation _self;
  final $Res Function(_RequestLocation) _then;

  /// Create a copy of RequestLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = null,
    Object? coordinates = null,
    Object? governorate = null,
    Object? city = null,
    Object? area = freezed,
  }) {
    return _then(_RequestLocation(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _self._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      governorate: null == governorate
          ? _self.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$RequestBudget {
  double get min;
  double get max;

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestBudgetCopyWith<RequestBudget> get copyWith =>
      _$RequestBudgetCopyWithImpl<RequestBudget>(
          this as RequestBudget, _$identity);

  /// Serializes this RequestBudget to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestBudget &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @override
  String toString() {
    return 'RequestBudget(min: $min, max: $max)';
  }
}

/// @nodoc
abstract mixin class $RequestBudgetCopyWith<$Res> {
  factory $RequestBudgetCopyWith(
          RequestBudget value, $Res Function(RequestBudget) _then) =
      _$RequestBudgetCopyWithImpl;
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class _$RequestBudgetCopyWithImpl<$Res>
    implements $RequestBudgetCopyWith<$Res> {
  _$RequestBudgetCopyWithImpl(this._self, this._then);

  final RequestBudget _self;
  final $Res Function(RequestBudget) _then;

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_self.copyWith(
      min: null == min
          ? _self.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _self.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RequestBudget implements RequestBudget {
  const _RequestBudget({required this.min, required this.max});
  factory _RequestBudget.fromJson(Map<String, dynamic> json) =>
      _$RequestBudgetFromJson(json);

  @override
  final double min;
  @override
  final double max;

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestBudgetCopyWith<_RequestBudget> get copyWith =>
      __$RequestBudgetCopyWithImpl<_RequestBudget>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestBudgetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestBudget &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @override
  String toString() {
    return 'RequestBudget(min: $min, max: $max)';
  }
}

/// @nodoc
abstract mixin class _$RequestBudgetCopyWith<$Res>
    implements $RequestBudgetCopyWith<$Res> {
  factory _$RequestBudgetCopyWith(
          _RequestBudget value, $Res Function(_RequestBudget) _then) =
      __$RequestBudgetCopyWithImpl;
  @override
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class __$RequestBudgetCopyWithImpl<$Res>
    implements _$RequestBudgetCopyWith<$Res> {
  __$RequestBudgetCopyWithImpl(this._self, this._then);

  final _RequestBudget _self;
  final $Res Function(_RequestBudget) _then;

  /// Create a copy of RequestBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_RequestBudget(
      min: null == min
          ? _self.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _self.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$PreferredTime {
  String get start;
  String get end;

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreferredTimeCopyWith<PreferredTime> get copyWith =>
      _$PreferredTimeCopyWithImpl<PreferredTime>(
          this as PreferredTime, _$identity);

  /// Serializes this PreferredTime to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PreferredTime &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @override
  String toString() {
    return 'PreferredTime(start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class $PreferredTimeCopyWith<$Res> {
  factory $PreferredTimeCopyWith(
          PreferredTime value, $Res Function(PreferredTime) _then) =
      _$PreferredTimeCopyWithImpl;
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class _$PreferredTimeCopyWithImpl<$Res>
    implements $PreferredTimeCopyWith<$Res> {
  _$PreferredTimeCopyWithImpl(this._self, this._then);

  final PreferredTime _self;
  final $Res Function(PreferredTime) _then;

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_self.copyWith(
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PreferredTime implements PreferredTime {
  const _PreferredTime({required this.start, required this.end});
  factory _PreferredTime.fromJson(Map<String, dynamic> json) =>
      _$PreferredTimeFromJson(json);

  @override
  final String start;
  @override
  final String end;

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PreferredTimeCopyWith<_PreferredTime> get copyWith =>
      __$PreferredTimeCopyWithImpl<_PreferredTime>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PreferredTimeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PreferredTime &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  @override
  String toString() {
    return 'PreferredTime(start: $start, end: $end)';
  }
}

/// @nodoc
abstract mixin class _$PreferredTimeCopyWith<$Res>
    implements $PreferredTimeCopyWith<$Res> {
  factory _$PreferredTimeCopyWith(
          _PreferredTime value, $Res Function(_PreferredTime) _then) =
      __$PreferredTimeCopyWithImpl;
  @override
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class __$PreferredTimeCopyWithImpl<$Res>
    implements _$PreferredTimeCopyWith<$Res> {
  __$PreferredTimeCopyWithImpl(this._self, this._then);

  final _PreferredTime _self;
  final $Res Function(_PreferredTime) _then;

  /// Create a copy of PreferredTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_PreferredTime(
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _self.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Quote {
  @JsonKey(name: '_id')
  String get id;
  CraftsmanSummary get craftsman;
  double get amount;
  String? get estimatedDuration;
  String? get notes;
  DateTime? get validUntil;
  String get status;
  DateTime get submittedAt;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteCopyWith<Quote> get copyWith =>
      _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Quote &&
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

  @override
  String toString() {
    return 'Quote(id: $id, craftsman: $craftsman, amount: $amount, estimatedDuration: $estimatedDuration, notes: $notes, validUntil: $validUntil, status: $status, submittedAt: $submittedAt)';
  }
}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res> {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) =
      _$QuoteCopyWithImpl;
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
class _$QuoteCopyWithImpl<$Res> implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      craftsman: null == craftsman
          ? _self.craftsman
          : craftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: null == submittedAt
          ? _self.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanSummaryCopyWith<$Res> get craftsman {
    return $CraftsmanSummaryCopyWith<$Res>(_self.craftsman, (value) {
      return _then(_self.copyWith(craftsman: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _Quote implements Quote {
  const _Quote(
      {@JsonKey(name: '_id') required this.id,
      required this.craftsman,
      required this.amount,
      this.estimatedDuration,
      this.notes,
      this.validUntil,
      this.status = 'pending',
      required this.submittedAt});
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

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

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteCopyWith<_Quote> get copyWith =>
      __$QuoteCopyWithImpl<_Quote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuoteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Quote &&
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

  @override
  String toString() {
    return 'Quote(id: $id, craftsman: $craftsman, amount: $amount, estimatedDuration: $estimatedDuration, notes: $notes, validUntil: $validUntil, status: $status, submittedAt: $submittedAt)';
  }
}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) =
      __$QuoteCopyWithImpl;
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
class __$QuoteCopyWithImpl<$Res> implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Quote(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      craftsman: null == craftsman
          ? _self.craftsman
          : craftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: null == submittedAt
          ? _self.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanSummaryCopyWith<$Res> get craftsman {
    return $CraftsmanSummaryCopyWith<$Res>(_self.craftsman, (value) {
      return _then(_self.copyWith(craftsman: value));
    });
  }
}

/// @nodoc
mixin _$CraftsmanSummary {
  @JsonKey(name: '_id')
  String get id;
  String get displayName;
  double? get rating;
  String? get profileImage;
  int? get completedJobs;

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CraftsmanSummaryCopyWith<CraftsmanSummary> get copyWith =>
      _$CraftsmanSummaryCopyWithImpl<CraftsmanSummary>(
          this as CraftsmanSummary, _$identity);

  /// Serializes this CraftsmanSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CraftsmanSummary &&
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

  @override
  String toString() {
    return 'CraftsmanSummary(id: $id, displayName: $displayName, rating: $rating, profileImage: $profileImage, completedJobs: $completedJobs)';
  }
}

/// @nodoc
abstract mixin class $CraftsmanSummaryCopyWith<$Res> {
  factory $CraftsmanSummaryCopyWith(
          CraftsmanSummary value, $Res Function(CraftsmanSummary) _then) =
      _$CraftsmanSummaryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String displayName,
      double? rating,
      String? profileImage,
      int? completedJobs});
}

/// @nodoc
class _$CraftsmanSummaryCopyWithImpl<$Res>
    implements $CraftsmanSummaryCopyWith<$Res> {
  _$CraftsmanSummaryCopyWithImpl(this._self, this._then);

  final CraftsmanSummary _self;
  final $Res Function(CraftsmanSummary) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      profileImage: freezed == profileImage
          ? _self.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      completedJobs: freezed == completedJobs
          ? _self.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CraftsmanSummary implements CraftsmanSummary {
  const _CraftsmanSummary(
      {@JsonKey(name: '_id') required this.id,
      required this.displayName,
      this.rating,
      this.profileImage,
      this.completedJobs});
  factory _CraftsmanSummary.fromJson(Map<String, dynamic> json) =>
      _$CraftsmanSummaryFromJson(json);

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

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CraftsmanSummaryCopyWith<_CraftsmanSummary> get copyWith =>
      __$CraftsmanSummaryCopyWithImpl<_CraftsmanSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CraftsmanSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CraftsmanSummary &&
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

  @override
  String toString() {
    return 'CraftsmanSummary(id: $id, displayName: $displayName, rating: $rating, profileImage: $profileImage, completedJobs: $completedJobs)';
  }
}

/// @nodoc
abstract mixin class _$CraftsmanSummaryCopyWith<$Res>
    implements $CraftsmanSummaryCopyWith<$Res> {
  factory _$CraftsmanSummaryCopyWith(
          _CraftsmanSummary value, $Res Function(_CraftsmanSummary) _then) =
      __$CraftsmanSummaryCopyWithImpl;
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
class __$CraftsmanSummaryCopyWithImpl<$Res>
    implements _$CraftsmanSummaryCopyWith<$Res> {
  __$CraftsmanSummaryCopyWithImpl(this._self, this._then);

  final _CraftsmanSummary _self;
  final $Res Function(_CraftsmanSummary) _then;

  /// Create a copy of CraftsmanSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? rating = freezed,
    Object? profileImage = freezed,
    Object? completedJobs = freezed,
  }) {
    return _then(_CraftsmanSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      rating: freezed == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      profileImage: freezed == profileImage
          ? _self.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      completedJobs: freezed == completedJobs
          ? _self.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$CustomerSummary {
  @JsonKey(name: '_id')
  String get id;
  String get name;
  String? get phone;
  String? get avatar;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomerSummaryCopyWith<CustomerSummary> get copyWith =>
      _$CustomerSummaryCopyWithImpl<CustomerSummary>(
          this as CustomerSummary, _$identity);

  /// Serializes this CustomerSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomerSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, avatar);

  @override
  String toString() {
    return 'CustomerSummary(id: $id, name: $name, phone: $phone, avatar: $avatar)';
  }
}

/// @nodoc
abstract mixin class $CustomerSummaryCopyWith<$Res> {
  factory $CustomerSummaryCopyWith(
          CustomerSummary value, $Res Function(CustomerSummary) _then) =
      _$CustomerSummaryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? phone,
      String? avatar});
}

/// @nodoc
class _$CustomerSummaryCopyWithImpl<$Res>
    implements $CustomerSummaryCopyWith<$Res> {
  _$CustomerSummaryCopyWithImpl(this._self, this._then);

  final CustomerSummary _self;
  final $Res Function(CustomerSummary) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CustomerSummary implements CustomerSummary {
  const _CustomerSummary(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      this.phone,
      this.avatar});
  factory _CustomerSummary.fromJson(Map<String, dynamic> json) =>
      _$CustomerSummaryFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? avatar;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomerSummaryCopyWith<_CustomerSummary> get copyWith =>
      __$CustomerSummaryCopyWithImpl<_CustomerSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, avatar);

  @override
  String toString() {
    return 'CustomerSummary(id: $id, name: $name, phone: $phone, avatar: $avatar)';
  }
}

/// @nodoc
abstract mixin class _$CustomerSummaryCopyWith<$Res>
    implements $CustomerSummaryCopyWith<$Res> {
  factory _$CustomerSummaryCopyWith(
          _CustomerSummary value, $Res Function(_CustomerSummary) _then) =
      __$CustomerSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? phone,
      String? avatar});
}

/// @nodoc
class __$CustomerSummaryCopyWithImpl<$Res>
    implements _$CustomerSummaryCopyWith<$Res> {
  __$CustomerSummaryCopyWithImpl(this._self, this._then);

  final _CustomerSummary _self;
  final $Res Function(_CustomerSummary) _then;

  /// Create a copy of CustomerSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_CustomerSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$CategorySummary {
  @JsonKey(name: '_id')
  String get id;
  String get name;
  String get nameAr;
  String? get icon;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategorySummaryCopyWith<CategorySummary> get copyWith =>
      _$CategorySummaryCopyWithImpl<CategorySummary>(
          this as CategorySummary, _$identity);

  /// Serializes this CategorySummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CategorySummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameAr, icon);

  @override
  String toString() {
    return 'CategorySummary(id: $id, name: $name, nameAr: $nameAr, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class $CategorySummaryCopyWith<$Res> {
  factory $CategorySummaryCopyWith(
          CategorySummary value, $Res Function(CategorySummary) _then) =
      _$CategorySummaryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      String? icon});
}

/// @nodoc
class _$CategorySummaryCopyWithImpl<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  _$CategorySummaryCopyWithImpl(this._self, this._then);

  final CategorySummary _self;
  final $Res Function(CategorySummary) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _self.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CategorySummary implements CategorySummary {
  const _CategorySummary(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      required this.nameAr,
      this.icon});
  factory _CategorySummary.fromJson(Map<String, dynamic> json) =>
      _$CategorySummaryFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String nameAr;
  @override
  final String? icon;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategorySummaryCopyWith<_CategorySummary> get copyWith =>
      __$CategorySummaryCopyWithImpl<_CategorySummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CategorySummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategorySummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameAr, icon);

  @override
  String toString() {
    return 'CategorySummary(id: $id, name: $name, nameAr: $nameAr, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class _$CategorySummaryCopyWith<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  factory _$CategorySummaryCopyWith(
          _CategorySummary value, $Res Function(_CategorySummary) _then) =
      __$CategorySummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String nameAr,
      String? icon});
}

/// @nodoc
class __$CategorySummaryCopyWithImpl<$Res>
    implements _$CategorySummaryCopyWith<$Res> {
  __$CategorySummaryCopyWithImpl(this._self, this._then);

  final _CategorySummary _self;
  final $Res Function(_CategorySummary) _then;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? icon = freezed,
  }) {
    return _then(_CategorySummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameAr: null == nameAr
          ? _self.nameAr
          : nameAr // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$AcceptedQuote {
  double get amount;
  String? get estimatedDuration;

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AcceptedQuoteCopyWith<AcceptedQuote> get copyWith =>
      _$AcceptedQuoteCopyWithImpl<AcceptedQuote>(
          this as AcceptedQuote, _$identity);

  /// Serializes this AcceptedQuote to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AcceptedQuote &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, estimatedDuration);

  @override
  String toString() {
    return 'AcceptedQuote(amount: $amount, estimatedDuration: $estimatedDuration)';
  }
}

/// @nodoc
abstract mixin class $AcceptedQuoteCopyWith<$Res> {
  factory $AcceptedQuoteCopyWith(
          AcceptedQuote value, $Res Function(AcceptedQuote) _then) =
      _$AcceptedQuoteCopyWithImpl;
  @useResult
  $Res call({double amount, String? estimatedDuration});
}

/// @nodoc
class _$AcceptedQuoteCopyWithImpl<$Res>
    implements $AcceptedQuoteCopyWith<$Res> {
  _$AcceptedQuoteCopyWithImpl(this._self, this._then);

  final AcceptedQuote _self;
  final $Res Function(AcceptedQuote) _then;

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? estimatedDuration = freezed,
  }) {
    return _then(_self.copyWith(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AcceptedQuote implements AcceptedQuote {
  const _AcceptedQuote({required this.amount, this.estimatedDuration});
  factory _AcceptedQuote.fromJson(Map<String, dynamic> json) =>
      _$AcceptedQuoteFromJson(json);

  @override
  final double amount;
  @override
  final String? estimatedDuration;

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AcceptedQuoteCopyWith<_AcceptedQuote> get copyWith =>
      __$AcceptedQuoteCopyWithImpl<_AcceptedQuote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AcceptedQuoteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AcceptedQuote &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, estimatedDuration);

  @override
  String toString() {
    return 'AcceptedQuote(amount: $amount, estimatedDuration: $estimatedDuration)';
  }
}

/// @nodoc
abstract mixin class _$AcceptedQuoteCopyWith<$Res>
    implements $AcceptedQuoteCopyWith<$Res> {
  factory _$AcceptedQuoteCopyWith(
          _AcceptedQuote value, $Res Function(_AcceptedQuote) _then) =
      __$AcceptedQuoteCopyWithImpl;
  @override
  @useResult
  $Res call({double amount, String? estimatedDuration});
}

/// @nodoc
class __$AcceptedQuoteCopyWithImpl<$Res>
    implements _$AcceptedQuoteCopyWith<$Res> {
  __$AcceptedQuoteCopyWithImpl(this._self, this._then);

  final _AcceptedQuote _self;
  final $Res Function(_AcceptedQuote) _then;

  /// Create a copy of AcceptedQuote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? estimatedDuration = freezed,
  }) {
    return _then(_AcceptedQuote(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$StatusHistoryEntry {
  String get status;
  DateTime get changedAt;
  String? get notes;

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StatusHistoryEntryCopyWith<StatusHistoryEntry> get copyWith =>
      _$StatusHistoryEntryCopyWithImpl<StatusHistoryEntry>(
          this as StatusHistoryEntry, _$identity);

  /// Serializes this StatusHistoryEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StatusHistoryEntry &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, changedAt, notes);

  @override
  String toString() {
    return 'StatusHistoryEntry(status: $status, changedAt: $changedAt, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $StatusHistoryEntryCopyWith<$Res> {
  factory $StatusHistoryEntryCopyWith(
          StatusHistoryEntry value, $Res Function(StatusHistoryEntry) _then) =
      _$StatusHistoryEntryCopyWithImpl;
  @useResult
  $Res call({String status, DateTime changedAt, String? notes});
}

/// @nodoc
class _$StatusHistoryEntryCopyWithImpl<$Res>
    implements $StatusHistoryEntryCopyWith<$Res> {
  _$StatusHistoryEntryCopyWithImpl(this._self, this._then);

  final StatusHistoryEntry _self;
  final $Res Function(StatusHistoryEntry) _then;

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? changedAt = null,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: null == changedAt
          ? _self.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _StatusHistoryEntry implements StatusHistoryEntry {
  const _StatusHistoryEntry(
      {required this.status, required this.changedAt, this.notes});
  factory _StatusHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$StatusHistoryEntryFromJson(json);

  @override
  final String status;
  @override
  final DateTime changedAt;
  @override
  final String? notes;

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StatusHistoryEntryCopyWith<_StatusHistoryEntry> get copyWith =>
      __$StatusHistoryEntryCopyWithImpl<_StatusHistoryEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StatusHistoryEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StatusHistoryEntry &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, changedAt, notes);

  @override
  String toString() {
    return 'StatusHistoryEntry(status: $status, changedAt: $changedAt, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$StatusHistoryEntryCopyWith<$Res>
    implements $StatusHistoryEntryCopyWith<$Res> {
  factory _$StatusHistoryEntryCopyWith(
          _StatusHistoryEntry value, $Res Function(_StatusHistoryEntry) _then) =
      __$StatusHistoryEntryCopyWithImpl;
  @override
  @useResult
  $Res call({String status, DateTime changedAt, String? notes});
}

/// @nodoc
class __$StatusHistoryEntryCopyWithImpl<$Res>
    implements _$StatusHistoryEntryCopyWith<$Res> {
  __$StatusHistoryEntryCopyWithImpl(this._self, this._then);

  final _StatusHistoryEntry _self;
  final $Res Function(_StatusHistoryEntry) _then;

  /// Create a copy of StatusHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? changedAt = null,
    Object? notes = freezed,
  }) {
    return _then(_StatusHistoryEntry(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      changedAt: null == changedAt
          ? _self.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ServiceRequest {
  @JsonKey(name: '_id')
  String get id;
  String get requestNumber;
  CustomerSummary get customer;
  CategorySummary get category;
  String? get subcategory;
  String get title;
  String get description;
  RequestLocation get location;
  DateTime? get preferredDate;
  PreferredTime? get preferredTime;
  List<String> get images;
  RequestBudget? get budget;
  RequestUrgency get urgency;
  RequestStatus get status;
  List<Quote> get quotes;
  CraftsmanSummary? get assignedCraftsman;
  AcceptedQuote? get acceptedQuote;
  List<StatusHistoryEntry> get statusHistory;
  DateTime? get startedAt;
  DateTime? get arrivedAt;
  DateTime? get completedAt;
  DateTime? get cancelledAt;
  String? get cancelledBy;
  String? get cancellationReason;
  double? get actualAmount;
  String? get completionNotes;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ServiceRequestCopyWith<ServiceRequest> get copyWith =>
      _$ServiceRequestCopyWithImpl<ServiceRequest>(
          this as ServiceRequest, _$identity);

  /// Serializes this ServiceRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServiceRequest &&
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
            const DeepCollectionEquality().equals(other.images, images) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.quotes, quotes) &&
            (identical(other.assignedCraftsman, assignedCraftsman) ||
                other.assignedCraftsman == assignedCraftsman) &&
            (identical(other.acceptedQuote, acceptedQuote) ||
                other.acceptedQuote == acceptedQuote) &&
            const DeepCollectionEquality()
                .equals(other.statusHistory, statusHistory) &&
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
        const DeepCollectionEquality().hash(images),
        budget,
        urgency,
        status,
        const DeepCollectionEquality().hash(quotes),
        assignedCraftsman,
        acceptedQuote,
        const DeepCollectionEquality().hash(statusHistory),
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

  @override
  String toString() {
    return 'ServiceRequest(id: $id, requestNumber: $requestNumber, customer: $customer, category: $category, subcategory: $subcategory, title: $title, description: $description, location: $location, preferredDate: $preferredDate, preferredTime: $preferredTime, images: $images, budget: $budget, urgency: $urgency, status: $status, quotes: $quotes, assignedCraftsman: $assignedCraftsman, acceptedQuote: $acceptedQuote, statusHistory: $statusHistory, startedAt: $startedAt, arrivedAt: $arrivedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, cancelledBy: $cancelledBy, cancellationReason: $cancellationReason, actualAmount: $actualAmount, completionNotes: $completionNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ServiceRequestCopyWith<$Res> {
  factory $ServiceRequestCopyWith(
          ServiceRequest value, $Res Function(ServiceRequest) _then) =
      _$ServiceRequestCopyWithImpl;
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
class _$ServiceRequestCopyWithImpl<$Res>
    implements $ServiceRequestCopyWith<$Res> {
  _$ServiceRequestCopyWithImpl(this._self, this._then);

  final ServiceRequest _self;
  final $Res Function(ServiceRequest) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestNumber: null == requestNumber
          ? _self.requestNumber
          : requestNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _self.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerSummary,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategorySummary,
      subcategory: freezed == subcategory
          ? _self.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _self.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _self.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _self.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _self.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      quotes: null == quotes
          ? _self.quotes
          : quotes // ignore: cast_nullable_to_non_nullable
              as List<Quote>,
      assignedCraftsman: freezed == assignedCraftsman
          ? _self.assignedCraftsman
          : assignedCraftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary?,
      acceptedQuote: freezed == acceptedQuote
          ? _self.acceptedQuote
          : acceptedQuote // ignore: cast_nullable_to_non_nullable
              as AcceptedQuote?,
      statusHistory: null == statusHistory
          ? _self.statusHistory
          : statusHistory // ignore: cast_nullable_to_non_nullable
              as List<StatusHistoryEntry>,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivedAt: freezed == arrivedAt
          ? _self.arrivedAt
          : arrivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _self.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledBy: freezed == cancelledBy
          ? _self.cancelledBy
          : cancelledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      cancellationReason: freezed == cancellationReason
          ? _self.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      actualAmount: freezed == actualAmount
          ? _self.actualAmount
          : actualAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      completionNotes: freezed == completionNotes
          ? _self.completionNotes
          : completionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerSummaryCopyWith<$Res> get customer {
    return $CustomerSummaryCopyWith<$Res>(_self.customer, (value) {
      return _then(_self.copyWith(customer: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategorySummaryCopyWith<$Res> get category {
    return $CategorySummaryCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestLocationCopyWith<$Res> get location {
    return $RequestLocationCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PreferredTimeCopyWith<$Res>? get preferredTime {
    if (_self.preferredTime == null) {
      return null;
    }

    return $PreferredTimeCopyWith<$Res>(_self.preferredTime!, (value) {
      return _then(_self.copyWith(preferredTime: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBudgetCopyWith<$Res>? get budget {
    if (_self.budget == null) {
      return null;
    }

    return $RequestBudgetCopyWith<$Res>(_self.budget!, (value) {
      return _then(_self.copyWith(budget: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanSummaryCopyWith<$Res>? get assignedCraftsman {
    if (_self.assignedCraftsman == null) {
      return null;
    }

    return $CraftsmanSummaryCopyWith<$Res>(_self.assignedCraftsman!, (value) {
      return _then(_self.copyWith(assignedCraftsman: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcceptedQuoteCopyWith<$Res>? get acceptedQuote {
    if (_self.acceptedQuote == null) {
      return null;
    }

    return $AcceptedQuoteCopyWith<$Res>(_self.acceptedQuote!, (value) {
      return _then(_self.copyWith(acceptedQuote: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ServiceRequest extends ServiceRequest {
  const _ServiceRequest(
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
  factory _ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);

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

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServiceRequestCopyWith<_ServiceRequest> get copyWith =>
      __$ServiceRequestCopyWithImpl<_ServiceRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ServiceRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServiceRequest &&
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

  @override
  String toString() {
    return 'ServiceRequest(id: $id, requestNumber: $requestNumber, customer: $customer, category: $category, subcategory: $subcategory, title: $title, description: $description, location: $location, preferredDate: $preferredDate, preferredTime: $preferredTime, images: $images, budget: $budget, urgency: $urgency, status: $status, quotes: $quotes, assignedCraftsman: $assignedCraftsman, acceptedQuote: $acceptedQuote, statusHistory: $statusHistory, startedAt: $startedAt, arrivedAt: $arrivedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, cancelledBy: $cancelledBy, cancellationReason: $cancellationReason, actualAmount: $actualAmount, completionNotes: $completionNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ServiceRequestCopyWith<$Res>
    implements $ServiceRequestCopyWith<$Res> {
  factory _$ServiceRequestCopyWith(
          _ServiceRequest value, $Res Function(_ServiceRequest) _then) =
      __$ServiceRequestCopyWithImpl;
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
class __$ServiceRequestCopyWithImpl<$Res>
    implements _$ServiceRequestCopyWith<$Res> {
  __$ServiceRequestCopyWithImpl(this._self, this._then);

  final _ServiceRequest _self;
  final $Res Function(_ServiceRequest) _then;

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ServiceRequest(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestNumber: null == requestNumber
          ? _self.requestNumber
          : requestNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _self.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerSummary,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategorySummary,
      subcategory: freezed == subcategory
          ? _self.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _self.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _self.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _self.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _self.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      quotes: null == quotes
          ? _self._quotes
          : quotes // ignore: cast_nullable_to_non_nullable
              as List<Quote>,
      assignedCraftsman: freezed == assignedCraftsman
          ? _self.assignedCraftsman
          : assignedCraftsman // ignore: cast_nullable_to_non_nullable
              as CraftsmanSummary?,
      acceptedQuote: freezed == acceptedQuote
          ? _self.acceptedQuote
          : acceptedQuote // ignore: cast_nullable_to_non_nullable
              as AcceptedQuote?,
      statusHistory: null == statusHistory
          ? _self._statusHistory
          : statusHistory // ignore: cast_nullable_to_non_nullable
              as List<StatusHistoryEntry>,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivedAt: freezed == arrivedAt
          ? _self.arrivedAt
          : arrivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _self.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledBy: freezed == cancelledBy
          ? _self.cancelledBy
          : cancelledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      cancellationReason: freezed == cancellationReason
          ? _self.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      actualAmount: freezed == actualAmount
          ? _self.actualAmount
          : actualAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      completionNotes: freezed == completionNotes
          ? _self.completionNotes
          : completionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerSummaryCopyWith<$Res> get customer {
    return $CustomerSummaryCopyWith<$Res>(_self.customer, (value) {
      return _then(_self.copyWith(customer: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategorySummaryCopyWith<$Res> get category {
    return $CategorySummaryCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestLocationCopyWith<$Res> get location {
    return $RequestLocationCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PreferredTimeCopyWith<$Res>? get preferredTime {
    if (_self.preferredTime == null) {
      return null;
    }

    return $PreferredTimeCopyWith<$Res>(_self.preferredTime!, (value) {
      return _then(_self.copyWith(preferredTime: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBudgetCopyWith<$Res>? get budget {
    if (_self.budget == null) {
      return null;
    }

    return $RequestBudgetCopyWith<$Res>(_self.budget!, (value) {
      return _then(_self.copyWith(budget: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CraftsmanSummaryCopyWith<$Res>? get assignedCraftsman {
    if (_self.assignedCraftsman == null) {
      return null;
    }

    return $CraftsmanSummaryCopyWith<$Res>(_self.assignedCraftsman!, (value) {
      return _then(_self.copyWith(assignedCraftsman: value));
    });
  }

  /// Create a copy of ServiceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AcceptedQuoteCopyWith<$Res>? get acceptedQuote {
    if (_self.acceptedQuote == null) {
      return null;
    }

    return $AcceptedQuoteCopyWith<$Res>(_self.acceptedQuote!, (value) {
      return _then(_self.copyWith(acceptedQuote: value));
    });
  }
}

/// @nodoc
mixin _$CreateRequestData {
  String get title;
  String get description;
  String get category;
  String? get subcategory;
  RequestLocation get location;
  DateTime? get preferredDate;
  PreferredTime? get preferredTime;
  List<String> get images;
  RequestBudget? get budget;
  RequestUrgency get urgency;

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateRequestDataCopyWith<CreateRequestData> get copyWith =>
      _$CreateRequestDataCopyWithImpl<CreateRequestData>(
          this as CreateRequestData, _$identity);

  /// Serializes this CreateRequestData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateRequestData &&
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
            const DeepCollectionEquality().equals(other.images, images) &&
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
      const DeepCollectionEquality().hash(images),
      budget,
      urgency);

  @override
  String toString() {
    return 'CreateRequestData(title: $title, description: $description, category: $category, subcategory: $subcategory, location: $location, preferredDate: $preferredDate, preferredTime: $preferredTime, images: $images, budget: $budget, urgency: $urgency)';
  }
}

/// @nodoc
abstract mixin class $CreateRequestDataCopyWith<$Res> {
  factory $CreateRequestDataCopyWith(
          CreateRequestData value, $Res Function(CreateRequestData) _then) =
      _$CreateRequestDataCopyWithImpl;
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
class _$CreateRequestDataCopyWithImpl<$Res>
    implements $CreateRequestDataCopyWith<$Res> {
  _$CreateRequestDataCopyWithImpl(this._self, this._then);

  final CreateRequestData _self;
  final $Res Function(CreateRequestData) _then;

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
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _self.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _self.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _self.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _self.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _self.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
    ));
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestLocationCopyWith<$Res> get location {
    return $RequestLocationCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PreferredTimeCopyWith<$Res>? get preferredTime {
    if (_self.preferredTime == null) {
      return null;
    }

    return $PreferredTimeCopyWith<$Res>(_self.preferredTime!, (value) {
      return _then(_self.copyWith(preferredTime: value));
    });
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBudgetCopyWith<$Res>? get budget {
    if (_self.budget == null) {
      return null;
    }

    return $RequestBudgetCopyWith<$Res>(_self.budget!, (value) {
      return _then(_self.copyWith(budget: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _CreateRequestData implements CreateRequestData {
  const _CreateRequestData(
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
  factory _CreateRequestData.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestDataFromJson(json);

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

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateRequestDataCopyWith<_CreateRequestData> get copyWith =>
      __$CreateRequestDataCopyWithImpl<_CreateRequestData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateRequestDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateRequestData &&
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

  @override
  String toString() {
    return 'CreateRequestData(title: $title, description: $description, category: $category, subcategory: $subcategory, location: $location, preferredDate: $preferredDate, preferredTime: $preferredTime, images: $images, budget: $budget, urgency: $urgency)';
  }
}

/// @nodoc
abstract mixin class _$CreateRequestDataCopyWith<$Res>
    implements $CreateRequestDataCopyWith<$Res> {
  factory _$CreateRequestDataCopyWith(
          _CreateRequestData value, $Res Function(_CreateRequestData) _then) =
      __$CreateRequestDataCopyWithImpl;
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
class __$CreateRequestDataCopyWithImpl<$Res>
    implements _$CreateRequestDataCopyWith<$Res> {
  __$CreateRequestDataCopyWithImpl(this._self, this._then);

  final _CreateRequestData _self;
  final $Res Function(_CreateRequestData) _then;

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_CreateRequestData(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _self.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as RequestLocation,
      preferredDate: freezed == preferredDate
          ? _self.preferredDate
          : preferredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preferredTime: freezed == preferredTime
          ? _self.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as PreferredTime?,
      images: null == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      budget: freezed == budget
          ? _self.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as RequestBudget?,
      urgency: null == urgency
          ? _self.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RequestUrgency,
    ));
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestLocationCopyWith<$Res> get location {
    return $RequestLocationCopyWith<$Res>(_self.location, (value) {
      return _then(_self.copyWith(location: value));
    });
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PreferredTimeCopyWith<$Res>? get preferredTime {
    if (_self.preferredTime == null) {
      return null;
    }

    return $PreferredTimeCopyWith<$Res>(_self.preferredTime!, (value) {
      return _then(_self.copyWith(preferredTime: value));
    });
  }

  /// Create a copy of CreateRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestBudgetCopyWith<$Res>? get budget {
    if (_self.budget == null) {
      return null;
    }

    return $RequestBudgetCopyWith<$Res>(_self.budget!, (value) {
      return _then(_self.copyWith(budget: value));
    });
  }
}

/// @nodoc
mixin _$SubmitQuoteData {
  double get amount;
  String? get estimatedDuration;
  String? get notes;
  DateTime? get validUntil;

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubmitQuoteDataCopyWith<SubmitQuoteData> get copyWith =>
      _$SubmitQuoteDataCopyWithImpl<SubmitQuoteData>(
          this as SubmitQuoteData, _$identity);

  /// Serializes this SubmitQuoteData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubmitQuoteData &&
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

  @override
  String toString() {
    return 'SubmitQuoteData(amount: $amount, estimatedDuration: $estimatedDuration, notes: $notes, validUntil: $validUntil)';
  }
}

/// @nodoc
abstract mixin class $SubmitQuoteDataCopyWith<$Res> {
  factory $SubmitQuoteDataCopyWith(
          SubmitQuoteData value, $Res Function(SubmitQuoteData) _then) =
      _$SubmitQuoteDataCopyWithImpl;
  @useResult
  $Res call(
      {double amount,
      String? estimatedDuration,
      String? notes,
      DateTime? validUntil});
}

/// @nodoc
class _$SubmitQuoteDataCopyWithImpl<$Res>
    implements $SubmitQuoteDataCopyWith<$Res> {
  _$SubmitQuoteDataCopyWithImpl(this._self, this._then);

  final SubmitQuoteData _self;
  final $Res Function(SubmitQuoteData) _then;

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
    return _then(_self.copyWith(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SubmitQuoteData implements SubmitQuoteData {
  const _SubmitQuoteData(
      {required this.amount,
      this.estimatedDuration,
      this.notes,
      this.validUntil});
  factory _SubmitQuoteData.fromJson(Map<String, dynamic> json) =>
      _$SubmitQuoteDataFromJson(json);

  @override
  final double amount;
  @override
  final String? estimatedDuration;
  @override
  final String? notes;
  @override
  final DateTime? validUntil;

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubmitQuoteDataCopyWith<_SubmitQuoteData> get copyWith =>
      __$SubmitQuoteDataCopyWithImpl<_SubmitQuoteData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubmitQuoteDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubmitQuoteData &&
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

  @override
  String toString() {
    return 'SubmitQuoteData(amount: $amount, estimatedDuration: $estimatedDuration, notes: $notes, validUntil: $validUntil)';
  }
}

/// @nodoc
abstract mixin class _$SubmitQuoteDataCopyWith<$Res>
    implements $SubmitQuoteDataCopyWith<$Res> {
  factory _$SubmitQuoteDataCopyWith(
          _SubmitQuoteData value, $Res Function(_SubmitQuoteData) _then) =
      __$SubmitQuoteDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double amount,
      String? estimatedDuration,
      String? notes,
      DateTime? validUntil});
}

/// @nodoc
class __$SubmitQuoteDataCopyWithImpl<$Res>
    implements _$SubmitQuoteDataCopyWith<$Res> {
  __$SubmitQuoteDataCopyWithImpl(this._self, this._then);

  final _SubmitQuoteData _self;
  final $Res Function(_SubmitQuoteData) _then;

  /// Create a copy of SubmitQuoteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? estimatedDuration = freezed,
    Object? notes = freezed,
    Object? validUntil = freezed,
  }) {
    return _then(_SubmitQuoteData(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: freezed == estimatedDuration
          ? _self.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      validUntil: freezed == validUntil
          ? _self.validUntil
          : validUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$RequestListResponse {
  List<ServiceRequest> get data;
  int get page;
  int get totalPages;
  int get total;
  int get limit;

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestListResponseCopyWith<RequestListResponse> get copyWith =>
      _$RequestListResponseCopyWithImpl<RequestListResponse>(
          this as RequestListResponse, _$identity);

  /// Serializes this RequestListResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestListResponse &&
            const DeepCollectionEquality().equals(other.data, data) &&
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
      const DeepCollectionEquality().hash(data),
      page,
      totalPages,
      total,
      limit);

  @override
  String toString() {
    return 'RequestListResponse(data: $data, page: $page, totalPages: $totalPages, total: $total, limit: $limit)';
  }
}

/// @nodoc
abstract mixin class $RequestListResponseCopyWith<$Res> {
  factory $RequestListResponseCopyWith(
          RequestListResponse value, $Res Function(RequestListResponse) _then) =
      _$RequestListResponseCopyWithImpl;
  @useResult
  $Res call(
      {List<ServiceRequest> data,
      int page,
      int totalPages,
      int total,
      int limit});
}

/// @nodoc
class _$RequestListResponseCopyWithImpl<$Res>
    implements $RequestListResponseCopyWith<$Res> {
  _$RequestListResponseCopyWithImpl(this._self, this._then);

  final RequestListResponse _self;
  final $Res Function(RequestListResponse) _then;

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
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ServiceRequest>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RequestListResponse implements RequestListResponse {
  const _RequestListResponse(
      {required final List<ServiceRequest> data,
      required this.page,
      required this.totalPages,
      required this.total,
      required this.limit})
      : _data = data;
  factory _RequestListResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestListResponseFromJson(json);

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

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestListResponseCopyWith<_RequestListResponse> get copyWith =>
      __$RequestListResponseCopyWithImpl<_RequestListResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestListResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RequestListResponse &&
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

  @override
  String toString() {
    return 'RequestListResponse(data: $data, page: $page, totalPages: $totalPages, total: $total, limit: $limit)';
  }
}

/// @nodoc
abstract mixin class _$RequestListResponseCopyWith<$Res>
    implements $RequestListResponseCopyWith<$Res> {
  factory _$RequestListResponseCopyWith(_RequestListResponse value,
          $Res Function(_RequestListResponse) _then) =
      __$RequestListResponseCopyWithImpl;
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
class __$RequestListResponseCopyWithImpl<$Res>
    implements _$RequestListResponseCopyWith<$Res> {
  __$RequestListResponseCopyWithImpl(this._self, this._then);

  final _RequestListResponse _self;
  final $Res Function(_RequestListResponse) _then;

  /// Create a copy of RequestListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? page = null,
    Object? totalPages = null,
    Object? total = null,
    Object? limit = null,
  }) {
    return _then(_RequestListResponse(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ServiceRequest>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _self.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
