import 'package:flutter/material.dart';
import 'package:app_packdelivery/components/my_button.dart';
import 'package:app_packdelivery/components/my_textfield.dart';
import 'package:app_packdelivery/components/square_tile.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});
  final userNameController= TextEditingController();
  final passwordController= TextEditingController();

  void signUserIn(){
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body:SafeArea(

          child: Center(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 40),
                  // welcome back, you've  been missed
                  Text(
                    'Welcome back you\'ve been missed',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16
                    ),

                  ),
                  const SizedBox(height: 25),
                  // username textfield
                  MyTextfield(
                    controller: userNameController, hintText: 'username', obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  // password textfield
                  MyTextfield(
                    controller: passwordController, hintText: 'password', obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Olvidastes la contraseña??',
                          style: TextStyle(color:Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // sign in button
                  MyButton(onTap: signUserIn,),
                  const SizedBox(height: 40),
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400]
                        ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('Or continue with',style: TextStyle(color: Colors.grey[700]),),
                        ),
                        Expanded(child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400]
                        ),
                        ),
                      ],
                    ),
                  ),

                  const  SizedBox(height: 35),
                  // google + apple  sign in button
                 // Expanded(
                 //  child: Row(
                 //    mainAxisAlignment: MainAxisAlignment.center,
                 //    children: const [
                 //      // google button
                 //      SquareTile(imagePath:'images/google.png'),
                 //      SizedBox(width: 10),
                 //      // apple button
                 //      SquareTile(imagePath:'images/apple.png'),
                 //    ],
                 //  ),
                 //),
                  const  SizedBox(height: 30),
                  // not a member register now
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No eres Miembro?',
                          style:
                          TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4,),
                        const Text(
                          'Registrar Ahora',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )

                ],)
          ),
        )

    );
  }}