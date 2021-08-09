import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Chitra",
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
                                        "Sylhet",
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
                                      Icon(Icons.email, color: Colors.black38),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "demo@mail.com",
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
                                      Icon(Icons.phone, color: Colors.black38),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "+88017XXXXXXXX",
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
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10, bottom: 10),
                                                  child: Text('No')),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10, bottom: 10),
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
                                child:
                                    Icon(Icons.delete, color: Colors.redAccent),
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
