import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/models/todo.dart';
import 'package:flutter_start_new/models/todo_state.dart';



final newProvider = StateNotifierProvider<NewProvider, TodoState>((ref) => NewProvider(TodoState.intState()));

class NewProvider extends StateNotifier<TodoState>{
  NewProvider(super.state);


  void addTodo(Todo todo)async{
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(milliseconds: 200));
    state = state.copyWith(
      isLoading: false,
      todos: [...state.todos, todo]
    );
  }

  void removeTodo(int index){
     state.todos.removeAt(index);
     state = state.copyWith(
       todos: [...state.todos]
     );
  }

  void updateTodo(int index, String title){
    Todo changeTodo = state.todos.firstWhere((element) => state.todos.indexOf(element) == index);
    changeTodo.title =  title;

    state = state.copyWith(
        todos: [...state.todos]
    );
    // state = state.copyWith(
    //   todos: [
    //    for(final n in state.todos)
    //      if(n == changeTodo) changeTodo else n
    //   ]
    // );
  }


}