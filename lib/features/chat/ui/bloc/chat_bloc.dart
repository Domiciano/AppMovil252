import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/chat/domain/model/message.dart';
import 'package:moviles252/features/chat/domain/model/conversation.dart';
import 'package:moviles252/features/auth/domain/usecases/who_am_i_usecase.dart';
import 'package:moviles252/features/chat/domain/usecases/find_or_create_conversation_usecase.dart';
import 'package:moviles252/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:moviles252/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:moviles252/features/profiles/data/repository/profiles_repository_impl.dart';
import 'package:moviles252/features/profiles/domain/repository/profiles_repository.dart';

// Events
abstract class ChatEvent {}

class InitializeChatEvent extends ChatEvent {
  final Profile otherUser;
  InitializeChatEvent({required this.otherUser});
}

class SendMessageEvent extends ChatEvent {
  final String content;
  SendMessageEvent({required this.content});
}

// States
abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<Message> messages;
  final Profile otherUser;
  final Conversation conversation;
  final Profile currentUser;
  ChatLoadedState({
    required this.messages,
    required this.otherUser,
    required this.conversation,
    required this.currentUser,
  });
}

class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState({required this.message});
}

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WhoAmIUseCase _whoAmIUseCase = WhoAmIUseCase();
  final FindOrCreateConversationUseCase _findOrCreateConversationUseCase =
      FindOrCreateConversationUseCase();
  final GetMessagesUseCase _getMessagesUseCase = GetMessagesUseCase();

  final ProfilesRepository repository = ProfilesRepositoryImpl();

  ChatBloc() : super(ChatInitialState()) {
    on<InitializeChatEvent>(_onInitializeChat);
    on<SendMessageEvent>(_onSendMessage);
  }

  void _onInitializeChat(
    InitializeChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    try {
      // Obtener usuario actual
      final currentUser = await _whoAmIUseCase();
      // Obtener otro usuario actual
      final otherUser = await repository.getProfileById(event.otherUser.id);

      if (currentUser == null) {
        emit(ChatErrorState(message: 'No se pudo obtener el usuario actual'));
        return;
      }
      if (otherUser == null) {
        emit(ChatErrorState(message: 'No se pudo obtener el otro usuario'));
        return;
      }
      // Crear la conversación
      var conversation = await _findOrCreateConversationUseCase.excecute(
        currentUser.id,
        event.otherUser.id,
      );
      // Cargar Mensajes
      var messages = await _getMessagesUseCase.execute(conversation.id);
      emit(
        ChatLoadedState(
          messages: messages,
          otherUser: otherUser,
          conversation: conversation,
          currentUser: currentUser,
        ),
      );
    } catch (e) {
      emit(ChatErrorState(message: 'Error al cargar el chat: $e'));
    }
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {}
}
