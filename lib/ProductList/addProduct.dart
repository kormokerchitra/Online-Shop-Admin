import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_admin/main.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> categoryList = ["Phone", "Computer", "Television"];
  String _value = "";
  Future<File> fileImage;

  @override
  void initState() {
    super.initState();
    _value = categoryList[0];
  }

  pickImagefromGallery(ImageSource src) {
    setState(() {
      fileImage = ImagePicker.pickImage(source: src);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      Text("Add Product",
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
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Category",
                style: TextStyle(color: subheader, fontSize: 12),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _value,
                  icon: const Icon(Icons.expand_more),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 0,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _value = newValue;
                    });
                  },
                  items: categoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Name",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product name", border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Code",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product code", border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Price",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product price",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Description",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product description",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Information",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product information",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Dimension",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product demension",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Size",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product size", border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Shipping Weight",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter shipping weight",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Manufacturer Name",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter manufacturer name",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Serial Number",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter serial number",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Code",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter product code", border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Image",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              GestureDetector(
                onTap: () {
                  pickImagefromGallery(ImageSource.gallery);
                },
                child: Container(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        FutureBuilder<File>(
                          future: fileImage,
                          builder: (BuildContext context,
                              AsyncSnapshot<File> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                padding: EdgeInsets.all(1.0),
                                decoration: new BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(
                                        width: 0.3, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: FileImage(snapshot.data),
                                      fit: BoxFit.cover
                                    )),
                              );
                            } else if (snapshot.error != null) {
                              return const Text(
                                'Error Picking Image',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                padding: EdgeInsets.all(1.0),
                                decoration: new BoxDecoration(
                                    color: Colors.grey.withOpacity(0.4),
                                    border: Border.all(
                                        width: 0.3, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: AssetImage('assets/product_back.jpg'),
                                      fit: BoxFit.cover
                                    )),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 20, top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: mainheader,
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
