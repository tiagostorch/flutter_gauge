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
                widthCircle: 20,
                index: 5.8 * 3,
                end: 100,
                number: Number.all,
                secondsMarker: SecondsMarker.secondsAndMinute,
                hand: Hand.long,
                counterAlign: CounterAlign.center,
                handColor: Colors.black,
                titleText: "6.8",
                titleStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
                subtitleText: "de 10.0",
                subtitleStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                animationDuration: Duration(seconds: 25),
                percentage: 75,
              ),
              new Text("Height")
            ],
          )
        ],
      ),
    );
  }
}
