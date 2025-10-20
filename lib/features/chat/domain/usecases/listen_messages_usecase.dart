import 'package:moviles252/domain/model/message.dart';
import 'package:moviles252/features/chat/data/repository/message_repository_impl.dart';
import 'package:moviles252/features/chat/domain/repository/message_repository.dart';

class ListenMessagesUsecase {
  final MessageRepository messageRepository = MessageRepositoryImpl();

  Stream<Message> excecute(String conversationId) {
    return messageRepository.listenMessages(conversationId);
  }
}
