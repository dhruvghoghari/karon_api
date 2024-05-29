import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController{

  TextEditingController standardController = TextEditingController();
  TextEditingController executiveController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  TextEditingController specialController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future? addProduct(
  {final String? standard_discount,
    final String? executive_discount,
    final String? manager_discount,
    final String? project_discount,
    final String? special_discount,})
  async{
    try{
      var headers = {
        "Authorization":" bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwaS5lYXJ0aGNvbnRyb2xzeXMuY29tL2FwaS9sb2dpbiIsImlhdCI6MTcxNjg5MDY0MywiZXhwIjoxNzE2OTc3MDQzLCJuYmYiOjE3MTY4OTA2NDMsImp0aSI6Ild5WjNNN0lFUHZwT3JDR3YiLCJzdWIiOiI4IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.gMpxOx0Jdl_TwHwk9DFScUKibIbQltyok6WIWkr7a4E"
      };
      var params = {
        "standard_discount": standard_discount,
        "executive_discount": executive_discount,
        "manager_discount": manager_discount,
        "project_discount": project_discount,
        "special_discount": special_discount,
      };
      Uri url = Uri.parse("https://api.earthcontrolsys.com/api/discount-type/store");
      var response = await http.post(url,body: params,headers: headers);
      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        log(json.toString());
        return {
          "status":true,
          "message": "Product Added Successfully!!"
        };
      }
      else{
        return{
          "status":false,
          "message":response.statusCode.toString()
        };
      }
    }
    catch(ex){
      return{
        "status":false,
        "message":ex.toString()
      };
    }
  }
}