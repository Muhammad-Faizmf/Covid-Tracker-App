
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:covid_tracker/CovidData/covid_apiFetcing.dart';
import 'package:covid_tracker/pages/countryDetails.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({ Key? key }) : super(key: key);

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {

  TextEditingController textcontroller = TextEditingController();
  
  ApiFetching apiDataFetching = ApiFetching();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textcontroller,
                onChanged: (value){
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search with country name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: apiDataFetching.CountriesDataFetching(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index){
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700, highlightColor: Colors.grey.shade100,
                          child: ListTile(
                            leading: Container(height: 50, width: 90, color: Colors.white),
                            title: Container(height: 10, width: 90, color: Colors.white),
                            subtitle: Container(height: 10, width: 90, color: Colors.white),
                          ),
                        );
                      }
                    );
                  }
                  else{
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        String name = snapshot.data![index]['country'];
                        if(textcontroller.text.isEmpty){
                          return ListTile(
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                            ),
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                            onTap: (){
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context)=>CountryDetails(
                                    country: snapshot.data![index]['country'],
                                    countryflag: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['todayCases'].toString(),
                                    active: snapshot.data![index]['active'].toString(),
                                    critical: snapshot.data![index]['critical'].toString(),
                                    tests: snapshot.data![index]['tests'].toString(),
                                    population: snapshot.data![index]['population'].toString(),
                                    deaths: snapshot.data![index]['todayDeaths'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    continent: snapshot.data![index]['continent'],
                                  ))
                              );
                            },
                          );
                        }
                        else if(name.toLowerCase().contains(textcontroller.text.toLowerCase())){
                          return ListTile(
                            leading: Image(
                              height: 50,
                              width: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                            ),
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                             onTap: (){
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context)=>CountryDetails(
                                    country: snapshot.data![index]['country'],
                                    countryflag: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['todayCases'].toString(),
                                    active: snapshot.data![index]['active'].toString(),
                                    critical: snapshot.data![index]['critical'].toString(),
                                    tests: snapshot.data![index]['tests'].toString(),
                                    population: snapshot.data![index]['population'].toString(),
                                    deaths: snapshot.data![index]['todayDeaths'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    continent: snapshot.data![index]['continent'].toString(),
                                  ))
                              );
                            },
                          );
                        }
                        else {
                          return Container();
                        }
                      }
                    );
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
