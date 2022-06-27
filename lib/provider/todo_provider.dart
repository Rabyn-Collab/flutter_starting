import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/counter_provider.dart';


class Person{
  int age;
  String name;
  String id;
  Person({required this.age, required this.name, required this.id});

}


final todoProvider = StateNotifierProvider<TodoProvider, List<Person>>((ref) => TodoProvider([]));


class  TodoProvider extends StateNotifier<List<Person>>{
  TodoProvider(super.state);

   void add(Person person){
       state = [...state, person];
   }

  void remove(String id){
     state.singleWhere((element) => element.id == id);
     state = [...state];
  }

}