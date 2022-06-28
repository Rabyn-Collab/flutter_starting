import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/todo_provider.dart';



class TodoPage extends StatelessWidget {

  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Consumer(
          builder: (context, ref, child) {
            final data = ref.watch(todoProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    enabled: true,
                    onChanged: (val){
                      print(val);
                     ref.read(todoProvider.notifier).getDataFilter(nameController.text);
                    },
                    onFieldSubmitted: (val){
                      final newPerson = Person(age: Random().nextInt(90)  , name: val, id: DateTime.now().toString());
                      ref.read(todoProvider.notifier).add(newPerson);
                      nameController.clear();
                      },
                    decoration: InputDecoration(
                      hintText: 'some text'
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        subtitle: Text(data[index].age.toString()),
                      title: Text(data[index].name, style: TextStyle(fontSize: 20),),
                         trailing: IconButton(
                          onPressed: (){
                      ref.read(todoProvider.notifier).remove(data[index].id);
                            },
                        icon: Icon(Icons.delete),
                            ),
                        );
                        }

                  ),
                ),
              ],
            );
          }
           )
    );
  }
}
