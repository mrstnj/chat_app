import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'api_key.dart';

void main() {
  runApp(MyApp());
}

class Message {
  const Message(
    this.message,
    this.sendTime, {
    required this.fromChatGpt,
  });
  final String message;
  final bool fromChatGpt;
  final DateTime sendTime;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final openAI = OpenAI.instance.build(
    token: writeYourOpenAPIKey,
    enableLog: true,
  );

  final _textEditingController = TextEditingController();
  var _answer = '';

  final _messages = <Message>[
    Message("お疲れ様！今日はどうだった？", DateTime(2024, 10, 23, 0, 0), fromChatGpt: false),
    Message("お疲れ様！今日はちょっとバタバタしてたけど、無事終わったよ。", DateTime(2024, 10, 23, 1, 0),
        fromChatGpt: true),
    Message("おー、よかったね！仕事終わりになんか予定あるの？", DateTime(2024, 10, 23, 2, 0),
        fromChatGpt: false),
    Message("特にないかなー。家でNetflixでも見ようかなって。", DateTime(2024, 10, 23, 3, 0),
        fromChatGpt: true),
    Message("Netflixいいね！最近面白いのあった？", DateTime(2024, 10, 23, 4, 0),
        fromChatGpt: false),
    Message("「ワンピース」の実写版見たけど、思ったより良かったよ！", DateTime(2024, 10, 23, 5, 0),
        fromChatGpt: true),
    Message("マジ？原作ファンだからちょっと不安だったんだけど、見る価値ある？", DateTime(2024, 10, 23, 6, 0),
        fromChatGpt: false),
    Message("あると思う！設定も忠実だし、キャストも結構頑張ってる感じ。", DateTime(2024, 10, 23, 7, 0),
        fromChatGpt: true),
    Message("じゃあ、週末に見てみようかな。おすすめありがとう！", DateTime(2024, 10, 23, 8, 0),
        fromChatGpt: false),
    Message("ぜひぜひ！感想も聞かせてねー。", DateTime(2024, 10, 23, 9, 0),
        fromChatGpt: true),
  ];

  // static Color colorBackground = Color.fromARGB(0xFF, 0x90, 0xac, 0xd7);
  // static Color colorMyMessage = Color.fromARGB(0xFF, 0x8a, 0xe1, 0x7e);
  // static Color colorOthersMessage = Color.fromARGB(0xFF, 0xff, 0xff, 0xff);
  // static Color colorTime = Color.fromARGB(0xFF, 0x72, 0x88, 0xa8);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CircleAvatar(radius: 16, child: Icon(Icons.add)),
                      ConstrainedBox(
                        constraints:
                          BoxConstraints(maxWidth: deviceWidth * 0.7),
                        child: Text(_messages[index].message)
                      ),
                      Text('午前12:00')
                    ],
                  );
                })
              ),
            Row(children: [
              Expanded(child: TextField(controller: _textEditingController)),
              IconButton(
                  onPressed: () async {
                    final answer =
                        await _sendMessage(_textEditingController.text);
                    setState(() {
                      _answer = answer;
                    });
                  },
                  icon: Icon(Icons.send)),
            ]),
            Text(_answer),
          ],
        ),
      ),
    );
  }

  Future<String> _sendMessage(String message) async {
    final request = CompleteText(
        prompt: message, model: Gpt3TurboInstruct(), maxTokens: 200);

    final response = await openAI.onCompletion(request: request);
    return response!.choices.first.text;
  }
}
