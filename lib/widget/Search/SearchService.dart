import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance.collection("FreshRecipes").where(
        "searchKey",
        isEqualTo: searchField.substring(0, 1).toUpperCase()).get();
  }
  searchByRecommend(String searchField) {
    return FirebaseFirestore.instance.collection("Recommended").where(
        "searchKey",
        isEqualTo: searchField.substring(0, 1).toUpperCase()).get();
  }
}
