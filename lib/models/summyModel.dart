class Summy {
  String? id;
  String? title;
  String? user;
  String? summary;
  String? createdAt;
  String? updatedAt;

  Summy({
    this.id,
    this.title,
    this.user,
    this.summary,
    this.createdAt,
    this.updatedAt,
  });

  Summy.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    user = json['user'];
    summary = json['summary'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['user'] = user;
    data['summary'] = summary;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
