
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unrelated_type_equality_checks

import 'dart:async';

import 'package:covid_tracker/pages/covidCasesScreen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}


class _HomepageState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController controller = AnimationController(
  duration: const Duration(seconds: 3),vsync: this)..repeat();  



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Timer(Duration(seconds: 5),
        ()=> Navigator.push(context, MaterialPageRoute(
          builder: (context)=> CovidCasesScreen()))
     );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Image(image: AssetImage("images/virus.png")),
                ),
              ),
               builder: (BuildContext context, Widget? child){
                 return Transform.rotate(
                   angle: controller.value * 2.0 * math.pi,
                   child: child,
                  );
               }
              ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Covid-19\nTracker App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}