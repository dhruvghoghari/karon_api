class CommentsModel {
  int? id;
  int? postId;
  int? userId;
  String? comment;

  CommentsModel({this.id, this.postId, this.userId, this.comment});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    userId = json['userId'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['userId'] = this.userId;
    data['comment'] = this.comment;
    return data;
  }
}
