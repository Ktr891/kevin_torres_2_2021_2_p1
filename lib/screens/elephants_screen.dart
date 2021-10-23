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
            : _getContent(),
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
      //_elephants = List<Elephant>.from(
      //  decodeJson.map((model) => Elephant.fromJson(model)));
      for (var item in decodeJson) {
        _elephants.add(Elephant.fromJson(item));
      }
    }
    print(_elephants);
  }

  Widget _getContent() {
    return _elephants.length == 0 ? _noContent() : _getListView();
  }

  Widget _noContent() {
    /*return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          _isFiltered
              ? 'No hay procedimientos con ese criterio de búsqueda.'
              : 'No hay procedimientos registrados.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );*/
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          'No hay elefantes para mostrar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getListView() {
    return ListView(
      children: _elephants.map((e) {
        return Card(
          child: InkWell(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeInImage(
                            placeholder: AssetImage('assets/logo.png'),
                            image: NetworkImage(e.image.toString()),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover),
                        Column(
                          children: [
                            Text(
                              e.name.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    )
                  ],
                )),
          ),
        );
      }).toList(),
    );
  }
}
