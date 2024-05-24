import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:karon_api/app/views/viewproductCategory.dart';

class ProductCategory extends StatefulWidget {


  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {

  List<dynamic>? allCategory;

   getCategory () async{
    Uri uri = Uri.parse("https://dummyjson.com/products/categories");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        allCategory = json;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ProductCategory"),),
    body: (allCategory!=null)?ListView.builder(
      itemCount: allCategory!.length,
      itemBuilder: (context,index)
      {
        return ListTile(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    ViewProductsCategory(name: allCategory![index].toString(),))
            );
          },
          title: Text(allCategory![index].toString()),
        );
      },
    ):SizedBox(),
    );
  }
}
