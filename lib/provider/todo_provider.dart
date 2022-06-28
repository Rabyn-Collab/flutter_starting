import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/counter_provider.dart';


class Person{
  int age;
  String name;
  String id;
  Person({required this.age, required this.name, required this.id});

}

final List<Person> users = [Person(name: 'hari', age: 90, id: '1'),
  Person(name: 'seeta', age: 70, id: '2'),
  Person(name: 'limo', age: 90, id: '3'),
  Person(name: 'mino', age: 90, id: '4'),];

final todoProvider = StateNotifierProvider<TodoProvider, List<Person>>((ref) => TodoProvider(users));


class  TodoProvider extends StateNotifier<List<Person>>{
  TodoProvider(super.state);

   void add(Person person){
     users.add(person);
       state = [...state, person];
   }

  void remove(String id){
     state.removeWhere((element) => element.id == id);
     state = [...state];
  }


   void getDataFilter(String searchText){
     final data  =  state.where((element) => element.name.contains(searchText)).toList();
       if(searchText.isEmpty){
         state = users;
       }else{
         state = data;
       }

   }



}