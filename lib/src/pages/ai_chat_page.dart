import 'package:chatapp/src/viewmodels/ai_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../uistates/message_ui_state.dart';

class AiChatPage extends StatelessWidget {
  const AiChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatMessagesProvider);
    final isLoading = ref.watch(chatStateProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    final _textEditingController = TextEditingController();
    final _scrollController = ScrollController();

    final Color colorMyMessage = Color.fromARGB(0xFF, 0x8a, 0xe1, 0x7e);
    final Color colorOthersMessage = Color.fromARGB(0xFF, 0xff, 0xff, 0xff);
    final Color colorTime = Color.fromARGB(0xFF, 0x72, 0x88, 0xa8);
    final Color colorAvator = Color.fromARGB(0xFF, 0x76, 0x5a, 0x44);
    final Color colorInput = Color.fromARGB(0xFF, 0xff, 0xff, 0xff);

    String _formatDateTime(DateTime dateTime) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('chatGPT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final showLoadingIcon =
                          isLoading && index == messages.length - 1;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: message.fromChatGpt
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message.fromChatGpt)
                              SizedBox(
                                  width: deviceWidth * 0.1,
                                  child: CircleAvatar(
                                      backgroundColor: colorAvator,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.asset(
                                            'assets/images/openai.png'),
                                      ))),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!message.fromChatGpt)
                                  Text(
                                    _formatDateTime(message.sendTime),
                                    style: TextStyle(color: colorTime),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: deviceWidth * 0.7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: message.fromChatGpt
                                          ? colorOthersMessage
                                          : colorMyMessage,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: showLoadingIcon
                                          ? const CircularProgressIndicator()
                                          : Text(
                                              message.message,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                    ),
                                  ),
                                ),
                                if (message.fromChatGpt)
                                  Text(
                                    _formatDateTime(message.sendTime),
                                    style: TextStyle(color: colorTime),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    })),
            Container(
              color: Colors.white,
              child: Row(children: [
                Expanded(
                    child: TextField(
                        style: TextStyle(fontSize: 14),
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            fillColor: colorInput,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32))))),
                IconButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            final message = _textEditingController.text;
                            if (message.trim().isNotEmpty) {
                              _textEditingController.clear();
                              // ref
                              //     .read(chatStateProvider.notifier)
                              //     .setLoading(true);
                              ref
                                  .read(chatMessagesProvider.notifier)
                                  .addMessage(
                                    Message(
                                      message: message,
                                      sendTime: DateTime.now(),
                                      fromChatGpt: false,
                                    ),
                                  );
                              ref
                                  .read(chatMessagesProvider.notifier)
                                  .addMessage(
                                    Message(
                                      message: '',
                                      sendTime: DateTime.now(),
                                      fromChatGpt: true,
                                    ),
                                  );
                              ref.read(sendMessageProvider(message));
                            }
                          },
                    icon: Icon(Icons.send,
                        color: isLoading ? Colors.grey : Colors.black)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // void _onTapSend(String userMessage){
  //   setState(() {
  //     _isLoading = true;
  //     _messages.addAll([
  //       Message(userMessage, DateTime.now(), fromChatGpt: false),
  //       Message.waitResponse(DateTime.now())
  //     ]);
  //   });

  //   _sendMessage(userMessage).then((chatGptMessage){
  //     setState(() {
  //       _messages.last = Message(chatGptMessage.trim(), DateTime.now(), fromChatGpt: true);
  //       _isLoading = false;
  //     });
  //     _ScrollDown();
  //   });
  // }

  // void _ScrollDown(){
  //   WidgetsBinding.instance.addPostFrameCallback((_){
  //     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //       duration: const Duration(microseconds: 500),
  //       curve: Curves.fastOutSlowIn);
  //   });
  // }
}
