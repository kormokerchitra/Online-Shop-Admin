import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_admin/HomePage/homepage.dart';
import 'package:online_shopping_admin/LoginPage/loginPage.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String userID = "";
  var userInfo;
  bool loader = false;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _conPassController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getUserID();
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("userId");
    userInfo = json.decode(userData);
    userID = "${userInfo["user_info"]["user_id"]}";
    _fullNameController.text = "${userInfo["user_info"]["full_name"]}";
    _addressController.text = "${userInfo["user_info"]["address"]}";
    _emailController.text = "${userInfo["user_info"]["email"]}";
    _phoneController.text = "${userInfo["user_info"]["phone_num"]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
        title: Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("My profile",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: sub_white,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.white,
                        border: Border.all(width: 0.2, color: Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                                      "Full Name",
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
                          padding: EdgeInsets.only(top: 0, right: 0, bottom: 5),
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
                                    controller: _fullNameController,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.account_circle,
                                        color: Colors.black38,
                                      ),
                                      hintText: 'Type your full name...',
                                      //labelText: 'Enter E-mail',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 20.0, 10.0),
                                      border: InputBorder.none,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Field is empty' : null,
                                    //onSaved: (val) => result = val,
                                    //validator: _validateEmail,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
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
                                      "Address",
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
                          padding: EdgeInsets.only(top: 0, right: 0, bottom: 5),
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
                                    controller: _addressController,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.location_city,
                                        color: Colors.black38,
                                      ),
                                      hintText: 'Type your address...',
                                      //labelText: 'Enter E-mail',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 20.0, 10.0),
                                      border: InputBorder.none,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Field is empty' : null,
                                    //onSaved: (val) => result = val,
                                    //validator: _validateEmail,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
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
                          padding: EdgeInsets.only(top: 0, right: 0, bottom: 5),
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
                                    validator: (val) =>
                                        val.isEmpty ? 'Field is empty' : null,
                                    //onSaved: (val) => result = val,
                                    //validator: _validateEmail,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
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
                                      "Phone number",
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
                          padding: EdgeInsets.only(top: 0, right: 0, bottom: 5),
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
                                    controller: _phoneController,
                                    autofocus: false,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.phone,
                                        color: Colors.black38,
                                      ),
                                      hintText: 'Type your phone number...',
                                      //labelText: 'Enter E-mail',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 20.0, 10.0),
                                      border: InputBorder.none,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Field is empty' : null,
                                    //onSaved: (val) => result = val,
                                    //validator: _validateEmail,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            !loader ? updateProfile() : null;
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(bottom: 20, top: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: mainheader,
                                  border: Border.all(
                                      width: 0.2, color: Colors.grey)),
                              child: loader
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: white,
                                      ),
                                    )
                                  : Text(
                                      "Update",
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
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
                                      "Change Password",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: mainheader,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
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
                                      "New Password",
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
                          padding: EdgeInsets.only(top: 0, right: 0, bottom: 5),
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
                                    controller: _passController,
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
                                    validator: (val) =>
                                        val.isEmpty ? 'Field is empty' : null,
                                    //onSaved: (val) => result = val,
                                    //validator: _validateEmail,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
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
                                      "Confirm Password",
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
                          padding: EdgeInsets.only(top: 0, right: 0, bottom: 5),
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
                                    controller: _conPassController,
                                    autofocus: false,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.lock_open,
                                        color: Colors.black38,
                                      ),
                                      hintText: 'Retype password...',
                                      //labelText: 'Enter E-mail',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 20.0, 10.0),
                                      border: InputBorder.none,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.vertical()),
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Field is empty' : null,
                                    //onSaved: (val) => result = val,
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
                    updatePassword();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: mainheader,
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: Text(
                        "Change",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    bool emailValid =
        RegExp(r"^[a-zA-Z.a-zA-Z.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_emailController.text);
    if (!emailValid) {
      showAlert("Invalid email");
    }  else if (!_phoneController.text.isEmpty &&
        _phoneController.text.length < 11) {
      showAlert("Invalid phone number");
    } else {
      setState(() {
        loader = true;
      });
      final response =
          await http.post(ip + 'easy_shopping/user_edit.php', body: {
        "user_id": "${userInfo["user_info"]["user_id"]}",
        "image": "",
        "full_name": _fullNameController.text,
        "username": "${userInfo["user_info"]["username"]}",
        "address": _addressController.text,
        "email": _emailController.text,
        "phone_num": _phoneController.text,
      });
      if (response.statusCode == 200) {
        print(response.body);

        setState(() {
          var user = json.decode(response.body);
          userInfo = user["user_info"];
          storeToLocal(json.encode(user));
          isLoggedin = true;
          loader = false;
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      } else {
        throw Exception('Unable to update user from the REST API');
      }
    }
  }

  Future<void> updatePassword() async {
    if (_passController.text.isEmpty) {
      showAlert("New password field is blank");
    } else if (_conPassController.text.isEmpty) {
      showAlert("Confirm password field is blank");
    } else if (_passController.text.length < 8 && _conPassController.text.length < 8) {
      showAlert("Password must be at least 8 characters");
    } else if (_passController.text != _conPassController.text) {
      showAlert("Password doesn't match");
    } else {
      final response =
          await http.post(ip + 'easy_shopping/user_pass_update.php', body: {
        "user_id": "$userID",
        "password": _passController.text,
      });
      if (response.statusCode == 200) {
        print(response.body);

        setState(() {
          //selectedPage = 0;
          clearLog();
        });
      } else {
        throw Exception('Unable to update user from the REST API');
      }
    }
  }

  void clearLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    isLoggedin = false;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  storeToLocal(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", user);
  }

  showAlert(String msg) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(msg,
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}
