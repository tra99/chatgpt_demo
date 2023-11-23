import 'package:chatgpt_demo/constants/constant.dart';
import 'package:chatgpt_demo/providers/chat_provider.dart';
import 'package:chatgpt_demo/providers/models_provider.dart';
import 'package:chatgpt_demo/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ChatProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
              scaffoldBackgroundColor: scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(
                color: cardColor,
              )),
        home: const ChatScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


