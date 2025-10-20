import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/chat/data/source/message_data_source.dart';
import 'package:moviles252/domain/model/message.dart';
import 'package:moviles252/domain/model/conversation.dart';
import 'package:moviles252/features/auth/domain/usecases/who_am_i_usecase.dart';
import 'package:moviles252/features/chat/domain/usecases/find_or_create_conversation_usecase.dart';
import 'package:moviles252/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:moviles252/features/chat/domain/usecases/listen_messages_usecase.dart';
import 'package:moviles252/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:moviles252/features/profiles/data/repository/profiles_repository_impl.dart';
import 'package:moviles252/features/profiles/domain/repository/profiles_repository.dart';
import 'package:moviles252/features/profiles/domain/usecases/get_profile_by_id.dart';

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

class ChatNewMessageArriveEvent extends ChatEvent {
  final Message message;
  ChatNewMessageArriveEvent({required this.message});
}

// States
abstract class ChatState {
  final Conversation? conversation;
  final String? meId;
  final String? otherId;
  final List<Message> messages;
  ChatState({
    this.messages = const [],
    this.conversation,
    this.meId,
    this.otherId,
  });
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  ChatLoadedState({
    required super.messages,
    super.conversation,
    super.meId,
    super.otherId,
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
  final SendMessageUseCase sendMessageUseCase = SendMessageUseCase();
  final GetProfileById getProfileById = GetProfileById();
  final ListenMessagesUsecase listenMessagesUsecase = ListenMessagesUsecase();

  final MessageDataSourceImpl source = MessageDataSourceImpl();

  ChatBloc() : super(ChatInitialState()) {
    on<InitializeChatEvent>(_onInitializeChat);
    on<SendMessageEvent>(_onSendMessage);
    on<ChatNewMessageArriveEvent>(_onMessageArrived);
  }

  void _onMessageArrived(
    ChatNewMessageArriveEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(
      ChatLoadedState(
        messages: [...state.messages, event.message],
        conversation: state.conversation,
        meId: state.meId,
        otherId: state.otherId,
      ),
    );
  }

  void _onInitializeChat(
    InitializeChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    try {
      // Obtener usuario actual
      Profile? currentUser = await _whoAmIUseCase();

      // Obtener otro usuario actual
      Profile? otherUser = await getProfileById.excecute(event.otherUser.id);

      if (currentUser == null) {
        emit(ChatErrorState(message: 'No se pudo obtener el usuario actual'));
        return;
      }
      if (otherUser == null) {
        emit(ChatErrorState(message: 'No se pudo obtener el otro usuario'));
        return;
      }
      // Cargar o Crear la conversación
      var conversation = await _findOrCreateConversationUseCase.excecute(
        currentUser.id,
        event.otherUser.id,
      );
      // Cargar Mensajes
      var messages = await _getMessagesUseCase.execute(conversation.id);
      emit(
        ChatLoadedState(
          messages: messages,
          conversation: conversation,
          meId: currentUser.id,
          otherId: otherUser.id,
        ),
      );
      //Escuchar nuevos mensajes
      listenMessagesUsecase.excecute(conversation.id).listen((msg) {
        add(ChatNewMessageArriveEvent(message: msg));
      });
    } catch (e) {
      emit(ChatErrorState(message: 'Error al cargar el chat: $e'));
    }
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    sendMessageUseCase.execute(
      state.conversation!.id,
      state.meId!,
      event.content,
    );
  }
}
