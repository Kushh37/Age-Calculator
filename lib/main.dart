//import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double age = 0.0;
  var selectedYear;

  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));

    animation = animationController;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _showPicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((DateTime dt) {
      setState(() {
        selectedYear = dt.year;
        calculateAge();
      });
    });
  }

  void calculateAge() {
    setState(() {
      age = (2021 - selectedYear).toDouble();
      animation = new Tween<double>(begin: animation.value, end: age,).animate(
          new CurvedAnimation(
              parent: animationController, curve: Curves.fastOutSlowIn));
    });
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: new Text("Age Calculator")),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(
                onPressed: _showPicker,
                child: Text(selectedYear != null
                    ? selectedYear.toString()
                    : "Select your Year of birth"),
                borderSide: BorderSide(color: Colors.black, width: 3.0),
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              Container(
                child: Text(
                  "Your Age is  ${animation.value.toStringAsFixed(0)}",
                  style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

