import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_admin/ProductList/addProduct.dart';
import 'package:online_shopping_admin/ProductList/productDetails.dart';
import 'package:online_shopping_admin/SearchPage/searchPage.dart';
import 'package:online_shopping_admin/Utils/utils.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

import 'editproduct.dart';

class ProductList extends StatefulWidget {
  final String cat_id;
  final String cat_name;
  ProductList({this.cat_id, this.cat_name});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var prodList = [];
  TextEditingController productController = new TextEditingController();
  TextEditingController productEditController = new TextEditingController();

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

  Future<void> deleteProduct(String prod_id, String cat_id) async {
    final response =
        await http.post(ip + 'easy_shopping/product_delete.php', body: {
      "prod_id": prod_id,
      "cat_id": cat_id,
    });
    print("prod_id - " + prod_id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body == "Success") {
        fetchProduct();
      }
    } else {
      throw Exception('Unable to delete product from the REST API');
    }
  }

  //Future<void> editProduct(String name, String prod_id) async {
  //final response =
  //await http.post(ip + 'easy_shopping/product_edit.php', body: {
  //"product_name": name,
  //"prod_id": prod_id,
  //});
  //print("name - " + name);
  //print(response.statusCode);
  //if (response.statusCode == 200) {
  //Navigator.pop(context);
  //productEditController.clear();
  //fetchProduct();
  //} else {
  //throw Exception('Unable to edit product from the REST API');
  //}
  //}

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
                Flexible(
                  child: Container(
                    child: Text(
                        widget.cat_name != null
                            ? "${widget.cat_name}"
                            : "Product List",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.search,
                  color: subheader,
                  size: 30,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.add,
                  color: subheader,
                  size: 30,
                ),
              ),
            ),
          )
        ],
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
              return widget.cat_id != null
                  ? prodList[index]["cat_id"] == widget.cat_id
                      ? bodydata(index, img)
                      : Container()
                  : bodydata(index, img);
            }),
          ),
        ),
      ),
    );
  }

  Widget bodydata(int index, String img) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(prodList[index])),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
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
                        margin: EdgeInsets.only(right: 10, left: 0),
                        height: 90,
                        width: 80,
                        child: img == ""
                            ? Image.asset('assets/product_back.jpg')
                            : CachedNetworkImage(
                                imageUrl: "${ip + img}",
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${prodList[index]["product_name"]}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black54),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: golden,
                                    size: 17,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 3),
                                    child: Text(
                                      "${prodList[index]["prod_rating"]} (${prodList[index]["rev_count"]})",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.attach_money,
                                      //   color: Colors.black87,
                                      //   size: 18,
                                      // ),
                                      //Text(
                                      //"Tk. $discountAmt",
                                      //"Tk. ${prodList[index]["product_price"]}",
                                      //style: TextStyle(
                                      //fontSize: 16,
                                      //color: Colors.black87),
                                      //),
                                      Text(
                                        "Tk. ${prodList[index]["product_price"]}",
                                        style: TextStyle(
                                            fontSize:
                                                discountAmt == 0 ? 16 : 13,
                                            color: discountAmt == 0
                                                ? Colors.black87
                                                : Colors.grey,
                                            decoration: discountAmt == 0
                                                ? TextDecoration.none
                                                : TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),

                                  // Icon(
                                  //   Icons.delete,
                                  //   color: Colors.grey,
                                  //   size: 23,
                                  // ),
                                ],
                              ),
                            ),
                            discountAmt == 0
                                ? Container()
                                : Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: <Widget>[
                                              // Icon(
                                              //   Icons.attach_money,
                                              //   color: Colors.black87,
                                              //   size: 16,
                                              // ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Tk. $discountAmt",
                                                    //"${prodList[index]["product_price"]}/-",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black87),
                                                  ),
                                                  Text(
                                                    " (${prodList[index]["prod_discount"]}%)",
                                                    //"${prodList[index]["product_price"]}/-",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black87),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProduct(prodList[index])),
                          );
                        },
                        //onTap: () {
                        //productEditController.text =
                        //productList[index]["product_name"];
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
                        //Text('Edit Product Details'),
                        //Container(
                        //padding: EdgeInsets.all(5),
                        //margin:
                        //EdgeInsets.only(top: 10),
                        //decoration: BoxDecoration(
                        //border: Border.all(
                        //width: 0.3,
                        //color: Colors.grey),
                        //borderRadius:
                        //BorderRadius.circular(
                        //5)),
                        //child: TextField(
                        //controller:
                        //productEditController,
                        //decoration: InputDecoration(
                        //hintText:
                        //"Enter product name",
                        //border:
                        //InputBorder.none),
                        //),
                        //),
                        //GestureDetector(
                        //onTap: () {
                        //if (productEditController
                        //.text !=
                        //"") {
                        //editProduct(
                        //productEditController
                        //.text,
                        //productList[index]
                        //["prod_id"]);
                        //}
                        //},
                        //child: Container(
                        //width:
                        //MediaQuery.of(context)
                        //.size
                        //.width,
                        //margin: EdgeInsets.only(
                        //bottom: 20, top: 10),
                        //padding:
                        //EdgeInsets.all(10),
                        //decoration: BoxDecoration(
                        //borderRadius:
                        //BorderRadius.all(
                        //Radius
                        //.circular(
                        //5.0)),
                        //color: mainheader,
                        //border: Border.all(
                        //width: 0.2,
                        //color:
                        //Colors.grey)),
                        //child: Text(
                        //"Edit",
                        //style: TextStyle(
                        //color:
                        //Colors.white),
                        //textAlign:
                        //TextAlign.center,
                        //)),
                        //),
                        //],
                        //),
                        //),
                        //);
                        //},
                        //);
                        //},
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              color: Colors.white,
                              child: Icon(
                                Icons.edit,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title: Text('Delete Product'),
                                  content: Text(
                                      'Do you want to delete the product?'),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            child: Text('No')),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        deleteProduct(
                                            prodList[index]["prod_id"],
                                            prodList[index]["cat_id"]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(10),
                            child: Container(
                              color: Colors.white,
                              child: Icon(
                                Icons.delete,
                                color: Colors.redAccent.withOpacity(0.6),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
