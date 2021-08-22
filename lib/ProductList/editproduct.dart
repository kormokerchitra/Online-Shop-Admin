import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct>{
  
  var prodList = [];
  TextEditingController prodnameEditController = new TextEditingController();
  TextEditingController prodcodeEditController = new TextEditingController();
  TextEditingController prodpriceEditController = new TextEditingController();
  TextEditingController proddesEditController = new TextEditingController();
  TextEditingController proddimEditController = new TextEditingController();
  TextEditingController prodsizeEditController = new TextEditingController();
  TextEditingController prodshipEditController = new TextEditingController();
  TextEditingController prodmanufEditController = new TextEditingController();
  TextEditingController prodsernumEditController = new TextEditingController(); 
  Future<File> fileImage;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final response = await http.get(ip + 'easy_shopping/product_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var prodBody = json.decode(response.body);
      print(prodBody["product_list"]);
      setState(() {
        prodList = prodBody["product_list"];
      });
      print(prodList.length);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<void> editProduct(String product_name) async {
      final response =
        await http.post(ip + 'easy_shopping/product_status_edit.php', body: {
      "product_name": prodnameEditController.text,
      "product_code": prodcodeEditController.text,
      "product_price": prodpriceEditController.text,
      "prod_description": proddesEditController.text,
      "prod_dimension": proddimEditController.text,
      "product_size": prodsizeEditController.text,
      "shipping_weight": prodshipEditController.text,
      "manuf_name": prodmanufEditController.text,
      "prod_serial_num": prodsernumEditController.text,
      "product_name": product_name,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      prodnameEditController.clear();
      prodcodeEditController.clear();
      prodpriceEditController.clear();
      proddesEditController.clear();
      proddimEditController.clear();
      prodsizeEditController.clear();
      prodshipEditController.clear();
      prodmanufEditController.clear();
      prodsernumEditController.clear();
      fetchProduct();
    } else {
      throw Exception('Unable to edit caegory from the REST API');
    }
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
                      Text("Edit Product",
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
                //child: DropdownButton<String>(
                  //isExpanded: true,
                  //value: _value,
                  //icon: const Icon(Icons.expand_more),
                  //iconSize: 24,
                  //elevation: 16,
                  //underline: Container(
                    //height: 0,
                    //color: Colors.deepPurpleAccent,
                  //),
                  //onChanged: (String newValue) {
                    //setState(() {
                      //_value = newValue;
                   // });
                  //},
                  //items: categoryList
                      //.map<DropdownMenuItem<String>>((String value) {
                    //return DropdownMenuItem<String>(
                      //value: value,
                      //child: Text(value),
                    //);
                  //}).toList(),
                //),
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
                  //controller: prodnameEditController,
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
                  //controller: prodcodeEditController,
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
                  //controller: prodpriceEditController,
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
                  //controller: proddesEditController,
                  decoration: InputDecoration(
                      hintText: "Enter product description",
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
                  //controller: proddimEditController,
                  decoration: InputDecoration(
                      hintText: "Enter product dimension",
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
                  //controller: prodsizeEditController,
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
                  //controller: prodshipEditController,
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
                  //controller: prodmanufEditController,
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
                  //controller: prodsernumEditController,
                  decoration: InputDecoration(
                      hintText: "Enter serial number",
                      border: InputBorder.none),
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
                    "Edit",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),

                  //GestureDetector(
                      //onTap: () {
                          //if (productController.text != "") {
                            //addproduct(productController.text);
                          //}
                      //},
                      //child: Container(
                         //width: MediaQuery.of(context).size.width,
                            //margin: EdgeInsets.only(bottom: 20, top: 10),
                            //padding: EdgeInsets.all(10),
                            //decoration: BoxDecoration(
                               //borderRadius:BorderRadius.all(Radius.circular(5.0)),
                                 //color: mainheader,
                                 //border: Border.all(width: 0.2, color: Colors.grey)),
                                 //child: Text(
                                  //"Add",
                                  //style: TextStyle(color: Colors.white),
                                  //textAlign: TextAlign.center,
                      //)),
                   //),
            ],
          ),
        ),
      ),
    );
  }
}