
import 'package:flutter/foundation.dart';


class UserChoferApp{

    final String username;
    final String  email;
    final  String apiToken;
    int   id_chofer;

   UserChoferApp({required this.username,required this.email,required this.apiToken,required this.id_chofer });

    factory UserChoferApp.fromJson(Map<String, dynamic> json) {
       return UserChoferApp(
          username: json['username'],
          email: json['email'],
          apiToken: json['apiToken'],
          id_chofer: json['id_chofer'],
       );

    }


}