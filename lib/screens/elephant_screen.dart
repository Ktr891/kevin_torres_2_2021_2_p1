import 'package:elephants_app/models/elephant.dart';
import 'package:elephants_app/screens/elephants_screen.dart';
import 'package:flutter/material.dart';

class ElephantScreen extends StatefulWidget {
  final Elephant elephant;

  ElephantScreen({required this.elephant});

  @override
  _ElephantScreenState createState() => _ElephantScreenState();
}

class _ElephantScreenState extends State<ElephantScreen> {
  String _name = '';
  String _affiliation = '';
  String _species = '';
  String _sex = '';
  String _fictional = '';
  String _dob = '';
  String _dod = '';
  String _wikilink = '';
  String _image = '';
  String _note = '';
  @override
  void initState() {
    super.initState();
    _getElephant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('Elefante: ' + _name),
        ),
        body: Stack(
          children: <Widget>[
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _showLogo(),
                _showInformation(),
              ],
            )),
          ],
        ));
  }

  void _getElephant() {
    _name = widget.elephant.name.toString();
    _affiliation = widget.elephant.affiliation.toString();
    _species = widget.elephant.species.toString();
    _sex = widget.elephant.sex.toString();
    _fictional = widget.elephant.fictional.toString();
    _dob = widget.elephant.dob.toString();
    _dod = widget.elephant.dod.toString();
    _wikilink = widget.elephant.wikilink.toString();
    _image = widget.elephant.image.toString();
    _note = widget.elephant.note.toString();
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      width: 150,
    );
  }

  Widget _showInformation() {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Nombre:       ' + _name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Afiliacion:     ' + _affiliation,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Especie:        ' + _species,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Sexo:             ' + _sex,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Ficticio:         ' + _fictional,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'dob:               ' + _dob,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'dod:               ' + _dod,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Ling: ' + _wikilink,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Nota: ' + _note,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
