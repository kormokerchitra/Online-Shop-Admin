import 'package:flutter/material.dart';
import 'package:online_shopping_admin/HomePage/homepage.dart';
import 'package:online_shopping_admin/LoginPage/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

String ip = "http://192.168.100.5/";
//String ip = "http://192.168.43.23/";

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getuserID();
  }

  getuserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString("userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Shopping Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: subheader,
      ),
      home: userEmail == null || userEmail == "" ? LoginPage() : HomePage(),
    );
  }
}
