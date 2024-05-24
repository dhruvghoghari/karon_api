import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:karon_api/app/controllers/homecontroller.dart';
import 'package:karon_api/models/usermodel.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  HomeController homeCon = Get.put(HomeController());

  List<UserModel>? getAllUser;
  List<UserModel>? filteredUserList;

  getUser() async{
    try{
      Uri url = Uri.parse('https://jsonplaceholder.org/users');
      var response = await http.get(url);
      if(response.statusCode == 200){
        var body = response.body.toString();
        var json = jsonDecode(body);
        setState(() {
          getAllUser = json.map<UserModel>((obj)=>UserModel.fromJson(obj)).toList();
          filteredUserList = getAllUser;
        });
      }
    }
    catch (ex){
      print(ex);
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
      appBar: AppBar(title: Text("User"),),
      body:Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (query){
                    setState(() {
                      filteredUserList = getAllUser!.where((element) {
                        final userTitle = element.firstname!.toLowerCase();
                        final queryLowercase = query.toLowerCase();
                        return userTitle.contains(queryLowercase);
                      }).toList();
                    });
                  },
                  controller: homeCon.searchCon,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Search Users...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){

              }, child: Text("Search"))
            ],
          ),
          Expanded(
            child:(getAllUser == null)?Center(child: CircularProgressIndicator()):ListView.builder(
                itemCount: getAllUser!.length,
                itemBuilder: (context ,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${getAllUser![index].firstname!} ${getAllUser![index].lastname!}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  getAllUser![index].email!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              getAllUser![index].birthDate!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            Divider(color: Colors.grey[300], thickness: 1, height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Username: ${getAllUser![index].login!.username!}'),
                                Text('Password: ${getAllUser![index].login!.password!}'),
                              ],
                            ),
                            Divider(color: Colors.grey[300], thickness: 1, height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(getAllUser![index].address!.street!),
                                Text(getAllUser![index].address!.suite!),
                                Text(getAllUser![index].address!.city!),
                                Text(getAllUser![index].address!.zipcode!),
                                Text('${getAllUser![index].address!.geo!.lat}, ${getAllUser![index].address!.geo!.lng!}'),
                              ],
                            ),
                            Divider(color: Colors.grey[300], thickness: 1, height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phone: ${getAllUser![index].phone!}'),
                                Text('Website: ${getAllUser![index].website!}'),
                                Text('Company: ${getAllUser![index].company!.name!}'),
                                Text('CatchPhrase: ${getAllUser![index].company!.catchPhrase!}'),
                                Text('BS: ${getAllUser![index].company!.bs!}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(onPressed: (){

                                }, icon: Icon(Icons.edit,color: Colors.green,)),
                                IconButton(onPressed: (){

                                }, icon: Icon(Icons.delete,color: Colors.red,))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      )
    );
  }
}