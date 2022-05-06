import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_admin/ProductList/productList.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatefulWidget {
  final prod_item;
  EditProduct(this.prod_item);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  var prodList = [];
  var catInfoList = [];
  List<String> categoryList = [];
  String _value = "", catId = "";
  TextEditingController prodnameEditController = new TextEditingController();
  TextEditingController prodcodeEditController = new TextEditingController();
  TextEditingController prodpriceEditController = new TextEditingController();
  TextEditingController proddesEditController = new TextEditingController();
  TextEditingController proddimEditController = new TextEditingController();
  TextEditingController prodsizeEditController = new TextEditingController();
  TextEditingController prodshipEditController = new TextEditingController();
  TextEditingController prodmanufEditController = new TextEditingController();
  TextEditingController prodsernumEditController = new TextEditingController();
  TextEditingController prodstockController = new TextEditingController();
  File fileImage;
  String product_pic = "";
  String base64Image = "";
  bool imageLoader = false;

  @override
  void initState() {
    super.initState();
    fetchCategory();
    product_pic = "${widget.prod_item["product_img"]}";
    if (product_pic != "") {
      setState(() {
        imageLoader = true;
      });
      convertURLToBase64(ip + product_pic);
    }
    setState(() {
      prodnameEditController.text = widget.prod_item["product_name"];
      prodcodeEditController.text = widget.prod_item["product_code"];
      prodpriceEditController.text = widget.prod_item["product_price"];
      proddesEditController.text = widget.prod_item["prod_description"];
      proddimEditController.text = widget.prod_item["prod_dimension"];
      prodsizeEditController.text = widget.prod_item["product_size"];
      prodshipEditController.text = widget.prod_item["shipping_weight"];
      prodmanufEditController.text = widget.prod_item["manuf_name"];
      prodsernumEditController.text = widget.prod_item["prod_serial_num"];
      prodstockController.text = widget.prod_item["prod_quantity"];
    });
  }

  Future<void> fetchCategory() async {
    final response = await http.get(ip + 'easy_shopping/category_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var categoryBody = json.decode(response.body);
      print(categoryBody["cat_list"]);
      setState(() {
        catInfoList = categoryBody["cat_list"];
        for (int i = 0; i < catInfoList.length; i++) {
          if (widget.prod_item["cat_id"] == catInfoList[i]["cat_id"]) {
            _value = catInfoList[i]["cat_name"];
            catId = catInfoList[i]["cat_id"];
          }
          categoryList.add(catInfoList[i]["cat_name"]);
        }

        print("_value");
        print(_value);
        print("catId");
        print(catId);
      });
      print("categoryList.length");
      print(categoryList.length);
    } else {
      throw Exception('Unable to fetch category from the REST API');
    }
  }

  Future<void> editProduct() async {
    List<int> imageBytes = fileImage.readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    var bodyData = {
      "product_name": prodnameEditController.text,
      "product_code": prodcodeEditController.text,
      "product_price": prodpriceEditController.text,
      "prod_description": proddesEditController.text,
      "prod_dimension": proddimEditController.text,
      "product_size": prodsizeEditController.text,
      "shipping_weight": prodshipEditController.text,
      "manuf_name": prodmanufEditController.text,
      "prod_serial_num": prodsernumEditController.text,
      "prod_id": widget.prod_item["prod_id"],
      "cat_id": widget.prod_item["cat_id"],
      "stock": prodstockController.text,
      "product_img": base64Image,
    };
    print(bodyData);
    final response =
        await http.post(ip + 'easy_shopping/product_edit.php', body: bodyData);
    print(response.body);
    if (response.statusCode == 200) {
      if (response.body == "Success") {
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
        prodstockController.clear();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductList()));
      }
    } else {
      throw Exception('Unable to edit product from the REST API');
    }
  }

  convertURLToBase64(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    List<int> imageBytes = response.bodyBytes;
    base64Image = base64Encode(imageBytes);
    setState(() {
      imageLoader = false;
    });
    print("base64Image download");
    print(base64Image);
  }

  Future<Null> pickImagefromGallery(ImageSource src) async {
    final image = await ImagePicker.pickImage(source: src);

    setState(() {
      fileImage = image;
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
                child: _value == ""
                    ? Container()
                    : DropdownButton<String>(
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
                  controller: prodnameEditController,
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
                  controller: prodcodeEditController,
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
                  controller: prodpriceEditController,
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
                  controller: proddesEditController,
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
                  controller: proddimEditController,
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
                  controller: prodsizeEditController,
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
                  controller: prodshipEditController,
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
                  controller: prodmanufEditController,
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
                  controller: prodsernumEditController,
                  decoration: InputDecoration(
                      hintText: "Enter serial number",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Stock",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  controller: prodstockController,
                  decoration: InputDecoration(
                      hintText: "Enter stock", border: InputBorder.none),
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
                        fileImage != null
                            ? Container(
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
                                    image: FileImage(fileImage),
                                  ),
                                ),
                              )
                            : product_pic != ""
                                ? imageLoader
                                    ? CircularProgressIndicator()
                                    : Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        padding: EdgeInsets.all(1.0),
                                        decoration: new BoxDecoration(
                                          color: Colors.grey.withOpacity(0.4),
                                          border: Border.all(
                                              width: 0.3, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(ip + product_pic),
                                          ),
                                        ),
                                      )
                                : Container(
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
                                          image: AssetImage(
                                              'assets/product_back.jpg'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  editProduct();
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
