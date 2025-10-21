import 'package:moviles252/domain/model/conversation.dart';
import 'package:moviles252/features/chat/data/source/conversation_data_source.dart';
import 'package:moviles252/features/chat/domain/repository/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDataSource _conversationDataSource =
      ConversationDataSourceImpl();

  @override
  Future<Conversation> findOrCreateConversation(
    String profile1Id,
    String profile2Id,
  ) async {
    Conversation? conversation = await _conversationDataSource.findConversation(
      profile1Id,
      profile2Id,
    );
    if (conversation != null) {
      return conversation;
    } else {
      return await _conversationDataSource.createConversation(
        profile1Id,
        profile2Id,
      );
    }
  }
}
