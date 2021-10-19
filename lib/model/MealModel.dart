import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Meal with ChangeNotifier {
  int? id;
  String? title;
  String? calories;
  String? ingredients;
  String? steps;
  String? serving;
  String? imageUrl;
  String? minites;
   Meal({
    this.id,
    this.title,
    this.calories,
    this.ingredients,
    this.steps,
    this.serving,
    this.imageUrl,
    this.minites,
   });

  Meal.fromjson(Map<String, dynamic> map) {
    if (map == null) {
      print("===>null");
    }
    id = map["id"];
    title = map["title"];
    calories = map["caliores"];
    ingredients = map["ingrediants"];
    steps = map["steps"];
    serving = map["servising"];
    imageUrl = map["imageUrl"];
    minites = map["minites"];
    minites = map["minites"];
   }

  toJsonData() {
    return {
      "id": id,
      "caliores": calories,
      "ingrediants": ingredients,
      "steps": steps,
      "servising": serving,
      "imageUrl": imageUrl,
      "title": title,
      "minites": minites,
     };
  }
  @override
  String toString() {
    // TODO: implement toString
    return "$id $serving $title $calories $minites ";
  }
}
