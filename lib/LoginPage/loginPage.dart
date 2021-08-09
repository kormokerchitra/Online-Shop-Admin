import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_admin/HomePage/homepage.dart';
import 'package:online_shopping_admin/main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _reviewController = TextEditingController();
  bool _isLoggedIn = false;
  String _debugLabelString = "", review = '', runningdate = '';
  bool _requireConsent = false;
  var dd, finalDate;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: sub_white,
          //height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: 5, left: 20, right: 20, bottom: 5),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.white,
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text(
                          //   "Login",
                          //   style: TextStyle(fontSize: 17, color: Colors.black),
                          //   textAlign: TextAlign.center,
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset('assets/logo.jpg')),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text("E-commerce Admin",
                                        style: TextStyle(
                                            color: subheader,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 35, right: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          //color: Colors.grey[200],
                                          //padding: EdgeInsets.all(20),
                                          child: Text(
                                        "Username",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 0, right: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.5, color: Colors.grey)),
                                    child: TextFormField(
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        icon: const Icon(
                                          Icons.account_box,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Type your username...',
                                        //labelText: 'Enter E-mail',
                                        contentPadding: EdgeInsets.fromLTRB(
                                            0.0, 10.0, 20.0, 10.0),
                                        border: InputBorder.none,
                                        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                        //border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                                      ),

                                      //onSaved: (val) => result = val,
                                      //validator: _validateEmail,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 15, right: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          //color: Colors.grey[200],
                                          //padding: EdgeInsets.all(20),
                                          child: Text(
                                        "Password",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 0, right: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 0.5, color: Colors.grey)),
                                    child: TextFormField(
                                      autofocus: false,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        icon: const Icon(
                                          Icons.lock,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Type your password...',
                                        //labelText: 'Enter E-mail',
                                        contentPadding: EdgeInsets.fromLTRB(
                                            0.0, 10.0, 20.0, 10.0),
                                        border: InputBorder.none,
                                        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                        //border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                                      ),

                                      //validator: _validateEmail,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      isLoggedin = true;
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: mainheader,
                            border: Border.all(width: 0.2, color: Colors.grey)),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
