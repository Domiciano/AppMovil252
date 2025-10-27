import 'package:moviles252/domain/model/message.dart';
import 'package:moviles252/features/chat/data/source/message_data_source.dart';
import 'package:moviles252/features/chat/domain/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageDataSource _messageDataSource = MessageDataSourceImpl();

  @override
  Future<Message> sendMessage(
    String conversationId,
    String senderId,
    String content,
  ) async {
    return await _messageDataSource.sendMessage(
      conversationId,
      senderId,
      content,
    );
  }

  @override
  Future<List<Message>> getMessagesByConversation(String conversationId) async {
    return await _messageDataSource.getMessagesByConversation(conversationId);
  }

  @override
  Stream<Message> listenMessages(String conversationId) {
    return _messageDataSource.listenMessagesByConversation(conversationId);
  }
}
