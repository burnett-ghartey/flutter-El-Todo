import 'package:eltodo/models/todo.dart';
import 'package:eltodo/repositories/repository.dart';

class TodoService {
   late Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  insertTodo(Todo todo) async{
    return await _repository.save('todos', todo.todoMap());
  }

  getTodos() async{
    return await _repository.getAllTodos('todos');
  }

  todosByCategory(String category) async  {
    return await _repository.getByColumnName('todos', 'category', category);
  }
}
