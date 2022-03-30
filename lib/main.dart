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
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.05,
                image: AssetImage("images/gas-station.jpg"),
                fit: BoxFit.cover),
          ),
      child: PageView(
        controller: controller,
        children: const [
          DetailPage(),
          Volltank(),
          SpritNachGeld()
        ],
      )
    ));
    }
}
//Page um Verbrauch für bestimmte Strecke zu berechnen
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

          InputRow(end: 100, tfmessage: 'Strecke', variable: _strecke.toDouble(), controller: streckeController, function: _calculate),
          InputRow(end: 10, tfmessage: 'Verbrauch', variable: _verbrauch, controller: verbrauchController, function: _calculate),
          InputRow(end: 10, tfmessage: 'Spritpreis', variable: _spritpreis, controller: spritController, function: _calculate),
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


//Page Volltank
class Volltank extends StatefulWidget {
  const Volltank({Key? key}) : super(key: key);

  @override
  _VolltankState createState() => _VolltankState();
}

class _VolltankState extends State<Volltank> {

  final _literController = TextEditingController();
  final  _spritController = TextEditingController();
  final _verbrauchController = TextEditingController();
  double _sprit = 0;
  int _liter = 0;
  double _verbrauch = 0;
  double _volltank = 0;
  double _streckeVolltank = 0;



  void _calculateVolltank() {
    setState(() {
      _liter = int.parse(_literController.text);
      _sprit = double.parse(_spritController.text);
      _verbrauch = double.parse(_verbrauchController.text);
      _volltank = double.parse((_sprit * _liter).toStringAsFixed(2));
      _streckeVolltank = double.parse(((_liter / _verbrauch)*100).toStringAsFixed(2));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 40, 20, 20),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsetsDirectional.only(top: 30),
              child: Text('Volltank', style: TextStyle(fontSize: 60, color: Colors.white60, fontFamily: 'RobotoMono-bold'),),
            ),

            InputRow(end: 20, tfmessage: 'Gesamtaufnahme', variable: _liter.toDouble(), controller: _literController, function: _calculateVolltank),
            InputRow(end: 10, tfmessage: 'Spritpreis', variable: _sprit, controller: _spritController, function: _calculateVolltank),
            InputRow(end: 10, tfmessage: 'Verbrauch', variable: _verbrauch, controller: _verbrauchController, function: _calculateVolltank),
            Button(function: _calculateVolltank),
            Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_gas_station_rounded, size: 50, color: Colors.blueGrey),
                      const Icon(Icons.attach_money_rounded, size: 50, color: Colors.blueGrey,),
                      Output(ergebnis: _volltank > 0 ? "${_volltank.toString()} €" : '-')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_road, size: 50, color: Colors.blueGrey),
                      Output(ergebnis: _streckeVolltank > 0 ? "${_streckeVolltank.toString()} km" : '-')
                    ],
                  )
                ]
            ),
          ],
        ),
    );

  }
}


class SpritNachGeld extends StatefulWidget {
  const SpritNachGeld({Key? key}) : super(key: key);

  @override
  _SpritNachGeldState createState() => _SpritNachGeldState();
}

class _SpritNachGeldState extends State<SpritNachGeld> {

  final _geldController = TextEditingController();
  final _spritController = TextEditingController();
  final _verbrauchController = TextEditingController();
  double _geld = 0;
  double _sprit = 0;
  double _verbrauch = 0;
  double erwarteterSprit = 0;
  double strecke= 0;


  void _wieViel(){
    setState(() {
      _geld = double.parse(_geldController.text);
      _sprit = double.parse(_spritController.text);
      _verbrauch = double.parse(_verbrauchController.text);
      erwarteterSprit = double.parse((_geld/_sprit).toStringAsFixed(1));
      strecke = double.parse(((erwarteterSprit/_verbrauch)*100).toStringAsFixed(1));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 40, 20, 20),
        child: Column(
          children: <Widget>[
            const Text("Wie viel Sprit für wie viel Geld?", style: TextStyle(fontSize: 20, color: Colors.white60, fontFamily: 'RobotoMono-bold'),),
            InputRow(end: 100, tfmessage: "verfügbares Geld", variable: _geld, controller: _geldController, function: _wieViel),
            InputRow(end: 10, tfmessage: "Spritpreis", variable: _sprit, controller: _spritController, function: _wieViel),
            InputRow(end: 10, tfmessage: "Verbrauch", variable: _verbrauch, controller: _verbrauchController, function: _wieViel),
            Button(function: _wieViel),
            Padding(
                padding: const EdgeInsetsDirectional.only(top: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.local_gas_station_rounded, size: 50, color: Colors.blueGrey,),
                        Output(ergebnis: erwarteterSprit > 0 ? "${erwarteterSprit.toString()} l" : '-'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.add_road, size: 50, color: Colors.blueGrey),
                        Output(ergebnis: strecke > 0 ? "${strecke.toString()} km" : "-")
                      ],
                    )
                  ],
                )

            ),
          ],
        ),
      )

    );
  }
}



//ActionButton
class Button extends StatelessWidget {
    Button({Key? key, required this.function}) : super(key: key);

  var function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
        child: OutlinedButton(
          child: const Text("Calculate", style: TextStyle(fontSize: 20),),
          onPressed: function,
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              primary: Colors.blueGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              side: const BorderSide(color: Colors.blueGrey)
          ),
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
  const InputRow({Key? key,required this.end, required this.tfmessage, required this.variable, required this.controller, required this.function}) : super(key: key);

  @override
  _InputRowState createState() => _InputRowState();

  final double end;
  final String tfmessage;
  final double variable;
  final TextEditingController controller;
  final void function;
}


class _InputRowState extends State<InputRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, widget.end, 0, 10),
      child: Column(
        children: <Widget>[
          TextField(
            onSubmitted: (value) => widget.function,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            controller: widget.controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.tfmessage, labelStyle: const TextStyle(color: Colors.white60),
            ),
          )
        ],
      ),

    );
  }
}
