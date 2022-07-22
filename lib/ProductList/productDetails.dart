import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_admin/DiscountList/discountList.dart';
import 'package:online_shopping_admin/LoginPage/loginPage.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_admin/Utils/utils.dart';
import '../../main.dart';
import 'editproduct.dart';

class DetailsPage extends StatefulWidget {
  final product_info;
  final bool fromDiscount;
  DetailsPage(this.product_info, {this.fromDiscount = false});

  @override
  State<StatefulWidget> createState() {
    return DetailsPageState();
  }
}

class DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _reviewController = TextEditingController();
  TextEditingController discPercentController = new TextEditingController();
  TextEditingController discDateController = new TextEditingController();
  Animation<double> animation;
  AnimationController controller;
  bool _isLoggedIn = false;
  String _debugLabelString = "", review = '', _ratingStatus = '';
  bool _requireConsent = false, isfav = false;
  int _current = 0,
      num = 0,
      totalFav = 10,
      count = 0,
      discountPercent = 0,
      discountAmt = 0,
      quantity = 0;
  double tk = 0.0;
  List imgList = [
    "assets/tshirt.png",
    "assets/shirt.jpg",
    "assets/pant.jpg",
    "assets/shoe.png"
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();

    discountAmt = Utils().getProductDiscount(
        widget.product_info["product_price"],
        widget.product_info["prod_discount"]);
    quantity = int.parse(widget.product_info["prod_quantity"]);
  }

  int _rating = 0;

  void rate(int rating) {
    if (rating == 1) {
      _ratingStatus = "Poor";
    }
    if (rating == 2) {
      _ratingStatus = "Average";
    }
    if (rating == 3) {
      _ratingStatus = "Good";
    }
    if (rating == 4) {
      _ratingStatus = "Very Good";
    }
    if (rating == 5) {
      _ratingStatus = "Excellent";
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

  Future<void> editProductDisc(String prod_id) async {
    if (discPercentController.text.isEmpty) {
      showAlert("Product discount field is blank");
    } else {
      final response =
          await http.post(ip + 'easy_shopping/product_status_edit.php', body: {
        "prod_discount": discPercentController.text,
        "prod_disc_date": discDateController.text,
        "prod_id": prod_id,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DiscountList(
                      product_id: widget.product_info["prod_id"],
                    )));
        discPercentController.clear();
        discDateController.clear();
      } else {
        throw Exception('Unable to edit caegory from the REST API');
      }
    }
  }

  void showDiscountDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit discount'),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text(
                          "Product Discount (%)",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        Text(
                          " *",
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    controller: discPercentController,
                    decoration: InputDecoration(
                        hintText: "Enter discount percentage (%)",
                        border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 EditProduct(prodList[index])),
                    //       );
                    editProductDisc(widget.product_info["prod_id"]);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 20, top: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: mainheader,
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: Text(
                        "Edit",
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
  }

  @override
  Widget build(BuildContext context) {
    var discountAmt2 = discountAmt;
    var discountAmt22 = discountAmt2;
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
                      Text("Product Details",
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
              if (widget.fromDiscount) {
                discPercentController.text =
                    widget.product_info["prod_discount"];
                discDateController.text = widget.product_info["prod_disc_date"];

                print(widget.product_info["prod_discount"]);
                showDiscountDialog();
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: AlertDialog(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select option'),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                discPercentController.text =
                                    widget.product_info["prod_discount"];
                                discDateController.text =
                                    widget.product_info["prod_disc_date"];

                                print(widget.product_info["prod_discount"]);
                                showDiscountDialog();
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 5, top: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      color: mainheader,
                                      border: Border.all(
                                          width: 0.2, color: Colors.grey)),
                                  child: Text(
                                    "Edit Discount",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditProduct((widget.product_info)),
                                    ));
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 20, top: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      color: mainheader,
                                      border: Border.all(
                                          width: 0.2, color: Colors.grey)),
                                  child: Text(
                                    "Edit Product",
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
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: widget.fromDiscount
                    ? Text("Edit Discount",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: subheader))
                    : Container(
                        child: Icon(
                        Icons.more_vert,
                        color: subheader,
                      )),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: sub_white,
          //height: MediaQuery.of(context).size.height,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                        height: 300,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          child: widget.product_info["product_img"] == ""
                              ? Image.asset(
                                  'assets/product_back.jpg',
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      "${ip + widget.product_info["product_img"]}",
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                          // child: CarouselSlider(
                          //   //height: 400.0,
                          //   // carouselController: buttonCarouselController,
                          //   options: CarouselOptions(
                          //     autoPlay: false,
                          //     enlargeCenterPage: true,
                          //     viewportFraction: 0.9,
                          //     aspectRatio: 2.0,
                          //     initialPage: 1,
                          //     autoPlayInterval: Duration(seconds: 10),
                          //     autoPlayAnimationDuration:
                          //         Duration(milliseconds: 2000),
                          //     scrollDirection: Axis.horizontal,
                          //     onPageChanged: (index, reason) {
                          //       setState(() {
                          //         _current = index;
                          //       });
                          //     },
                          //   ),

                          //   items: imgList.map((imgUrl) {
                          //     return Builder(
                          //       builder: (BuildContext context) {
                          //         return Container(
                          //           width: MediaQuery.of(context).size.width,
                          //           margin:
                          //               EdgeInsets.symmetric(horizontal: 10.0),
                          //           decoration: BoxDecoration(
                          //             color: Colors.white,
                          //           ),
                          //           child: GestureDetector(
                          //             onTap: () {
                          //               //viewImage(_current);
                          //             },
                          //             child: imgUrl == null
                          //                 ? CircularProgressIndicator()
                          //                 : Image.asset(
                          //                     imgUrl,
                          //                     fit: BoxFit.contain,
                          //                   ),
                          //           ),
                          //         );
                          //       },
                          //     );
                          //   }).toList(),
                          // ),
                        )),
                  ],
                ),

                SizedBox(
                  height: 0,
                ),
                // Container(
                //     width: 50,
                //     child: Divider(
                //       color: mainheader,
                //     )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.product_info["product_name"],
                        style: TextStyle(fontSize: 17, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Product Code: ",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black45),
                          ),
                          Text(widget.product_info["product_code"],
                              style: TextStyle(
                                fontSize: 14,
                                color: mainheader,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Size: ",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black45),
                          ),
                          Text(
                              widget.product_info["product_size"] == ""
                                  ? "N/A"
                                  : "${widget.product_info["product_size"]}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54))
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Stock: ",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black45),
                          ),
                          Text(
                              widget.product_info["prod_quantity"] == "0"
                                  ? "Out of stock"
                                  : "${widget.product_info["prod_quantity"]}",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54))
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            child: Row(
                              children: <Widget>[
                                //Icon(
                                //Icons.attach_money,
                                //color: discountAmt == 0.0
                                //? Colors.black
                                //: Colors.grey,
                                //size: 20,
                                //),
                                SizedBox(
                                  width: 0,
                                ),
                                Text(
                                  "Tk. ${widget.product_info["product_price"]}",
                                  style: TextStyle(
                                      color: discountAmt == 0.0
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: 17,
                                      decoration: discountAmt == 0.0
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough),
                                )
                              ],
                            ),
                          ),
                          discountAmt == 0.0
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: <Widget>[
                                      //Icon(
                                      //Icons.attach_money,
                                      //color: Colors.black,
                                      //size: 20,
                                      //),
                                      SizedBox(
                                        width: 0,
                                      ),
                                      Text(
                                        "Tk. $discountAmt (${widget.product_info["prod_discount"]}%)",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: golden,
                                  size: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 3),
                                  child: Text(
                                    "${widget.product_info["prod_rating"]} (${widget.product_info["rev_count"]})",
                                    //widget.product_info["prod_rating"],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Product Description",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product_info["prod_description"],
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15, color: Colors.black45),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Product Information",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      //color: Colors.grey[200],
                                      //padding: EdgeInsets.all(20),
                                      child: Text(
                                    "Product dimension",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                        child: Text(
                                      widget.product_info["prod_dimension"] ==
                                              ""
                                          ? "N/A"
                                          : "${widget.product_info["prod_dimension"]}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                  )
                                  //Container(
                                  //child: Text(
                                  //widget.product_info["prod_dimension"],
                                  //textAlign: TextAlign.start,
                                  //style: TextStyle(color: Colors.black54),
                                  //))
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      //color: Colors.grey[200],
                                      //padding: EdgeInsets.all(20),
                                      child: Text(
                                    "Shipping Weight",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                  Expanded(
                                    child: Container(
                                        child: Text(
                                      widget.product_info["shipping_weight"],
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                  )
                                  //Container(
                                  //child: Text(
                                  //widget.product_info["shipping_weight"],
                                  //textAlign: TextAlign.start,
                                  //style: TextStyle(color: Colors.black54),
                                  //))
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      //color: Colors.grey[200],
                                      //padding: EdgeInsets.all(20),
                                      child: Text(
                                    "Manufacturer",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                        child: Text(
                                      widget.product_info["manuf_name"],
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                  )
                                  //Container(
                                  //child: Text(
                                  //widget.product_info["manuf_name"],
                                  //textAlign: TextAlign.start,
                                  //style: TextStyle(color: Colors.black54),
                                  //))
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      //color: Colors.grey[200],
                                      //padding: EdgeInsets.all(20),
                                      child: Text(
                                    "SIN",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                        child: Text(
                                      widget.product_info["prod_serial_num"],
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                  )
                                  //Container(
                                  //child: Text(
                                  //widget.product_info["prod_serial_num"],
                                  //textAlign: TextAlign.start,
                                  //style: TextStyle(color: Colors.black54),
                                  //))
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
        ),
      ),
    );
  }
}
