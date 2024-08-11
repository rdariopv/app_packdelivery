import 'package:app_packdelivery/data/models/item_pack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListProvider extends ChangeNotifier {
  List<ItemPack> _items = [];
  bool _isLoading = false;
  String? _token;

  List<ItemPack> get items => _items;
  bool get isLoading => _isLoading;


  void setToken(String? token) {
    _token = token;
  }

  Future<void> fetchItems() async {
    if (_token == null) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse('https://docker-php-test.onrender.com/getorderpack'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      //List jsonResponse = json.decode(response.body);
      final jsonResponse = json.decode(response.body);

      //_items = apiResponse.data;
      final data = json.decode(response.body);
      if(data['coderror'] == "0"){
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
}
