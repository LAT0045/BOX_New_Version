import 'dart:convert';

class Message {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String messageContent;
  final int timestamp;

  Message({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.messageContent,
    required this.timestamp,
  });

  factory Message.fromMap(String messageId, Map<dynamic, dynamic> map) {
    return Message(
      messageId: messageId,
      senderId: map['senderID'] ?? "",
      receiverId: map['receiverID'] ?? "",
      messageContent: map['message'] ?? "",
      timestamp: map['timestamp'] ?? 0,
    );
  }
  @override
  String toString() {
    return 'Message: {Message ID: $messageId, '
        'Sender ID: $senderId, '
        'Receiver ID: $receiverId, '
        'Message Content: $messageContent, '
        'Timestamp: $timestamp}\n';
  }
}