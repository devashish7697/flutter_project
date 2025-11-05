import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class stateApp extends StatefulWidget {
  const stateApp({super.key});

  @override
  State<stateApp> createState() => _stateAppState();
}

class _stateAppState extends State<stateApp> {

  int count = 0;

  void _increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Counter Example')),
        body: Center(
          child: Text('count : $count', style: TextStyle(fontSize: 25),),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _increment ,
            foregroundColor: Colors.black,
            elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // make it square-rounded
          ),
            child: Icon(Icons.add),
        ),
      ),
    );
  }
}
