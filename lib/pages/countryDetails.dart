
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {

  String country, countryflag, totalCases;
  String tests, recovered, deaths;
  String active, critical, population;
  String continent;
  
  CountryDetails({ 
    Key? key, 
    required this.country,
    required this.countryflag,
    required this.totalCases,
    required this.tests,
    required this.active,
    required this.deaths,
    required this.critical,
    required this.population,
    required this.recovered,
    required this.continent,
    })
    : super(key: key);

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(widget.country),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067, left: 5, right: 5),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06),
                        ReuseRow("Continent", widget.continent),
                        ReuseRow("Today Cases", widget.totalCases),
                        ReuseRow("Recovered", widget.recovered),
                        ReuseRow("Today Deaths", widget.deaths),
                        ReuseRow("Population", widget.population),
                        ReuseRow("Tests", widget.tests),
                        ReuseRow("Active", widget.active),
                        ReuseRow("Critical", widget.critical),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.countryflag)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget ReuseRow(String title, String value){
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 10.0),
          Divider(),
        ],
      ),
    );
  }
}