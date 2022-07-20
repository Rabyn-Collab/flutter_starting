import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/view/status_page.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     debugShowCheckedModeBanner: false,
        home: StatusPage()
    );
  }
}





class Counter extends StatelessWidget {


  int count = 1;

  StreamController<int>   counts = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: StreamBuilder<int>(
                  stream: counts.stream,
                  initialData: count,
                  builder: (context, snapshot) {
                    return Container(
                      child: Text('${snapshot.data}', style: TextStyle(fontSize: 25),),
                    );
                  }
                )
            )
        ),
            floatingActionButton: FloatingActionButton(
        onPressed: (){
          counts.sink.add(count++);
        },
            child: Icon(Icons.add),
            ),
    );
  }
}

