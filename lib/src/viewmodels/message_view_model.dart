import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../uistates/message_ui_state.dart';

part 'message_view_model.g.dart';

final getAllMessagesProvider = FutureProvider<List<Message>>((ref) async {
  final dio = Dio();
  try {
    final response = await dio.get<List<dynamic>>("http://10.0.2.2:3000/get_messages/v1");
    final List<Message> messages = (response.data as List<dynamic>).map((item) {
      return Message.fromJson(item);
    }).toList();
    return messages;   
  } catch (e) {
    throw Exception('エラーが発生しました');
  }
});

@riverpod
class MessageViewModel extends _$MessageViewModel {
  @override
  List<Message> build() {
    ref.listen(getAllMessagesProvider, (previous, next) {
      next.whenData((messages) {
        state = messages;
      });
    });
    return const <Message>[];
  }

  void addMessage(Message message) {
    state = [...state, message];
  }

  void updateLastMessage(Message message) {
    state = [...state.sublist(0, state.length - 1), message];
  }
}