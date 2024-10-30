import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp/src/chat_app.dart';

void main() {
  runApp(const ProviderScope(child: ChatApp()));
}
