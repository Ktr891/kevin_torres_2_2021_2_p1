import 'package:elephants_app/components/loader_component.dart';
import 'package:elephants_app/screens/elephants_screen.dart';
import 'package:flutter/material.dart';

class BeginningScreen extends StatefulWidget {
  const BeginningScreen({Key? key}) : super(key: key);

  @override
  _BeginningScreenState createState() => _BeginningScreenState();
}

class _BeginningScreenState extends State<BeginningScreen> {
  bool _showLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _showLogo(),
            _showButton(),
          ],
        )),
        _showLoader
            ? LoaderComponent(
                text: 'Por favor espere',
              )
            : Container(),
      ],
    ));
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      width: 500,
    );
  }

  Widget _showButton() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showElephants(),
              child: Text('Ver Elefantes'),
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                return Colors.lightGreen;
                ;
              })),
            ),
          ),
        ],
      ),
    );
  }

  void _showElephants() {
    setState(() {
      _showLoader = true;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ElephantsScreen()));
    setState(() {
      _showLoader = false;
    });
  }
}
