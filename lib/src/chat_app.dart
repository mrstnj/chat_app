import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chatapp/src/pages/ai_chat_page.dart';
import 'package:chatapp/src/pages/chat_page.dart';
import 'package:chatapp/src/routers/page.dart' as router;

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    redirect: (BuildContext context, GoRouterState state) {
      return router.Page.aiChatPage.path;
    },
  ),
  GoRoute(
    path: router.Page.aiChatPage.path,
    builder:  (context, state) => const AiChatPage(),  
  ),
  GoRoute(
    path: router.Page.chatPage.path,
    builder:  (context, state) => const ChatPage(),  
  )
]);

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'チャットアプリ',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(0xFF, 0x90, 0xac, 0xd7),
      ),
      routerConfig: _router,
    );
  }
}