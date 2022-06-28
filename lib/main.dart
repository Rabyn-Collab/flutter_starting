import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/counter_provider.dart';
import 'package:flutter_start_new/view/todo_page.dart';
import 'package:get/get.dart';



Future getSomething()async{
  final dio = Dio();
 try{
   final response = await  dio.get('https://jsonplaceholder.typicode.com/photos');
  print(response.data);
 }on DioError catch(err){
   print(err.message);
 }
}



void main () async{
  getSomething();
  // try{
  //   final data = await getSomething();
  //   print('call me');
  //   print(data);
  // }catch(err){
  //   print(err);
  // }
  //getSomething().then((value) => print(value)).catchError((err) => print(err));
  runApp(ProviderScope(child: Home()));
}




class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home:TodoPage(),
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

