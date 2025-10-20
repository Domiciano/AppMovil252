import 'package:moviles252/features/chat/data/repository/conversation_repository_impl.dart';
import 'package:moviles252/domain/model/conversation.dart';
import 'package:moviles252/features/chat/domain/repository/conversation_repository.dart';

class FindOrCreateConversationUseCase {
  final ConversationRepository _repository = ConversationRepositoryImpl();

  Future<Conversation> excecute(String profile1Id, String profile2Id) async {
    return await _repository.findOrCreateConversation(profile1Id, profile2Id);
  }
}
