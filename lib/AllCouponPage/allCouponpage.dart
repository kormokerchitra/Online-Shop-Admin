import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
  bool isLoading = true, isEditLoading = false;
  String runningdate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var now = new DateTime.now();
    runningdate = new DateFormat("yyyy-MM-dd").format(now);
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
          String voucherExpDate = couponList[i]["vou_exp_date"];
          List expArr = voucherExpDate.split("-");
          String day = expArr[0];
          int dayInt = int.parse(day);
          String month = expArr[1];
          int monthInt = int.parse(month);
          String year = expArr[2];
          int yearInt = int.parse(year);

          final now = DateTime.now();
          final expirationDate = DateTime(yearInt, monthInt, dayInt);
          final bool isExpired = expirationDate.isBefore(now);
          if (couponList[i]["voucher_status"] == "1" && !isExpired) {
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

  showAlert(String msg) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(msg,
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold)),
        );
      },
    );
  }

  Future<void> addCoupon() async {
    if (vNameController.text.isEmpty) {
      showAlert("Voucher/coupon name field is blank");
    } else if (vAmtController.text.isEmpty) {
      showAlert("Voucher/coupon amount field is blank");
    } else if (vDateController.text.isEmpty) {
      showAlert("Voucher/coupon expire date field is blank");
    } else {
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
  }

  Future<void> editCoupon(String vou_id) async {
    if (vNameController1.text.isEmpty) {
      showAlert("Voucher/coupon name field is blank");
    } else if (vAmtController1.text.isEmpty) {
      showAlert("Voucher/coupon amount field is blank");
    } else if (vDateController1.text.isEmpty) {
      showAlert("Voucher/coupon expire date field is blank");
    } else if (vStatusController1.text.isEmpty) {
      showAlert("Voucher/coupon status field is blank");
    } else {
      setState(() {
        isEditLoading = true;
      });
      print(json.encode({
        "vou_name": vNameController1.text,
        "vou_amount": vAmtController1.text,
        "vou_exp_date": vDateController1.text,
        "vou_status": vStatusController1.text,
        "vou_id": vou_id,
      }));
      final response =
          await http.post(ip + 'easy_shopping/voucher_edit.php', body: {
        "vou_name": vNameController1.text,
        "vou_amount": vAmtController1.text,
        "vou_exp_date": vDateController1.text,
        "vou_status": vStatusController1.text,
        "vou_id": vou_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          vNameController1.clear();
          vAmtController1.clear();
          vDateController1.clear();
          vStatusController1.clear();
          isEditLoading = false;
        });
        fetchCoupon();
      } else {
        throw Exception('Unable to edit voucher from the REST API');
      }
    }
    // setState(() {
    //   isEditLoading = true;
    // });
    // print(json.encode({
    //   "vou_name": vNameController1.text,
    //   "vou_amount": vAmtController1.text,
    //   "vou_exp_date": vDateController1.text,
    //   "vou_status": vStatusController1.text,
    //   "vou_id": vou_id,
    // }));
    // final response =
    //     await http.post(ip + 'easy_shopping/voucher_edit.php', body: {
    //   "vou_name": vNameController1.text,
    //   "vou_amount": vAmtController1.text,
    //   "vou_exp_date": vDateController1.text,
    //   "vou_status": vStatusController1.text,
    //   "vou_id": vou_id,
    // });
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   setState(() {
    //     vNameController1.clear();
    //     vAmtController1.clear();
    //     vDateController1.clear();
    //     vStatusController1.clear();
    //     isEditLoading = false;
    //   });
    //   fetchCoupon();
    // } else {
    //   throw Exception('Unable to edit voucher from the REST API');
    // }
  }

  Future<void> deleteCoupon(String vou_id) async {
    final response = await http.post(ip + 'easy_shopping/voucher_delete.php',
        body: {"vou_id": vou_id});
    print("vou_id - " + vou_id);
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
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add Voucher/Coupon'),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "Voucher/Coupon Name",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13),
                                  ),
                                  Text(
                                    " *",
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 15),
                                  ),
                                ],
                              )),
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
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "Voucher/Coupon Amount",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13),
                                  ),
                                  Text(
                                    " *",
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 15),
                                  ),
                                ],
                              )),
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
                                  hintText: "Enter voucher/coupon amount",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "Voucher/Coupon Expire Date",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13),
                                  ),
                                  Text(
                                    " *",
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 15),
                                  ),
                                ],
                              )),
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
                                  hintText: "Enter expire date (yyyy-mm-dd)",
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
                                  "Add",
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
                          "Active",
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
                          "Inactive",
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
          isEditLoading
              ? Container(
                  margin: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator())
              : Container(),
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
                                                // Text(
                                                //   "Active",
                                                //   style: TextStyle(
                                                //       color: Colors.green,
                                                //       fontWeight:
                                                //           FontWeight.normal),
                                                // ),
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
                                                                              margin: EdgeInsets.only(top: 20),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Voucher/Coupon Name",
                                                                                    style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                                  ),
                                                                                  Text(
                                                                                    " *",
                                                                                    style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              )),
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
                                                                              margin: EdgeInsets.only(top: 20),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Voucher/Coupon Amount",
                                                                                    style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                                  ),
                                                                                  Text(
                                                                                    " *",
                                                                                    style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              )),
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
                                                                              margin: EdgeInsets.only(top: 20),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Voucher/Coupon Expire Date",
                                                                                    style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                                  ),
                                                                                  Text(
                                                                                    " *",
                                                                                    style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              )),
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
                                                                              margin: EdgeInsets.only(top: 20),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Voucher/Coupon Status",
                                                                                    style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                                  ),
                                                                                  Text(
                                                                                    " *",
                                                                                    style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              )),
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
                                                                                vStatusController1.text = "0";
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
                                                                                "Change to Inactive",
                                                                                style: TextStyle(color: Colors.redAccent, fontSize: 11),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              editCoupon(couponListActive[index]["vou_id"]);
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
                                                                            "vou_id"]);
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
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        vNameController1.text =
                                                            couponListUsed[
                                                                    index][
                                                                "voucher_name"];
                                                        vAmtController1.text =
                                                            couponListUsed[
                                                                    index][
                                                                "voucher_amount"];
                                                        vDateController1.text =
                                                            couponListUsed[
                                                                    index][
                                                                "vou_exp_date"];
                                                        vStatusController1
                                                                .text =
                                                            couponListUsed[
                                                                    index][
                                                                "voucher_status"];
                                                        return Expanded(
                                                          child: AlertDialog(
                                                            content: StatefulBuilder(
                                                                builder: (BuildContext
                                                                        context,
                                                                    setState) {
                                                              return SingleChildScrollView(
                                                                physics:
                                                                    BouncingScrollPhysics(),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Edit Voucher/Coupon'),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                20),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Voucher/Coupon Name",
                                                                              style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              " *",
                                                                              style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 10),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 0.3,
                                                                              color: Colors.grey),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            vNameController1,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                "Enter voucher/coupon name",
                                                                            border:
                                                                                InputBorder.none),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                20),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Voucher/Coupon Amount",
                                                                              style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              " *",
                                                                              style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 10),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 0.3,
                                                                              color: Colors.grey),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            vAmtController1,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                "Enter amount",
                                                                            border:
                                                                                InputBorder.none),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                20),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Voucher/Coupon Expire Date",
                                                                              style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              " *",
                                                                              style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 10),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 0.3,
                                                                              color: Colors.grey),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            vDateController1,
                                                                        decoration: InputDecoration(
                                                                            hintText:
                                                                                "Enter expiry date (yyyy-mm-dd)",
                                                                            border:
                                                                                InputBorder.none),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                20),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Voucher/Coupon Status",
                                                                              style: TextStyle(color: Colors.black54, fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              " *",
                                                                              style: TextStyle(color: Colors.redAccent, fontSize: 15),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 10),
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 0.3,
                                                                              color: Colors.grey),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child: TextField(
                                                                          controller:
                                                                              vStatusController1,
                                                                          enabled:
                                                                              false,
                                                                          decoration: InputDecoration(
                                                                              hintText: "Enter Status",
                                                                              border: InputBorder.none)),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          vStatusController1.text =
                                                                              "1";
                                                                          print(
                                                                              "user");
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                5,
                                                                            left:
                                                                                5,
                                                                            bottom:
                                                                                5),
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          "Change to Active",
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 11),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        editCoupon(couponListUsed[index]
                                                                            [
                                                                            "vou_id"]);
                                                                      },
                                                                      child: Container(
                                                                          width: MediaQuery.of(context).size.width,
                                                                          margin: EdgeInsets.only(bottom: 20, top: 10),
                                                                          padding: EdgeInsets.all(10),
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: mainheader, border: Border.all(width: 0.2, color: Colors.grey)),
                                                                          child: Text(
                                                                            "Edit",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                            textAlign:
                                                                                TextAlign.center,
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
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    padding: EdgeInsets.all(10),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      size: 18,
                                                    ),
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
                                                                            "vou_id"]);
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
