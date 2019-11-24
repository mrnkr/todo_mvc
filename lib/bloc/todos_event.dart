import 'package:meta/meta.dart';
import 'package:todo_mvc/model/Todo.dart';

@immutable
abstract class TodoEvent {}

@immutable
class CreateTodo extends TodoEvent {
  final Todo todo;

  CreateTodo({
    @required this.todo,
  });
}

@immutable
class CompleteTodo extends TodoEvent {
  final String id;

  CompleteTodo({
    @required this.id,
  });
}

@immutable
class RemoveTodo extends TodoEvent {
  final String id;

  RemoveTodo({
    @required this.id,
  });
}

@immutable
class ClearCompleted extends TodoEvent {}

@immutable
class FilterTodos extends TodoEvent {
  final bool Function(Todo) predicate;

  FilterTodos({
    @required this.predicate,
  });
}
