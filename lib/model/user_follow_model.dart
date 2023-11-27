enum Status {
  accepted,
  requested;

  static Status from(String? status) {
    if (status == null) return Status.accepted;
    if (status == "accepted") {
      return Status.accepted;
    } else {
      return Status.requested;
    }
  }
}

class UserFollowModel {
  String? name;
  String? userName;
  String? email;
  String? uId;
  String? image;
  Status? status;

  UserFollowModel({
    this.name,
    this.userName,
    this.email,
    this.uId,
    this.image,
    this.status
  });

  static UserFollowModel fromJson(Map<String, dynamic> json) =>
    new UserFollowModel(
      name: json['name'],
      userName: json['userName'],
      email: json['email'],
      uId: json['_id'],
      image: json['image'],
      status: Status.from(json['status']),
    );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userName': userName,
      'email': email,
      'uId': uId,
      'image': image,
    };
  }
}
