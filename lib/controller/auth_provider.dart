import 'package:app_packdelivery/controller/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



import '../data/models/user_chofer_app.dart';
class AuthProvider extends ChangeNotifier {
  /// state  of user information
  UserChoferApp? _user;
  UserChoferApp? get user => _user;
  bool get isAuthenticated => _user != null;


 // static const String baseUrl = 'https://docker-php-test.onrender.com';

  Future<bool> login(String username, String password) async {
    String urllocal="https://logibol.sistemasamedida.online/order-api/public/usuario";
    final response = await http.post(
      Uri.parse(urllocal),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _user= new UserChoferApp(username: username,
          email: "mail@gmail.com",
          apiToken: data["token"],
          id_chofer: 223);
      notifyListeners();
      return data['coderror'] == "0";

    } else {
      throw Exception('Error en el inicio de sesión');
    }
  }


  void logout(){
    _user =  null;
    notifyListeners();
  }

}