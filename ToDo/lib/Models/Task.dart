class Task {
  String content;
  var time;
  bool done;

  Task({required this.content, required this.done, required this.time});

  factory Task.fromMap(Map task) {
    return Task(
        content: task["content"], time: task["time"], done: task["done"]);
  }

  Map toMap() {
    return {"content": content, "time": time, "done": done};
  }
}
