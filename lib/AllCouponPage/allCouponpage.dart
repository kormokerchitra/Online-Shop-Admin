import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_shopping_admin/main.dart';

class AllCouponPage extends StatefulWidget {
  @override
  _AllCouponPageState createState() => _AllCouponPageState();
}

class _AllCouponPageState extends State<AllCouponPage> {
  bool isAvailableClicked = true;

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
                      Text("Voucher/Coupon List",
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
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Expanded(
                    child: AlertDialog(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add Voucher/Coupon'),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.3, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter voucher/coupon name",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.3, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter amount",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.3, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter expiry date (yyyy-MM-dd)",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(bottom: 20, top: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: mainheader,
                                  border: Border.all(
                                      width: 0.2, color: Colors.grey)),
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAvailableClicked = true;
                    });
                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: isAvailableClicked ? subheader : sub_white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        border: Border.all(
                            width: 0.5,
                            color:
                                isAvailableClicked ? subheader : Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Available",
                          style: TextStyle(
                              color: isAvailableClicked
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAvailableClicked = false;
                    });
                  },
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !isAvailableClicked ? subheader : sub_white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        border: Border.all(
                            width: 0.5,
                            color:
                                !isAvailableClicked ? subheader : Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Used",
                          style: TextStyle(
                              color: !isAvailableClicked
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: isAvailableClicked
                  ? Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: List.generate(10, (index) {
                          return Container(
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "#V383434987V",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Discount amount: 100/-",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Date: 12-09-2021",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Available",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Expanded(
                                                        child: AlertDialog(
                                                          title: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'Edit Voucher/Coupon'),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            0.3,
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    TextField(
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                          "Enter voucher/coupon name",
                                                                      border: InputBorder
                                                                          .none),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            0.3,
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    TextField(
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                          "Enter amount",
                                                                      border: InputBorder
                                                                          .none),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            0.3,
                                                                        color: Colors
                                                                            .grey),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    TextField(
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                          "Enter expiry date (yyyy-MM-dd)",
                                                                      border: InputBorder
                                                                          .none),
                                                                ),
                                                              ),
                                                              Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  margin: EdgeInsets.only(
                                                                      bottom:
                                                                          20,
                                                                      top: 10),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              5.0)),
                                                                      color:
                                                                          mainheader,
                                                                      border: Border.all(
                                                                          width:
                                                                              0.2,
                                                                          color:
                                                                              Colors.grey)),
                                                                  child: Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Expanded(
                                                        child: AlertDialog(
                                                          title: Text(
                                                              'Delete Voucher/Coupon'),
                                                          content: Text(
                                                              'Do you want to delete the voucher/coupon?'),
                                                          actions: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                        'No')),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                        'Yes')),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent
                                                        .withOpacity(0.4),
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: List.generate(10, (index) {
                          return Container(
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "#V383434987V",
                                            style: TextStyle(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Discount amount: 100/-",
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Date: 12-09-2021",
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Used",
                                            style: TextStyle(
                                                color: Colors.redAccent
                                                    .withOpacity(0.7),
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Expanded(
                                                    child: AlertDialog(
                                                      title: Text(
                                                          'Delete Voucher/Coupon'),
                                                      content: Text(
                                                          'Do you want to delete the voucher/coupon?'),
                                                      actions: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .all(
                                                                    8.0),
                                                            child: Container(
                                                                margin: EdgeInsets.only(
                                                                    right:
                                                                        10,
                                                                    bottom:
                                                                        10),
                                                                child: Text(
                                                                    'No')),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .all(
                                                                    8.0),
                                                            child: Container(
                                                                margin: EdgeInsets.only(
                                                                    right:
                                                                        10,
                                                                    bottom:
                                                                        10),
                                                                child: Text(
                                                                    'Yes')),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.all(10),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
