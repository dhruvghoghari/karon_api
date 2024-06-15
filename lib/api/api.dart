import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:karon_api/utils/constants.dart';
import '../models/mainproducts.dart';
import '../models/posts.dart';

class Api {

  Future? getProducts() async {
    try {
      Uri url = Uri.parse(Constants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var body = response.body.toString();
        var json = jsonDecode(body);
        print("get Products response================== " + json.toString());
        return MainProducts.fromJson(json);
      } else {
        print("Failed to get products. Status code: ${response.statusCode}");
        return null;
      }
    } catch (ex) {
      return apiDialog(e.response!.data['message'])}
  }


  // Future? searchData(q) async{
  //   try{
  //       Uri url= Uri.parse("https://dummyjson.com/products/search?q="+q);
  //       var response = await http.get(url);
  //       if(response.statusCode == 200){
  //         var body = response.body.toString();
  //         var json = jsonDecode(body);
  //         return MainProducts.fromJson(json);
  //       }
  //       else{
  //         print("Faild to data . status code :${response.statusCode}");
  //         return null;
  //       }
  //   }
  //   catch (ex){
  //     print("Error occurred: $ex");
  //     return null;
  //   }
  // }

  Future? getPost() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
     // print("Get Posts response============= : " + json.toString());
      return (json.map<Posts>((obj) => Posts.fromJson(obj)).toList());
    }
    return null;
  }
}