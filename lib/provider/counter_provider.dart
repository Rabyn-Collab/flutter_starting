import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Person{
  int age;
  String name;
  Person({required this.name, required this.age});

}


final counterProvider = ChangeNotifierProvider((ref) => CounterProvider(ref));
final countState = StateProvider<Person>((ref) => Person(name: 'hari', age: 90));
//changeNotifier
class  CounterProvider extends ChangeNotifier{
  CounterProvider(this.ref);
ChangeNotifierProviderRef ref;

  void increment(){
    int number = ref.watch(countState).age;
     number++;
     notifyListeners();
  }

  void decrement(){
    int number = ref.watch(countState).age;
    number--;
    notifyListeners();
  }

}