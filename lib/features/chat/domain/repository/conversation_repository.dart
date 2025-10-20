import 'package:moviles252/domain/model/conversation.dart';

abstract class ConversationRepository {
  Future<Conversation> findOrCreateConversation(
    String profile1Id,
    String profile2Id,
  );
}
