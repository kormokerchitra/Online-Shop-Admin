import 'dart:convert';
import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_admin/AllProductCard/allProductCard.dart';
import 'dart:async';

import '../../main.dart';

class AllProductPage extends StatefulWidget {
  final String cat_id;
  final String cat_name;
  AllProductPage({this.cat_id, this.cat_name});

  @override
  State<StatefulWidget> createState() {
    return AllProductPageState();
  }
}

class AllProductPageState extends State<AllProductPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  int count = 0;
  var prodList = [];

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final response = await http.get(ip + 'easy_shopping/product_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var productBody = json.decode(response.body);
      print(productBody["product_list"]);
      setState(() {
        prodList = productBody["product_list"];
      });
      print(prodList.length);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }

    for (int i = 0; i < prodList.length; i++) {
      if (prodList[i]["cat_id"] == widget.cat_id) {
        setState(() {
          count++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                          widget.cat_name == null
                              ? "New Arrival"
                              : widget.cat_name,
                          //widget.cat_name,
                          //"${prodList[index]["cat_name"]}",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: sub_white,
        //height: MediaQuery.of(context).size.height,
        child: Container(
          margin: EdgeInsets.only(left: 0, right: 0, top: 0),
          color: sub_white,
          width: MediaQuery.of(context).size.width,
          child: count == 0
              ? Center(
                  child: Container(
                    child: Text("No data available!"),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return prodList[index]["cat_id"] == widget.cat_id
                        ? AllProductCard(prod_item: prodList[index])
                        : Container();
                  },
                  itemCount: prodList.length,
                ),
        ),
      ),
    );
  }
}
