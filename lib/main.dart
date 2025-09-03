import 'package:flutter/material.dart';
import 'package:model_class/Visitorlist.dart';
import 'package:model_class/home.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  void getToken()async{
    final prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('auth_token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: token==null?LoginPage():HomePage(),
    );
  }
}
