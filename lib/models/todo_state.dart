import 'package:flutter_start_new/models/todo.dart';





class TodoState{
 final bool isLoading;
 final List<Todo> todos;

 TodoState({required this.isLoading, required this.todos});

 TodoState.intState() : todos=[], isLoading=false;

 TodoState copyWith({List<Todo>? todos, bool? isLoading}){
   return TodoState(
       isLoading: isLoading ?? this.isLoading,
       todos: todos ?? this.todos
   );
 }




}