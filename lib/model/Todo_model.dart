class TodoModel {
  TodoModel({
    this.title,
    this.description,
    this.id,});

  TodoModel.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    id = json['id'];
  }

  String? title;
  String? description;
  String ?id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['id'] = id;
    return map;
  }

}