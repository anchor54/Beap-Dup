class MyContact {
  List<OnAddScreen>? onAddScreen;
  List<OnInvite>? onInvite;

  MyContact({this.onAddScreen, this.onInvite});

  MyContact.fromJson(Map<String, dynamic> json) {
    if (json['onAddScreen'] != null) {
      onAddScreen = <OnAddScreen>[];
      json['onAddScreen'].forEach((v) {
        onAddScreen!.add(new OnAddScreen.fromJson(v));
      });
    }
    if (json['onInvite'] != null) {
      onInvite = <OnInvite>[];
      json['onInvite'].forEach((v) {
        onInvite!.add(new OnInvite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onAddScreen != null) {
      data['onAddScreen'] = this.onAddScreen!.map((v) => v.toJson()).toList();
    }
    if (this.onInvite != null) {
      data['onInvite'] = this.onInvite!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnAddScreen {
  String? sId;
  String? name;
  String? image;
  String? mobile;
  String? userName;

  OnAddScreen({this.sId, this.name, this.image, this.mobile, this.userName});

  OnAddScreen.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    mobile = json['mobile'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    data['userName'] = this.userName;
    return data;
  }
}

class OnInvite {
  String? contactname;
  String? mobileNo;
  String? countryCode;
  bool? invited;

  OnInvite({this.contactname, this.mobileNo, this.countryCode, this.invited});

  OnInvite.fromJson(Map<String, dynamic> json) {
    contactname = json['contactname'];
    mobileNo = json['mobile_no'];
    countryCode = json['country_code'];
    invited = json['invited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactname'] = this.contactname;
    data['mobile_no'] = this.mobileNo;
    data['country_code'] = this.countryCode;
    data['invited'] = this.invited;
    return data;
  }
}
