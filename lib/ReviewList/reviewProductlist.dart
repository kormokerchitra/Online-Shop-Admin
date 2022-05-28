import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:online_shopping_admin/ReviewList/reviewList.dart';
import 'package:online_shopping_admin/main.dart';

class ReviewProductlist extends StatefulWidget {
  @override
  _ReviewProductlistState createState() => _ReviewProductlistState();
}

class _ReviewProductlistState extends State<ReviewProductlist> {
  var prodList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final response = await http.get(ip + 'easy_shopping/product_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var prodBody = json.decode(response.body);
      print(prodBody["product_list"]);
      setState(() {
        prodList = prodBody["product_list"];
      });
      print(prodList.length);
    } else {
      throw Exception('Unable to fetch products from the REST API');
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
                        Text("Review Product List",
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
              children: List.generate(prodList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewList(
                              prodList[index]["prod_id"],
                              prodList[index]["cat_id"],
                              prodList[index]["product_name"])),
                    );
                  },
                  child: Container(
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
                                    "${prodList[index]["product_name"]}",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Icon(Icons.category,
                                            color: Colors.black38),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${prodList[index]["cat_name"]}",
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
                                        Icon(Icons.star, color: subheader),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${prodList[index]["prod_rating"]}",
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
                                //showDialog(
                                  //context: context,
                                  //barrierDismissible: true,
                                  //builder: (BuildContext context) {
                                    //return Expanded(
                                      //child: AlertDialog(
                                        //title: Column(
                                          //crossAxisAlignment:
                                              //CrossAxisAlignment.start,
                                          //children: [
                                            //Text('Reply'),
                                            //Container(
                                              //padding: EdgeInsets.all(5),
                                              //margin: EdgeInsets.only(top: 10),
                                              //decoration: BoxDecoration(
                                                  //border: Border.all(
                                                      //width: 0.3,
                                                      //color: Colors.grey),
                                                  //borderRadius:
                                                      //BorderRadius.circular(5)),
                                              //child: TextField(
                                                //controller: categoryController,
                                                //decoration: InputDecoration(
                                                    //hintText: "Enter reply...",
                                                    //border: InputBorder.none),
                                              //),
                                            //),
                                            //GestureDetector(
                                              //onTap: () {
                                                //// if (categoryController.text != "") {
                                                //// addCategory(categoryController.text);
                                                //// }
                                              //},
                                              //child: Container(
                                                  //width: MediaQuery.of(context)
                                                      //.size
                                                      //.width,
                                                  //margin: EdgeInsets.only(
                                                      //bottom: 20, top: 10),
                                                  //padding: EdgeInsets.all(10),
                                                  //decoration: BoxDecoration(
                                                      //borderRadius:
                                                          //BorderRadius.all(
                                                              //Radius.circular(
                                                                  //5.0)),
                                                      //color: mainheader,
                                                      //border: Border.all(
                                                          //width: 0.2,
                                                          //color: Colors.grey)),
                                                  //child: Text(
                                                    //"Submit",
                                                    //style: TextStyle(
                                                        //color: Colors.white),
                                                    //textAlign: TextAlign.center,
                                                  //)),
                                            //),
                                          //],
                                        //),
                                      //),
                                    //);
                                  //},
                                //);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
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
