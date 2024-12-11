class HabitModel {
  String? id;
  String? name;
  String? description;
  bool? isCompleted;

  HabitModel({this.id, this.name, this.description, this.isCompleted = false});

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        isCompleted: json['isCompleted']);
  }

  HabitModel copyWith(
      {String? id, String? title, bool? isCompleted, String? description}) {
    return HabitModel(
      id: id ?? this.id,
      name: title ?? this.name,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['isCompleted'] = isCompleted;

    return data;
  }
}
