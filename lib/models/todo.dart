class Todo {
  var id;
  var title;
  var description;
  var category;
  var todoDate;
  var isFinished;

  // Todo(this.id, this.title, this.description, this.category, this.todoDate,
  //     this.isFinished);

  todoMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['todoDate'] = todoDate;
    map['isFinished'] = isFinished;

    return map;
  }
}
