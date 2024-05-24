import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:karon_api/models/userlistmodel.dart';
import 'package:http/http.dart' as http;

class SingleUser extends StatefulWidget {
  const SingleUser({super.key});

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {

  UserListModel? singleObj;
  
  getSingleUser() async{
    Uri url = Uri.parse("https://api.restful-api.dev/objects/7");
    var response = await http.get(url);
    if(response.statusCode == 200){
      var json = jsonDecode(response.body.toString());
      setState(() {
        singleObj =  UserListModel.fromJson(json);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSingleUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Singleuser"),),
      body:(singleObj == null)?Center(child: SingleChildScrollView(),):Column(
        children: [
          Text(singleObj!.data!.year.toString()),
          Text(singleObj!.data!.dataPrice.toString()),
          Text(singleObj!.data!.cpuModel.toString()),
          Text(singleObj!.data!.hardDiskSize.toString()),

        ],
      )
    );
  }
}
