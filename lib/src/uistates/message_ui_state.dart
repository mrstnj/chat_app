import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_ui_state.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String message,
    required DateTime sendTime,
    required bool fromChatGpt,
  }) = _Message;
}