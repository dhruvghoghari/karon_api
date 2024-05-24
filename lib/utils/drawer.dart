import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karon_api/app/views/jsonplaceholder/comments.dart';
import 'package:karon_api/app/views/jsonplaceholder/getdummy.dart';
import 'package:karon_api/app/views/jsonplaceholder/user.dart';
import 'package:karon_api/app/views/loginview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/views/users/Singleuser.dart';
import '../app/views/users/userdetails.dart';
import '../app/views/users/userlist.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title:  Text('users'),
            onTap: () {
              Get.to(() => User());
            },
          ),
          ListTile(
            title:  Text('Comments'),
            onTap: () {
              Get.to(() => Comments());
            },
          ),
          ListTile(
            title: Text("UserList"),
            onTap: (){
              Get.to(() => UserList());
            },
          ),
          ListTile(
            title: Text("GetDummy"),
            onTap: (){
              Get.to(() => GetDummy());
            },
          ),
          ListTile(
            title: Text("Single User"),
            onTap: (){
              Get.to(() => SingleUser());
            },
          ),
          ListTile(
            title: Text("UserDetails"),
            onTap: (){
              Get.to(() => UserDetails());
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Get.offAll(LoginView());
            },
          )
        ],
      ),
    );
  }
}