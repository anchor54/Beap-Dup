import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/view_model/create_or_edit_goal_vm.dart';

class GoalSummaryModel {
  int? totalPost;
  Activity? activity;
  List<CurrentWeekArray>? currentWeekArray;

  GoalSummaryModel({this.totalPost, this.activity, this.currentWeekArray});

  GoalSummaryModel.fromJson(Map<String, dynamic> json) {
    totalPost = json['totalPost'];
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    if (json['currentWeekArray'] != null) {
      currentWeekArray = <CurrentWeekArray>[];
      json['currentWeekArray'].forEach((v) {
        currentWeekArray!.add(new CurrentWeekArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPost'] = this.totalPost;
    if (this.activity != null) {
      data['activity'] = this.activity!.toJson();
    }
    if (this.currentWeekArray != null) {
      data['currentWeekArray'] =
          this.currentWeekArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activity {
  Repeat? repeat;
  String? sId;
  String? habitTitle;
  String? skinGame;
  String? frequent;
  String? everyDayAt;
  List<String>? image;
  String? status;
  String? startDate;
  PostVisibility? postVisibility;
  List<UserFollowModel>? visibleTo;

  Activity(
      {this.repeat,
      this.sId,
      this.habitTitle,
      this.skinGame,
      this.frequent,
      this.everyDayAt,
      this.image,
      this.status,
      this.startDate,
      this.postVisibility,
      this.visibleTo});

  Activity.fromJson(Map<String, dynamic> json) {
    repeat =
        json['repeat'] != null ? new Repeat.fromJson(json['repeat']) : null;
    sId = json['_id'];
    habitTitle = json['habitTitle'];
    skinGame = json['skinGame'];
    frequent = json['frequent'];
    everyDayAt = json['everyDayAt'];
    status = json['status'];
    startDate = json['startDate'];
    postVisibility = json['visibility'] == "Public"
        ? PostVisibility.PUBLIC
        : json['visibility'] == "Private"
            ? PostVisibility.PRIVATE
            : PostVisibility.PARTIAL;
    if (json['visibleTo'] != null) {
      visibleTo = <UserFollowModel>[];
      json['visibleTo'].forEach((v) {
        visibleTo!.add(UserFollowModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.repeat != null) {
      data['repeat'] = this.repeat!.toJson();
    }
    data['_id'] = this.sId;
    data['habitTitle'] = this.habitTitle;
    data['skinGame'] = this.skinGame;
    data['frequent'] = this.frequent;
    data['everyDayAt'] = this.everyDayAt;
    data['status'] = this.status;
    data['startDate'] = this.startDate;
    return data;
  }
}

class Goalinvites {
  String? sId;
  String? goalId;
  String? goalCreatorId;
  String? invitedId;
  String? createdAt;
  String? updatedAt;
  List<User>? user;

  Goalinvites(
      {this.sId,
      this.goalId,
      this.goalCreatorId,
      this.invitedId,
      this.createdAt,
      this.updatedAt,
      this.user});

  Goalinvites.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    goalId = json['goalId'];
    goalCreatorId = json['goalCreatorId'];
    invitedId = json['invitedId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['goalId'] = this.goalId;
    data['goalCreatorId'] = this.goalCreatorId;
    data['invitedId'] = this.invitedId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? dob;
  String? image;
  String? status;
  String? countryCode;
  List<Null>? removeSuggestContact;
  String? frequent;
  String? email;
  String? password;
  String? otp;
  bool? otpVerify;
  String? expireOTP;
  bool? isAdmin;
  String? bio;
  List<Null>? invitedBy;
  List<Null>? invitedTo;
  List<String>? friends;
  List<Null>? pendingFriendRequests;
  List<Null>? activeActivities;
  List<Null>? invitees;
  String? createdAt;
  String? updatedAt;
  String? token;
  String? userName;
  String? firebase;

  User(
      {this.sId,
      this.name,
      this.dob,
      this.image,
      this.status,
      this.countryCode,
      this.removeSuggestContact,
      this.frequent,
      this.email,
      this.password,
      this.otp,
      this.otpVerify,
      this.expireOTP,
      this.isAdmin,
      this.bio,
      this.invitedBy,
      this.invitedTo,
      this.friends,
      this.pendingFriendRequests,
      this.activeActivities,
      this.invitees,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.userName,
      this.firebase});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    dob = json['dob'];
    image = json['image'];
    status = json['Status'];
    countryCode = json['countryCode'];
    // if (json['removeSuggestContact'] != null) {
    //   removeSuggestContact = <Null>[];
    //   json['removeSuggestContact'].forEach((v) {
    //     removeSuggestContact!.add(new Null.fromJson(v));
    //   });
    // }
    frequent = json['frequent'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    otpVerify = json['otpVerify'];
    expireOTP = json['expireOTP'];
    isAdmin = json['isAdmin'];
    bio = json['bio'];
    // if (json['invitedBy'] != null) {
    //   invitedBy = <Null>[];
    //   json['invitedBy'].forEach((v) {
    //     invitedBy!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['invitedTo'] != null) {
    //   invitedTo = <Null>[];
    //   json['invitedTo'].forEach((v) {
    //     invitedTo!.add(new Null.fromJson(v));
    //   });
    // }
    // friends = json['friends'].cast<String>();
    // if (json['pendingFriendRequests'] != null) {
    //   pendingFriendRequests = <Null>[];
    //   json['pendingFriendRequests'].forEach((v) {
    //     pendingFriendRequests!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['activeActivities'] != null) {
    //   activeActivities = <Null>[];
    //   json['activeActivities'].forEach((v) {
    //     activeActivities!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['invitees'] != null) {
    //   invitees = <Null>[];
    //   json['invitees'].forEach((v) {
    //     invitees!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
    userName = json['userName'];
    firebase = json['firebase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['Status'] = this.status;
    data['countryCode'] = this.countryCode;
    // if (this.removeSuggestContact != null) {
    //   data['removeSuggestContact'] =
    //       this.removeSuggestContact!.map((v) => v.toJson()).toList();
    // }
    data['frequent'] = this.frequent;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['otpVerify'] = this.otpVerify;
    data['expireOTP'] = this.expireOTP;
    data['isAdmin'] = this.isAdmin;
    data['bio'] = this.bio;
    // if (this.invitedBy != null) {
    //   data['invitedBy'] = this.invitedBy!.map((v) => v.toJson()).toList();
    // }
    // if (this.invitedTo != null) {
    //   data['invitedTo'] = this.invitedTo!.map((v) => v.toJson()).toList();
    // }
    // data['friends'] = this.friends;
    // if (this.pendingFriendRequests != null) {
    //   data['pendingFriendRequests'] =
    //       this.pendingFriendRequests!.map((v) => v.toJson()).toList();
    // }
    // if (this.activeActivities != null) {
    //   data['activeActivities'] =
    //       this.activeActivities!.map((v) => v.toJson()).toList();
    // }
    // if (this.invitees != null) {
    //   data['invitees'] = this.invitees!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['token'] = this.token;
    data['userName'] = this.userName;
    data['firebase'] = this.firebase;
    return data;
  }
}

class Repeat {
  Every? every;
  String? type;
  String? frequency;
  List<String>? days;

  Repeat({this.every, this.type, this.frequency, this.days});

  Repeat.fromJson(Map<String, dynamic> json) {
    every = json['every'] != null ? new Every.fromJson(json['every']) : null;
    type = json['type'];
    frequency = json['frequency'];
    days = json['days'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.every != null) {
      data['every'] = this.every!.toJson();
    }
    data['type'] = this.type;
    data['frequency'] = this.frequency;
    data['days'] = this.days;
    return data;
  }
}

class Every {
  String? type;
  String? frequency;

  Every({this.type, this.frequency});

  Every.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    frequency = json['frequency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['frequency'] = this.frequency;
    return data;
  }
}

class CurrentWeekArray {
  String? dayName;
  String? dayDate;
  DailyPost? dailyPost;

  CurrentWeekArray({this.dayName, this.dayDate, this.dailyPost});

  CurrentWeekArray.fromJson(Map<String, dynamic> json) {
    dayName = json['dayName'];
    dayDate = json['dayDate'];
    dailyPost = json['dailyPost'] != null
        ? new DailyPost.fromJson(json['dailyPost'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayName'] = this.dayName;
    data['dayDate'] = this.dayDate;
    if (this.dailyPost != null) {
      data['dailyPost'] = this.dailyPost!.toJson();
    }
    return data;
  }
}

class DailyPost {
  String? sId;
  String? date;
  String? day;
  bool? completed;
  String? image;
  String? status;
  String? createdBy;
  String? goalId;
  String? createdAt;
  String? updatedAt;

  DailyPost(
      {this.sId,
      this.date,
      this.day,
      this.completed,
      this.image,
      this.status,
      this.createdBy,
      this.goalId,
      this.createdAt,
      this.updatedAt});

  DailyPost.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    day = json['day'];
    completed = json['completed'];
    image = json['image'];
    status = json['status'];
    createdBy = json['createdBy'];
    goalId = json['goalId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['day'] = this.day;
    data['completed'] = this.completed;
    data['image'] = this.image;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['goalId'] = this.goalId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Friends {
  String? image;
  String? sId;
  String? name;
  String? userName;

  Friends({this.image, this.sId, this.name, this.userName});

  Friends.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    sId = json['_id'];
    name = json['name'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['userName'] = this.userName;
    return data;
  }
}
