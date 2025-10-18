import 'package:moviles252/features/chat/data/repository/message_repository_impl.dart';
import 'package:moviles252/features/chat/domain/model/message.dart';
import 'package:moviles252/features/chat/domain/repository/message_repository.dart';

class GetMessagesUseCase {
  final MessageRepository _repository = MessageRepositoryImpl();

  Future<List<Message>> execute(String conversationId) async {
    return await _repository.getMessagesByConversation(conversationId);
  }
}
