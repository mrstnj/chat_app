import 'package:chatapp/src/viewmodels/loading_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../uistates/ai_message_ui_state.dart';
import '../services/ai_chat_service.dart';

part 'ai_message_view_model.g.dart';

@riverpod
class AiMessageViewModel extends _$AiMessageViewModel {
  @override
  List<AiMessage> build() {
    return const <AiMessage>[];
  }

  void addMessage(AiMessage message) {
    state = [...state, message];
  }

  void updateLastMessage(AiMessage message) {
    state = [...state.sublist(0, state.length - 1), message];
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    final loadingViewModel = ref.read(loadingViewModelProvider.notifier);
    final chatService = ref.read(aiChatServiceProvider);

    loadingViewModel.setLoading(true);

    addMessage(
      AiMessage(
        message: message,
        sendTime: DateTime.now(),
        fromChatGpt: false,
      ),
    );

    addMessage(
      AiMessage(
        message: '',
        sendTime: DateTime.now(),
        fromChatGpt: true,
      ),
    );

    try {
      final response = await chatService.sendMessage(message);
      updateLastMessage(
        AiMessage(
          message: response.trim(),
          sendTime: DateTime.now(),
          fromChatGpt: true,
        ),
      );
    } catch (e) {
      updateLastMessage(
        AiMessage(
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
