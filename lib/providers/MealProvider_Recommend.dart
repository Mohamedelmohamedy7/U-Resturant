import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/MealModel.dart';

class MealProviderRecommend extends ChangeNotifier {
  List<Meal> get RecommendModel => _RecommendModel;
  List<Meal> _RecommendModel = [];

  getDataRecommend() {
    CollectionReference _collectionReference =
        FirebaseFirestore.instance.collection("Recommended");
    try {
      _collectionReference.get().then((value) {
        _RecommendModel.clear();
        for (int i = 0; i < value.docs.length; i++) {
           _RecommendModel.add(
              Meal.fromjson(value.docs[i].data() as Map<String, dynamic>));
        }
        notifyListeners();
        print('_RecommendModel[0].id = ${_RecommendModel[0].calories}');
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
