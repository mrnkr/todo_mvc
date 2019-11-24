import 'package:meta/meta.dart';
import 'package:todo_mvc/model/Todo.dart';

@immutable
class TodosState {
  final List<Todo> _todos;
  final bool Function(Todo) _predicate;
  Iterable<Todo> get todos => _todos.where(_predicate);
  int get completed => _todos.where((todo) => todo.done).length;
  int get remaining => _todos.where((todo) => !todo.done).length;

  TodosState({
    Iterable<Todo> todos,
    bool Function(Todo) predicate,
  })  : _todos = todos ?? <Todo>[],
        _predicate = predicate ?? ((t) => true);

  TodosState addOne(Todo todo) {
    return TodosState(todos: [..._todos, todo], predicate: _predicate);
  }

  TodosState completeById(String id) {
    var idx = _todos.indexWhere((todo) => todo.id == id);
    var updated = [..._todos];
    updated[idx] = updated[idx].complete();
    return TodosState(todos: updated, predicate: _predicate);
  }

  TodosState removeById(String id) {
    return TodosState(
        todos: _todos.where((todo) => todo.id != id).toList(),
        predicate: _predicate);
  }

  TodosState clearCompleted() {
    return TodosState(
        todos: _todos.where((todo) => !todo.done).toList(),
        predicate: _predicate);
  }

  TodosState filter(bool Function(Todo) predicate) {
    return TodosState(todos: _todos, predicate: predicate);
  }

  TodosState.fromJson(Map data)
      : _todos = (data['todos'] as List<Map> ?? []).map((e) => Todo.fromJson(e)).toList(),
        _predicate = ((t) => true);

  Map toJson() {
    return {
      'todos': _todos.map((todo) => todo.toJson()).toList(),
    };
  }
}
