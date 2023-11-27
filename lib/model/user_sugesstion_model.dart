class UserSugesstionModel {
  String? sId;
  String? name;
  String? dob;
  String? image;
  String? status;
  String? countryCode;
  // List<Null>? removeSuggestContact;
  String? frequent;
  String? email;
  String? password;
  String? otp;
  bool? otpVerify;
  String? expireOTP;
  bool? isAdmin;
  String? bio;
  // List<Null>? invitedBy;
  // List<Null>? invitedTo;
  // List<Null>? friends;
  // List<String>? pendingFriendRequests;
  // List<Null>? activeActivities;
  // List<Null>? invitees;
  String? createdAt;
  String? updatedAt;
  String? token;
  String? userName;
  Friend? friend;

  UserSugesstionModel(
      {this.sId,
        this.name,
        this.dob,
        this.image,
        this.status,
        this.countryCode,
        // this.removeSuggestContact,
        this.frequent,
        this.email,
        this.password,
        this.otp,
        this.otpVerify,
        this.expireOTP,
        this.isAdmin,
        this.bio,
        // this.invitedBy,
        // this.invitedTo,
        // this.friends,
        // this.pendingFriendRequests,
        // this.activeActivities,
        // this.invitees,
        this.createdAt,
        this.updatedAt,
        this.token,
        this.userName,
        this.friend});

  UserSugesstionModel.fromJson(Map<String, dynamic> json) {
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
    // if (json['friends'] != null) {
    //   friends = <Null>[];
    //   json['friends'].forEach((v) {
    //     friends!.add(new Null.fromJson(v));
    //   });
    // }
    // pendingFriendRequests = json['pendingFriendRequests'].cast<String>();
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
    friend =
    json['friend'] != null ? new Friend.fromJson(json['friend']) : null;
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
    // if (this.friends != null) {
    //   data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    // }
    // data['pendingFriendRequests'] = this.pendingFriendRequests;
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
    if (this.friend != null) {
      data['friend'] = this.friend!.toJson();
    }
    return data;
  }
}

class Friend {
  String? sId;
  String? sender;
  String? recipient;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Friend(
      {this.sId,
        this.sender,
        this.recipient,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Friend.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'];
    recipient = json['recipient'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sender'] = this.sender;
    data['recipient'] = this.recipient;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
