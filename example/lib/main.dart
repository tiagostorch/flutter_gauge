import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new FlutterGauge(
                    inactiveColor: Colors.redAccent,
                    activeColor: Colors.green,
                    handSize: 10,
                    width: 300,
                    widthCircle: 40,
                    index: 6.8*3,
                    end: 10*3,
                    number: Number.none,
                    secondsMarker: SecondsMarker.seconds,
                    isCircle: false,
                    hand: Hand.short,
                    counterAlign: CounterAlign.center,
                    handColor: Colors.black,
                    titleText: "6.8",
                    titleStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    subtitleText: "de 10.0",
                    subtitleStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    animationDuration: Duration(seconds: 25),
                  ),
                  new Text("Height")
              ],
            )
        ],
      ),
    );
  }
}








