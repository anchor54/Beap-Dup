enum GoalVisibility {
  PUBLIC(title: 'Public'),
  PRIVATE(title: 'Private'),
  CUSTOM(title: 'Custom');

  const GoalVisibility({required this.title});
  final String title;
}

class GoalModel {
  Repeat? repeat;
  String? sId;
  String? habitTitle;
  String? skinGame;
  String? frequent;
  String? everyDayAt;
  List<String>? everyWeekOn;
  List<String>? image;
  String? status;
  String? createdBy;
  String? startDate;
  String? createdAt;
  String? updatedAt;
  String? planExpireIn;
  int? dailyTasksCount;
  int? uniqueTasksCount;
  String? completionPercentage;
  GoalVisibility visibility = GoalVisibility.PUBLIC;
  List<String> visibleToIds = [];

  GoalModel(
      {this.repeat,
      this.sId,
      this.habitTitle,
      this.skinGame,
      this.frequent,
      this.everyDayAt,
      this.everyWeekOn,
      this.image,
      this.status,
      this.createdBy,
      this.startDate,
      this.createdAt,
      this.updatedAt,
      this.planExpireIn,
      this.dailyTasksCount,
      this.uniqueTasksCount,
      this.completionPercentage,
      this.visibility = GoalVisibility.PUBLIC,
      this.visibleToIds = const []});

  GoalModel.fromJson(Map<String, dynamic> json) {
    repeat =
        json['repeat'] != null ? new Repeat.fromJson(json['repeat']) : null;
    sId = json['_id'];
    habitTitle = json['habitTitle'];
    skinGame = json['skinGame'];
    frequent = json['frequent'];
    everyDayAt = json['everyDayAt'];
    // if (json['everyWeekOn'] != null) {
    //   everyWeekOn = <Null>[];
    //   json['everyWeekOn'].forEach((v) {
    //     everyWeekOn!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['image'] != null) {
    //   image = <Null>[];
    //   json['image'].forEach((v) {
    //     image!.add(new Null.fromJson(v));
    //   });
    // }
    status = json['status'];
    createdBy = json['createdBy'];
    startDate = json['startDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    planExpireIn = json['planExpireIn'];
    dailyTasksCount = json['dailyTasksCount'];
    uniqueTasksCount = json['uniqueTasksCount'];
    completionPercentage = json['completionPercentage'];
    visibility = json['visibility'] == "Partial"
        ? GoalVisibility.CUSTOM
        : json['visibility'] == "Private"
            ? GoalVisibility.PRIVATE
            : GoalVisibility.PUBLIC;
    visibleToIds =
        json['visibleToIds'] != null ? json['visibleToIds'].cast<String>() : [];
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
    // if (this.everyWeekOn != null) {
    //   data['everyWeekOn'] = this.everyWeekOn!.map((v) => v.toJson()).toList();
    // }
    // if (this.image != null) {
    //   data['image'] = this.image!.map((v) => v.toJson()).toList();
    // }
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['startDate'] = this.startDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['planExpireIn'] = this.planExpireIn;
    data['dailyTasksCount'] = this.dailyTasksCount;
    data['uniqueTasksCount'] = this.uniqueTasksCount;
    data['completionPercentage'] = this.completionPercentage;
    data['visibility'] =
        this.visibility == GoalVisibility.PUBLIC ? "PUBLIC" : "PRIVATE";
    data['visibleToIds'] = this.visibleToIds;
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
