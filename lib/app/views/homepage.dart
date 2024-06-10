import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karon_api/app/controllers/homecontroller.dart';
import 'package:karon_api/app/controllers/productcontroller.dart';
import 'package:http/http.dart' as http;
import '../../utils/drawer.dart';
import '../../utils/responsive.dart';
import 'detailsproduct.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeCon = Get.put(HomeController());
  ProductController productCon = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();

  //  List<ProductsModel>? allData;
  //
  // getData() async
  // {
  //   try{
  //     Uri url = Uri.parse("https://dummyjson.com/products?limit=30");
  //     var response = await http.get(url);
  //     if(response.statusCode == 200){
  //       var body = response.body.toString();
  //       var json = jsonDecode(body);
  //       setState(() {
  //         allData = json['products'].map<ProductsModel>((obj)=>ProductsModel.fromJson(obj)).toList();
  //       });
  //       //print("get Data======"+allData.toString());
  //     }
  //   }
  //   catch(ex){
  //     print("error" + ex.toString());
  //   }
  // }

  // searchData(q) async {
  //   Uri url= Uri.parse("https://dummyjson.com/products/search?q="+q);
  //   var response = await http.get(url);
  //   if(response.statusCode == 200){
  //     var body = response.body.toString();
  //     var json = jsonDecode(body);
  //     setState(() {
  //       allData = json['products'].map<ProductsModel>((obj) =>ProductsModel.fromJson(obj)).toList();
  //     });
  //   }
  // }
  @override
  void initState() {
    super.initState();
    homeCon.api.getProducts()!.then((value){
      homeCon.productList!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(title: Text(''),),
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
                  //productCon.api.searchData(q);
              }, child: Text("Search"))
              ],
            ),
            Expanded(child: (homeCon.productList!=null)?
            ListView.builder(
                itemCount:homeCon.productList!.length,
                itemBuilder: (BuildContext context,int index){
                  return GestureDetector(
                    onTap: (){
                      Get.to(() => DetailsProduct(
                          id: homeCon.productList![index].id.toString()
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
                        padding: EdgeInsets.all(Responsive.height * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                homeCon.productList![index].thumbnail.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                             hGap(1),
                            Text(
                              homeCon.productList![index].title.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            hGap(1),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow[700]),
                                wGap(2),
                                Text(
                                  homeCon.productList![index].rating.toString(),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            hGap(1),
                            Text(
                              homeCon.productList![index].description.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                            hGap(1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${homeCon.productList![index].price.toString()}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Discount: ${homeCon.productList![index].discountPercentage.toString()}%",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            hGap(1),
                            Text(
                              "Brand: ${homeCon.productList![index].brand.toString()}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Category: ${homeCon.productList![index].category.toString()}",
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