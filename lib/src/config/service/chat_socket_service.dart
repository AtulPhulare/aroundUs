import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../features/chat/models/message_model.dart';

class ChatSocketService {
  io.Socket? _socket;
  String Function() getToken;
  String baseUrl;
  String? _currentConversationId;
  ChatSocketService({required this.getToken, required this.baseUrl});

  bool get isConnected => _socket?.connected ?? false;

  final StreamController<Message> _newMessageController =
      StreamController<Message>.broadcast();
  Stream<Message> get newMessageStream => _newMessageController.stream;

  final StreamController<Map<String, dynamic>> _errorController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get errorStream => _errorController.stream;

  final StreamController<Map<String, dynamic>> _messagesDeletedController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get messagesDeletedStream =>
      _messagesDeletedController.stream;

  final StreamController<Map<String, dynamic>> _deleteSuccessController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get deleteSuccessStream =>
      _deleteSuccessController.stream;

  final StreamController<Map<String, dynamic>> _typingController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get typingStream => _typingController.stream;

  final StreamController<Map<String, dynamic>> _userStatusController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get userStatusStream =>
      _userStatusController.stream;

  final StreamController<Map<String, dynamic>> _leftConversationController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get leftConversationStream =>
      _leftConversationController.stream;
  void connect() {
    if (_socket?.connected == true) return;

    final token = getToken();
    if (token.isEmpty) {
      _errorController.add({'code': 'AUTH_REQUIRED', 'message': 'No token'});
      return;
    }

    _socket = io.io(
      baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': token})
          .build(),
    );

    _registerListeners();

    _socket!.connect();
  }

  void _registerListeners() {
    _socket!.onConnect((_) {
      if (_currentConversationId != null) {
        _socket!.emit('join_conversation', {
          'conversationId': _currentConversationId,
        });
      }
    });
    _socket!.onDisconnect((_) {});

    _socket!.onConnectError((err) {
      _errorController.add({'message': err.toString()});
    });

    _socket!.on('error', (data) {
      final map = data is Map
          ? Map<String, dynamic>.from(data)
          : {'message': data.toString()};
      _errorController.add(map);
    });

    _socket!.on('new_message', (data) {
      final map = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
      _newMessageController.add(Message.fromJson(map));
    });

    _socket!.on('messages_deleted', (data) {
      final map = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
      _messagesDeletedController.add(map);
    });

    _socket!.on('delete_multiple_messages_success', (data) {
      final map = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
      _deleteSuccessController.add(map);
    });

    _socket!.on('user_typing', (data) {
      final map = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
      _typingController.add(map);
    });

    _socket!.on('user_status_changed', (data) {
      final map = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
      _userStatusController.add(map);
    });

    _socket!.on('left_conversation', (data) {
      final map = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
      _leftConversationController.add(map);
    });
  }

  void joinConversation(String conversationId) {
    if (_socket?.connected != true) return;

    _currentConversationId = conversationId;

    _socket!.emit('join_conversation', {'conversationId': conversationId});
  }

  void leaveConversation(String conversationId) {
    if (_socket?.connected != true) return;
    _socket!.emit('leave_conversation', {'conversationId': conversationId});
  }

  void sendMessage(
    String conversationId,
    String message, {
    String messageType = 'text',
  }) {
    if (_socket?.connected != true) {
      return;
    }
    _socket!.emit('send_message', {
      'conversationId': conversationId,
      'message': message,
      'message_type': messageType,
    });
  }

  void deleteMultipleMessages(String conversationId, List<String> messageIds) {
    if (_socket?.connected != true) return;
    _socket!.emit('delete_multiple_messages', {
      'conversationId': conversationId,
      'messageIds': messageIds,
    });
  }

  void setTyping(String conversationId, bool isTyping) {
    if (_socket?.connected != true) return;
    _socket!.emit('typing', {
      'conversationId': conversationId,
      'isTyping': isTyping,
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }

  void dispose() {
    disconnect();
    _newMessageController.close();
    _errorController.close();
    _messagesDeletedController.close();
    _deleteSuccessController.close();
    _typingController.close();
    _userStatusController.close();
    _leftConversationController.close();
  }
}
