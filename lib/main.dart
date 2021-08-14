import 'package:flutter/material.dart';
import 'package:online_shopping_admin/LoginPage/loginPage.dart';

void main() {
  runApp(MyApp());
}

Color mainheader = Colors.blue;
Color subheader = Colors.lightBlue;
Color sub_white = Color(0xFFf4f4f4);
Color white = Color(0xFFFFFFFF);
Color golden = Color(0xFFCFB53B);

bool isLoggedin = false;
List orderList = [];

String ip = "http://192.168.100.4/";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Shopping Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
