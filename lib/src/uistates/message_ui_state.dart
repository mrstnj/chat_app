import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_ui_state.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String message,
    required DateTime sendTime,
    required bool fromOthers,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'] as String,
      fromOthers: json['from_others'],
      sendTime: DateTime.parse(json['send_time'] as String),
    );
  }
}
