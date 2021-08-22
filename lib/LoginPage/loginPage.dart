import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_admin/HomePage/homepage.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoggedIn = false, isLoading = false;
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
                                    child: Text("Easy Shopping Admin",
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
                                        "Email",
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
                                      controller: _emailController,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        icon: const Icon(
                                          Icons.email,
                                          color: Colors.black38,
                                        ),
                                        hintText: 'Type your email...',
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
                                      controller: _passwordController,
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
                  isLoading
                      ? Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 10),
                          child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: () {
                            if (_emailController.text == "") {
                              loginErrMsg("Email fiels is blank");
                            } else if (_passwordController.text == "") {
                              loginErrMsg("Password fiels is blank");
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              loginData();
                            }
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
                                  border: Border.all(
                                      width: 0.2, color: Colors.grey)),
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

  Future<void> loginData() async {
    final response = await http.post(ip + 'easy_shopping/login.php', body: {
      "email": _emailController.text,
      "password": _passwordController.text
    });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      if (response.body != "failure") {
        storeToLocal(response.body);
        _emailController.clear();
        _passwordController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        isLoggedin = true;
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        loginErrMsg("Email/Password is incorrect");
      }
    } else {
      throw Exception('Unable to add caegory from the REST API');
    }
  }

  loginErrMsg(String msg) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 100.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Center(
                  child: new Text(msg),
                )),
          );
        });
  }

  storeToLocal(String user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", user_id);
  }
}
