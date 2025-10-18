import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviles252/domain/model/profile.dart';
import 'package:moviles252/features/chat/domain/model/message.dart';

// Events
abstract class ChatEvent {}

class LoadChatEvent extends ChatEvent {
  final Profile otherUser;
  LoadChatEvent({required this.otherUser});
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
  ChatLoadedState({required this.messages, required this.otherUser});
}

class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState({required this.message});
}

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    on<LoadChatEvent>(_onLoadChat);
    on<SendMessageEvent>(_onSendMessage);
  }

  void _onLoadChat(LoadChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());

    try {
      // Datos dummy de mensajes para mostrar la funcionalidad
      final dummyMessages = [
        Message(
          id: '1',
          senderId: 'current_user',
          receiverId: event.otherUser.id,
          content: 'Hola! ¿Cómo estás?',
          timestamp: DateTime.now().subtract(Duration(hours: 2)),
          isRead: true,
        ),
        Message(
          id: '2',
          senderId: event.otherUser.id,
          receiverId: 'current_user',
          content: '¡Hola! Todo bien, gracias por preguntar. ¿Y tú?',
          timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 45)),
          isRead: true,
        ),
        Message(
          id: '3',
          senderId: 'current_user',
          receiverId: event.otherUser.id,
          content:
              'Muy bien también, gracias. ¿Qué planes tienes para el fin de semana?',
          timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
          isRead: true,
        ),
        Message(
          id: '4',
          senderId: event.otherUser.id,
          receiverId: 'current_user',
          content:
              'Pensaba ir al cine con unos amigos. ¿Te gustaría acompañarnos?',
          timestamp: DateTime.now().subtract(Duration(minutes: 45)),
          isRead: true,
        ),
        Message(
          id: '5',
          senderId: 'current_user',
          receiverId: event.otherUser.id,
          content: '¡Me encantaría! ¿A qué película van a ver?',
          timestamp: DateTime.now().subtract(Duration(minutes: 30)),
          isRead: false,
        ),
      ];

      emit(
        ChatLoadedState(messages: dummyMessages, otherUser: event.otherUser),
      );
    } catch (e) {
      emit(ChatErrorState(message: 'Error al cargar el chat: $e'));
    }
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    if (state is ChatLoadedState) {
      final currentState = state as ChatLoadedState;

      // Crear nuevo mensaje
      final newMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: 'current_user',
        receiverId: currentState.otherUser.id,
        content: event.content,
        timestamp: DateTime.now(),
        isRead: false,
      );

      // Agregar el mensaje a la lista
      final updatedMessages = List<Message>.from(currentState.messages)
        ..add(newMessage);

      emit(
        ChatLoadedState(
          messages: updatedMessages,
          otherUser: currentState.otherUser,
        ),
      );
    }
  }
}
