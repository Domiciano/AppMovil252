import 'package:moviles252/features/chat/domain/model/message.dart';

abstract class MessageRepository {
  Future<Message> sendMessage(
    String conversationId,
    String senderId,
    String content,
  );
  Future<List<Message>> getMessagesByConversation(String conversationId);
}
