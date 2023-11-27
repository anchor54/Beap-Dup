class SendRequest {
  String? image;
  String? sId;
  String? name;
  String? userName;

  SendRequest({this.image, this.sId, this.name, this.userName});

  SendRequest.fromJson(Map<String, dynamic> json) {
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
