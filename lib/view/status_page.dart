import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/auth_provider.dart';
import 'package:flutter_start_new/view/auth_page.dart';
import 'package:flutter_start_new/view/main_page.dart';





class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final userData = ref.watch(userStream);
              return userData.when(
                  data: (data){
                    if(data == null){
                       return AuthPage();
                    }else{
                      return MainPage();
                    }
                  },
                  error: (err, stack) => Text('$err'),
                  loading: () => Center(child: CircularProgressIndicator(),)
              );
            }
    )
    );
  }
}




