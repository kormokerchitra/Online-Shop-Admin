import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_shopping_admin/AllProductPage/allProductPage.dart';
import 'package:online_shopping_admin/main.dart';
import 'package:http/http.dart' as http;

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var categoryList = [];
  TextEditingController categoryController = new TextEditingController();
  TextEditingController categoryEditController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategory();
  }

  Future<void> fetchCategory() async {
    final response = await http.get(ip + 'easy_shopping/category_list.php');
    if (response.statusCode == 200) {
      print(response.body);
      var categoryBody = json.decode(response.body);
      print(categoryBody["cat_list"]);
      setState(() {
        categoryList = categoryBody["cat_list"];
      });
      print(categoryList.length);
    } else {
      throw Exception('Unable to fetch category from the REST API');
    }
  }

  Future<void> deleteCategory(String cat_id) async {
    final response = await http.post(ip + 'easy_shopping/category_delete.php',
        body: {"cat_id": cat_id});
    print("cat_id - " + cat_id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      fetchCategory();
    } else {
      throw Exception('Unable to delete category from the REST API');
    }
  }

  Future<void> addCategory(String name) async {
    final response = await http
        .post(ip + 'easy_shopping/category_add.php', body: {"cat_name": name});
    print("name - " + name);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      categoryController.clear();
      fetchCategory();
    } else {
      throw Exception('Unable to add caegory from the REST API');
    }
  }

  Future<void> editCategory(String name, String cat_id) async {
    final response =
        await http.post(ip + 'easy_shopping/category_edit.php', body: {
      "cat_name": name,
      "cat_id": cat_id,
    });
    print("name - " + name);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      categoryEditController.clear();
      fetchCategory();
    } else {
      throw Exception('Unable to edit caegory from the REST API');
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
                      Text("Category List",
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
                              controller: categoryController,
                              decoration: InputDecoration(
                                  hintText: "Enter category name",
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (categoryController.text != "") {
                                addCategory(categoryController.text);
                              }
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: List.generate(categoryList.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllProductPage(
                              cat_id: categoryList[index]["cat_id"],
                              cat_name: categoryList[index]["cat_name"],
                            )),
                  );
                },
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${categoryList[index]["cat_name"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.shopping_basket,
                                                  color: Colors.grey,
                                                  size: 17,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "${categoryList[index]["product_count"]} Items",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ],
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
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    categoryEditController.text =
                                        categoryList[index]["cat_name"];
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
                                                    controller:
                                                        categoryEditController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Enter category name",
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (categoryEditController
                                                            .text !=
                                                        "") {
                                                      editCategory(
                                                          categoryEditController
                                                              .text,
                                                          categoryList[index]
                                                              ["cat_id"]);
                                                    }
                                                  },
                                                  child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin: EdgeInsets.only(
                                                          bottom: 20, top: 10),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                          color: mainheader,
                                                          border: Border.all(
                                                              width: 0.2,
                                                              color:
                                                                  Colors.grey)),
                                                      child: Text(
                                                        "Edit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
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
                                            title: Text('Delete Category'),
                                            content: Text(
                                                'Do you want to delete the category?'),
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
                                                  deleteCategory(
                                                      categoryList[index]
                                                          ["cat_id"]);
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
