import 'package:app_packdelivery/controller/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ListProvider>(context);

    return AlertDialog(
      title: Text('API Result'),
      content: Text(apiProvider.message.toString()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}