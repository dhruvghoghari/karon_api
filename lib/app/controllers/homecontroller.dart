import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karon_api/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/mainproducts.dart';

class HomeController extends GetxController{

  TextEditingController searchCon = TextEditingController();

  List<MainProducts>? productList;
  Api api = Api();

  var name = "".obs;
  var email = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var gender ="".obs;
  var image ="".obs;

  userData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString("username") ?? "";
    email.value = prefs.getString("email") ?? "";
    firstName.value = prefs.getString("firstName") ?? "";
    lastName.value = prefs.getString("lastName") ?? "";
    gender.value = prefs.getString("gender") ?? "";
    image.value = prefs.getString("image") ?? "";
  }

}