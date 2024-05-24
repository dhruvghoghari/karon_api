import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/userdetailsmodel.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  List<UserDetailsModel>? allUser;

   getUser() async{
    Uri url = Uri.parse("https://dummyjson.com/users");
    var response = await http.get(url);
    if(response.statusCode == 200){
      var body = response.body.toString();
      var json = jsonDecode(body);
      print(" Get User Deatails Response ============== "+json.toString());
      setState(() {
        allUser = json['users'].map<UserDetailsModel>((obj)=>UserDetailsModel.fromJson(obj)).toList();
      });
      print("All User==========="+allUser.toString());
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
      appBar: AppBar(title: Text("UserDetails"),),
      body:(allUser == null)?Center(child: SingleChildScrollView(),):ListView.builder(
        itemCount: allUser!.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300
              ),
              child: Column(
                children: [
                  Text(allUser![index].firstName.toString()),
                  Text(allUser![index].lastName.toString()),
                  Text(allUser![index].age.toString()),
                  Text(allUser![index].hair!.color.toString()),
                  Text(allUser![index].hair!.color.toString()),
                  Text(allUser![index].email.toString()),
                  Text(allUser![index].crypto!.coin.toString())
                ],
              ),
            ),
          );
        }
      )
    );
  }
}