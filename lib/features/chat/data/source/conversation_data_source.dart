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
    try {
      final response = await Supabase.instance.client
          .from('conversations')
          .select()
          .or(
            'and(profile1_id.eq.$profile1Id,profile2_id.eq.$profile2Id),and(profile1_id.eq.$profile2Id,profile2_id.eq.$profile1Id)',
          )
          .maybeSingle();
      print(response);
      if (response != null) {
        return Conversation.fromJson(response);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Conversation> createConversation(
    String profile1Id,
    String profile2Id,
  ) async {
    final now = DateTime.now();
    final conversation = Conversation(
      id: '',
      profile1Id: profile1Id,
      profile2Id: profile2Id,
      createdAt: now,
    );

    final response = await Supabase.instance.client
        .from("conversations")
        .insert(conversation.toJson())
        .select()
        .single();

    return Conversation.fromJson(response);
  }
}
