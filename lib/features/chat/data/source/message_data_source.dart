import 'package:moviles252/features/chat/domain/model/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MessageDataSource {
  Future<Message> sendMessage(
    String conversationId,
    String senderId,
    String content,
  );
  Future<List<Message>> getMessagesByConversation(String conversationId);
}

class MessageDataSourceImpl extends MessageDataSource {
  @override
  Future<Message> sendMessage(
    String conversationId,
    String senderId,
    String content,
  ) async {
    final now = DateTime.now();
    final message = Message(
      id: '', // Se generará en Supabase
      conversationId: conversationId,
      senderId: senderId,
      content: content,
      createdAt: now,
    );

    final response = await Supabase.instance.client
        .from("messages")
        .insert(message.toJson())
        .select()
        .single();

    return Message.fromJson(response);
  }

  @override
  Future<List<Message>> getMessagesByConversation(String conversationId) async {
    final response = await Supabase.instance.client
        .from("messages")
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);

    return (response as List).map((json) => Message.fromJson(json)).toList();
  }
}
