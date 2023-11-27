class GoalFriendsModel {
  String? sId;
  String? name;
  String? image;
  String? userName;
  bool? isInvitedInGoal;

  GoalFriendsModel(
      {this.sId, this.name, this.image, this.userName, this.isInvitedInGoal});

  GoalFriendsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    userName = json['userName'];
    isInvitedInGoal = json['isInvitedInGoal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['userName'] = this.userName;
    data['isInvitedInGoal'] = this.isInvitedInGoal;
    return data;
  }
}
