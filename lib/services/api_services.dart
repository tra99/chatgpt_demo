import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const BASE_URL = "https://api.openkh.org/chat/completions";
  static const API_KEY = "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"; // Replace with your actual API key

  static Future<List<ChatModel>> sendMessage({
    required String message,
    String modelId = "gpt-4",
  }) async {
    try {
      var messages = [
        {
          "role": "user",
          "content": message,
        }
      ];

      final response = await http.post(
        Uri.parse(BASE_URL),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json",
          "Charset": "utf-8",
        },
        body: jsonEncode({
          "model": modelId,
          "messages": messages,
          "max_tokens": 100,
          "stream": true,
        }),
      );

      if (response.statusCode == 200) {
        String responseBody = response.body;
        responseBody = responseBody.substring(5);
        Map<String, dynamic> jsonsResponse = json.decode(responseBody);

        if (jsonsResponse.containsKey('choices') &&
            jsonsResponse['choices'].length > 0) {
          List<ChatModel> chatList = jsonsResponse['choices'].map((choice) {
            return ChatModel(
              msg: choice['text'],
              chatIndex: 1,
            );
          }).toList();
          return chatList;
        } else {
          throw Exception("No choices found in the response.");
        }
      } else {
        throw Exception("Failed to fetch response. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }
}

class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({
    required this.msg,
    required this.chatIndex,
  });
}

