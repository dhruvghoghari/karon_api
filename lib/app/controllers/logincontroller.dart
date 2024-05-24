import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{

  RxBool isLogin = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  Future? userLogin(String username, String password) async{
    try{
      var headers = {'Content-Type': 'application/json'};
      var params = {
      'username': username,
      'password': password,
      };
      Uri uri = Uri.parse("https://dummyjson.com/auth/login");
      var response = await http.post(uri,body:jsonEncode(params),headers: headers);
      if(response.statusCode == 200){
         var json = jsonDecode(response.body);

         SharedPreferences prefs = await SharedPreferences.getInstance();
         var name = json['username'].toString();
         var email = json['email'].toString();
         var firstName = json['firstName'].toString();
         var lastName = json['lastName'].toString();
         var gender = json['gender'].toString();
         var image = json['image'].toString();


         prefs.setString('username', name);
         prefs.setString('email', email);
         prefs.setString('firstName', firstName);
         prefs.setString('lastName', lastName);
         prefs.setString('gender', gender);
         prefs.setString('image', image);


         return {
           "status":true,
           "message":"Login success"
         };
      }
      else{
        return {
          "status":false,
          "message":"Login fail"
        };
      }
    }
    catch(ex){
      return {
        "status":false,
        "message":"Login fail"
      };
    }
  }
}