import 'package:moviles252/domain/model/message.dart';
import 'package:moviles252/features/chat/domain/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
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
  Stream<Message> listenMessages(String conversationId) {
    throw Exception();
  }
}
