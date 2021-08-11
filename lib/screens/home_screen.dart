import 'package:eltodo/helpers/drawer_navigation.dart';
import 'package:eltodo/models/todo.dart';
import 'package:eltodo/screens/todo_screen.dart';
import 'package:eltodo/service/todo_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  getTodos() async{
    var todoService = TodoService();
    var todos = await todoService.getTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];

        _todos.add(model);
      });
    });
    print(_todos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EL TODO')),
      drawer: DrawerNavigation(),
      body: Card(
        child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_todos[index].title ?? 'No title'),
                ],
              ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
