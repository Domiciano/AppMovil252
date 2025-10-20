import 'package:moviles252/domain/model/conversation.dart';
import 'package:moviles252/features/chat/domain/repository/conversation_repository.dart';
import 'package:moviles252/features/chat/data/source/conversation_data_source.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDataSource _dataSource = ConversationDataSourceImpl();

  @override
  Future<Conversation> findOrCreateConversation(
    String profile1Id,
    String profile2Id,
  ) async {
    var conversation = await _dataSource.findConversation(
      profile1Id,
      profile2Id,
    );
    if (conversation == null) {
      return _dataSource.createConversation(profile1Id, profile2Id);
    } else {
      return conversation;
    }
  }
}
