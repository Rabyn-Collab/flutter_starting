import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/counter_provider.dart';
import 'package:flutter_start_new/provider/todo_new_provider.dart';
import 'package:flutter_start_new/view/home_page.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/todo.dart';






void main () async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final b = await Hive.openBox('cached');
  SystemChrome.setPreferredOrientations(
      [
       DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
       ]
  );
  runApp(ProviderScope(child: Home()));
}




class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        //home:HomePage(),
      home: TodoShow(),
    );
  }
}








class TodoShow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final todoState = ref.watch(newProvider);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: todoState.isLoading ? Center(child: CircularProgressIndicator()): ListView(
                  children: [
                    Container(
                      child: TextFormField(
                        onFieldSubmitted: (val){
                          ref.read(newProvider.notifier).addTodo(Todo(title: val));
                        },
                        decoration: InputDecoration(
                          hintText: 'add some todo'
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 500,
                      child: ListView.builder(
                        itemCount: todoState.todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          final todo = todoState.todos[index];
                          return  ListTile(
                            title: Text(todo.title),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: (){

                                      }, icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: (){

                                        ref.read(newProvider.notifier).removeTodo(index);

                                      }, icon: Icon(Icons.delete))
                                ],

                              ),
                            ),
                          );
                        },

                      ),
                    )

                  ],
                ),
              );
            }
          ),
        )
    );
  }

  IconButton _buildIconButton({required Todo todo,required int index,required Icon icon, required VoidCallback on}) {
    return IconButton(
        onPressed: on, icon: icon
    );
  }
}













class User{
  final String name;
  final int age;

  User({required this.name, required this.age});

  User.initState(): age=90, name='hari';
  User copyWith({int? age, String? name}){
    return User(
        name: name ?? this.name,
        age: age ?? this.age
    );
  }


}



class Sample1 extends StatelessWidget {
  User user= User.initState();

  @override
  Widget build(BuildContext context) {
    user = user.copyWith(age: 100);
    print('${user.name} ${user.age}');
    return Scaffold(
        body: Container()
    );
  }
}









class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    print('build');
    return Scaffold(
        body: Container(
          child: Center(
            child: Consumer(
              builder: (context, ref, child) {
               // final number = ref.watch(counterProvider).number;
               // final count = ref.watch(countState);
                int age = ref.watch(countState.select((value) => value.age));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$age', style: TextStyle(fontSize: 50),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              ref.read(countState.notifier).update((state) => state.copyWith(
                                age: 100
                              ));
                            }, child: Text('increment')
                        ),
                        TextButton(
                            onPressed: () {
                              ref.read(counterProvider).decrement();
                            }, child: Text('decrement')),
                      ],
                    )
                  ],
                );
              }
            ),
          ),
        )
    );
  }
}

