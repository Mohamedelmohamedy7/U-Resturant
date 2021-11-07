import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:food_app/model/MealModel.dart';
import 'package:sqflite/sqflite.dart';
class FavoriteProvider extends ChangeNotifier{

  Future<String> getDbPath() async {
    var dbPath = await getDatabasesPath();
    var favoriteDbPath = dbPath + "/" + Constants.DB_NAME;
    // print(noteDbPath);
    notifyListeners();
    return favoriteDbPath;
  }
  Future<Database> geFavoriteDb() async {
    String path = await getDbPath();
    notifyListeners();
    return openDatabase(
      path,
      version: Constants.DB_VERSION,
      onCreate: (db, version) => createDb(db),
      onUpgrade: (db, oldVersion, newVersion) => upgradeDb(db),
    );
  }

     createDb(Database db) {
      //create table
      String sql =
      'create table ${Constants.TABLE_NAME} ( ${Constants.COL_ID} integer primary key autoincrement, ${Constants.COL_TITLE} text, ${Constants.COL_STEPS} text,${Constants.COL_SARVCING} text,${Constants.COL_MINUTES} text,${Constants.COL_INGREDIANTS} text,${Constants.COL_IMAGEURL} text,${Constants.COL_CALORIES} text,${Constants.COL_view} text )';
      print(sql);
      db.execute(sql);
      notifyListeners();

     }

    upgradeDb(Database db) {
     createDb(db);
     notifyListeners();

    }

 Future<int> insertFavorite(Meal meal)async{
    Database db = await geFavoriteDb();
    notifyListeners();
    var queryResult = await db.rawQuery('SELECT * FROM ${Constants.TABLE_NAME} WHERE ${Constants.COL_TITLE}="${meal.title}"');
    if(queryResult==null || queryResult.length==0) {
      Fluttertoast.showToast(
        msg: "Meal Is Added To Favorites",
        textColor:Colors.white,
        backgroundColor:  primaryColor,
        fontSize: 12,
        toastLength: Toast.LENGTH_SHORT,
      );
      return db.insert(Constants.TABLE_NAME, meal.toJsonData());
    }
    else{
      Fluttertoast.showToast(
        msg: "Meal Is Already Added",
        textColor: Colors.grey.shade500,
        backgroundColor: Colors.black,
        fontSize: 13,
        toastLength: Toast.LENGTH_SHORT,
      );
      print("false");
      return 0;
    }
    }

  Future<List<Meal>> viewData() async {
     List<Meal> meal =[];
    Database db = await geFavoriteDb();
      List<Map<String,dynamic>> list= await db.query(Constants.TABLE_NAME,);
      list.forEach((element) {
        meal.add(Meal.fromjson(element));
      });
     notifyListeners();
     return meal;
  }
  void insertFav(Meal meal){
     insertFavorite(meal).then((value) {
      value !=null ?
      print("Done") : print("error");
      notifyListeners();
    });

  }
  Future<int> delete(Meal meal) async {
    Database db = await geFavoriteDb();
    return db.delete(Constants.TABLE_NAME,where:"${Constants.COL_ID}=?",whereArgs: [meal.id]);
   }


}
