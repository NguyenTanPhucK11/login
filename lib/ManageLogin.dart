import 'package:flutter/material.dart';

class ManageLogin extends StatefulWidget {
  @override
  _ManageLoginState createState() => _ManageLoginState();
}

class _ManageLoginState extends State<ManageLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ), 
      home: Scaffold(
        appBar: AppBar(title: Text('Manage Account'),),
        body: _buildBody(),
      ),
    );
  }

  _buildBody(){
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ListTile( title: Text('ID 1')),
        ListTile( title: Text('ID 2')),
        ListTile( title: Text('ID 3')),
      ],
    );
  }
}