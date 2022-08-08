import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_shopping_admin/AllCouponPage/allCouponpage.dart';
import 'package:online_shopping_admin/CategoryList/categoryList.dart';
import 'package:online_shopping_admin/DiscountList/discountList.dart';
import 'package:online_shopping_admin/LoginPage/loginPage.dart';
import 'package:online_shopping_admin/MyProfilePage/myProfilePage.dart';
import 'package:online_shopping_admin/NotificationPage/notifications.dart';
import 'package:online_shopping_admin/OrderList/orderList.dart';
import 'package:online_shopping_admin/ProductList/productList.dart';
import 'package:online_shopping_admin/ReviewList/reviewList.dart';
import 'package:online_shopping_admin/ReviewList/reviewProductlist.dart';
import 'package:online_shopping_admin/UserList/userList.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String user_count = "0",
      product_count = "0",
      discount_count = "0",
      category_count = "0",
      order_count = "0",
      voucher_count = "0",
      review_count = "0",
      notification_count = "0";
  String userID = "";
  var userInfo;
  List notifyList = [];
  int notifCount = 0;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
    getCounter();
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("userId");
    userInfo = json.decode(userData);
    userID = "${userInfo["user_info"]["user_id"]}";
    getNotification();
  }

  Future<void> getNotification() async {
    final response = await http.post(
        ip + 'easy_shopping/notification_all_list.php',
        body: {"receiver": "admin"});
    if (response.statusCode == 200) {
      print(response.body);
      var notifyBody = json.decode(response.body);
      print(notifyBody["notification_list"]);

      setState(() {
        isLoading = false;
        var notifList = notifyBody["notification_list"];
        for (int i = 0; i < notifList.length; i++) {
          if (notifList[i]["seen"] == "0" &&
              notifList[i]["receiver"] == userID) {
            notifCount++;
            notification_count = "$notifCount";
          }
          notifyList.add(notifList[i]);
        }

        print("notifylist - $notifyList");
        print("notifylist_count - $notification_count");
      });
    } else {
      throw Exception('Unable to fetch counter from the REST API');
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    isLoggedin = false;
  }
  //String pro_pic = "";

  Future<void> getCounter() async {
    isLoading = true;
    final response = await http.get(ip + 'easy_shopping/dashboard_counter.php');
    if (response.statusCode == 200) {
      print(response.body);
      var prodBody = json.decode(response.body);
      print(prodBody["user_count"]);
      setState(() {
        isLoading = false;
        user_count = "${prodBody["user_count"]}";
        product_count = "${prodBody["product_count"]}";
        discount_count = "${prodBody["discount_count"]}";
        category_count = "${prodBody["category_count"]}";
        order_count = "${prodBody["order_count"]}";
        voucher_count = "${prodBody["voucher_count"]}";
        review_count = "${prodBody["review_count"]}";
      });
    } else {
      throw Exception('Unable to fetch counter from the REST API');
    }
  }

  doneMsg() {
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
                  child: new Text("Refresh succesfully!"),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Drawer drawer = new Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyProfilePage()),
                    // );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: isLoggedin
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyProfilePage()));
                                    },
                                    child: Text(
                                      "Hello, Admin",
                                      style: TextStyle(
                                          fontSize: 20, color: subheader),
                                    ),
                                  ),
                                  // Text(
                                  //   !isLoggedin
                                  //       ? "User"
                                  //       : "${userInfo["full_name"]}",
                                  //   style: TextStyle(fontSize: 17),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //     margin: EdgeInsets.only(right: 30),
                        //     child: Icon(Icons.chevron_right)),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Divider()),
                new ListTile(
                    leading: new Icon(Icons.person),
                    title: new Text('User List'),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserList()),
                          )
                        }),
                new ListTile(
                    leading: new Icon(Icons.category),
                    title: new Text('Category List'),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryList()),
                          )
                        }),
                new ListTile(
                    leading: new Icon(Icons.list),
                    title: new Text('Product List'),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList()),
                          )
                        }),
                new ListTile(
                    leading: new Icon(Icons.format_list_numbered),
                    title: new Text('Discount List'),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiscountList()),
                          )
                        }),
                new ListTile(
                    leading: new Icon(Icons.shopping_cart),
                    title: new Text('Order List'),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderList()),
                          )
                        }),
                new ListTile(
                    leading: new Icon(Icons.local_activity),
                    title: new Text('Voucher/Coupon List'),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllCouponPage()),
                          )
                        }),
                new ListTile(
                    leading: new Icon(Icons.star),
                    title: new Text('Review List'),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewProductlist()),
                          )
                        }),
                Container(
                    margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: Divider()),
                new ListTile(
                  leading: new Icon(Icons.account_box_rounded),
                  title: new Text('Profile'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfilePage()),
                    )
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.settings_power),
                  title: new Text('Logout'),
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          title: Text('Logout'),
                          content: Text('Do you want to logout?'),
                          actions: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    margin:
                                        EdgeInsets.only(right: 10, bottom: 10),
                                    child: Text('No')),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                logout();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    margin:
                                        EdgeInsets.only(right: 10, bottom: 10),
                                    child: Text('Yes')),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    //return Scaffold(
    // drawer: drawer,
    // key: _scaffoldKey,
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: 30, child: Image.asset('assets/logo.jpg')),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Easy Shopping Admin",
                      style: TextStyle(
                          color: subheader,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  notifCount = 0;
                  notification_count = "0";
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotifyPage(notifyList)),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.notifications, color: subheader),
                    ),
                    notifCount == 0
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(notification_count,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal)),
                          )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLoading = true;
                });
                getNotification();
                getCounter();
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh_outlined, color: subheader),
              ),
            )
          ]),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Dashboard",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserList()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 30, left: 30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: subheader,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: subheader)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Total User ($user_count)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryList()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: subheader,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: subheader)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.category,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Total Category ($category_count)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductList()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: subheader,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: subheader)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.list,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Total Products ($product_count)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DiscountList()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: subheader,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: subheader)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.format_list_numbered,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Total Discount Products ($discount_count)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderList()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: subheader,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: subheader)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Total Orders ($order_count)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllCouponPage()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: subheader,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: subheader)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Total Voucher/Coupon ($voucher_count)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewProductlist()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: subheader,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.5, color: subheader)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Total Review ($review_count)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
