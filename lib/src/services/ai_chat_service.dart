import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../config/api_key.dart';

part 'ai_chat_service.g.dart';

@riverpod
AiChatService aiChatService(Ref ref) => AiChatService();

class AiChatService {
  final openAI = OpenAI.instance.build(
    token: writeYourOpenAPIKey,
    enableLog: true,
  );

  Future<String> sendMessage(String message) async {
    final request = CompleteText(
        prompt: message, model: Gpt3TurboInstruct(), maxTokens: 200);

    final response = await openAI.onCompletion(request: request);
    return response!.choices.first.text;
  }
}
