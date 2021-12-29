class User {
  String? id;
  String? username;
  String? email;
  bool? isAdmin;
  String? createdAt;
  String? updatedAt;
  String? accessToken;

  User(
      {this.id,
      this.username,
      this.email,
      this.isAdmin,
      this.createdAt,
      this.updatedAt,
      this.accessToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['isAdmin'] = this.isAdmin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
