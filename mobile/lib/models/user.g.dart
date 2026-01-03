// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      id: json['_id'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      '_id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'role': _$UserRoleEnumMap[instance.role]!,
      'email': instance.email,
      'avatar': instance.avatar,
      'isPhoneVerified': instance.isPhoneVerified,
      'isEmailVerified': instance.isEmailVerified,
      'isActive': instance.isActive,
      'fcmTokens': instance.fcmTokens,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.craftsman: 'craftsman',
  UserRole.admin: 'admin',
};

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
      id: json['id'] as String?,
      label: json['label'] as String,
      address: json['address'] as String,
      area: json['area'] as String?,
      landmark: json['landmark'] as String?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'address': instance.address,
      'area': instance.area,
      'landmark': instance.landmark,
      'lat': instance.lat,
      'lng': instance.lng,
      'isDefault': instance.isDefault,
    };

_Customer _$CustomerFromJson(Map<String, dynamic> json) => _Customer(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      favoritesCraftsmen: (json['favoritesCraftsmen'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CustomerToJson(_Customer instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'addresses': instance.addresses,
      'favoritesCraftsmen': instance.favoritesCraftsmen,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
