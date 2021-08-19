import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_admin/main.dart';

class ReviewList extends StatefulWidget {
  final String prod_id;
  final String prod_name;
  ReviewList(this.prod_id, this.prod_name);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  var reviewList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReview();
  }

  Future<void> fetchReview() async {
    final response = await http.get(ip + 'easy_shopping/review_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var reviewBody = json.decode(response.body);
      print(reviewBody["list"]);
      setState(() {
        reviewList = reviewBody["list"];
      });
      print(reviewList.length);
    } else {
      throw Exception('Unable to fetch reviews from the REST API');
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
                        Text(widget.prod_name,
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
              children: List.generate(reviewList.length, (index) {
                return reviewList[index]["prod_id"] == widget.prod_id
                    ? Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${reviewList[index]["full_name"]}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.black38),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${reviewList[index]["rating"]}",
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
                                            Icon(Icons.comment,
                                                color: Colors.black38),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${reviewList[index]["reviews"]}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Date : ${reviewList[index]["date"]}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black38),
                                        ),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(top: 5),
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.production_quantity_limits,
                                      //           color: Colors.black38),
                                      //       SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       Text(
                                      //         "${reviewList[index]["product_name"]}",
                                      //         style: TextStyle(
                                      //             fontSize: 15,
                                      //             color: Colors.black38),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // Container(
                                      //   margin: EdgeInsets.only(top: 5),
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.category,
                                      //           color: Colors.black38),
                                      //       SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       Text(
                                      //         "${reviewList[index]["cat_name"]}",
                                      //         style: TextStyle(
                                      //             fontSize: 15,
                                      //             color: Colors.black38),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
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
                                                Text('Reply'),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.3,
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: TextField(
                                                    //controller: categoryController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter reply...",
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // if (categoryController.text != "") {
                                                    // addCategory(categoryController.text);
                                                    // }
                                                  },
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin: EdgeInsets.only(
                                                          bottom: 20, top: 10),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          color: mainheader,
                                                          border: Border.all(
                                                              width: 0.2,
                                                              color:
                                                                  Colors.grey)),
                                                      child: Text(
                                                        "Submit",
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
                                    margin: EdgeInsets.only(right: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.comment,
                                        color: subheader,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container();
              }),
            ),
          ),
        ));
  }
}
