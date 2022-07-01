import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/models/user.dart';



class UserService{

 static Future<List<UserDetail>> getData() async{
    final dio = Dio();
     try{
       final response = await dio.get('https://jsonplaceholder.typicode.com/users');
         final data = (response.data as List).map((e) => UserDetail.fromJson(e)).toList();
         return data;
     }on DioError catch (err){
       print(err.error);
       throw AsyncValue.error('${err.error}');

     }
  }



}