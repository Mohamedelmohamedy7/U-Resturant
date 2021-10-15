import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/MealModel.dart';

class MealProviderRecommend extends ChangeNotifier{
  List<Meal> get RecommendModel=>_RecommendModel;
  List<Meal> _RecommendModel=[];
  var  loading ;

  getDataRecommend()   {

    CollectionReference _collectionReference =FirebaseFirestore.instance.collection("Recommended");
    try {
      loading=true;
      _collectionReference.get().then((value) {
        loading=false;
        _RecommendModel.clear();
        for (int i = 0; i < value.docs.length; i++) {
          _RecommendModel.add(
              Meal.fromjson(value.docs[i].data() as Map<String, dynamic>));
        }
        loading=false;
        print(RecommendModel[2].imageUrl);
        print("the length is = ${RecommendModel.length}");
      });
    }catch(e){
      print(e);
    }
    notifyListeners();
  }


}