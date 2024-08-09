

import 'package:app_packdelivery/controller/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_packdelivery/screens/home_page.dart';
import 'package:app_packdelivery/components/my_button.dart';
import 'package:app_packdelivery/components/my_textfield.dart';
import 'package:app_packdelivery/components/square_tile.dart';
import 'package:app_packdelivery/controller/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
   LoginPage({super.key});

  State<LoginPage> createState()=> _LoginPageState();}

class _LoginPageState extends State<LoginPage>{

  final _formKey = GlobalKey<FormState>();
  final _usernameController= TextEditingController();
  final _passwordController= TextEditingController();
  final ApiService _apiService = ApiService();

  Future<bool>? _loginFuture;
  void _initiateLogin() {
   // if (_formKey.currentState!.validate()) {
      setState(() {
        _loginFuture = _apiService.login(
          _usernameController.text,
          _passwordController.text,
        );



      });



  }

  bool _isLoading = false;
  String _errorMessage = '';
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
     bool result=  await Provider.of<AuthProvider>(context, listen: false)
          .login(username, password);
      // Al iniciar sesión con éxito, la vista se actualizará automáticamente
        //if(result){
        //    WidgetsBinding.instance.addPostFrameCallback((_) {
        //      Navigator.of(context).pushReplacement(
        //        MaterialPageRoute(builder: (context) => HomePage()),
        //      );
        //    });
        //}
    } catch (error) {
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

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
                    Icons.fire_truck,
                    size: 100,
                  ),
                  const SizedBox(height: 40),
                  // welcome back, you've  been missed
                  Text(
                    'LogiBOL',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20
                    ),

                  ),
                  const SizedBox(height: 25),
                  // username textfield
                  MyTextfield(
                    controller: _usernameController, hintText: 'username', obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  // password textfield
                  MyTextfield(
                    controller: _passwordController, hintText: 'password', obscureText: false,
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
               //   MyButton( onTap:_initiateLogin ),

                  _isLoading
                      ? CircularProgressIndicator()
                      : MyButton(
                    onTap: _login,
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),


                  //if (_loginFuture != null)
                  //  FutureBuilder<bool>(
                  //    future: _loginFuture,
                  //    builder: (context, snapshot) {
                  //      if (snapshot.connectionState == ConnectionState.waiting) {
                  //        return CircularProgressIndicator();
                  //      } else if (snapshot.hasError) {
                  //        return Text('Error: ${snapshot.error}');
                  //      } else if (snapshot.data == true) {
                  //        WidgetsBinding.instance.addPostFrameCallback((_) {
//
                  //          Navigator.of(context).pushReplacement(
                  //            MaterialPageRoute(builder: (context) => HomePage()),
                  //          );
                  //        });
                  //        return SizedBox.shrink();
                  //      } else {
                  //        return Text('Credenciales inválidas');
                  //      }
                  //    },
                  //  ),

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


  }







}