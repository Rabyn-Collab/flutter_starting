import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/counter_provider.dart';
import 'package:get/get.dart';





void main () {
  runApp(ProviderScope(child: Home()));
}




class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home: Counter(),
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
                              ref.read(countState.notifier).state.age = 100;
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

