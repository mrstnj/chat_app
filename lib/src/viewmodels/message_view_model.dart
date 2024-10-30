import 'package:chatapp/src/viewmodels/loading_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../uistates/message_ui_state.dart';
import '../services/ai_chat_service.dart';

part 'message_view_model.g.dart';

@riverpod
class MessageViewModel extends _$MessageViewModel {
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

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    final loadingViewModel = ref.read(loadingViewModelProvider.notifier);
    final chatService = ref.read(aiChatServiceProvider);

    loadingViewModel.setLoading(true);

    addMessage(
      Message(
        message: message,
        sendTime: DateTime.now(),
        fromChatGpt: false,
      ),
    );

    addMessage(
      Message(
        message: '',
        sendTime: DateTime.now(),
        fromChatGpt: true,
      ),
    );

    try {
      final response = await chatService.sendMessage(message);
      updateLastMessage(
        Message(
          message: response.trim(),
          sendTime: DateTime.now(),
          fromChatGpt: true,
        ),
      );
    } catch (e) {
      updateLastMessage(
        Message(
          message: "Error: Unable to get response",
          sendTime: DateTime.now(),
          fromChatGpt: true,
        ),
      );
    } finally {
      loadingViewModel.setLoading(false);
    }
  }
}