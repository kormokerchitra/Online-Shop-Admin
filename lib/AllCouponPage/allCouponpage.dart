import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class AllCouponPage extends StatefulWidget {
  @override
  _AllCouponPageState createState() => _AllCouponPageState();
}

class _AllCouponPageState extends State<AllCouponPage> {
  bool isAvailableClicked = true;
  TextEditingController vNameController = new TextEditingController();
  TextEditingController vNameController1 = new TextEditingController();
  TextEditingController vDateController = new TextEditingController();
  TextEditingController vDateController1 = new TextEditingController();
  TextEditingController vAmtController = new TextEditingController();
  TextEditingController vAmtController1 = new TextEditingController();
  TextEditingController vStatusController1 = new TextEditingController();
  List couponListActive = [], couponListUsed = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCoupon();
  }

  Future<void> fetchCoupon() async {
    couponListActive.clear();
    couponListUsed.clear();
    final response = await http.get(ip + 'easy_shopping/voucher_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var couponBody = json.decode(response.body);
      print(couponBody["voucher_list"]);
      setState(() {
        var couponList = couponBody["voucher_list"];
        for (int i = 0; i < couponList.length; i++) {
          if (couponList[i]["voucher_status"] == "Available") {
            couponListActive.add(couponList[i]);
          } else {
            couponListUsed.add(couponList[i]);
          }
        }
        isLoading = false;
      });
      print("used : " + couponListUsed.length.toString());
    } else {
      throw Exception('Unable to fetch voucher from the REST API');
    }
  }

  Future<void> addCoupon() async {
    final response =
        await http.post(ip + 'easy_shopping/voucher_add.php', body: {
      "vou_name": vNameController.text,
      "vou_amount": vAmtController.text,
      "vou_exp_date": vDateController.text
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      vNameController.clear();
      vAmtController.clear();
      vDateController.clear();
      fetchCoupon();
    } else {
      throw Exception('Unable to add caegory from the REST API');
    }
  }

  Future<void> editCoupon(String id) async {
    print(json.encode({
      "vou_name": vNameController1.text,
      "vou_amount": vAmtController1.text,
      "vou_exp_date": vDateController1.text,
      "vou_status": vStatusController1.text,
      "id": id,
    }));
    final response =
        await http.post(ip + 'easy_shopping/voucher_edit.php', body: {
      "vou_name": vNameController1.text,
      "vou_amount": vAmtController1.text,
      "vou_exp_date": vDateController1.text,
      "vou_status": vStatusController1.text,
      "id": id,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      vNameController1.clear();
      vAmtController1.clear();
      vDateController1.clear();
      vStatusController1.clear();
      fetchCoupon();
    } else {
      throw Exception('Unable to edit caegory from the REST API');
    }
  }

  Future<void> deleteCoupon(String id) async {
    final response = await http
        .post(ip + 'easy_shopping/voucher_delete.php', body: {"id": id});
    print("id - " + id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      fetchCoupon();
    } else {
      throw Exception('Unable to delete voucher from the REST API');
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
                              controller: vNameController,
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
                              controller: vAmtController,
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
                              controller: vDateController,
                              decoration: InputDecoration(
                                  hintText: "Enter expiry date (yyyy-MM-dd)",
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addCoupon();
                            },
                            child: Container(
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : isAvailableClicked
                    ? couponListActive.length == 0
                        ? Center(child: Text("No data available!"))
                        : SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: List.generate(couponListActive.length,
                                    (index) {
                                  return Container(
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "#${couponListActive[index]["voucher_name"]}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "Discount amount: ${couponListActive[index]["voucher_amount"]}/-",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "Date: ${couponListActive[index]["vou_exp_date"]}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight
                                                              .normal),
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
                                                  "${couponListActive[index]["voucher_status"]}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              vNameController1
                                                                      .text =
                                                                  couponListActive[
                                                                          index]
                                                                      [
                                                                      "voucher_name"];
                                                              vAmtController1
                                                                      .text =
                                                                  couponListActive[
                                                                          index]
                                                                      [
                                                                      "voucher_amount"];
                                                              vDateController1
                                                                      .text =
                                                                  couponListActive[
                                                                          index]
                                                                      [
                                                                      "vou_exp_date"];
                                                              vStatusController1
                                                                      .text =
                                                                  couponListActive[
                                                                          index]
                                                                      [
                                                                      "voucher_status"];
                                                              return Expanded(
                                                                child:
                                                                    AlertDialog(
                                                                  content: StatefulBuilder(builder:
                                                                      (BuildContext
                                                                              context,
                                                                          setState) {
                                                                    return SingleChildScrollView(
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              'Edit Voucher/Coupon'),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            margin:
                                                                                EdgeInsets.only(top: 10),
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(width: 0.3, color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                                            child:
                                                                                TextField(
                                                                              controller: vNameController1,
                                                                              decoration: InputDecoration(hintText: "Enter voucher/coupon name", border: InputBorder.none),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            margin:
                                                                                EdgeInsets.only(top: 10),
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(width: 0.3, color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                                            child:
                                                                                TextField(
                                                                              controller: vAmtController1,
                                                                              decoration: InputDecoration(hintText: "Enter amount", border: InputBorder.none),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            margin:
                                                                                EdgeInsets.only(top: 10),
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(width: 0.3, color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                                            child:
                                                                                TextField(
                                                                              controller: vDateController1,
                                                                              decoration: InputDecoration(hintText: "Enter expiry date (yyyy-MM-dd)", border: InputBorder.none),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            margin:
                                                                                EdgeInsets.only(top: 10),
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(width: 0.3, color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                                                                            child: TextField(
                                                                                controller: vStatusController1,
                                                                                enabled: false,
                                                                                decoration: InputDecoration(hintText: "Enter Status", border: InputBorder.none)),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                vStatusController1.text = "Used";
                                                                                print("user");
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              alignment: Alignment.centerRight,
                                                                              padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                                                                              margin: EdgeInsets.only(top: 10),
                                                                              child: Text(
                                                                                "Change to Used",
                                                                                style: TextStyle(color: Colors.redAccent, fontSize: 11),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              editCoupon(couponListActive[index]["id"]);
                                                                            },
                                                                            child: Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                margin: EdgeInsets.only(bottom: 20, top: 10),
                                                                                padding: EdgeInsets.all(10),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: mainheader, border: Border.all(width: 0.2, color: Colors.grey)),
                                                                                child: Text(
                                                                                  "Edit",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                  textAlign: TextAlign.center,
                                                                                )),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Expanded(
                                                                child:
                                                                    AlertDialog(
                                                                  title: Text(
                                                                      'Delete Voucher/Coupon'),
                                                                  content: Text(
                                                                      'Do you want to delete the voucher/coupon?'),
                                                                  actions: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 10, bottom: 10),
                                                                            child: Text('No')),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        deleteCoupon(couponListActive[index]
                                                                            [
                                                                            "id"]);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
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
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors
                                                                .redAccent
                                                                .withOpacity(
                                                                    0.4),
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
                            ),
                          )
                    : couponListUsed.length == 0
                        ? Center(child: Text("No data available!"))
                        : SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: List.generate(couponListUsed.length,
                                    (index) {
                                  return Container(
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "#${couponListUsed[index]["voucher_name"]}",
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "Discount amount: ${couponListUsed[index]["voucher_amount"]}/-",
                                                      style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "Date: ${couponListUsed[index]["vou_exp_date"]}",
                                                      style: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          fontWeight: FontWeight
                                                              .normal),
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
                                                    "${couponListUsed[index]["voucher_status"]}",
                                                    style: TextStyle(
                                                        color: Colors.redAccent
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                                Container(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
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
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
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
                                                                    deleteCoupon(
                                                                        couponListUsed[index]
                                                                            [
                                                                            "id"]);
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
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
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      padding:
                                                          EdgeInsets.all(10),
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
