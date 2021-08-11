import 'package:eltodo/models/todo.dart';
import 'package:eltodo/service/category_service.dart';
import 'package:eltodo/service/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _todoTitle = TextEditingController();
  final _todoDescription = TextEditingController();
  final _todoDate = TextEditingController();
  final List<DropdownMenuItem> _categories = [];
  // ignore: prefer_typing_uninitialized_variables
  var _selectedValue;
 

  DateTime _date = DateTime.now();

  _selectTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (_pickedDate != null) {
      setState(() {
        _date = _pickedDate;
        _todoDate.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.getCategory();

    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  _showSnackBar(message) {
    var snackbar = SnackBar(
      content: Text(message),
    );
    _scaffoldKey.currentState!.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: const Text('Create Todo')),
        body: Column(
          children: <Widget>[
            TextField(
              controller: _todoTitle,
              decoration: const InputDecoration(
                  hintText: 'Todo Title', labelText: 'Cook Food'),
            ),
            TextField(
              controller: _todoDescription,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: 'Todo Description',
                  labelText: 'Cook rice and Curry'),
            ),
            TextField(
              controller: _todoDate,
              decoration: InputDecoration(
                  hintText: 'YY-MM-DD',
                  labelText: 'YY-MM-DD',
                  prefixIcon: InkWell(
                      onTap: () {
                        _selectTodoDate(context);
                      },
                      child: const Icon(Icons.calendar_today))),
            ),
            DropdownButtonFormField<dynamic>(
              value: _selectedValue,
              items: _categories,
              hint: const Text('Choose One Category'),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            RaisedButton(
              onPressed: () async {
                var todoObj = Todo();
                todoObj.title = _todoTitle.text;
                todoObj.description = _todoDescription.text;
                todoObj.category = _selectedValue;
                todoObj.todoDate = _todoDate.text;
                todoObj.isFinished = 0;

                var _todoService = TodoService();
                var result = await _todoService.insertTodo(todoObj);
                if (result > 0) {
                  _showSnackBar('success');
                }
              },
              child: const Text('Save'),
            )
          ],
        ));
  }
}
