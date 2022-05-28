import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_shopping_admin/AllCouponPage/allCouponpage.dart';
import 'package:online_shopping_admin/CategoryList/categoryList.dart';
import 'package:online_shopping_admin/DiscountList/discountList.dart';
import 'package:online_shopping_admin/LoginPage/loginPage.dart';
import 'package:online_shopping_admin/MyProfilePage/myProfilePage.dart';
import 'package:online_shopping_admin/OrderList/orderList.dart';
import 'package:online_shopping_admin/ProductList/productList.dart';
import 'package:online_shopping_admin/ReviewList/reviewList.dart';
import 'package:online_shopping_admin/ReviewList/reviewProductlist.dart';
import 'package:online_shopping_admin/UserList/userList.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  leading: new Icon(Icons.security),
                  title: new Text('Terms and Condition'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserList()),
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
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserList()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 20, left: 20),
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
                        "Total User ()",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                        "Total Category ()",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                        "Total Products ()",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                        "Total Orders ()",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                        "Total Discount Products ()",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                  MaterialPageRoute(builder: (context) => AllCouponPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                        "Total Voucher/Coupon ()",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                  MaterialPageRoute(builder: (context) => ReviewProductlist()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                        "Total Review ()",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
