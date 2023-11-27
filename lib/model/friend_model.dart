class FriendModel {
  String? sId;
  String? date;
  String? day;
  bool? completed;
  String? image;
  String? status;
  CreatedBy? createdBy;
  String? goalId;
  String? createdAt;
  String? updatedAt;
  GoalInvite? goalInvite;
  Activity? activity;

  FriendModel(
      {this.sId,
        this.date,
        this.day,
        this.completed,
        this.image,
        this.status,
        this.createdBy,
        this.goalId,
        this.createdAt,
        this.updatedAt,
        this.goalInvite,
        this.activity});

  FriendModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    day = json['day'];
    completed = json['completed'];
    image = json['image'];
    status = json['status'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    goalId = json['goalId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    goalInvite = json['goalInvite'] != null
        ? new GoalInvite.fromJson(json['goalInvite'])
        : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['day'] = this.day;
    data['completed'] = this.completed;
    data['image'] = this.image;
    data['status'] = this.status;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['goalId'] = this.goalId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.goalInvite != null) {
      data['goalInvite'] = this.goalInvite!.toJson();
    }
    if (this.activity != null) {
      data['activity'] = this.activity!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  String? sId;
  String? name;
  String? dob;
  String? image;
  String? mobile;
  List<String>? removeSuggestContact;
  String? frequent;
  String? password;
  String? otp;
  bool? otpVerify;
  String? expireOTP;
  bool? isAdmin;
  String? bio;
  String? token;
  List<String>? invitedBy;
  List<String>? invitedTo;
  List<String>? friends;
  List<String>? pendingFriendRequests;
  List<String>? activeActivities;
  List<String>? invitees;
  String? createdAt;
  String? updatedAt;
  String? userName;

  CreatedBy(
      {this.sId,
        this.name,
        this.dob,
        this.image,
        this.mobile,
        this.removeSuggestContact,
        this.frequent,
        this.password,
        this.otp,
        this.otpVerify,
        this.expireOTP,
        this.isAdmin,
        this.bio,
        this.token,
        this.invitedBy,
        this.invitedTo,
        this.friends,
        this.pendingFriendRequests,
        this.activeActivities,
        this.invitees,
        this.createdAt,
        this.updatedAt,
        this.userName});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    dob = json['dob'];
    image = json['image'];
    mobile = json['mobile'];
    if (json['removeSuggestContact'] != null) {
      removeSuggestContact = <Null>[].cast<String>();
      // json['removeSuggestContact'].forEach((v) {
      //   removeSuggestContact!.add(Null.fromJson(v));
      // });
    }
    frequent = json['frequent'];
    password = json['password'];
    otp = json['otp'];
    otpVerify = json['otpVerify'];
    expireOTP = json['expireOTP'];
    isAdmin = json['isAdmin'];
    bio = json['bio'];
    token = json['token'];
    if (json['invitedBy'] != null) {
      invitedBy = <Null>[].cast<String>();
      // json['invitedBy'].forEach((v) {
      //   invitedBy!.add(new Null.fromJson(v));
      // });
    }
    invitedTo = json['invitedTo'].cast<String>();
    friends = json['friends'].cast<String>();
    if (json['pendingFriendRequests'] != null) {
      pendingFriendRequests = <Null>[].cast<String>();
      // json['pendingFriendRequests'].forEach((v) {
      //   pendingFriendRequests!.add(new Null.fromJson(v));
      // });
    }
    activeActivities = json['activeActivities'].cast<String>();
    if (json['invitees'] != null) {
      invitees = <Null>[].cast<String>();
      // json['invitees'].forEach((v) {
      //   invitees!.add(new Null.fromJson(v));
      // });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    if (this.removeSuggestContact != null) {
      // data['removeSuggestContact'] =
      //     this.removeSuggestContact!.map((v) => v.toJson()).toList();
    }
    data['frequent'] = this.frequent;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['otpVerify'] = this.otpVerify;
    data['expireOTP'] = this.expireOTP;
    data['isAdmin'] = this.isAdmin;
    data['bio'] = this.bio;
    data['token'] = this.token;
    // if (this.invitedBy != null) {
    //   data['invitedBy'] = this.invitedBy!.map((v) => v.toJson()).toList();
    // }
    data['invitedTo'] = this.invitedTo;
    data['friends'] = this.friends;
    // if (this.pendingFriendRequests != null) {
    //   data['pendingFriendRequests'] =
    //       this.pendingFriendRequests!.map((v) => v.toJson()).toList();
    // }
    data['activeActivities'] = this.activeActivities;
    // if (this.invitees != null) {
    //   data['invitees'] = this.invitees!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userName'] = this.userName;
    return data;
  }
}

class GoalInvite {
  String? sId;
  String? goalId;
  String? goalCreatorId;
  String? invitedId;
  String? createdAt;
  String? updatedAt;

  GoalInvite(
      {this.sId,
        this.goalId,
        this.goalCreatorId,
        this.invitedId,
        this.createdAt,
        this.updatedAt});

  GoalInvite.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    goalId = json['goalId'];
    goalCreatorId = json['goalCreatorId'];
    invitedId = json['invitedId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['goalId'] = this.goalId;
    data['goalCreatorId'] = this.goalCreatorId;
    data['invitedId'] = this.invitedId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Activity {
  String? sId;
  String? habitTitle;
  String? startDate;
  String? endDate;
  int? duration;
  String? frequent;
  String? everyDayAt;
  List<String>? everyWeekOn;
  List<String>? image;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Activity(
      {this.sId,
        this.habitTitle,
        this.startDate,
        this.endDate,
        this.duration,
        this.frequent,
        this.everyDayAt,
        this.everyWeekOn,
        this.image,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  Activity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    habitTitle = json['habitTitle'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    frequent = json['frequent'];
    everyDayAt = json['everyDayAt'];
    everyWeekOn = json['everyWeekOn'].cast<String>();
    // if (json['image'] != null) {
    //   image = <Null>[];
    //   json['image'].forEach((v) {
    //     image!.add(new Null.fromJson(v));
    //   });
    // }
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['habitTitle'] = this.habitTitle;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['duration'] = this.duration;
    data['frequent'] = this.frequent;
    data['everyDayAt'] = this.everyDayAt;
    data['everyWeekOn'] = this.everyWeekOn;
    // if (this.image != null) {
    //   data['image'] = this.image!.map((v) => v.toJson()).toList();
    // }
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
