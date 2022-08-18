
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:covid_tracker/CovidData/covid_apiFetcing.dart';
import 'package:covid_tracker/Models/CovidModel.dart';
import 'package:covid_tracker/pages/countryListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class CovidCasesScreen extends StatefulWidget {
  const CovidCasesScreen({ Key? key }) : super(key: key);

  @override
  _CovidCasesScreenState createState() => _CovidCasesScreenState();
}

class _CovidCasesScreenState extends State<CovidCasesScreen> with TickerProviderStateMixin {

  bool Internet = false;

  final colorslist = <Color>[
    Colors.green,
    Colors.red,
    Colors.blue
  ];

  late AnimationController controller = AnimationController(
  duration: const Duration(seconds: 3),vsync: this)..repeat();
  
  ApiFetching apiDataFetching = ApiFetching();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              FutureBuilder(
               future: apiDataFetching.CovidDataFetching(),
                builder: (context, AsyncSnapshot<CovidModel> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      heightFactor: 15,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        controller: controller,
                      ),
                    );
                  }
                  else{
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: PieChart(
                            dataMap: {
                              "Total":double.parse(snapshot.data!.cases.toString()),
                              "Recovered":double.parse(snapshot.data!.recovered.toString()),
                              "Deaths":double.parse(snapshot.data!.deaths.toString())
                            },
                            colorList: colorslist,
                            animationDuration: Duration(milliseconds: 1200),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartType: ChartType.ring,
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06
                          ),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseRow("Total", snapshot.data!.cases.toString()),
                                  ReuseRow("Recoverd", snapshot.data!.recovered.toString()),
                                  ReuseRow("Deaths", snapshot.data!.deaths.toString()),
                                  ReuseRow("Active", snapshot.data!.active.toString()),
                                  ReuseRow("Critical", snapshot.data!.critical.toString()),
                                  ReuseRow("Tests", snapshot.data!.tests.toString()),
                                  ReuseRow("Affected Countries", snapshot.data!.affectedCountries.toString())
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (BuildContext context)=>CountryListScreen()
                                )
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Center(
                                  child: Text("Track Countries"),
                                ),
                              ),
                            ),
                          ),
                        ],
                     );
                  }
                }
              ),

            ],
          ),
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