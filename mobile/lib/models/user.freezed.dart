// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {
  @JsonKey(name: '_id')
  String get id;
  String get phone;
  String get name;
  UserRole get role;
  String? get email;
  String? get avatar;
  bool get isPhoneVerified;
  bool get isEmailVerified;
  bool get isActive;
  List<String> get fcmTokens;
  DateTime? get lastLoginAt;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserCopyWith<User> get copyWith =>
      _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other.fcmTokens, fcmTokens) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      phone,
      name,
      role,
      email,
      avatar,
      isPhoneVerified,
      isEmailVerified,
      isActive,
      const DeepCollectionEquality().hash(fcmTokens),
      lastLoginAt,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, name: $name, role: $role, email: $email, avatar: $avatar, isPhoneVerified: $isPhoneVerified, isEmailVerified: $isEmailVerified, isActive: $isActive, fcmTokens: $fcmTokens, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) _then) =
      _$UserCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String phone,
      String name,
      UserRole role,
      String? email,
      String? avatar,
      bool isPhoneVerified,
      bool isEmailVerified,
      bool isActive,
      List<String> fcmTokens,
      DateTime? lastLoginAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? avatar = freezed,
    Object? isPhoneVerified = null,
    Object? isEmailVerified = null,
    Object? isActive = null,
    Object? fcmTokens = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      isPhoneVerified: null == isPhoneVerified
          ? _self.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _self.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmTokens: null == fcmTokens
          ? _self.fcmTokens
          : fcmTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastLoginAt: freezed == lastLoginAt
          ? _self.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _User implements User {
  const _User(
      {@JsonKey(name: '_id') required this.id,
      required this.phone,
      required this.name,
      required this.role,
      this.email,
      this.avatar,
      this.isPhoneVerified = false,
      this.isEmailVerified = false,
      this.isActive = true,
      final List<String> fcmTokens = const [],
      this.lastLoginAt,
      this.createdAt,
      this.updatedAt})
      : _fcmTokens = fcmTokens;
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String phone;
  @override
  final String name;
  @override
  final UserRole role;
  @override
  final String? email;
  @override
  final String? avatar;
  @override
  @JsonKey()
  final bool isPhoneVerified;
  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final bool isActive;
  final List<String> _fcmTokens;
  @override
  @JsonKey()
  List<String> get fcmTokens {
    if (_fcmTokens is EqualUnmodifiableListView) return _fcmTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fcmTokens);
  }

  @override
  final DateTime? lastLoginAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality()
                .equals(other._fcmTokens, _fcmTokens) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      phone,
      name,
      role,
      email,
      avatar,
      isPhoneVerified,
      isEmailVerified,
      isActive,
      const DeepCollectionEquality().hash(_fcmTokens),
      lastLoginAt,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, name: $name, role: $role, email: $email, avatar: $avatar, isPhoneVerified: $isPhoneVerified, isEmailVerified: $isEmailVerified, isActive: $isActive, fcmTokens: $fcmTokens, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) =
      __$UserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String phone,
      String name,
      UserRole role,
      String? email,
      String? avatar,
      bool isPhoneVerified,
      bool isEmailVerified,
      bool isActive,
      List<String> fcmTokens,
      DateTime? lastLoginAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? name = null,
    Object? role = null,
    Object? email = freezed,
    Object? avatar = freezed,
    Object? isPhoneVerified = null,
    Object? isEmailVerified = null,
    Object? isActive = null,
    Object? fcmTokens = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_User(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      isPhoneVerified: null == isPhoneVerified
          ? _self.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmailVerified: null == isEmailVerified
          ? _self.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmTokens: null == fcmTokens
          ? _self._fcmTokens
          : fcmTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastLoginAt: freezed == lastLoginAt
          ? _self.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$Address {
  String? get id;
  String get label;
  String get address;
  String? get area;
  String? get landmark;
  double get lat;
  double get lng;
  bool get isDefault;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressCopyWith<Address> get copyWith =>
      _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Address &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, label, address, area, landmark, lat, lng, isDefault);

  @override
  String toString() {
    return 'Address(id: $id, label: $label, address: $address, area: $area, landmark: $landmark, lat: $lat, lng: $lng, isDefault: $isDefault)';
  }
}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) =
      _$AddressCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String label,
      String address,
      String? area,
      String? landmark,
      double lat,
      double lng,
      bool isDefault});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? address = null,
    Object? area = freezed,
    Object? landmark = freezed,
    Object? lat = null,
    Object? lng = null,
    Object? isDefault = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      landmark: freezed == landmark
          ? _self.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      isDefault: null == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Address implements Address {
  const _Address(
      {this.id,
      required this.label,
      required this.address,
      this.area,
      this.landmark,
      required this.lat,
      required this.lng,
      this.isDefault = false});
  factory _Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @override
  final String? id;
  @override
  final String label;
  @override
  final String address;
  @override
  final String? area;
  @override
  final String? landmark;
  @override
  final double lat;
  @override
  final double lng;
  @override
  @JsonKey()
  final bool isDefault;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AddressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Address &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, label, address, area, landmark, lat, lng, isDefault);

  @override
  String toString() {
    return 'Address(id: $id, label: $label, address: $address, area: $area, landmark: $landmark, lat: $lat, lng: $lng, isDefault: $isDefault)';
  }
}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) =
      __$AddressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String label,
      String address,
      String? area,
      String? landmark,
      double lat,
      double lng,
      bool isDefault});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? label = null,
    Object? address = null,
    Object? area = freezed,
    Object? landmark = freezed,
    Object? lat = null,
    Object? lng = null,
    Object? isDefault = null,
  }) {
    return _then(_Address(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      area: freezed == area
          ? _self.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      landmark: freezed == landmark
          ? _self.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: null == lat
          ? _self.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _self.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      isDefault: null == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$Customer {
  @JsonKey(name: '_id')
  String get id;
  String get userId;
  List<Address> get addresses;
  List<String> get favoritesCraftsmen;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<Customer> get copyWith =>
      _$CustomerCopyWithImpl<Customer>(this as Customer, _$identity);

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Customer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other.addresses, addresses) &&
            const DeepCollectionEquality()
                .equals(other.favoritesCraftsmen, favoritesCraftsmen) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      const DeepCollectionEquality().hash(addresses),
      const DeepCollectionEquality().hash(favoritesCraftsmen),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Customer(id: $id, userId: $userId, addresses: $addresses, favoritesCraftsmen: $favoritesCraftsmen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) _then) =
      _$CustomerCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String userId,
      List<Address> addresses,
      List<String> favoritesCraftsmen,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res> implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._self, this._then);

  final Customer _self;
  final $Res Function(Customer) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? addresses = null,
    Object? favoritesCraftsmen = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      addresses: null == addresses
          ? _self.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      favoritesCraftsmen: null == favoritesCraftsmen
          ? _self.favoritesCraftsmen
          : favoritesCraftsmen // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Customer implements Customer {
  const _Customer(
      {@JsonKey(name: '_id') required this.id,
      required this.userId,
      final List<Address> addresses = const [],
      final List<String> favoritesCraftsmen = const [],
      this.createdAt,
      this.updatedAt})
      : _addresses = addresses,
        _favoritesCraftsmen = favoritesCraftsmen;
  factory _Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String userId;
  final List<Address> _addresses;
  @override
  @JsonKey()
  List<Address> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  final List<String> _favoritesCraftsmen;
  @override
  @JsonKey()
  List<String> get favoritesCraftsmen {
    if (_favoritesCraftsmen is EqualUnmodifiableListView)
      return _favoritesCraftsmen;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoritesCraftsmen);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomerCopyWith<_Customer> get copyWith =>
      __$CustomerCopyWithImpl<_Customer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Customer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses) &&
            const DeepCollectionEquality()
                .equals(other._favoritesCraftsmen, _favoritesCraftsmen) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      const DeepCollectionEquality().hash(_addresses),
      const DeepCollectionEquality().hash(_favoritesCraftsmen),
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Customer(id: $id, userId: $userId, addresses: $addresses, favoritesCraftsmen: $favoritesCraftsmen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$CustomerCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$CustomerCopyWith(_Customer value, $Res Function(_Customer) _then) =
      __$CustomerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String userId,
      List<Address> addresses,
      List<String> favoritesCraftsmen,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$CustomerCopyWithImpl<$Res> implements _$CustomerCopyWith<$Res> {
  __$CustomerCopyWithImpl(this._self, this._then);

  final _Customer _self;
  final $Res Function(_Customer) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? addresses = null,
    Object? favoritesCraftsmen = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Customer(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      addresses: null == addresses
          ? _self._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      favoritesCraftsmen: null == favoritesCraftsmen
          ? _self._favoritesCraftsmen
          : favoritesCraftsmen // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
