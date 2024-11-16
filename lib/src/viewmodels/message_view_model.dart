import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../uistates/message_ui_state.dart';

part 'message_view_model.g.dart';

final getAllMessagesProvider = FutureProvider<List<Message>>((ref) async {
  final dio = Dio();
  try {
    final response =
        await dio.get<List<dynamic>>("http://10.0.2.2:3000/get_messages/v1");
    final List<Message> messages = (response.data as List<dynamic>).map((item) {
      return Message.fromJson(item);
    }).toList();
    return messages;
  } catch (e) {
    throw Exception('エラーが発生しました');
  }
});

final webSocketProvider = Provider<WebSocketChannel>((ref) {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:3000/ws'),
  );

  ref.onDispose(() {
    channel.sink.close(status.goingAway);
  });

  return channel;
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

    final webSocket = ref.read(webSocketProvider);
    webSocket.stream.listen((event) {
      try {
        final data = Message.fromJson(event);
        addMessage(data);
      } catch (e) {
        print('WebSocketデータの処理に失敗: $e');
      }
    });

    return const <Message>[];
  }

  void addMessage(Message message) {
    state = [...state, message];
  }

  void updateLastMessage(Message message) {
    state = [...state.sublist(0, state.length - 1), message];
  }

  void sendMessage(String message, String sendUser) {
    final webSocket = ref.read(webSocketProvider);
    final data = {
      "action": "sendMessage",
      "data": {
        "send_user": sendUser,
        "message": message,
      },
    };

    try {
      webSocket.sink.add(data);
    } catch (e) {
      print('メッセージ送信に失敗: $e');
    }
  }
}