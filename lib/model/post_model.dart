class PostModel {
  String? userId;
  String? userName;
  String? profileImage;
  String? habitTitle;
  String? postImage;

  PostModel(
      {this.userId,
      this.userName,
      this.profileImage,
      this.postImage,
      this.habitTitle});

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
      userId: json['userId'],
      userName: json['userName'],
      profileImage: json['profileImage'],
      postImage: json['postImage'],
      habitTitle: json['habitTitle']);
}
