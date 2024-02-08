// To parse this JSON data, do
//
//     final footballResponseModel = footballResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FootballResponseModel> footballResponseModelFromJson(String str) => List<FootballResponseModel>.from(json.decode(str).map((x) => FootballResponseModel.fromJson(x)));

String footballResponseModelToJson(List<FootballResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FootballResponseModel {
  String? teamKey;
  String? teamName;
  TeamCountry? teamCountry;
  int? teamFounded;
  String? teamBadge;
  bool isFavorite = false;

  FootballResponseModel({
    this.teamKey,
    this.teamName,
    this.teamCountry,
    this.teamFounded,
    this.teamBadge,
  });

  FootballResponseModel.fromJson(Map<String, dynamic> json)  {
    teamKey = json["team_key"];
    teamName = json["team_name"] ?? "";
    teamCountry = teamCountryValues.map[json["team_country"] ?? ""];
    teamFounded = int.parse(json["team_founded"]);
    teamBadge = json["team_badge"] ?? "";
  }

  Map<String, dynamic> toJson() => {
    "team_key": teamKey,
    "team_name": teamName,
    "team_country": teamCountryValues.reverse[teamCountry],
    "team_founded": teamFounded.toString(),
    "team_badge": teamBadge,
  };

  Map<String, dynamic> toMap() {
    return {
      'teamKey': teamKey,
      'teamName': teamName,
      'teamBadge': teamBadge,
      'teamCountry': teamCountry?.toString().split('.').last,
      'teamFounded': teamFounded,
    };
  }

  String getCountryName() {
    if (teamCountry != null) {
      return teamCountryValues.reverse[teamCountry] ?? "Unknown";
    } else {
      return "Unknown";
    }
  }

  fromJson(Map<String, Object?> e) {}
}

enum TeamCountry {
  EMPTY,
  SPAIN
}

final teamCountryValues = EnumValues({
  "": TeamCountry.EMPTY,
  "Spain": TeamCountry.SPAIN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
