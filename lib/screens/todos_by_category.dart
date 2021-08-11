import 'package:eltodo/models/todo.dart';
import 'package:eltodo/service/category_service.dart';
import 'package:eltodo/service/todo_service.dart';
import 'package:flutter/material.dart';

class TodoByCategory extends StatefulWidget {
  final String category;

  TodoByCategory(this.category);

  @override
  _TodoByCategoryState createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  TodoService todoService = TodoService();
  List<Todo> _todoList = [];

  @override
  void initState() {
    getToDoByCategory();
    super.initState();
  }

  getToDoByCategory() async {
    var todos = await todoService.todosByCategory(widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Todos By Category')),
        body: Column(
          children: [
            Text(widget.category),
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return Text(_todoList[index].title);
                },
              ),
            )
          ],
        ));
  }
}
