import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/todo_new_provider.dart';



class EditPage extends StatelessWidget {
final String todo;
final int index;

EditPage(this.todo, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: todo,
                  onFieldSubmitted: (val) {
                   ref.read(newProvider.notifier).updateTodo(index, val);
                   Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        )
    );
  }
}
