import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _Message {
  final String text;
  final bool isMine;
  final String sender;
  final String time;
  const _Message({
    required this.text,
    required this.isMine,
    required this.sender,
    required this.time,
  });
}

final _seedMessages = [
  _Message(
    text: "Hey everyone! Who's free this Saturday for a game?",
    isMine: false,
    sender: 'Rahul',
    time: '9:30 AM',
  ),
  _Message(
    text: "I'm in! Where are we playing?",
    isMine: false,
    sender: 'Priya',
    time: '9:32 AM',
  ),
  _Message(
    text: 'I can make it too. How about Kandivali ground?',
    isMine: true,
    sender: 'Me',
    time: '9:35 AM',
  ),
  _Message(
    text: "Perfect! Let's meet at 7 AM. Bring water!",
    isMine: false,
    sender: 'Rahul',
    time: '9:40 AM',
  ),
  _Message(text: 'Confirmed!', isMine: true, sender: 'Me', time: '9:42 AM'),
];

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<_Message> _messages = List.from(_seedMessages);

  void _send() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(
        _Message(text: text, isMine: true, sender: 'Me', time: 'now'),
      );
      _msgCtrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.surface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_rounded, color: c.textPrimary),
        ),
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.tagBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('⚽', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Volleyball in Kandivali',
                  style: TextStyle(fontFamily: 'Sora', 
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                Text(
                  '28 members',
                  style: TextStyle(fontFamily: 'Sora', 
                    fontSize: 11,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline_rounded, color: c.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _Bubble(message: _messages[i]),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            color: c.surface,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: c.inputFill,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _msgCtrl,
                      style: TextStyle(fontFamily: 'Sora', 
                        fontSize: 14,
                        color: c.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(fontFamily: 'Sora', 
                          color: c.textHint,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orange.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final _Message message;
  const _Bubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: message.isMine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!message.isMine)
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Text(
                message.sender,
                style: TextStyle(fontFamily: 'Sora', 
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: c.textSecondary,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: message.isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isMine) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.tagBlue,
                  child: Text(
                    message.sender[0],
                    style: TextStyle(fontFamily: 'Sora', 
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: c.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: message.isMine ? AppColors.orange : c.card,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(message.isMine ? 18 : 4),
                      bottomRight: Radius.circular(message.isMine ? 4 : 18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: c.shadow,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(fontFamily: 'Sora', 
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: message.isMine ? Colors.white : c.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              message.time,
              style: TextStyle(fontFamily: 'Sora', fontSize: 10, color: c.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
