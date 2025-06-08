class Notification {
  String? id;
  String? title;
  String? content;
  String? date;
  Notification({this.id, this.title, this.content, this.date});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
    );
  }

  static Map<String, dynamic> toJson(Notification notification) {
    return {
      "id": notification.id,
      "title": notification.title,
      "content": notification.content,
      "date": notification.date,
    };
  }
}
