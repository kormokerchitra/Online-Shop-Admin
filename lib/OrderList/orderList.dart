import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_shopping_admin/OrderList/orderDetails.dart';
import 'package:online_shopping_admin/Utils/utils.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class OrderList extends StatefulWidget {
  final inv_id;
  OrderList({this.inv_id = ""});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  double totalPrice = 0.0;
  List filterType = [];
  int selectedIndex = 0,
      processingCount = 0,
      pickedCount = 0,
      shippedCount = 0,
      deliveredCount = 0,
      cancelledCount = 0;
  String selectedItemName = "All";
  bool isLoading = true;
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

        filterType.add({"name": "All", "count": "${orderList.length}"});

        for (int i = 0; i < orderList.length; i++) {
          if (orderList[i]["status"] == "Processing") {
            processingCount++;
          } else if (orderList[i]["status"] == "Picked") {
            pickedCount++;
          } else if (orderList[i]["status"] == "Shipped") {
            shippedCount++;
          } else if (orderList[i]["status"] == "Delivered") {
            deliveredCount++;
          } else if (orderList[i]["status"] == "Cancelled") {
            cancelledCount++;
          }
        }
        filterType.add({"name": "Processing", "count": "$processingCount"});
        filterType.add({"name": "Picked", "count": "$pickedCount"});
        filterType.add({"name": "Shipped", "count": "$shippedCount"});
        filterType.add({"name": "Delivered", "count": "$deliveredCount"});
        filterType.add({"name": "Cancelled", "count": "$cancelledCount"});
        print(filterType);

        isLoading = false;
      });
      print(orderList.length);
      print("filterType");
      print(filterType);

      if (widget.inv_id != "") {
        checkForInvID();
      }
    } else {
      throw Exception('Unable to fetch order from the REST API');
    }
  }

  checkForInvID() {
    for (int i = 0; i < orderList.length; i++) {
      if (widget.inv_id == orderList[i]["inv_id"]) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailsPage(orderList[i])),
        );
      }
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : widget.inv_id != ""
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()))
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 5, left: 10, right: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            child: Row(
                                children:
                                    List.generate(filterType.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedItemName =
                                        filterType[index]["name"];
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? mainheader
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 0.2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    "${filterType[index]["name"]} (${filterType[index]["count"]})",
                                    style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black54),
                                  ),
                                ),
                              );
                            })),
                          ),
                        ),
                      ),
                      filterType[selectedIndex]["count"] == "0"
                          ? Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Text("No data available"))
                          : Container(
                              child: Column(
                                children:
                                    List.generate(orderList.length, (index) {
                                  totalPrice = double.parse(
                                      orderList[index]["total_payable"]);
                                  return orderList[index]["status"] ==
                                          selectedItemName
                                      ? itemData(index)
                                      : selectedItemName == "All"
                                          ? itemData(index)
                                          : Container();
                                }),
                              ),
                            ),
                    ],
                  ),
                ),
    );
  }

  Widget itemData(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailsPage(orderList[index])),
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
                                            fontSize: 14, color: Colors.grey),
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
                                              fontSize: 15, color: mainheader),
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
                                "Delivery Date: ${orderList[index]["delivery_date"]}",
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
                              child: Text(
                                "Status: ${orderList[index]["status"]}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: mainheader,
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
  }
}
