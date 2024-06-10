import 'package:get/get.dart';
import 'package:karon_api/api/api.dart';
import '../../models/posts.dart';

class PostsController extends GetxController{

  var postList = <Posts>[].obs;
  Api api = Api();
}