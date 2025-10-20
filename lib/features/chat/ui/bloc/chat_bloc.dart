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
abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {}

class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState({required this.message});
}

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    on<InitializeChatEvent>(_onInitializeChat);
    on<SendMessageEvent>(_onSendMessage);
    on<ChatNewMessageArriveEvent>(_onMessageArrived);
  }

  void _onMessageArrived(
    ChatNewMessageArriveEvent event,
    Emitter<ChatState> emit,
  ) {
    throw Exception();
  }

  void _onInitializeChat(
    InitializeChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    throw Exception();
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    throw Exception();
  }
}
