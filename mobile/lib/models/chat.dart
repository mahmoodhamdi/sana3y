import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('voice')
  voice,
  @JsonValue('location')
  location,
  @JsonValue('system')
  system,
}

@freezed
class Message with _$Message {
  const Message._();

  const factory Message({
    @JsonKey(name: '_id') required String id,
    required String conversationId,
    required MessageSender senderId,
    @Default(MessageType.text) MessageType type,
    required String content,
    Map<String, dynamic>? metadata,
    @Default(false) bool isRead,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  bool get isSystemMessage => type == MessageType.system;
}

@freezed
class MessageSender with _$MessageSender {
  const factory MessageSender({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? avatar,
  }) = _MessageSender;

  factory MessageSender.fromJson(Map<String, dynamic> json) =>
      _$MessageSenderFromJson(json);
}

@freezed
class LastMessage with _$LastMessage {
  const factory LastMessage({
    required String content,
    required String senderId,
    required DateTime createdAt,
  }) = _LastMessage;

  factory LastMessage.fromJson(Map<String, dynamic> json) =>
      _$LastMessageFromJson(json);
}

@freezed
class ConversationParticipant with _$ConversationParticipant {
  const factory ConversationParticipant({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? phone,
    String? avatar,
    required String role,
  }) = _ConversationParticipant;

  factory ConversationParticipant.fromJson(Map<String, dynamic> json) =>
      _$ConversationParticipantFromJson(json);
}

@freezed
class ConversationRequest with _$ConversationRequest {
  const factory ConversationRequest({
    @JsonKey(name: '_id') required String id,
    required String requestNumber,
    required String title,
    required String status,
    ConversationCategory? category,
  }) = _ConversationRequest;

  factory ConversationRequest.fromJson(Map<String, dynamic> json) =>
      _$ConversationRequestFromJson(json);
}

@freezed
class ConversationCategory with _$ConversationCategory {
  const factory ConversationCategory({
    @JsonKey(name: '_id') required String id,
    required String nameAr,
    String? icon,
  }) = _ConversationCategory;

  factory ConversationCategory.fromJson(Map<String, dynamic> json) =>
      _$ConversationCategoryFromJson(json);
}

@freezed
class Conversation with _$Conversation {
  const Conversation._();

  const factory Conversation({
    @JsonKey(name: '_id') required String id,
    required String requestId,
    required List<ConversationParticipant> participants,
    LastMessage? lastMessage,
    @Default({}) Map<String, int> unreadCount,
    @Default(0) int myUnreadCount,
    @Default(true) bool isActive,
    ConversationRequest? request,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  ConversationParticipant? getOtherParticipant(String myUserId) {
    return participants.where((p) => p.id != myUserId).firstOrNull;
  }
}

@freezed
class SendMessageData with _$SendMessageData {
  const factory SendMessageData({
    @Default(MessageType.text) MessageType type,
    required String content,
    Map<String, dynamic>? metadata,
  }) = _SendMessageData;

  factory SendMessageData.fromJson(Map<String, dynamic> json) =>
      _$SendMessageDataFromJson(json);
}

@freezed
class ConversationListResponse with _$ConversationListResponse {
  const factory ConversationListResponse({
    required List<Conversation> data,
    required int page,
    required int totalPages,
    required int total,
    required int limit,
  }) = _ConversationListResponse;

  factory ConversationListResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationListResponseFromJson(json);
}

@freezed
class MessageListResponse with _$MessageListResponse {
  const factory MessageListResponse({
    required List<Message> data,
    required int page,
    required int totalPages,
    required int total,
    required int limit,
  }) = _MessageListResponse;

  factory MessageListResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageListResponseFromJson(json);
}
