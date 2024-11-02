import 'package:chatapp/src/viewmodels/loading_view_model.dart';
import 'package:chatapp/src/viewmodels/message_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

final _scrollController = ScrollController();
void _ScrollDown() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 500),
        curve: Curves.fastOutSlowIn);
  });
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMessages = ref.watch(getAllMessagesProvider);
    print(asyncMessages);
    // final messageViewModel = ref.read(messageViewModelProvider.notifier);
    final messages = ref.watch(messageViewModelProvider);
    final isLoading = ref.watch(loadingViewModelProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    final _textEditingController = TextEditingController();

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
        title: const Text('Person'),
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
                          mainAxisAlignment: message.fromOthers
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message.fromOthers)
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
                                if (!message.fromOthers)
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
                                      color: message.fromOthers
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
                                if (message.fromOthers)
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
                              // messageViewModel.sendMessage(message);
                              _ScrollDown();
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
}
