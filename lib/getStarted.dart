import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Text(
                'GET STARTED',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
