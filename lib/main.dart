import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/counter_provider.dart';
import 'package:flutter_start_new/view/home_page.dart';
import 'package:get/get.dart';






void main () async{
  WidgetsFlutterBinding.ensureInitialized();
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
        home:HomePage(),
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

