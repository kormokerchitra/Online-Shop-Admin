import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_shopping_admin/AllCouponPage/allCouponpage.dart';
import 'package:online_shopping_admin/CategoryList/categoryList.dart';
import 'package:online_shopping_admin/DiscountList/discountList.dart';
import 'package:online_shopping_admin/LoginPage/loginPage.dart';
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
              margin: EdgeInsets.only(left: 20),
              width: 30,
              child: Image.asset('assets/logo.jpg')),
          title: Container(
            child: Text("Easy Shopping Admin",
                style: TextStyle(
                    color: subheader,
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                showDialog(
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
                );
              },
              child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Icon(
                    Icons.settings_power,
                    color: Colors.grey,
                  )),
            )
          ],
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
                          "User List",
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
                          "Category List",
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
                          "Product List",
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
                          "Order List",
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
                          "Discount List",
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
                          "Voucher/Coupon List",
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
                          "Review List",
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
      ),
    );
  }
}
