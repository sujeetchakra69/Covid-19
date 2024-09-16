import 'dart:convert';

import 'package:covid19/components/services/app_URI.dart';
import 'package:covid19/components/services/model.dart';
import 'package:http/http.dart' as http;

class Statesservices{

  Future <Models> fetchWorldStateRecords() async{
    final response =  await http.get(Uri.parse(AppUrl.worldStateUrl));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return Models.fromJson(data);

    }
    else{
      throw Exception('error');
    }
  }


  
  Future <List<dynamic>> countriesList() async{
    var data;
    final response =  await http.get(Uri.parse(AppUrl.countrieslist));
    if(response.statusCode==200){
       data = jsonDecode(response.body);
      return data;

    }
    else{
      throw Exception('error');
    }
  }
}