import 'package:moviles252/features/chat/data/repository/message_repository_impl.dart';
import 'package:moviles252/features/chat/domain/model/message.dart';
import 'package:moviles252/features/chat/domain/repository/message_repository.dart';

class SendMessageUseCase {
  final MessageRepository _repository = MessageRepositoryImpl();

  Future<Message> call(
    String conversationId,
    String senderId,
    String content,
  ) async {
    return await _repository.sendMessage(conversationId, senderId, content);
  }
}
