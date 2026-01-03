// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['_id'] as String,
      conversationId: json['conversationId'] as String,
      senderId:
          MessageSender.fromJson(json['senderId'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
      content: json['content'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'content': instance.content,
      'metadata': instance.metadata,
      'isRead': instance.isRead,
      'readAt': instance.readAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.voice: 'voice',
  MessageType.location: 'location',
  MessageType.system: 'system',
};

_$MessageSenderImpl _$$MessageSenderImplFromJson(Map<String, dynamic> json) =>
    _$MessageSenderImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$MessageSenderImplToJson(_$MessageSenderImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };

_$LastMessageImpl _$$LastMessageImplFromJson(Map<String, dynamic> json) =>
    _$LastMessageImpl(
      content: json['content'] as String,
      senderId: json['senderId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LastMessageImplToJson(_$LastMessageImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'senderId': instance.senderId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$ConversationParticipantImpl _$$ConversationParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationParticipantImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$ConversationParticipantImplToJson(
        _$ConversationParticipantImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'role': instance.role,
    };

_$ConversationRequestImpl _$$ConversationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationRequestImpl(
      id: json['_id'] as String,
      requestNumber: json['requestNumber'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      category: json['category'] == null
          ? null
          : ConversationCategory.fromJson(
              json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConversationRequestImplToJson(
        _$ConversationRequestImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestNumber': instance.requestNumber,
      'title': instance.title,
      'status': instance.status,
      'category': instance.category,
    };

_$ConversationCategoryImpl _$$ConversationCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationCategoryImpl(
      id: json['_id'] as String,
      nameAr: json['nameAr'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$ConversationCategoryImplToJson(
        _$ConversationCategoryImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nameAr': instance.nameAr,
      'icon': instance.icon,
    };

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['_id'] as String,
      requestId: json['requestId'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) =>
              ConversationParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage: json['lastMessage'] == null
          ? null
          : LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadCount: (json['unreadCount'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      myUnreadCount: (json['myUnreadCount'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      request: json['request'] == null
          ? null
          : ConversationRequest.fromJson(
              json['request'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestId': instance.requestId,
      'participants': instance.participants,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
      'myUnreadCount': instance.myUnreadCount,
      'isActive': instance.isActive,
      'request': instance.request,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$SendMessageDataImpl _$$SendMessageDataImplFromJson(
        Map<String, dynamic> json) =>
    _$SendMessageDataImpl(
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
      content: json['content'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SendMessageDataImplToJson(
        _$SendMessageDataImpl instance) =>
    <String, dynamic>{
      'type': _$MessageTypeEnumMap[instance.type]!,
      'content': instance.content,
      'metadata': instance.metadata,
    };

_$ConversationListResponseImpl _$$ConversationListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => Conversation.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$$ConversationListResponseImplToJson(
        _$ConversationListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'limit': instance.limit,
    };

_$MessageListResponseImpl _$$MessageListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$$MessageListResponseImplToJson(
        _$MessageListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'limit': instance.limit,
    };
