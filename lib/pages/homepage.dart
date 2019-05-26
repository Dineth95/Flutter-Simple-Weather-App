import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/Models/result.dart';
import 'package:flutter_weather_app/Models/current.dart';
import 'package:flutter_weather_app/Models/location.dart';
import 'package:flutter_weather_app/Models/condition.dart';

//final result = resultFromJson(jsonString);

class homepage extends StatefulWidget{
  homepageState createState()=>new homepageState();
}

class homepageState extends State<homepage>{

  final String url='https://api.apixu.com/v1/current.json?key= b32ef5610cd747829f1195455192604&q=colombo';
  var data;
  Result resultFromJson(String str) => Result.fromJson(json.decode(str));

  String resultToJson(Result data) => json.encode(data.toJson());


  void initState(){
    super.initState();
    this.getResult();
  }

  Future<String> getResult() async{
    var response=await http.get(
      Uri.encodeFull(url)
    );
    print(response.body);


    setState(() {
      var convertDataToJson=jsonDecode(response.body);
      data=convertDataToJson['current'];
      return "success";
    });
  }

  Widget result(var da){
    if(da==null){
      return new Center(child: CircularProgressIndicator(
        strokeWidth: 5.0,
      )
      );
    }else{

      return new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Image.network('https://3c1703fe8d.site.internapcdn.net/newman/csz/news/800/2018/1-whytheweathe.jpg'),
            ),
            new Padding(
            padding: EdgeInsets.only(top: 10.0),
            child:new Text('Last Updated:'+da['last_updated'].toString(),style: TextStyle(
              fontSize: 15.0
            ),),),
            new Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:new Text('Temperature in Celcius: '+da['temp_c'].toString(),style: TextStyle(
                  fontSize: 15.0
              ),),),
            new Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:new Text('Wind Mph: '+da['wind_mph'].toString(),style: TextStyle(
                  fontSize: 15.0
              ),),),
            new Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:new Text('Humidity: '+da['humidity'].toString(),style: TextStyle(
                  fontSize: 15.0
              ),),),
            new Padding(
              padding: EdgeInsets.only(
                top: 15.0,

              ),
              child:new Container(
                height: 100.0,
                width: 100.0,
                color: Colors.blueGrey,
                child:Image.network('http:'+da['condition']['icon'].toString()),
              )
            )
          ],
        ),
      );
    }
  }

  Widget build(BuildContext context){
    return new Scaffold(

      appBar: new AppBar(
        title: new Text('Colombo Current Weather'),
      ),

      body:result(data)

    );
  }
}