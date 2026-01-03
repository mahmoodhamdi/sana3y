// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  MessageSender get senderId => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String conversationId,
      MessageSender senderId,
      MessageType type,
      String content,
      Map<String, dynamic>? metadata,
      bool isRead,
      DateTime? readAt,
      DateTime createdAt});

  $MessageSenderCopyWith<$Res> get senderId;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? type = null,
    Object? content = null,
    Object? metadata = freezed,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as MessageSender,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageSenderCopyWith<$Res> get senderId {
    return $MessageSenderCopyWith<$Res>(_value.senderId, (value) {
      return _then(_value.copyWith(senderId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String conversationId,
      MessageSender senderId,
      MessageType type,
      String content,
      Map<String, dynamic>? metadata,
      bool isRead,
      DateTime? readAt,
      DateTime createdAt});

  @override
  $MessageSenderCopyWith<$Res> get senderId;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? type = null,
    Object? content = null,
    Object? metadata = freezed,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$MessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as MessageSender,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl extends _Message {
  const _$MessageImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.conversationId,
      required this.senderId,
      this.type = MessageType.text,
      required this.content,
      final Map<String, dynamic>? metadata,
      this.isRead = false,
      this.readAt,
      required this.createdAt})
      : _metadata = metadata,
        super._();

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String conversationId;
  @override
  final MessageSender senderId;
  @override
  @JsonKey()
  final MessageType type;
  @override
  final String content;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool isRead;
  @override
  final DateTime? readAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Message(id: $id, conversationId: $conversationId, senderId: $senderId, type: $type, content: $content, metadata: $metadata, isRead: $isRead, readAt: $readAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      conversationId,
      senderId,
      type,
      content,
      const DeepCollectionEquality().hash(_metadata),
      isRead,
      readAt,
      createdAt);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message extends Message {
  const factory _Message(
      {@JsonKey(name: '_id') required final String id,
      required final String conversationId,
      required final MessageSender senderId,
      final MessageType type,
      required final String content,
      final Map<String, dynamic>? metadata,
      final bool isRead,
      final DateTime? readAt,
      required final DateTime createdAt}) = _$MessageImpl;
  const _Message._() : super._();

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get conversationId;
  @override
  MessageSender get senderId;
  @override
  MessageType get type;
  @override
  String get content;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool get isRead;
  @override
  DateTime? get readAt;
  @override
  DateTime get createdAt;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageSender _$MessageSenderFromJson(Map<String, dynamic> json) {
  return _MessageSender.fromJson(json);
}

/// @nodoc
mixin _$MessageSender {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  /// Serializes this MessageSender to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageSender
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageSenderCopyWith<MessageSender> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageSenderCopyWith<$Res> {
  factory $MessageSenderCopyWith(
          MessageSender value, $Res Function(MessageSender) then) =
      _$MessageSenderCopyWithImpl<$Res, MessageSender>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name, String? avatar});
}

/// @nodoc
class _$MessageSenderCopyWithImpl<$Res, $Val extends MessageSender>
    implements $MessageSenderCopyWith<$Res> {
  _$MessageSenderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageSender
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageSenderImplCopyWith<$Res>
    implements $MessageSenderCopyWith<$Res> {
  factory _$$MessageSenderImplCopyWith(
          _$MessageSenderImpl value, $Res Function(_$MessageSenderImpl) then) =
      __$$MessageSenderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String name, String? avatar});
}

/// @nodoc
class __$$MessageSenderImplCopyWithImpl<$Res>
    extends _$MessageSenderCopyWithImpl<$Res, _$MessageSenderImpl>
    implements _$$MessageSenderImplCopyWith<$Res> {
  __$$MessageSenderImplCopyWithImpl(
      _$MessageSenderImpl _value, $Res Function(_$MessageSenderImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageSender
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_$MessageSenderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageSenderImpl implements _MessageSender {
  const _$MessageSenderImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      this.avatar});

  factory _$MessageSenderImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageSenderImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'MessageSender(id: $id, name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageSenderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar);

  /// Create a copy of MessageSender
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageSenderImplCopyWith<_$MessageSenderImpl> get copyWith =>
      __$$MessageSenderImplCopyWithImpl<_$MessageSenderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageSenderImplToJson(
      this,
    );
  }
}

abstract class _MessageSender implements MessageSender {
  const factory _MessageSender(
      {@JsonKey(name: '_id') required final String id,
      required final String name,
      final String? avatar}) = _$MessageSenderImpl;

  factory _MessageSender.fromJson(Map<String, dynamic> json) =
      _$MessageSenderImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get avatar;

  /// Create a copy of MessageSender
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageSenderImplCopyWith<_$MessageSenderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastMessage _$LastMessageFromJson(Map<String, dynamic> json) {
  return _LastMessage.fromJson(json);
}

/// @nodoc
mixin _$LastMessage {
  String get content => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this LastMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastMessageCopyWith<LastMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMessageCopyWith<$Res> {
  factory $LastMessageCopyWith(
          LastMessage value, $Res Function(LastMessage) then) =
      _$LastMessageCopyWithImpl<$Res, LastMessage>;
  @useResult
  $Res call({String content, String senderId, DateTime createdAt});
}

/// @nodoc
class _$LastMessageCopyWithImpl<$Res, $Val extends LastMessage>
    implements $LastMessageCopyWith<$Res> {
  _$LastMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? senderId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastMessageImplCopyWith<$Res>
    implements $LastMessageCopyWith<$Res> {
  factory _$$LastMessageImplCopyWith(
          _$LastMessageImpl value, $Res Function(_$LastMessageImpl) then) =
      __$$LastMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, String senderId, DateTime createdAt});
}

/// @nodoc
class __$$LastMessageImplCopyWithImpl<$Res>
    extends _$LastMessageCopyWithImpl<$Res, _$LastMessageImpl>
    implements _$$LastMessageImplCopyWith<$Res> {
  __$$LastMessageImplCopyWithImpl(
      _$LastMessageImpl _value, $Res Function(_$LastMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? senderId = null,
    Object? createdAt = null,
  }) {
    return _then(_$LastMessageImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMessageImpl implements _LastMessage {
  const _$LastMessageImpl(
      {required this.content, required this.senderId, required this.createdAt});

  factory _$LastMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMessageImplFromJson(json);

  @override
  final String content;
  @override
  final String senderId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'LastMessage(content: $content, senderId: $senderId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMessageImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content, senderId, createdAt);

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMessageImplCopyWith<_$LastMessageImpl> get copyWith =>
      __$$LastMessageImplCopyWithImpl<_$LastMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMessageImplToJson(
      this,
    );
  }
}

abstract class _LastMessage implements LastMessage {
  const factory _LastMessage(
      {required final String content,
      required final String senderId,
      required final DateTime createdAt}) = _$LastMessageImpl;

  factory _LastMessage.fromJson(Map<String, dynamic> json) =
      _$LastMessageImpl.fromJson;

  @override
  String get content;
  @override
  String get senderId;
  @override
  DateTime get createdAt;

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastMessageImplCopyWith<_$LastMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationParticipant _$ConversationParticipantFromJson(
    Map<String, dynamic> json) {
  return _ConversationParticipant.fromJson(json);
}

/// @nodoc
mixin _$ConversationParticipant {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;

  /// Serializes this ConversationParticipant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationParticipantCopyWith<ConversationParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationParticipantCopyWith<$Res> {
  factory $ConversationParticipantCopyWith(ConversationParticipant value,
          $Res Function(ConversationParticipant) then) =
      _$ConversationParticipantCopyWithImpl<$Res, ConversationParticipant>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? phone,
      String? avatar,
      String role});
}

/// @nodoc
class _$ConversationParticipantCopyWithImpl<$Res,
        $Val extends ConversationParticipant>
    implements $ConversationParticipantCopyWith<$Res> {
  _$ConversationParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatar = freezed,
    Object? role = null,
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
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationParticipantImplCopyWith<$Res>
    implements $ConversationParticipantCopyWith<$Res> {
  factory _$$ConversationParticipantImplCopyWith(
          _$ConversationParticipantImpl value,
          $Res Function(_$ConversationParticipantImpl) then) =
      __$$ConversationParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? phone,
      String? avatar,
      String role});
}

/// @nodoc
class __$$ConversationParticipantImplCopyWithImpl<$Res>
    extends _$ConversationParticipantCopyWithImpl<$Res,
        _$ConversationParticipantImpl>
    implements _$$ConversationParticipantImplCopyWith<$Res> {
  __$$ConversationParticipantImplCopyWithImpl(
      _$ConversationParticipantImpl _value,
      $Res Function(_$ConversationParticipantImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = freezed,
    Object? avatar = freezed,
    Object? role = null,
  }) {
    return _then(_$ConversationParticipantImpl(
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
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationParticipantImpl implements _ConversationParticipant {
  const _$ConversationParticipantImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      this.phone,
      this.avatar,
      required this.role});

  factory _$ConversationParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationParticipantImplFromJson(json);

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
  final String role;

  @override
  String toString() {
    return 'ConversationParticipant(id: $id, name: $name, phone: $phone, avatar: $avatar, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationParticipantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, avatar, role);

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationParticipantImplCopyWith<_$ConversationParticipantImpl>
      get copyWith => __$$ConversationParticipantImplCopyWithImpl<
          _$ConversationParticipantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationParticipantImplToJson(
      this,
    );
  }
}

abstract class _ConversationParticipant implements ConversationParticipant {
  const factory _ConversationParticipant(
      {@JsonKey(name: '_id') required final String id,
      required final String name,
      final String? phone,
      final String? avatar,
      required final String role}) = _$ConversationParticipantImpl;

  factory _ConversationParticipant.fromJson(Map<String, dynamic> json) =
      _$ConversationParticipantImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get avatar;
  @override
  String get role;

  /// Create a copy of ConversationParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationParticipantImplCopyWith<_$ConversationParticipantImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ConversationRequest _$ConversationRequestFromJson(Map<String, dynamic> json) {
  return _ConversationRequest.fromJson(json);
}

/// @nodoc
mixin _$ConversationRequest {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get requestNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  ConversationCategory? get category => throw _privateConstructorUsedError;

  /// Serializes this ConversationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationRequestCopyWith<ConversationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationRequestCopyWith<$Res> {
  factory $ConversationRequestCopyWith(
          ConversationRequest value, $Res Function(ConversationRequest) then) =
      _$ConversationRequestCopyWithImpl<$Res, ConversationRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestNumber,
      String title,
      String status,
      ConversationCategory? category});

  $ConversationCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$ConversationRequestCopyWithImpl<$Res, $Val extends ConversationRequest>
    implements $ConversationRequestCopyWith<$Res> {
  _$ConversationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestNumber = null,
    Object? title = null,
    Object? status = null,
    Object? category = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ConversationCategory?,
    ) as $Val);
  }

  /// Create a copy of ConversationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $ConversationCategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationRequestImplCopyWith<$Res>
    implements $ConversationRequestCopyWith<$Res> {
  factory _$$ConversationRequestImplCopyWith(_$ConversationRequestImpl value,
          $Res Function(_$ConversationRequestImpl) then) =
      __$$ConversationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestNumber,
      String title,
      String status,
      ConversationCategory? category});

  @override
  $ConversationCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$ConversationRequestImplCopyWithImpl<$Res>
    extends _$ConversationRequestCopyWithImpl<$Res, _$ConversationRequestImpl>
    implements _$$ConversationRequestImplCopyWith<$Res> {
  __$$ConversationRequestImplCopyWithImpl(_$ConversationRequestImpl _value,
      $Res Function(_$ConversationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestNumber = null,
    Object? title = null,
    Object? status = null,
    Object? category = freezed,
  }) {
    return _then(_$ConversationRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestNumber: null == requestNumber
          ? _value.requestNumber
          : requestNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ConversationCategory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationRequestImpl implements _ConversationRequest {
  const _$ConversationRequestImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.requestNumber,
      required this.title,
      required this.status,
      this.category});

  factory _$ConversationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationRequestImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String requestNumber;
  @override
  final String title;
  @override
  final String status;
  @override
  final ConversationCategory? category;

  @override
  String toString() {
    return 'ConversationRequest(id: $id, requestNumber: $requestNumber, title: $title, status: $status, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestNumber, requestNumber) ||
                other.requestNumber == requestNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, requestNumber, title, status, category);

  /// Create a copy of ConversationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationRequestImplCopyWith<_$ConversationRequestImpl> get copyWith =>
      __$$ConversationRequestImplCopyWithImpl<_$ConversationRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationRequestImplToJson(
      this,
    );
  }
}

