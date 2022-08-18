
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:covid_tracker/CovidData/covid_Url.dart';
import 'package:covid_tracker/Models/CovidModel.dart';
import "package:http/http.dart" as http;

class ApiFetching {
  
 Future<CovidModel> CovidDataFetching() async {
   
   var res  = await http.get(Uri.parse(AppUrl.allCovidUrl));
   
   if(res.statusCode == 200){
    var data = jsonDecode(res.body.toString());
    return CovidModel.fromJson(data); 
   }
   else {
   throw Exception("Error");
  }
}

Future<List<dynamic>> CountriesDataFetching() async {
   
   var res  = await http.get(Uri.parse(AppUrl.countriesList));
   var data;
   if(res.statusCode == 200){
    data = jsonDecode(res.body);
    return data;
   }
   else {
   throw Exception("Error");
  }
}
}