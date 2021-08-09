import 'package:flutter/material.dart';
import 'package:online_shopping_admin/main.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
                      Text("Product List",
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
                          Text('Add Category'),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.3, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter category name",
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
                                "Add",
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
                            child: Row(
                              children: [
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
                                                Text('Edit Category'),
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
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter category name",
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                            color:
                                                                Colors.grey)),
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10,
                                                          bottom: 10),
                                                      child: Text('No')),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10,
                                                          bottom: 10),
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
                                          color:
                                              Colors.redAccent.withOpacity(0.6),
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
            }),
          ),
        ),
      ),
    );
  }
}
