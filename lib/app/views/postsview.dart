import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karon_api/app/controllers/postscontroller.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {

  var isLoading = false;
  PostsController con = Get.put(PostsController());
  @override
  void initState() {
    super.initState();
    con.api.getPost()!.then((data) {
      con.postList(data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post"),),
      body: Obx(() {
        return ListView.builder(
            itemCount: con.postList.length,
            itemBuilder: (BuildContext context ,int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey.withAlpha(20),
                  child:Column(
                    children: [
                      Text(con.postList[index].title!),
                      Text(con.postList[index].body!)
                    ],
                  )

                ),
              );
            }
        );
      })
    );
  }
}