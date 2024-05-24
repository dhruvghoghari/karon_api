import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:karon_api/models/userlistmodel.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  List<UserListModel>? getAllData;

  getUser() async{
    Uri uri = Uri.parse('https://api.restful-api.dev/objects');
    var response = await http.get(uri);
    if(response.statusCode == 200){
      var body = response.body.toString();
      var json = jsonDecode(body);
      print("Get response ==================================="+json.toString());
      setState(() {
        getAllData = json.map<UserListModel>((obj)=>UserListModel.fromJson(obj)).toList();
      });
      print("getAllData============="+getAllData.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UserList"),),
      body:(getAllData == null)?Center(child: CircularProgressIndicator()):ListView.builder(
        itemCount: getAllData!.length,
        itemBuilder: (context , index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(0.10)
              ),
              child: Column(
                children: [
                  Text(getAllData![index].name.toString()),
                  Text(getAllData![index].data!.dataColor.toString()),
                  Text(getAllData![index].data!.dataCapacity.toString()),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}