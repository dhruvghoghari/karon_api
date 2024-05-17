import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/produtsmodel.dart';

class DetailsProduct extends StatefulWidget {
  var id ="";
  DetailsProduct({super.key, required this.id});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {

  ProductsModel? obj;
  getSingleProducts() async {
    try{
      Uri uri = Uri.parse("https://dummyjson.com/products/"+widget.id);
      var response = await http.get(uri);
      if(response.statusCode == 200){
        var json = jsonDecode(response.body.toString());
        print("Details response ==="+json.toString());
        setState(() {
          obj = ProductsModel.fromJson(json);
        });
      }
    }
    catch(ex){
      print("error" + ex.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getSingleProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("detailsProducts"),),
      body: Column(
        children: [
          obj != null
              ? Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10.0),
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
                  CachedNetworkImage(
                    imageUrl: obj!.thumbnail.toString(),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                        Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    obj!.title.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    obj!.description.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                obj!.rating.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.price_check, color: Colors.green, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                "\$${obj!.price.toString()}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.local_offer, color: Colors.red, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                "${obj!.discountPercentage.toString()}% off",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            obj!.brand.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            obj!.category.toString(),
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}