import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




final userStream = StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

final authProvider = Provider((ref) => AuthProvider());

class AuthProvider {


  Future<String> userLogin({required String email, required String password}) async{
      try{
         final response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
         return 'success';
      }on FirebaseAuthException catch (err){
        return '${err.message}';
      }
  }



}