

import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {

  List<String> data;


  SecondScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('second screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data[0]),
            const SizedBox(height: 10,),
            Text(data[1]),
            const SizedBox(height: 10,),
            Text(data[2]),
            const SizedBox(height: 10,),
            Text(data[3]),
          ],
        ),
      ),
    );
  }
}
