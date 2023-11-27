class CalendarModel {
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

  CalendarModel(
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

  CalendarModel.fromJson(Map<String, dynamic> json) {
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
