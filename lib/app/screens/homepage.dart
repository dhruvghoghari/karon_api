import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karon_api/models/produtsmodel.dart';
import 'package:http/http.dart' as http;
import 'detailsproduct.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  List<ProductsModel>? allData;

  getData() async
  {
    try{
      Uri url = Uri.parse("https://dummyjson.com/products?limit=30");
      var response = await http.get(url);
      if(response.statusCode == 200){
        var body = response.body.toString();// json to convert to string
        var json = jsonDecode(body);        //
        setState(() {
          allData = json['products'].map<ProductsModel>((obj)=>ProductsModel.fromJson(obj)).toList();
        });
      }
    }
    catch(ex){
      print("error" + ex.toString());
    }
  }
  
  searchData(q) async {
    Uri url= Uri.parse("https://dummyjson.com/products/search?q="+q);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        allData = json['products'].map<ProductsModel>((obj) =>ProductsModel.fromJson(obj)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded( 
                  child: TextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Search Brands and Products...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  var q = searchController.text.toString();
                  searchData(q);
                }, child: Text("Search"))
              ],
            ),
            Expanded(child: (allData!=null)?

            ListView.builder(
                itemCount: allData!.length,
                itemBuilder: (BuildContext context,int index){
                  return GestureDetector(
                    onTap: (){
                      Get.to(() => DetailsProduct(
                          id: allData![index].id.toString()
                      ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0).w,
                              child: Image.network(
                                allData![index].thumbnail.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              allData![index].title.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow[700]),
                                SizedBox(width: 5),
                                Text(
                                  allData![index].rating.toString(),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              allData![index].description.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${allData![index].price.toString()}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Discount: ${allData![index].discountPercentage.toString()}%",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Brand: ${allData![index].brand.toString()}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Category: ${allData![index].category.toString()}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  );
                }
            ):Text("Loading")
            )
          ],
        ),
      )
    );
  }
}