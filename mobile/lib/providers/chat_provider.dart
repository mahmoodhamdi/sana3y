import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/chat.dart';
import '../services/chat_service.dart';

part 'chat_provider.g.dart';

// Conversations list provider
@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  @override
  Future<List<Conversation>> build() async {
    return _loadConversations();
  }

  Future<List<Conversation>> _loadConversations() async {
    final service = ref.read(chatServiceProvider);
    final response = await service.getConversations();
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadConversations);
  }

  void addConversation(Conversation conversation) {
    state = AsyncData([conversation, ...state.value ?? []]);
  }

  void updateConversation(Conversation conversation) {
    state = AsyncData(
      (state.value ?? [])
          .map((c) => c.id == conversation.id ? conversation : c)
          .toList(),
    );
  }

  void removeConversation(String conversationId) {
    state = AsyncData(
      (state.value ?? []).where((c) => c.id != conversationId).toList(),
    );
  }
}

// Single conversation messages provider
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  String? _conversationId;

  @override
  Future<List<Message>> build(String conversationId) async {
    _conversationId = conversationId;
    return _loadMessages();
  }

  Future<List<Message>> _loadMessages() async {
    if (_conversationId == null) return [];
    final service = ref.read(chatServiceProvider);
    final response = await service.getMessages(_conversationId!);
    return response.data;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadMessages);
  }

  Future<Message> sendMessage(SendMessageData data) async {
    if (_conversationId == null) throw Exception('Conversation ID not set');
    final service = ref.read(chatServiceProvider);
    final message = await service.sendMessage(_conversationId!, data);

    // Add to local list
    state = AsyncData([...state.value ?? [], message]);

    return message;
  }

  void addMessage(Message message) {
    state = AsyncData([...state.value ?? [], message]);
  }

  Future<void> markAsRead() async {
    if (_conversationId == null) return;
    final service = ref.read(chatServiceProvider);
    await service.markAsRead(_conversationId!);
  }
}

// Unread count provider
@riverpod
Future<int> unreadMessagesCount(UnreadMessagesCountRef ref) async {
  final service = ref.watch(chatServiceProvider);
  return service.getUnreadCount();
}

// Get or create conversation helper
@riverpod
Future<Conversation> getOrCreateConversation(
  GetOrCreateConversationRef ref, {
  required String requestId,
  required String otherUserId,
}) async {
  final service = ref.watch(chatServiceProvider);
  return service.createConversation(
    requestId: requestId,
    otherUserId: otherUserId,
  );
}
