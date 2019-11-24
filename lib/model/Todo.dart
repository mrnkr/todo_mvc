import 'package:meta/meta.dart';
import 'package:todo_mvc/model/Identifiable.dart';

@immutable
class Todo extends Identifiable {
  final String description;
  final bool done;

  Todo({
    id,
    this.description,
    this.done = false,
  }) : super(id: id);

  Todo.fromJson(Map data)
      : description = data['description'],
        done = data['done'],
        super.fromJson(data);

  Map toJson() {
    return {
      'id': id,
      'description': description,
      'done': done,
    };
  }

  Todo complete() {
    return Todo(id: id, description: description, done: true);
  }
}
