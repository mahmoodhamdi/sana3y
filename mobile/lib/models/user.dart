import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole {
  @JsonValue('customer')
  customer,
  @JsonValue('craftsman')
  craftsman,
  @JsonValue('admin')
  admin,
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: '_id') required String id,
    required String phone,
    required String name,
    required UserRole role,
    String? email,
    String? avatar,
    @Default(false) bool isPhoneVerified,
    @Default(false) bool isEmailVerified,
    @Default(true) bool isActive,
    @Default([]) List<String> fcmTokens,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    String? id,
    required String label,
    required String address,
    String? area,
    String? landmark,
    required double lat,
    required double lng,
    @Default(false) bool isDefault,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
class Customer with _$Customer {
  const factory Customer({
    @JsonKey(name: '_id') required String id,
    required String userId,
    @Default([]) List<Address> addresses,
    @Default([]) List<String> favoritesCraftsmen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
}