abstract class _ConversationRequest implements ConversationRequest {
  const factory _ConversationRequest(
      {@JsonKey(name: '_id') required final String id,
      required final String requestNumber,
      required final String title,
      required final String status,
      final ConversationCategory? category}) = _$ConversationRequestImpl;

  factory _ConversationRequest.fromJson(Map<String, dynamic> json) =
      _$ConversationRequestImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get requestNumber;
  @override
  String get title;
  @override
  String get status;
  @override
  ConversationCategory? get category;

  /// Create a copy of ConversationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationRequestImplCopyWith<_$ConversationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationCategory _$ConversationCategoryFromJson(Map<String, dynamic> json) {
  return _ConversationCategory.fromJson(json);
}

/// @nodoc
mixin _$ConversationCategory {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this ConversationCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCategoryCopyWith<ConversationCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCategoryCopyWith<$Res> {
  factory $ConversationCategoryCopyWith(ConversationCategory value,
          $Res Function(ConversationCategory) then) =
      _$ConversationCategoryCopyWithImpl<$Res, ConversationCategory>;
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String nameAr, String? icon});
}

/// @nodoc
class _$ConversationCategoryCopyWithImpl<$Res,
        $Val extends ConversationCategory>
    implements $ConversationCategoryCopyWith<$Res> {
  _$ConversationCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ConversationCategoryImplCopyWith<$Res>
    implements $ConversationCategoryCopyWith<$Res> {
  factory _$$ConversationCategoryImplCopyWith(_$ConversationCategoryImpl value,
          $Res Function(_$ConversationCategoryImpl) then) =
      __$$ConversationCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: '_id') String id, String nameAr, String? icon});
}

