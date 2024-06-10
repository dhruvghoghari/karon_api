import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class AppTheme{

  static getSnackBar({String? message,String? color}) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 45.0
    ));
  }

}

String? nameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Firstname';
  }
  return null;
}


String? passwordValidation(String? value) {
  {
    if (value == null || value.isEmpty) {
      return 'Please enter a Password';

    } else if (value.length != 8) {
      return 'Please enter a valid 10-digit Password';
    }
    return null;
  }
}
