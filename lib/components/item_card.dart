import 'package:flutter/material.dart';

import '../data/models/item_pack.dart';
import 'package:flutter/material.dart';

import '../screens/map_page.dart';

// Asegúrate de que tu modelo ItemPack está importado
// import 'item_pack.dart';

class ItemCard extends StatelessWidget {
  final ItemPack item;
  final Function(ItemPack, int) onChangeState; // Callback para cambiar el estado

  ItemCard({required this.item, required this.onChangeState});


  // Lista de estados de ejemplo
  final List<Map<String, dynamic>> statuses = [
    {'id': 1, 'name': 'En Proceso'},
    {'id': 2, 'name': 'Completado'},
    {'id': 3, 'name': 'Pendiente'},
    // Agrega más estados aquí
  ];

  Future<void> _showChangeStateDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar Estado'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: statuses.map((status) {
                return ListTile(
                  title: Text(status['name']),
                  onTap: () {
                    Navigator.of(context).pop(); // Cierra el diálogo
                    onChangeState(item, status['id']); // Llama al callback con el nuevo estado
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 5.0,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Mostrar título
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${item.nro_carga ?? 'No Carga'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Mostrar imagen o ícono
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              image: item.image != null
                  ? DecorationImage(
                image: NetworkImage(item.image!),
                fit: BoxFit.cover,
              )
                  : null,
              color: item.image == null ? Colors.grey[200] : null,
            ),
            child: item.image == null
                ? Center(
              child: Icon(Icons.image, size: 50, color: Colors.grey),
            )
                : null,
          ),
          // Mostrar detalles
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Factura: ${item.nro_factura ?? 'No Factura'}\n'
                  'Fecha: ${item.fecha_orden?.toLocal().toString().split(' ')[0] ?? 'No Fecha'}\n'
                  'Estado: ${item.desc_estado ?? 'No Estado'}\n'
                  'Detalle: ${item.detalle ?? 'No Detalle'}\n'
                  'Empresa: ${item.desc_empresa ?? 'No Empresa'}\n'
                  'Cliente: ${item.desc_cliente ?? 'No Cliente'}\n'
                  'Chofer: ${item.desc_chofer ?? 'No Chofer'}\n'
                  'Carga: ${item.desc_carga ?? 'No Carga'}\n'
                  'Placa: ${item.desc_placa ?? 'No Placa'}\n'
                  'Tramo: ${item.desc_tramo ?? 'No Tramo'}\n',
              style: TextStyle(fontSize: 16),
            ),
          ),
          // Botón para cambiar el estado
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            //Row(
//
            //  mainAxisSize: MainAxisSize.min, // Ensure buttons take only the space they need
            //  mainAxisAlignment: MainAxisAlignment.end,
            //  children: [
            //    ElevatedButton(
            //      onPressed: () {
            //        // Handle button 1 press
            //      },
            //      child: Text('Button 1'),
            //    ),
            //    SizedBox(width: 8), // Spacing between buttons
            //    ElevatedButton(
            //      onPressed: () {
            //        // Handle button 2 press
            //      },
            //      child: Text('Button 2'),
            //    ),
            //  ],
            //),
            Align(
              alignment: Alignment.centerRight,
              child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    //onPressed: () => _showChangeStateDialog(context),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()),
                      );
                    },
                    child: Text('Ubicación'),
                  ),
                  SizedBox(width: 8), // Spacing between buttons
                  ElevatedButton(
                    onPressed: () => _showChangeStateDialog(context),
                    child: Text('Cambiar Estado'),
                  ),

              ],),
             // ElevatedButton(
             //   onPressed:() => _showChangeStateDialog(context),
             //   child: Text('Cambiar Estado'),
             // ),
            ),
          ),
        ],
      ),
    );
  }
}
