import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  const MyButton({super.key, required this.onTap }) ;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: this.onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color:Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Iniciar Sesion',
            style: TextStyle(
              color:Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),

          ),
        ),
      );
  }
}