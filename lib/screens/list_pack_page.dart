
import 'package:app_packdelivery/components/item_card.dart';
import 'package:app_packdelivery/controller/list_provider.dart';
import 'package:app_packdelivery/data/models/item_pack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPackPage extends StatefulWidget {
  const ListPackPage({super.key});

  @override
  State<ListPackPage> createState() => _ListPackPage();
}


class _ListPackPage extends State<ListPackPage> {
  bool _isLoaded = false;

  // Ejemplo de función para cambiar el estado
  void changeItemState(ItemPack item, int newStateId) {
    // Lógica para cambiar el estado del item
    // Esto podría implicar actualizar el estado en la API o localmente
    print('Cambiar estado para el item ${item.nro_carga} a estado $newStateId');
    //Provider.of<ListProvider>(context, listen: false).setState(item.id_orden??0, newStateId).then((_) {
    //  setState(() {
    //    _isLoaded = true;
    //  });
    //});
  }



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
              return ItemCard(
                item: item,
                onChangeState: (item, newStateId) {

                  changeItemState(item, newStateId);

                  // Actualiza la lista de items si es necesario
                },
              );
             // return Card(
             //   margin: EdgeInsets.all(8.0),
             //   child: ListTile(
             //     title: Text(item.id_orden.toString()),
             //     subtitle: Text(item.detalle.toString()),
             //   ),
             // );
            },
          );
        },
      ),
    );
  }
}