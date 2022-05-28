import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping_admin/ProductList/productList.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //var categoryList = [];
  TextEditingController prodnameController = new TextEditingController();
  TextEditingController prodcodeController = new TextEditingController();
  TextEditingController prodpriceController = new TextEditingController();
  TextEditingController proddesController = new TextEditingController();
  TextEditingController proddiscController = new TextEditingController();
  TextEditingController proddiscdateController = new TextEditingController();
  TextEditingController proddimController = new TextEditingController();
  TextEditingController prodsizeController = new TextEditingController();
  TextEditingController prodshipController = new TextEditingController();
  TextEditingController prodmanufController = new TextEditingController();
  TextEditingController prodsernumController = new TextEditingController();
  TextEditingController prodstockController = new TextEditingController();

  List<String> categoryList = [];
  //List<String> categoryList = ["Phone", "Computer", "Television"];
  String _value = "", catId = "", totalProduct = "", base64Image = "";
  File fileImage;
  var catInfoList = [];

  //@override
  //void initState() {
  // TODO: implement initState
  //super.initState();
  //fetchCategory();
  //}

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  Future<Null> pickImagefromGallery(ImageSource src) async {
    final image = await ImagePicker.pickImage(source: src);

    setState(() {
      fileImage = image;
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
          categoryList.add(catInfoList[i]["cat_name"]);
        }
        _value = categoryList[0];
        catId = catInfoList[0]["cat_id"];

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

  Future<void> addProduct() async {
    if (fileImage != null) {
      List<int> imageBytes = fileImage.readAsBytesSync();
      print(imageBytes);
      base64Image = base64Encode(imageBytes);
    }
    var bodyData = {
      "product_name": prodnameController.text,
      "cat_id": catId,
      "product_img": base64Image,
      "product_code": prodcodeController.text,
      "product_price": prodpriceController.text,
      "prod_discount": proddiscController.text,
      "prod_disc_date": proddiscdateController.text,
      "prod_description": proddesController.text,
      "prod_dimension": proddimController.text,
      "product_size": prodsizeController.text,
      "shipping_weight": prodshipController.text,
      "manuf_name": prodmanufController.text,
      "prod_serial_num": prodsernumController.text,
      "stock": prodstockController.text,
    };
    print(bodyData);

    final response =
        await http.post(ip + 'easy_shopping/product_add.php', body: bodyData);

    print(response.statusCode);
    print("response.body");
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      prodnameController.clear();
      prodcodeController.clear();
      prodpriceController.clear();
      proddesController.clear();
      proddiscController.clear();
      proddiscdateController.clear();
      proddimController.clear();
      prodsizeController.clear();
      prodshipController.clear();
      prodmanufController.clear();
      prodsernumController.clear();
      prodstockController.clear();
      editCategoryProductCount();
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductList()));
    } else {
      throw Exception('Unable to add product from the REST API');
    }
  }

  Future<void> editCategoryProductCount() async {
    int totalProductInt = int.parse(totalProduct);
    totalProductInt++;
    print("totalProductInt");
    print(totalProductInt);
    final response =
        await http.post(ip + 'easy_shopping/category_product_count.php', body: {
      "product_count": "$totalProductInt",
      "cat_id": catId,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Unable to edit caegory from the REST API');
    }
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
                      for (int i = 0; i < catInfoList.length; i++) {
                        if (newValue == catInfoList[i]["cat_name"]) {
                          catId = catInfoList[i]["cat_id"];
                          totalProduct = catInfoList[i]["product_count"];
                        }
                      }
                      _value = newValue;
                      print(catId);
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
                  controller: prodnameController,
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
                  controller: prodcodeController,
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
                  controller: prodpriceController,
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
                  controller: proddesController,
                  decoration: InputDecoration(
                      hintText: "Enter product description",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Product Discount",
                    style: TextStyle(color: subheader, fontSize: 12),
                  )),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  controller: proddiscController,
                  decoration: InputDecoration(
                      hintText: "Enter product discount",
                      border: InputBorder.none),
                ),
              ),
              //Container(
              //margin: EdgeInsets.only(top: 20),
              //child: Text(
              //"Product Discount Expire Date",
              //style: TextStyle(color: subheader, fontSize: 12),
              //)),
              //Container(
              //padding: EdgeInsets.all(5),
              //margin: EdgeInsets.only(top: 10),
              //decoration: BoxDecoration(
              //border: Border.all(width: 0.3, color: Colors.grey),
              //borderRadius: BorderRadius.circular(5)),
              //child: TextField(
              //controller: proddiscdateController,
              //decoration: InputDecoration(
              //hintText: "Enter product discount expire date",
              //border: InputBorder.none),
              //),
              //),
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
                  controller: proddimController,
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
                  controller: prodsizeController,
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
                  controller: prodshipController,
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
                  controller: prodmanufController,
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
                  controller: prodsernumController,
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
                                      image:
                                          AssetImage('assets/product_back.jpg'),
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
                  addProduct();
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
                      "Add",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
