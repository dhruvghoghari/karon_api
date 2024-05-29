import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karon_api/app/controllers/homecontroller.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.userData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prfile"),),
      body: SafeArea(
        child: Column(
          children: [
            Image.network(homeController.image.value),
            Text(homeController.name.value),
            Text(homeController.lastName.value),
            Text(homeController.gender.value),
            Text(homeController.email.value)
          ],
        ),
      ),
    );
  }
}