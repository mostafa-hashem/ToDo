class TaskModel {
  String id;
  String title;
  String description;
  int date;
  int time;
  bool status;
  String userID;

  TaskModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.status,
       required this.userID
      });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            date: json['date'],
           userID: json['userID'],
            time: json['time'],
            status: json['status']);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
       "userID": userID,
      "time": time,
      "status": status,
    };
  }
}
