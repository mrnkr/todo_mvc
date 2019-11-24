import 'package:flutter/cupertino.dart';
import 'package:todo_mvc/model/Todo.dart';

class TodoRow extends StatelessWidget {
  final Todo todo;
  final Function onComplete;
  final Function onRemove;

  const TodoRow({
    @required Key key,
    @required this.todo,
    this.onComplete,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: CupertinoColors.destructiveRed),
      key: key,
      onDismissed: (direction) => onRemove(),
      child: GestureDetector(
        onTap: onComplete,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(todo.description),
              Visibility(
                visible: todo.done,
                child: Icon(CupertinoIcons.check_mark_circled),
              )
            ],
          ),
        ),
      ),
    );
  }
}
