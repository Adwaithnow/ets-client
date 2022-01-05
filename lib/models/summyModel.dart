class Summy {
  String? title;
  String? user;
  String? summary;
  String? createdAt;
  String? updatedAt;

  Summy({
    this.title,
    this.user,
    this.summary,
    this.createdAt,
    this.updatedAt,
  });

  Summy.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    user = json['user'];
    summary = json['summary'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['user'] = user;
    data['summary'] = summary;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}