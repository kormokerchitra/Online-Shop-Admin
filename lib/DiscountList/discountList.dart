import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_admin/ProductList/productDetails.dart';
import 'package:online_shopping_admin/Utils/utils.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class DiscountList extends StatefulWidget {
  @override
  _DiscountListState createState() => _DiscountListState();
}

class _DiscountListState extends State<DiscountList> {
  var prodList = [];
  TextEditingController discPercentController = new TextEditingController();
  TextEditingController discDateController = new TextEditingController();

  int discountPercent = 0, discountAmt = 0;

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
                      Text("Discount Product List",
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
              String img = prodList[index]["product_img"];
              print("pic - ${ip + img}");
              discountAmt = Utils().getProductDiscount(
                  prodList[index]["product_price"],
                  prodList[index]["prod_discount"]);
              var discountAmt2 = discountAmt;
              return prodList[index]["prod_discount"] != "0"
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(prodList[index])),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 0),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  // color: Colors.red,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.only(right: 10, left: 0),
                                        height: 90,
                                        width: 80,
                                        child: img == ""
                                            ? Image.asset(
                                                'assets/product_back.jpg')
                                            : CachedNetworkImage(
                                                imageUrl: "${ip + img}",
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${prodList[index]["product_name"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54),
                                              textAlign: TextAlign.start,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Row(
                                                children: <Widget>[
                                                  //Icon(
                                                  //Icons.star,
                                                  //color: golden,
                                                  //size: 17,
                                                  //),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 3),
                                                    child: Text(
                                                      "Discount: ${prodList[index]["prod_discount"]}%",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      //Icon(
                                                      //Icons.attach_money,
                                                      //color: Colors.black87,
                                                      //size: 18,
                                                      //),
                                                      //Text(
                                                      //"Date: ${prodList[index]["prod_disc_date"]}",
                                                      //style: TextStyle(
                                                      //fontSize: 16,
                                                      //color: Colors.black87,
                                                      //),
                                                      //),
                                                      //Text(
                                                      //"Tk. ${prodList[index]["product_price"]}",
                                                      //style: TextStyle(
                                                      //fontSize: 16,
                                                      //color: Colors.black87,
                                                      //),
                                                      //),

                                                      Text(
                                                        "Tk. ${prodList[index]["product_price"]}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                discountAmt == 0
                                                                    ? 16
                                                                    : 13,
                                                            color:
                                                                discountAmt ==
                                                                        0
                                                                    ? Colors
                                                                        .black87
                                                                    : Colors
                                                                        .grey,
                                                            decoration: discountAmt ==
                                                                    0
                                                                ? TextDecoration
                                                                    .none
                                                                : TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                    ],
                                                  ),
                                                  discountAmt == 0
                                                      ? Container()
                                                      : Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 0),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    // Icon(
                                                                    //   Icons.attach_money,
                                                                    //   color: Colors.black87,
                                                                    //   size: 16,
                                                                    // ),
                                                                    Text(
                                                                      "Tk. $discountAmt",
                                                                      //"${prodList[index]["product_price"]}/-",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black87),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      discPercentController.text =
                                          prodList[index]["prod_discount"];
                                      discDateController.text =
                                          prodList[index]["prod_disc_date"];
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return Expanded(
                                            child: AlertDialog(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Edit discount'),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.3,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: TextField(
                                                      controller:
                                                          discPercentController,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Enter discount percentage (%)",
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                  //Container(
                                                  //padding: EdgeInsets.all(5),
                                                  //margin: EdgeInsets.only(
                                                  //top: 10),
                                                  //decoration: BoxDecoration(
                                                  //border: Border.all(
                                                  //width: 0.3,
                                                  //color: Colors.grey),
                                                  //borderRadius:
                                                  //BorderRadius
                                                  //.circular(5)),
                                                  //child: TextField(
                                                  //controller:
                                                  //discDateController,
                                                  //decoration: InputDecoration(
                                                  //hintText:
                                                  //"Enter date (YYYY-MM-DD)",
                                                  //border:
                                                  //InputBorder.none),
                                                  //),
                                                  //),
                                                  GestureDetector(
                                                    onTap: () {
                                                      editProductDisc(
                                                          prodList[index]
                                                              ["prod_id"]);
                                                    },
                                                    child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        margin: EdgeInsets.only(
                                                            bottom: 20,
                                                            top: 10),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                            color: mainheader,
                                                            border: Border.all(
                                                                width: 0.2,
                                                                color: Colors
                                                                    .grey)),
                                                        child: Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          color: Colors.white,
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container();
            }),
          ),
        ),
      ),
    );
  }

  Future<void> editProductDisc(String prod_id) async {
    final response =
        await http.post(ip + 'easy_shopping/product_status_edit.php', body: {
      "prod_discount": discPercentController.text,
      "prod_disc_date": discDateController.text,
      "prod_id": prod_id,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      discPercentController.clear();
      discDateController.clear();
      fetchProduct();
    } else {
      throw Exception('Unable to edit caegory from the REST API');
    }
  }
}
