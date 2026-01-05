import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/chat.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat_provider.dart';
import '../../services/api_client.dart';
import '../../config/constants.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String conversationId;

  const ChatScreen({super.key, required this.conversationId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  bool _isSending = false;
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    // Mark as read when entering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messagesNotifierProvider(widget.conversationId).notifier).markAsRead();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesNotifierProvider(widget.conversationId));
    final currentUser = ref.watch(currentUserProvider);
    final conversationsAsync = ref.watch(conversationsNotifierProvider);

    // Get the conversation for header info
    final conversation = conversationsAsync.valueOrNull?.firstWhere(
      (c) => c.id == widget.conversationId,
      orElse: () => throw Exception('Conversation not found'),
    );

    final otherParticipant = conversation?.getOtherParticipant(currentUser?.id ?? '');

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: otherParticipant?.avatar != null
                  ? NetworkImage(otherParticipant!.avatar!)
                  : null,
              child: otherParticipant?.avatar == null
                  ? Text(
                      otherParticipant?.name.substring(0, 1).toUpperCase() ?? '?',
                      style: const TextStyle(fontSize: 14),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherParticipant?.name ?? 'محادثة',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (conversation?.request != null)
                    Text(
                      conversation!.request!.title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () => _makeCall(otherParticipant?.phone),
            tooltip: 'اتصال',
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'ابدأ المحادثة الآن',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId.id == currentUser?.id;
                    final showAvatar = !isMe &&
                        (index == 0 ||
                            messages[index - 1].senderId.id != message.senderId.id);

                    return _MessageBubble(
                      message: message,
                      isMe: isMe,
                      showAvatar: showAvatar,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('خطأ: $e')),
            ),
          ),

          // Input
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: _isUploadingImage
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.attach_file),
                  onPressed: _isUploadingImage ? null : _showAttachmentOptions,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send, color: Colors.white),
                    onPressed: _isSending ? null : _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);

    try {
      await ref
          .read(messagesNotifierProvider(widget.conversationId).notifier)
          .sendMessage(SendMessageData(content: text));

      _messageController.clear();

      // Scroll to bottom
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إرسال الرسالة: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _makeCall(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رقم الهاتف غير متاح')),
      );
      return;
    }

    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تعذر فتح تطبيق الاتصال')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الاتصال: $e')),
        );
      }
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'إرفاق ملف',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
              title: const Text('الكاميرا'),
              subtitle: const Text('التقاط صورة جديدة'),
              onTap: () {
                Navigator.pop(context);
                _pickAndSendImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.photo_library, color: Colors.white),
              ),
              title: const Text('معرض الصور'),
              subtitle: const Text('اختيار صورة من المعرض'),
              onTap: () {
                Navigator.pop(context);
                _pickAndSendImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.location_on, color: Colors.white),
              ),
              title: const Text('الموقع'),
              subtitle: const Text('مشاركة موقعك الحالي'),
              onTap: () {
                Navigator.pop(context);
                _sendLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndSendImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image == null) return;

      setState(() => _isUploadingImage = true);

      // Upload image
      final apiClient = ApiClient();
      final response = await apiClient.uploadFile(
        ApiEndpoints.upload,
        image.path,
        'image',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final imageUrl = response.data['data']['url'] as String?;
        if (imageUrl != null) {
          // Send image message
          await ref
              .read(messagesNotifierProvider(widget.conversationId).notifier)
              .sendMessage(SendMessageData(
                content: imageUrl,
                type: MessageType.image,
              ));
          _scrollToBottom();
        }
      } else {
        throw Exception('فشل رفع الصورة');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في إرسال الصورة: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploadingImage = false);
      }
    }
  }

  Future<void> _sendLocation() async {
    // For now, show a message that location sharing will be available
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('مشاركة الموقع ستكون متاحة قريباً')),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool showAvatar;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.showAvatar,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isSystemMessage) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.content,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar)
            CircleAvatar(
              radius: 14,
              backgroundImage: message.senderId.avatar != null
                  ? NetworkImage(message.senderId.avatar!)
                  : null,
              child: message.senderId.avatar == null
                  ? Text(
                      message.senderId.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(fontSize: 10),
                    )
                  : null,
            )
          else if (!isMe)
            const SizedBox(width: 28),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.type == MessageType.image)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        message.content,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Text(
                      message.content,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.createdAt),
                        style: TextStyle(
                          color: isMe
                              ? Colors.white.withValues(alpha: 0.7)
                              : Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message.isRead ? Icons.done_all : Icons.done,
                          size: 14,
                          color: message.isRead
                              ? Colors.lightBlueAccent
                              : Colors.white.withValues(alpha: 0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
