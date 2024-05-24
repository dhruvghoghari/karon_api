import 'package:get/get_navigation/src/routes/get_route.dart';
import '../bindings/homebindings.dart';
import '../views/homepage.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}