import 'package:app_packdelivery/data/models/item_pack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListProvider extends ChangeNotifier {
  List<ItemPack> _items = [];
  bool _isLoading = false;
  String? _token;
  String? message;

  List<ItemPack> get items => _items;
  bool get isLoading => _isLoading;


  void setToken(String? token) {
    _token = token;
  }

  Future<void> fetchItems() async {
    if (_token == null) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.get(
     // Uri.parse('https://docker-php-test.onrender.com/getorderpack'),
      Uri.parse('https://logibol.sistemasamedida.online/order-api/public/ordenescarga'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      //List jsonResponse = json.decode(response.body);
      final jsonResponse = json.decode(response.body);

      //_items = apiResponse.data;
      final data = json.decode(response.body);
      if(data['coderror'] == 0){
        final list2=data["resultobj"];
        var ordenesJson = list2 as List;
        List<ItemPack> ordenesList = ordenesJson.map((ordenJson) => ItemPack.fromJson(ordenJson)).toList();

        _items = ordenesList;
        final x=2;
      }


    } else {
      throw Exception('Failed to load items');
    }

    _isLoading = false;
    notifyListeners();

  }

  Future<void> setState(int id_orden, int id_state) async {
    if (_token == null) return;

    _isLoading = true;
    notifyListeners();

    //final response = await http.post(
    //  Uri.parse('https://docker-php-test.onrender.com/setstate'),
    //  headers: {'Authorization': 'Bearer $_token'},
    //);

    final response = await http.post(
      Uri.parse('https://docker-php-test.onrender.com/setstate'),
      headers: <String, String>{
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'id_orden': id_orden,
        'id_chofer': id_state,
      }),
    );
    if (response.statusCode == 200) {
      //List jsonResponse = json.decode(response.body);
      final jsonResponse = json.decode(response.body);

      //_items = apiResponse.data;
      final data = json.decode(response.body);
     // return data['coderror'] == "0";
      if(data['coderror'] == 0){
        final messagelocal=data["message"];
        message=messagelocal;
        notifyListeners();

        final x=2;
      }


    } else {
      throw Exception('Failed to set state');
    }

    _isLoading = false;
    notifyListeners();
  }


}
