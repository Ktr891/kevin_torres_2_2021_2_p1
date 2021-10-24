import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:elephants_app/components/loader_component.dart';
import 'package:elephants_app/models/elephant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'elephant_screen.dart';

class ElephantsScreen extends StatefulWidget {
  const ElephantsScreen({Key? key}) : super(key: key);

  @override
  _ElephantsScreenState createState() => _ElephantsScreenState();
}

class _ElephantsScreenState extends State<ElephantsScreen> {
  List<Elephant> _elephants = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _getElephants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Elefantes'),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter, icon: Icon(Icons.filter_none))
              : IconButton(onPressed: _showFilter, icon: Icon(Icons.filter_alt))
        ],
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

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estes conectado a internet.',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

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
  }

  Widget _getContent() {
    return _elephants.length == 0 ? _noContent() : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          _isFiltered
              ? 'No hay Elfantes con ese criterio de búsqueda.'
              : 'No hay Elefantes registrados.',
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
            onTap: () => _goView(e),
            child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: FadeInImage(
                              placeholder: AssetImage('assets/logo.png'),
                              image: NetworkImage(e.image.toString()),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover),
                        ),
                        Column(
                          children: [
                            Text(
                              e.name.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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

  void _showFilter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Filtrar Elefantes'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Escriba las primeras letras del elefante'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Criterio de búsqueda...',
                      labelText: 'Buscar',
                      suffixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    _search = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              TextButton(onPressed: () => _filter(), child: Text('Filtrar')),
            ],
          );
        });
  }

  void _filter() {
    if (_search.isEmpty) {
      return;
    }

    List<Elephant> filteredList = [];
    for (var elephant in _elephants) {
      if (elephant.name
          .toString()
          .toLowerCase()
          .contains(_search.toLowerCase())) {
        filteredList.add(elephant);
      }
    }

    setState(() {
      _elephants = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getElephants();
  }

  _goView(Elephant elephant) async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ElephantScreen(
                  elephant: elephant,
                )));
    if (result == 'yes') {
      _getElephants();
    }
  }
}
