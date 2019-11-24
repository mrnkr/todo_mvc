import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './bloc.dart';

class TodosBloc extends HydratedBloc<TodoEvent, TodosState> {
  @override
  TodosState get initialState => super.initialState ?? TodosState();

  @override
  Stream<TodosState> mapEventToState(TodoEvent e) async* {
    if (e is FilterTodos) {
      yield state.filter(e.predicate);
    }

    if (e is CreateTodo) {
      yield state.addOne(e.todo);
    }

    if (e is CompleteTodo) {
      yield state.completeById(e.id);
    }

    if (e is RemoveTodo) {
      yield state.removeById(e.id);
    }

    if (e is ClearCompleted) {
      yield state.clearCompleted();
    }
  }

  @override
  TodosState fromJson(Map<String, dynamic> data) {
    try {
      return TodosState.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(TodosState s) {
    try {
      return s.toJson();
    } catch (_) {
      return null;
    }
  }
}
