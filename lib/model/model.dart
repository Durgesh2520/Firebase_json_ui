class Welcome2 {
  Welcome2({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  Welcome2.fromJson(Map<String, dynamic>json){
    userId = json['userID'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
}