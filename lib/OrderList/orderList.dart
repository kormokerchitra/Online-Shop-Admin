import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_shopping_admin/OrderList/orderDetails.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  double totalPrice = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  Future<void> fetchOrder() async {
    final response = await http.get(ip + 'easy_shopping/order_list_all.php');
    if (response.statusCode == 200) {
      print(response.body);
      var corderBody = json.decode(response.body);
      print(corderBody["order_list"]);
      setState(() {
        orderList = corderBody["order_list"];
      });
      print(orderList.length);
    } else {
      throw Exception('Unable to fetch order from the REST API');
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
                      Text("Order List",
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
        child: Column(
          children: List.generate(orderList.length, (index) {
            totalPrice = double.parse(orderList[index]["total_payable"]);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailsPage(orderList[index])),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "#${orderList[index]["inv_id"]}",
                                      //"#${orderList[index]["inv_id"]}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Order by ${orderList[index]["full_name"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.shopping_basket,
                                                color: Colors.grey,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "${orderList[index]["total_product"]} Items",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "Total price: Tk. ${totalPrice.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: mainheader),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Date: ${orderList[index]["delivery_date"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black45,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
