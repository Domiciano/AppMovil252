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

  @override
  Stream<Message> listenMessagesByConversation(String conversationId) {
    print("Listening messages ...");
    final controller = StreamController<Message>();
    final channel = Supabase.instance.client
        .channel('public:messages')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            controller.add(Message.fromJson(payload.newRecord));
            print(payload.newRecord);
          },
        )
        .subscribe();
    controller.onCancel = () {
      Supabase.instance.client.removeChannel(channel);
    };
    return controller.stream;
  }
}
