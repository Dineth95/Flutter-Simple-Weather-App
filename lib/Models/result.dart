import 'package:flutter_weather_app/Models/current.dart';
import 'package:flutter_weather_app/Models/location.dart';
import 'package:flutter_weather_app/Models/condition.dart';
import 'dart:convert';


class Result {
  Location location;
  Current current;

  Result({
    this.location,
    this.current,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current": current.toJson(),
  };

  String getName(){
    return location.name;
  }
}