import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  int left = 1;
  int right = 1;
  int sum = 0;
  AnimationController _controller;
  CurvedAnimation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        animte();
  }

  animte(){
    _controller = AnimationController(duration: Duration(seconds: 2),vsync: this);
    animation = CurvedAnimation(parent: _controller,curve: Curves.bounceOut);
    _controller.forward();
    _controller.addListener(() {
      setState(() {

      });
      print(_controller.value);});
    _controller.addStatusListener((status) {if(status == AnimationStatus.completed){
      left = Random().nextInt(6)+1;
      right = Random().nextInt(6)+1;
      sum = left + right;
      print('Completed');
          _controller.reverse();
    }});
  }

  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  void roll(){
    _controller.forward();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Rolling Dice',
          style: TextStyle(
            color: Colors.redAccent,

          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded
                  (child: GestureDetector(
                  onDoubleTap: roll,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image(height: 200 - (animation.value)*100,
                      image: AssetImage('assets/images/dice-png-$left.png'),
                  ),
                ),
                )
                ),
                Expanded
                  (child: GestureDetector (
                  onDoubleTap: roll,
                  child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image(height: 200 - (animation.value)*100,
                      image: AssetImage('assets/images/dice-png-$right.png'),
                  ),
                ),
               ),
               )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(onPressed: roll,
                      child: Text('ROLL',style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Sum = $sum',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                  ),
                ]
            )
          ],
        ),
      ),
    );
  }
}

