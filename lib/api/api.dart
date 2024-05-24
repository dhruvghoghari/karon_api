import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:karon_api/utils/constants.dart';
import '../models/produtsmodel.dart';

class Api {
  Future? getData() async {
    try {
      Uri url = Uri.parse(Constants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var body = response.body.toString();
        var json = jsonDecode(body);
        return ProductsModel.fromJson(json);
        //return json['products'].map<ProductsModel>((obj) => ProductsModel.fromJson(obj)).toList();
      }
    }
    catch (ex) {
      return ex;
    }
  }
  

}