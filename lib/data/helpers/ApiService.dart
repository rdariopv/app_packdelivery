import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://docker-php-test.onrender.com';


  Future<bool> login(String username, String password) async {
    const Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };


    final response = await http.post(
      Uri.parse('$baseUrl/login'),
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
      return data['coderror'] == "0";

    } else {
      throw Exception('Error en el inicio de sesión');
    }
  }
}