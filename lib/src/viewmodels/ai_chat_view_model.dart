import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../uistates/message_ui_state.dart';
import '../services/ai_chat_service.dart';

part 'ai_chat_view_model.g.dart';

@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  List<Message> build() {
    return const <Message>[];
  }

  void addMessage(Message message) {
    state = [...state, message];
  }

  void updateLastMessage(Message message) {
    state = [...state.sublist(0, state.length - 1), message];
  }
}

@riverpod
class ChatState extends _$ChatState {
  @override
  bool build() => false;

  void setLoading(bool loading) {
    state = loading;
  }
}

@riverpod
Future<void> sendMessage(
  Ref ref,
  String message,
) async {
  if (message.trim().isEmpty) return;

  final messagesNotifier = ref.read(chatMessagesProvider.notifier);
  final chatStateNotifier = ref.read(chatStateProvider.notifier);
  final chatService = ref.read(aiChatServiceProvider);

  chatStateNotifier.setLoading(true);

  messagesNotifier.addMessage(
    Message(
      message: message,
      sendTime: DateTime.now(),
      fromChatGpt: false,
    ),
  );
  messagesNotifier.addMessage(
    Message(
      message: '',
      sendTime: DateTime.now(),
      fromChatGpt: true,
    ),
  );

  try {
    final response = await chatService.sendMessage(message);
    messagesNotifier.updateLastMessage(
      Message(
        message: response.trim(),
        sendTime: DateTime.now(),
        fromChatGpt: true,
      ),
    );
  } catch (e) {
    messagesNotifier.updateLastMessage(
      Message(
        message: "Error: Unable to get response",
        sendTime: DateTime.now(),
        fromChatGpt: true,
      ),
    );
  } finally {
    chatStateNotifier.setLoading(false);
  }
}
