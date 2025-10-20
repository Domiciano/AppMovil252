import 'package:moviles252/domain/model/conversation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ConversationDataSource {
  Future<Conversation?> findConversation(String profile1Id, String profile2Id);
  Future<Conversation> createConversation(String profile1Id, String profile2Id);
}

class ConversationDataSourceImpl extends ConversationDataSource {
  @override
  Future<Conversation?> findConversation(
    String profile1Id,
    String profile2Id,
  ) async {
    throw Exception();
  }

  @override
  Future<Conversation> createConversation(
    String profile1Id,
    String profile2Id,
  ) async {
    throw Exception();
  }
}
