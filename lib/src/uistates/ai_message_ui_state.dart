import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_message_ui_state.freezed.dart';

@freezed
class AiMessage with _$AiMessage {
  const factory AiMessage({
    required String message,
    required DateTime sendTime,
    required bool fromChatGpt,
  }) = _AiMessage;
}