/// @nodoc
class __$$ConversationCategoryImplCopyWithImpl<$Res>
    extends _$ConversationCategoryCopyWithImpl<$Res, _$ConversationCategoryImpl>
    implements _$$ConversationCategoryImplCopyWith<$Res> {
  __$$ConversationCategoryImplCopyWithImpl(_$ConversationCategoryImpl _value,
      $Res Function(_$ConversationCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? icon = freezed,
  }) {
    return _then(_$ConversationCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
class _$ConversationCategoryImpl implements _ConversationCategory {
  const _$ConversationCategoryImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.nameAr,
      this.icon});

  factory _$ConversationCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationCategoryImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String nameAr;
  @override
  final String? icon;

  @override
  String toString() {
    return 'ConversationCategory(id: $id, nameAr: $nameAr, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nameAr, icon);

  /// Create a copy of ConversationCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationCategoryImplCopyWith<_$ConversationCategoryImpl>
      get copyWith =>
          __$$ConversationCategoryImplCopyWithImpl<_$ConversationCategoryImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationCategoryImplToJson(
      this,
    );
  }
}

abstract class _ConversationCategory implements ConversationCategory {
  const factory _ConversationCategory(
      {@JsonKey(name: '_id') required final String id,
      required final String nameAr,
      final String? icon}) = _$ConversationCategoryImpl;

  factory _ConversationCategory.fromJson(Map<String, dynamic> json) =
      _$ConversationCategoryImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get nameAr;
  @override
  String? get icon;

  /// Create a copy of ConversationCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationCategoryImplCopyWith<_$ConversationCategoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;
  List<ConversationParticipant> get participants =>
      throw _privateConstructorUsedError;
  LastMessage? get lastMessage => throw _privateConstructorUsedError;
  Map<String, int> get unreadCount => throw _privateConstructorUsedError;
  int get myUnreadCount => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  ConversationRequest? get request => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestId,
      List<ConversationParticipant> participants,
      LastMessage? lastMessage,
      Map<String, int> unreadCount,
      int myUnreadCount,
      bool isActive,
      ConversationRequest? request,
      DateTime createdAt,
      DateTime updatedAt});

  $LastMessageCopyWith<$Res>? get lastMessage;
  $ConversationRequestCopyWith<$Res>? get request;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? participants = null,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? myUnreadCount = null,
    Object? isActive = null,
    Object? request = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ConversationParticipant>,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessage?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      myUnreadCount: null == myUnreadCount
          ? _value.myUnreadCount
          : myUnreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ConversationRequest?,
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

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $LastMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationRequestCopyWith<$Res>? get request {
    if (_value.request == null) {
      return null;
    }

    return $ConversationRequestCopyWith<$Res>(_value.request!, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String requestId,
      List<ConversationParticipant> participants,
      LastMessage? lastMessage,
      Map<String, int> unreadCount,
      int myUnreadCount,
      bool isActive,
      ConversationRequest? request,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $LastMessageCopyWith<$Res>? get lastMessage;
  @override
  $ConversationRequestCopyWith<$Res>? get request;
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requestId = null,
    Object? participants = null,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? myUnreadCount = null,
    Object? isActive = null,
    Object? request = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ConversationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ConversationParticipant>,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessage?,
      unreadCount: null == unreadCount
          ? _value._unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      myUnreadCount: null == myUnreadCount
          ? _value.myUnreadCount
          : myUnreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ConversationRequest?,
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
class _$ConversationImpl extends _Conversation {
  const _$ConversationImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.requestId,
      required final List<ConversationParticipant> participants,
      this.lastMessage,
      final Map<String, int> unreadCount = const {},
      this.myUnreadCount = 0,
      this.isActive = true,
      this.request,
      required this.createdAt,
      required this.updatedAt})
      : _participants = participants,
        _unreadCount = unreadCount,
        super._();

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String requestId;
  final List<ConversationParticipant> _participants;
  @override
  List<ConversationParticipant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final LastMessage? lastMessage;
  final Map<String, int> _unreadCount;
  @override
  @JsonKey()
  Map<String, int> get unreadCount {
    if (_unreadCount is EqualUnmodifiableMapView) return _unreadCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_unreadCount);
  }

  @override
  @JsonKey()
  final int myUnreadCount;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final ConversationRequest? request;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Conversation(id: $id, requestId: $requestId, participants: $participants, lastMessage: $lastMessage, unreadCount: $unreadCount, myUnreadCount: $myUnreadCount, isActive: $isActive, request: $request, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality()
                .equals(other._unreadCount, _unreadCount) &&
            (identical(other.myUnreadCount, myUnreadCount) ||
                other.myUnreadCount == myUnreadCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.request, request) || other.request == request) &&
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
      requestId,
      const DeepCollectionEquality().hash(_participants),
      lastMessage,
      const DeepCollectionEquality().hash(_unreadCount),
      myUnreadCount,
      isActive,
      request,
      createdAt,
      updatedAt);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation extends Conversation {
  const factory _Conversation(
      {@JsonKey(name: '_id') required final String id,
      required final String requestId,
      required final List<ConversationParticipant> participants,
      final LastMessage? lastMessage,
      final Map<String, int> unreadCount,
      final int myUnreadCount,
      final bool isActive,
      final ConversationRequest? request,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ConversationImpl;
  const _Conversation._() : super._();

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get requestId;
  @override
  List<ConversationParticipant> get participants;
  @override
  LastMessage? get lastMessage;
  @override
  Map<String, int> get unreadCount;
  @override
  int get myUnreadCount;
  @override
  bool get isActive;
  @override
  ConversationRequest? get request;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SendMessageData _$SendMessageDataFromJson(Map<String, dynamic> json) {
  return _SendMessageData.fromJson(json);
}

/// @nodoc
mixin _$SendMessageData {
  MessageType get type => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this SendMessageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMessageDataCopyWith<SendMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageDataCopyWith<$Res> {
  factory $SendMessageDataCopyWith(
          SendMessageData value, $Res Function(SendMessageData) then) =
      _$SendMessageDataCopyWithImpl<$Res, SendMessageData>;
  @useResult
  $Res call({MessageType type, String content, Map<String, dynamic>? metadata});
}

/// @nodoc
class _$SendMessageDataCopyWithImpl<$Res, $Val extends SendMessageData>
    implements $SendMessageDataCopyWith<$Res> {
  _$SendMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendMessageDataImplCopyWith<$Res>
    implements $SendMessageDataCopyWith<$Res> {
  factory _$$SendMessageDataImplCopyWith(_$SendMessageDataImpl value,
          $Res Function(_$SendMessageDataImpl) then) =
      __$$SendMessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MessageType type, String content, Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$SendMessageDataImplCopyWithImpl<$Res>
    extends _$SendMessageDataCopyWithImpl<$Res, _$SendMessageDataImpl>
    implements _$$SendMessageDataImplCopyWith<$Res> {
  __$$SendMessageDataImplCopyWithImpl(
      _$SendMessageDataImpl _value, $Res Function(_$SendMessageDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? content = null,
    Object? metadata = freezed,
  }) {
    return _then(_$SendMessageDataImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMessageDataImpl implements _SendMessageData {
  const _$SendMessageDataImpl(
      {this.type = MessageType.text,
      required this.content,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$SendMessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMessageDataImplFromJson(json);

  @override
  @JsonKey()
  final MessageType type;
  @override
  final String content;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SendMessageData(type: $type, content: $content, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, content,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of SendMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageDataImplCopyWith<_$SendMessageDataImpl> get copyWith =>
      __$$SendMessageDataImplCopyWithImpl<_$SendMessageDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMessageDataImplToJson(
      this,
    );
  }
}

abstract class _SendMessageData implements SendMessageData {
  const factory _SendMessageData(
      {final MessageType type,
      required final String content,
      final Map<String, dynamic>? metadata}) = _$SendMessageDataImpl;

  factory _SendMessageData.fromJson(Map<String, dynamic> json) =
      _$SendMessageDataImpl.fromJson;

  @override
  MessageType get type;
  @override
  String get content;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of SendMessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageDataImplCopyWith<_$SendMessageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationListResponse _$ConversationListResponseFromJson(
    Map<String, dynamic> json) {
  return _ConversationListResponse.fromJson(json);
}

/// @nodoc
mixin _$ConversationListResponse {
  List<Conversation> get data => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this ConversationListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationListResponseCopyWith<ConversationListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationListResponseCopyWith<$Res> {
  factory $ConversationListResponseCopyWith(ConversationListResponse value,
          $Res Function(ConversationListResponse) then) =
      _$ConversationListResponseCopyWithImpl<$Res, ConversationListResponse>;
  @useResult
  $Res call(
      {List<Conversation> data,
      int page,
      int totalPages,
      int total,
      int limit});
}

/// @nodoc
class _$ConversationListResponseCopyWithImpl<$Res,
        $Val extends ConversationListResponse>
    implements $ConversationListResponseCopyWith<$Res> {
  _$ConversationListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationListResponse
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
              as List<Conversation>,
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
abstract class _$$ConversationListResponseImplCopyWith<$Res>
    implements $ConversationListResponseCopyWith<$Res> {
  factory _$$ConversationListResponseImplCopyWith(
          _$ConversationListResponseImpl value,
          $Res Function(_$ConversationListResponseImpl) then) =
      __$$ConversationListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Conversation> data,
      int page,
      int totalPages,
      int total,
      int limit});
}

/// @nodoc
class __$$ConversationListResponseImplCopyWithImpl<$Res>
    extends _$ConversationListResponseCopyWithImpl<$Res,
        _$ConversationListResponseImpl>
    implements _$$ConversationListResponseImplCopyWith<$Res> {
  __$$ConversationListResponseImplCopyWithImpl(
      _$ConversationListResponseImpl _value,
      $Res Function(_$ConversationListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationListResponse
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
    return _then(_$ConversationListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
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
class _$ConversationListResponseImpl implements _ConversationListResponse {
  const _$ConversationListResponseImpl(
      {required final List<Conversation> data,
      required this.page,
      required this.totalPages,
      required this.total,
      required this.limit})
      : _data = data;

  factory _$ConversationListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationListResponseImplFromJson(json);

  final List<Conversation> _data;
  @override
  List<Conversation> get data {
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
    return 'ConversationListResponse(data: $data, page: $page, totalPages: $totalPages, total: $total, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationListResponseImpl &&
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

  /// Create a copy of ConversationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationListResponseImplCopyWith<_$ConversationListResponseImpl>
      get copyWith => __$$ConversationListResponseImplCopyWithImpl<
          _$ConversationListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationListResponseImplToJson(
      this,
    );
  }
}

abstract class _ConversationListResponse implements ConversationListResponse {
  const factory _ConversationListResponse(
      {required final List<Conversation> data,
      required final int page,
      required final int totalPages,
      required final int total,
      required final int limit}) = _$ConversationListResponseImpl;

  factory _ConversationListResponse.fromJson(Map<String, dynamic> json) =
      _$ConversationListResponseImpl.fromJson;

  @override
  List<Conversation> get data;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  int get total;
  @override
  int get limit;

  /// Create a copy of ConversationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationListResponseImplCopyWith<_$ConversationListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MessageListResponse _$MessageListResponseFromJson(Map<String, dynamic> json) {
  return _MessageListResponse.fromJson(json);
}

/// @nodoc
mixin _$MessageListResponse {
  List<Message> get data => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  /// Serializes this MessageListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageListResponseCopyWith<MessageListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageListResponseCopyWith<$Res> {
  factory $MessageListResponseCopyWith(
          MessageListResponse value, $Res Function(MessageListResponse) then) =
      _$MessageListResponseCopyWithImpl<$Res, MessageListResponse>;
  @useResult
  $Res call(
      {List<Message> data, int page, int totalPages, int total, int limit});
}

/// @nodoc
class _$MessageListResponseCopyWithImpl<$Res, $Val extends MessageListResponse>
    implements $MessageListResponseCopyWith<$Res> {
  _$MessageListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageListResponse
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
              as List<Message>,
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
abstract class _$$MessageListResponseImplCopyWith<$Res>
    implements $MessageListResponseCopyWith<$Res> {
  factory _$$MessageListResponseImplCopyWith(_$MessageListResponseImpl value,
          $Res Function(_$MessageListResponseImpl) then) =
      __$$MessageListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Message> data, int page, int totalPages, int total, int limit});
}

/// @nodoc
class __$$MessageListResponseImplCopyWithImpl<$Res>
    extends _$MessageListResponseCopyWithImpl<$Res, _$MessageListResponseImpl>
    implements _$$MessageListResponseImplCopyWith<$Res> {
  __$$MessageListResponseImplCopyWithImpl(_$MessageListResponseImpl _value,
      $Res Function(_$MessageListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageListResponse
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
    return _then(_$MessageListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Message>,
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
class _$MessageListResponseImpl implements _MessageListResponse {
  const _$MessageListResponseImpl(
      {required final List<Message> data,
      required this.page,
      required this.totalPages,
      required this.total,
      required this.limit})
      : _data = data;

  factory _$MessageListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageListResponseImplFromJson(json);

  final List<Message> _data;
  @override
  List<Message> get data {
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
    return 'MessageListResponse(data: $data, page: $page, totalPages: $totalPages, total: $total, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageListResponseImpl &&
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

  /// Create a copy of MessageListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageListResponseImplCopyWith<_$MessageListResponseImpl> get copyWith =>
      __$$MessageListResponseImplCopyWithImpl<_$MessageListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageListResponseImplToJson(
      this,
    );
  }
}

abstract class _MessageListResponse implements MessageListResponse {
  const factory _MessageListResponse(
      {required final List<Message> data,
      required final int page,
      required final int totalPages,
      required final int total,
      required final int limit}) = _$MessageListResponseImpl;

  factory _MessageListResponse.fromJson(Map<String, dynamic> json) =
      _$MessageListResponseImpl.fromJson;

  @override
  List<Message> get data;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  int get total;
  @override
  int get limit;

  /// Create a copy of MessageListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageListResponseImplCopyWith<_$MessageListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
