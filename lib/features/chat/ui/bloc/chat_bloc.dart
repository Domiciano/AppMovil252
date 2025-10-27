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
  final List<Message> messages;
  final String? meId;
  final String? otherId;
  final String? conversation;
  ChatState({
    this.messages = const [],
    this.meId,
    this.otherId,
    this.conversation,
  });
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  ChatLoadedState({
    super.messages,
    super.meId,
    super.otherId,
    super.conversation,
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
  final SendMessageUseCase _sendMessageUseCase = SendMessageUseCase();
  final ListenMessagesUsecase _listenMessagesUsecase = ListenMessagesUsecase();

  ChatBloc() : super(ChatInitialState()) {
    on<InitializeChatEvent>(_onInitializeChat);
    on<SendMessageEvent>(_onSendMessage);
    on<ChatNewMessageArriveEvent>(_onMessageArrived);
  }

  void _onMessageArrived(
    ChatNewMessageArriveEvent event,
    Emitter<ChatState> emit,
  ) {
    var currentState = state;
    emit(
      ChatLoadedState(
        messages: [...currentState.messages, event.message],
        meId: currentState.meId,
        otherId: currentState.otherId,
        conversation: currentState.conversation,
      ),
    );
  }

  void _onInitializeChat(
    InitializeChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoadingState());
    var me = await _whoAmIUseCase.call();
    if (me == null) {
      print("Current user no existe");
      return;
    }
    Conversation conversation = await _findOrCreateConversationUseCase.excecute(
      me.id,
      event.otherUser.id,
    );
    print(conversation);
    var messages = await _getMessagesUseCase.execute(conversation.id);
    emit(
      ChatLoadedState(
        messages: messages,
        meId: me.id,
        otherId: event.otherUser.id,
        conversation: conversation.id,
      ),
    );
    //Listen to new messages
    Stream<Message> stream = _listenMessagesUsecase.excecute(conversation.id);
    stream.listen((data) {
      add(ChatNewMessageArriveEvent(message: data));
    });
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    _sendMessageUseCase.execute(
      state.conversation!,
      state.meId!,
      event.content,
    );
  }
}
