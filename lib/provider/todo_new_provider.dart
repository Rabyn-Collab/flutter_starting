import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/models/todo.dart';
import 'package:flutter_start_new/models/todo_state.dart';



final newProvider = StateNotifierProvider<NewProvider, TodoState>((ref) => NewProvider(TodoState.intState()));

class NewProvider extends StateNotifier<TodoState>{
  NewProvider(super.state);


  void addTodo(Todo todo)async{
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      todos: [...state.todos, todo]
    );
  }

  void removeTodo(){

  }

  void updateTodo(){

  }


}