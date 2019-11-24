import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_mvc/bloc/bloc.dart';
import 'package:todo_mvc/model/Todo.dart';
import 'package:todo_mvc/pages/home/todo_row.dart';
import 'package:todo_mvc/pages/home/mk_todo.dart';

class Home extends StatelessWidget {
  final TodosBloc _todos;

  Home({Key key})
      : _todos = GetIt.instance<TodosBloc>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Todos'),
        trailing: GestureDetector(
          child: Icon(CupertinoIcons.eye),
          onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (ctx) => _buildCupertinoActionSheet(ctx),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: MkTodo(
                onSubmit: (value) =>
                    _todos.add(CreateTodo(todo: Todo(description: value))),
              ),
            ),
            Expanded(
              child: BlocBuilder(
                bloc: _todos,
                builder: (ctx, TodosState state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (ctx, idx) {
                            final todo = state.todos.elementAt(idx);

                            return TodoRow(
                              key: Key(todo.id),
                              todo: todo,
                              onComplete: () =>
                                  _todos.add(CompleteTodo(id: todo.id)),
                              onRemove: () =>
                                  _todos.add(RemoveTodo(id: todo.id)),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, right: 8, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('${state.remaining} items left'),
                            Visibility(
                              visible: state.completed > 0,
                              child: CupertinoButton(
                                child: Text(
                                    'Clear completed (${state.completed})'),
                                onPressed: () => _todos.add(ClearCompleted()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  CupertinoActionSheet _buildCupertinoActionSheet(BuildContext context) {
    return CupertinoActionSheet(
      title: Text('Filter todos'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Show all'),
          onPressed: () {
            _todos.add(FilterTodos(predicate: (todo) => true));
            Navigator.of(context).pop();
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Show active only'),
          onPressed: () {
            _todos.add(FilterTodos(predicate: (todo) => !todo.done));
            Navigator.of(context).pop();
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Show completed only'),
          onPressed: () {
            _todos.add(FilterTodos(predicate: (todo) => todo.done));
            Navigator.of(context).pop();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Dismiss'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
