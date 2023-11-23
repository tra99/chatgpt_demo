import 'package:chatgpt_demo/models/chat_model.dart';
import 'package:chatgpt_demo/services/api_services.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  // for user
  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  // for bot
  Future<void> sendMessageAndGetAnswers(
      {required String msg}) async {
    chatList.addAll(await ApiService.sendMessage(
      message: msg, modelId: '',
    ));notifyListeners();
  }
}
