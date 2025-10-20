import 'dart:async';
import 'package:moviles252/domain/model/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MessageDataSource {
  Future<Message> sendMessage(
    String conversationId,
    String senderId,
    String content,
  );
  Future<List<Message>> getMessagesByConversation(String conversationId);
  Stream<Message> listenMessagesByConversation(String conversationId);
}

class MessageDataSourceImpl extends MessageDataSource {
  @override
  Future<Message> sendMessage(
    String conversationId,
    String senderId,
    String content,
  ) async {
    throw Exception();
  }

  @override
  Future<List<Message>> getMessagesByConversation(String conversationId) async {
    throw Exception();
  }

  @override
  Stream<Message> listenMessagesByConversation(String conversationId) {
    throw Exception();
  }
}
