import 'package:moviles252/domain/model/conversation.dart';
import 'package:moviles252/features/chat/domain/repository/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  @override
  Future<Conversation> findOrCreateConversation(
    String profile1Id,
    String profile2Id,
  ) async {
    throw Exception();
  }
}
