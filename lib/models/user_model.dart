class UserModel {
  String? email;
  String? name;
  String? url;
  String? userId;

  UserModel(
      {
      this.email,
      this.name,
      this.url,
      this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    url = json['url'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['url'] = url;
    data['userId'] = userId;
    return data;
  }
}
