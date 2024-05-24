import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:karon_api/models/produtsmodel.dart';

class ViewProductsCategory extends StatefulWidget {
  var name="";
   ViewProductsCategory({required this.name});

  @override
  State<ViewProductsCategory> createState() => _ViewProductsCategoryState();
}

class _ViewProductsCategoryState extends State<ViewProductsCategory> {

  List<ProductsModel>? allCategory;

  getCategory() async{

    try{
      Uri url = Uri.parse("https://dummyjson.com/products/category/"+widget.name);
      log("init call "+widget.name);
      var response = await http.get(url);
      if(response.statusCode == 200){
        var body = response.body.toString();
        log(body);
        var json = jsonDecode(body);
        print(json.toString());
        setState(() {
          allCategory = json['products'].map<ProductsModel>((obj)  =>ProductsModel.fromJson(obj)).toList();
        });
      }
    }
    catch(ex){
      print("Error"+ex.toString());
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
      appBar: AppBar(title: Text("ProductsCategory"),),
      body: Column(
        children: [
          Expanded(
            child: allCategory != null
                ? ListView.builder(
              itemCount: allCategory!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            allCategory![index].thumbnail.toString(),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          allCategory![index].title.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          allCategory![index].description.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.orange, size: 20),
                                const SizedBox(width: 5),
                                Text(
                                  allCategory![index].rating.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                              "\$${allCategory![index].price.toString()}",
                              style: const TextStyle(fontSize: 16, color: Colors.green),
                            ),
                            Text(
                              "${allCategory![index].discountPercentage.toString()}% off",
                              style: const TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Brand: ${allCategory![index].brand.toString()}",
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        Text(
                          "Category: ${allCategory![index].category.toString()}",
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : const Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}