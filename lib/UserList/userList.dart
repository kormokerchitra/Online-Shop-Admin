import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_admin/main.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  var userList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final response = await http.get(ip + 'easy_shopping/user_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var userBody = json.decode(response.body);
      print(userBody["user_list"]);
      setState(() {
        userList = userBody["user_list"];
      });
      print(userList.length);
    } else {
      throw Exception('Unable to fetch users from the REST API');
    }
  }

  Future<void> deleteUser(String user_id) async {
    final response = await http
        .post(ip + 'easy_shopping/user_delete.php', body: {"user_id": user_id});
    print("user_id - " + user_id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      fetchUser();
    } else {
      throw Exception('Unable to delete user from the REST API');
    }
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
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text("User List",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: List.generate(userList.length, (index) {
                return userList[index]["full_name"] == "Admin"
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${userList[index]["full_name"]}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                color: Colors.black38),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${userList[index]["address"]}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.email,
                                                color: Colors.black38),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${userList[index]["email"]}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.phone,
                                                color: Colors.black38),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${userList[index]["phone_num"]}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Expanded(
                                            child: AlertDialog(
                                              title: Text('Delete User'),
                                              content: Text(
                                                  'Do you want to delete the user?'),
                                              actions: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 10),
                                                        child: Text('No')),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    deleteUser(userList[index]
                                                        ["user_id"]);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 10),
                                                        child: Text('Yes')),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.redAccent),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
              }),
            ),
          ),
        ));
  }
}
