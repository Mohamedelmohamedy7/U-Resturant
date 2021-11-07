import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/MealModel.dart';

class MealProvider extends ChangeNotifier {
  List<Meal> get Model {
    return _Model;
  }

  List<Meal> _Model = [];
  var loading;

  getData() async {
    CollectionReference _collectionReference =
        FirebaseFirestore.instance.collection("FreshRecipes");
    try {
      await _collectionReference.get().then((value) {
        _Model.clear();
        for (int i = 0; i < value.docs.length; i++) {
           _Model.add(
              Meal.fromjson(value.docs[i].data() as Map<String, dynamic>));
        }
        notifyListeners();
      });
    } catch (e) {
      loading = true;
     }
    notifyListeners();
  }
}
