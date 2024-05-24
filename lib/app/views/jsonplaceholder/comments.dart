import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/commentsmodel.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {

  List<CommentsModel>? allComments;
  getComments() async{
    Uri uri = Uri.parse("https://jsonplaceholder.org/comments");
    var response = await http.get(uri);
    if(response.statusCode == 200){
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        allComments = json.map<CommentsModel>((obj)=>CommentsModel.fromJson(obj)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comments"),),
      body: (allComments == null)?Center(child: SingleChildScrollView()):ListView.builder(
        itemCount: allComments!.length,
        itemBuilder: (context , index){
          return Column(
            children: [
            Text(allComments![index].postId.toString()),
              Text(allComments![index].userId.toString()),
              Text(allComments![index].comment.toString()),
            ],
          );
        }
      )
    );
  }
}
