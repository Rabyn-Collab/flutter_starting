import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/auth_provider.dart';
import 'package:flutter_start_new/provider/log_loading_provider.dart';
import 'package:get/get.dart';




class AuthPage extends StatelessWidget {

  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passController = TextEditingController();
final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Consumer(
            builder: (context, ref, child) {
              final isLogin = ref.watch(loginProvider);
              final authService = ref.watch(authProvider);
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Form(
                  //  autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _form,
                    child: ListView(
                      children: [
                        Text(isLogin ? 'Login Form' : 'SignUp Form', style: TextStyle(fontSize: 20, letterSpacing: 2),),
                        SizedBox(height: 50,),
                     if(isLogin == false)
                      _buildTextFormField(
                          label: 'username',
                          controller: nameController,
                          val: ( val){
                            if(val!.isEmpty){
                              return 'username is required';
                            }else if(val.length > 20){
                              return 'character limit exceed';
                            }
                            return null;
                      }, isPass: false),
                        SizedBox(height: 20,),

                        _buildTextFormField(
                            label: 'email',
                            controller: mailController,
                            val: (val){
                              if(val!.isEmpty || !val.contains('@')){
                                return 'email is required';
                              }else if(val.length > 90){
                                return 'character limit exceed';
                              }
                              return null;
                            }, isPass: false),
                        SizedBox(height: 20,),
                        _buildTextFormField(
                            label: 'password',
                            controller: passController,
                            val: (val){
                              if(val!.isEmpty){
                                return 'password is required';
                              }else if(val.length > 25){
                                return 'character limit exceed';
                              }
                              return null;

                            }, isPass: true),
                        if(isLogin == false)     SizedBox(height: 30,),
                    if(isLogin == false)  Container(
                          height: 150,
                          decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   begin: Alignment.topRight,
                            //   end: Alignment.bottomRight,
                            //   colors: [
                            //     Colors.black,
                            //     Colors.purple,
                            //     Colors.amberAccent
                            //   ]
                            // ),
                            border: Border.all(color: Colors.black)
                          ),
                          child: Center(child: Text('please select an image')),
                        ),
                        SizedBox(height: 30,),
                        ElevatedButton(
                            onPressed: () async{
                              _form.currentState!.save();
                              if(_form.currentState!.validate()){

                                if(isLogin){
                                 final response = await  authService.userLogin(
                                     email: mailController.text.trim(),
                                     password: passController.text.trim()
                                 );
                                }else{

                                }

                              }

                            }, child: Text('Submit')
                        ),

                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text(isLogin ? 'Don\'t have an account' : 'Already have an account'),

                            TextButton(
                                onPressed: (){
                                  ref.read(loginProvider.notifier).toggle();

                                }, child:Text(isLogin? 'Sign Up' : 'Login')
                            )

                          ],
                        )

                      ],
                    ),
                  ),
                ),
              );
            }
              )
    );
  }

  TextFormField _buildTextFormField({
    required String label,
    required TextEditingController controller,
    required FormFieldValidator<String> val,
    required bool isPass
  }) {
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
          hintText: label
      ),
      validator: val,
      obscureText: isPass ? true : false,
    );
  }
}
