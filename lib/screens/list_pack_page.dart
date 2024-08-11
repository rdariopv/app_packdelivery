
import 'package:app_packdelivery/controller/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPackPage extends StatefulWidget {
  const ListPackPage({super.key});

  @override
  State<ListPackPage> createState() => _ListPackPage();
}


class _ListPackPage extends State<ListPackPage> {
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      // Solo llama a fetchItems si no se ha cargado previamente
      Provider.of<ListProvider>(context, listen: false).fetchItems().then((_) {
        setState(() {
          _isLoaded = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ListProvider>(context);


    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: Consumer<ListProvider>(
        builder: (context, itemProvider, child) {
          if (itemProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (itemProvider.items.isEmpty) {
            return Center(child: Text('No items found'));
          }else{

          }

          return ListView.builder(
            itemCount: itemProvider.items.length,
            itemBuilder: (context, index) {
              final item = itemProvider.items[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(item.id_orden.toString()),
                  subtitle: Text(item.detalle.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}