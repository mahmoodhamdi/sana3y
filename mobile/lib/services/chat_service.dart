import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat.dart';
import '../providers/auth_provider.dart';
import 'api_client.dart';

part 'chat_service.g.dart';

@riverpod
ChatService chatService(ChatServiceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ChatService(apiClient);
}

class ChatService {
  final ApiClient _apiClient;

  ChatService(this._apiClient);

  // Get conversations list
  Future<ConversationListResponse> getConversations({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      '/chat/conversations',
      queryParameters: {'page': page, 'limit': limit},
    );

    return ConversationListResponse(
      data: (response.data['data'] as List)
          .map((e) => Conversation.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Get single conversation
  Future<Conversation> getConversation(String conversationId) async {
    final response = await _apiClient.get('/chat/conversations/$conversationId');
    return Conversation.fromJson(response.data['data']);
  }

  // Create or get conversation
  Future<Conversation> createConversation({
    required String requestId,
    required String otherUserId,
  }) async {
    final response = await _apiClient.post(
      '/chat/conversations',
      data: {
        'requestId': requestId,
        'otherUserId': otherUserId,
      },
    );
    return Conversation.fromJson(response.data['data']);
  }

  // Get messages for a conversation
  Future<MessageListResponse> getMessages(
    String conversationId, {
    int page = 1,
    int limit = 50,
    DateTime? before,
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (before != null) {
      params['before'] = before.toIso8601String();
    }

    final response = await _apiClient.get(
      '/chat/conversations/$conversationId/messages',
      queryParameters: params,
    );

    return MessageListResponse(
      data: (response.data['data'] as List)
          .map((e) => Message.fromJson(e))
          .toList(),
      page: response.data['pagination']['page'],
      totalPages: response.data['pagination']['totalPages'],
      total: response.data['pagination']['total'],
      limit: response.data['pagination']['limit'],
    );
  }

  // Send a message
  Future<Message> sendMessage(
    String conversationId,
    SendMessageData data,
  ) async {
    final response = await _apiClient.post(
      '/chat/conversations/$conversationId/messages',
      data: {
        'type': data.type.name,
        'content': data.content,
        if (data.metadata != null) 'metadata': data.metadata,
      },
    );
    return Message.fromJson(response.data['data']);
  }

  // Mark conversation as read
  Future<void> markAsRead(String conversationId) async {
    await _apiClient.put('/chat/conversations/$conversationId/read');
  }

  // Get total unread count
  Future<int> getUnreadCount() async {
    final response = await _apiClient.get('/chat/unread-count');
    return response.data['data']['count'];
  }

  // Archive conversation
  Future<void> archiveConversation(String conversationId) async {
    await _apiClient.delete('/chat/conversations/$conversationId');
  }
}
