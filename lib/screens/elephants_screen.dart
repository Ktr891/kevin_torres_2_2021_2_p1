import 'dart:convert';

import 'package:elephants_app/components/loader_component.dart';
import 'package:elephants_app/models/elephant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ElephantsScreen extends StatefulWidget {
  const ElephantsScreen({Key? key}) : super(key: key);

  @override
  _ElephantsScreenState createState() => _ElephantsScreenState();
}

class _ElephantsScreenState extends State<ElephantsScreen> {
  List<Elephant> _elephants = [];
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _getElephants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elefantes'),
      ),
      body: Center(
        child: _showLoader
            ? LoaderComponent(
                text: 'Por favor espere',
              )
            : Text('Elefantes'),
      ),
    );
  }

  void _getElephants() async {
    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse('https://elephant-api.herokuapp.com/elephants');
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    setState(() {
      _showLoader = false;
    });

    var body = response.body;
    var decodeJson = jsonDecode(body);
    if (decodeJson != null) {
      for (var item in decodeJson) {
        _elephants.add(Elephant.fromJson(item));
      }
    }
    print(_elephants);
  }
}
