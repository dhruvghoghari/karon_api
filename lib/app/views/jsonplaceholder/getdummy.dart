import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:karon_api/models/postmodel.dart';

class GetDummy extends StatefulWidget {
  const GetDummy({super.key});

  @override
  State<GetDummy> createState() => _GetDummyState();
}

class _GetDummyState extends State<GetDummy> {


  List<PostsModel>? allPosts;

  getPosts() async{
    Uri uri = Uri.parse("https://jsonplaceholder.org/posts");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        allPosts = json.map<PostsModel>((obj)=>PostsModel.fromJson(obj)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetDummy"),),
      body: (allPosts == null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: allPosts!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        allPosts![index].thumbnail!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      allPosts![index].title!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      allPosts![index].slug!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Status: ${allPosts![index].status!}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Category: ${allPosts![index].category!}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      allPosts![index].content!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}