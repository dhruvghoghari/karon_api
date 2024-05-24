import 'package:get/get.dart';
import 'package:karon_api/app/controllers/logincontroller.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(),);
  }
}