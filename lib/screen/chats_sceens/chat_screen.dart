import 'package:daleel_app_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../dependencies.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String receiverImage;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late final User currentUser;
  late final String currentUserId, chatId, currentName, currentImage;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    final u = userController.user;
    if (u == null) return;

    currentUser = u;
    currentUserId = u.userId.toString();
    currentName = "${u.firstName} ${u.lastName}";
    currentImage = u.profileImage;

    chatId = currentUserId.compareTo(widget.receiverId) < 0
        ? '$currentUserId-${widget.receiverId}'
        : '${widget.receiverId}-$currentUserId';

    _isInit = true;
  }

  void _sendMessage() async {
    final messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      _controller.clear();
      final timestamp = FieldValue.serverTimestamp();

      await FirebaseFirestore.instance.collection('messages').add({
        'text': messageText,
        'senderId': currentUserId,
        'receiverId': widget.receiverId,
        'chatId': chatId,
        'createdAt': timestamp,
      });

      await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
        'chatId': chatId,
        'lastMessage': messageText,
        'lastMessageTime': timestamp,
        'users': [currentUserId, widget.receiverId],
        'userNames': {
          currentUserId: currentName,
          widget.receiverId: widget.receiverName,
        },
        'userImages': {
          currentUserId: currentImage,
          widget.receiverId: widget.receiverImage,
        },
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit)
      return const Scaffold(body: Center(child: Text("Loading...")));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: widget.receiverImage.isNotEmpty
                  ? (widget.receiverImage.startsWith('http')
                        ? NetworkImage(widget.receiverImage)
                        : NetworkImage(
                            'http://10.0.2.2:8000${widget.receiverImage}',
                          ))
                  : null,
              child: widget.receiverImage.isEmpty
                  ? const Icon(Icons.person, size: 16)
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              widget.receiverName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 155, 132),
              Color.fromARGB(255, 228, 228, 227),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .where('chatId', isEqualTo: chatId)
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "Say hi!",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(16.0),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;
                        return _buildMessageBubble(
                          context,
                          data['text'] ?? '',
                          data['senderId'] == currentUserId,
                        );
                      },
                    );
                  },
                ),
              ),
              _buildMessageInput(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isMe ? const Radius.circular(20) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
