enum Page {
  aiChatPage(path: '/ai-chat'),
  chatPage(path: '/chat');

  const Page({required this.path});

  final String path;
}