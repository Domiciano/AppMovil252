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
    var message = await Supabase.instance.client
        .from("messages")
        .insert({
          "conversation_id": conversationId,
          "sender_id": senderId,
          "content": content,
        })
        .select()
        .single();
    return Message.fromJson(message);
  }

  @override
  Future<List<Message>> getMessagesByConversation(String conversationId) async {
    var list = await Supabase.instance.client
        .from("messages")
        .select()
        .eq("conversation_id", conversationId)
        .order("created_at", ascending: true);
    return list.map((json) => Message.fromJson(json)).toList();
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
            print("++++++++++++++++");
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
