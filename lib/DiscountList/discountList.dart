import 'package:flutter/material.dart';
import 'package:online_shopping_admin/main.dart';

class DiscountList extends StatefulWidget {
  @override
  _DiscountListState createState() => _DiscountListState();
}

class _DiscountListState extends State<DiscountList> {
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
            children: List.generate(10, (index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 0),
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
                                    child: Image.asset('assets/shoe.png')),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Product Name hghgjhgjgjh",
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
                                            Icon(
                                              Icons.star,
                                              color: golden,
                                              size: 17,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: golden,
                                              size: 17,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: golden,
                                              size: 17,
                                            ),
                                            Icon(
                                              Icons.star_half,
                                              color: golden,
                                              size: 17,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: golden,
                                              size: 17,
                                            ),
                                            // Container(
                                            //   margin: EdgeInsets.only(left: 3),
                                            //   child: Text(
                                            //     "4.5",
                                            //     style: TextStyle(
                                            //         color: Colors.grey),
                                            //   ),
                                            // )
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
                                                Icon(
                                                  Icons.attach_money,
                                                  color: Colors.black87,
                                                  size: 18,
                                                ),
                                                Text(
                                                  "20.25",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
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
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.3,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter discount percentage (%)",
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.3,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter date (yyyy-MM-dd)",
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.only(
                                                    bottom: 20, top: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                    color: mainheader,
                                                    border: Border.all(
                                                        width: 0.2,
                                                        color: Colors.grey)),
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )),
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
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  )),
                            ),
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
      ),
    );
  }
}
