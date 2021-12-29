import 'package:flutter/material.dart';

class first extends StatelessWidget {
  const first({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Material(
        color: Colors.amber,
        child: Center(
           child: Text(
          "Hello Worlds",
          style: TextStyle(color: Colors.white,fontSize: 40.0),
        ),
        )
      );
  }
}