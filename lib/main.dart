import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verbrauchsrechner',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(49, 60, 62, 22),
      ),
      home: const MyHomePage(title: 'Verbrauchsrechner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: const [
          DetailPage(),
          Volltank()
        ],
      )
    );
    }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  double _verbrauch = 0;
  int _strecke = 0;
  double _verbrauchIns = 0;
  double _spritpreis = 0;
  double _preis = 0;
  var streckeController = TextEditingController();
  var verbrauchController = TextEditingController();
  var spritController = TextEditingController();


  void _calculate() {
    setState(() {
      _verbrauch = double.parse(verbrauchController.text);
      _strecke = int.parse(streckeController.text);
      _spritpreis = double.parse(spritController.text);
      _verbrauchIns = double.parse(((_strecke/100)*(_verbrauch/100)*100).toStringAsFixed(1));
      _preis = double.parse((_verbrauchIns * _spritpreis).toStringAsFixed(2));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 40, 20, 20),
      child: Center(
          child: Column(
            children: <Widget>[

          InputRow(message: 'Strecke', end: 50, tfmessage: 'km', hintmessage: 'Strecke', variable: _strecke.toDouble(), controller: streckeController, function: _calculate,),
          InputRow(message: 'Verbrauch', end: 10, tfmessage: 'l/100km', hintmessage: 'Verbrauch', variable: _verbrauch, controller: verbrauchController, function: _calculate),
          InputRow(message: 'Spritpreis', end: 10, tfmessage: '€/l', hintmessage: 'Spritpreis', variable: _spritpreis, controller: spritController, function: _calculate),
          Button(function: _calculate),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_gas_station_rounded, size: 50, color: Colors.blueGrey,),
              Output(ergebnis: _verbrauchIns > 0 ? "${_verbrauchIns.toString()} l" : '-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.attach_money, size: 50, color: Colors.blueGrey),
              Output(ergebnis: _preis > 0 ? "${_preis.toString()} €" : '-')
            ],
          )
      ],
    ),
    ),
    );
  }
}



class Volltank extends StatefulWidget {
  const Volltank({Key? key}) : super(key: key);

  @override
  _VolltankState createState() => _VolltankState();
}

class _VolltankState extends State<Volltank> {

  var _literController = TextEditingController();
  var _spritController = TextEditingController();
  double _sprit = 0;
  int _liter = 0;
  double _volltank = 0;



  void _calculateVolltank() {
    setState(() {
      _liter = int.parse(_literController.text);
      _sprit = double.parse(_spritController.text);
      _volltank = _sprit * _liter;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.all(60),
            child: Text('Volltank', style: TextStyle(fontSize: 60, color: Colors.white60, fontFamily: 'RobotoMono-bold'),),
          ),

          InputRow(message: 'Gesamtaufnahme', end: 10, tfmessage: 'L', hintmessage: 'Gesamt Liter', variable: _liter.toDouble(), controller: _literController, function: _calculateVolltank),
          InputRow(message: 'Spritpreis', end: 10, tfmessage: '€/L', hintmessage: 'Spritpreis', variable: _sprit, controller: _spritController, function: _calculateVolltank),
          Button(function: _calculateVolltank),
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_gas_station_rounded, size: 50, color: Colors.blueGrey),
                  const Icon(Icons.attach_money_rounded, size: 50, color: Colors.blueGrey,),
                  Output(ergebnis: _volltank > 0 ? "${_volltank.toString()} €" : '-')
                ],
              )
          ),


        ],
      ),
    );
  }
}


class Button extends StatelessWidget {
   Button({Key? key, required this.function}) : super(key: key);

  var function;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: const Text("Calculate", style: TextStyle(fontSize: 20.0),),
      onPressed: function,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(10),
          primary: Colors.blueGrey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: const BorderSide(color: Colors.blueGrey)
      ),
    );
  }
}



class Output extends StatefulWidget {
  const Output({Key? key, required this.ergebnis}) : super(key: key);

  final String ergebnis;

  @override
  _OutputState createState() => _OutputState();
}

class _OutputState extends State<Output> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Text(widget.ergebnis, style: const TextStyle(fontSize: 40, color: Colors.white60),),
    );
  }
}


class InputRow extends StatefulWidget {
  InputRow({Key? key, required this.message, required this.end, required this.tfmessage, required this.hintmessage, required this.variable, required this.controller, required this.function}) : super(key: key);

  @override
  _InputRowState createState() => _InputRowState();

  final String message;
  final double end;
  final String tfmessage;
  final String hintmessage;
  double variable;
  var controller = TextEditingController();
  var function;
}


class _InputRowState extends State<InputRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, widget.end, 0, 10),
      child: Column(
        children: <Widget>[
          Text(widget.message,
            style: const TextStyle(fontSize: 30, color: Colors.white60),
          ),
          TextField(
            onSubmitted: (value) => widget.function,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            controller: widget.controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.tfmessage,
              hintText: widget.hintmessage,
            ),
          )
        ],
      ),

    );

  }
}

