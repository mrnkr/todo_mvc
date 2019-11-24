import 'package:flutter/cupertino.dart';

class MkTodo extends StatefulWidget {
  final Function onSubmit;

  MkTodo({Key key, this.onSubmit}) : super(key: key);

  @override
  _MkTodoState createState() => _MkTodoState(onSubmit: onSubmit);
}

class _MkTodoState extends State<MkTodo> {
  final Function onSubmit;
  final TextEditingController controller;
  String _description = '';

  _MkTodoState({
    @required this.onSubmit,
  }) : controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoTextField(
        autocorrect: true,
        autofocus: false,
        clearButtonMode: OverlayVisibilityMode.editing,
        controller: controller,
        maxLines: 1,
        onChanged: (value) => setState(() => _description = value),
        onEditingComplete: () {
          onSubmit(_description);
          controller.clear();
          FocusScope.of(context).unfocus();
          setState(() => _description = '');
        },
        padding: EdgeInsets.all(8),
        placeholder: 'What needs to be done?',
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
