import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/StatelesssWidget/Constant.dart';
import 'package:food_app/Screen/auth_Screen/Login_Screen.dart';
import 'package:food_app/Screen/auth_Screen/Registers_screen.dart';
import 'package:food_app/providers/MealProvider.dart';
import 'package:food_app/providers/MealProvider_Recommend.dart';
import 'package:food_app/providers/auth_provdier.dart';
import 'package:food_app/widget/SeeAllToday.dart';
import 'package:provider/provider.dart';
import 'Favorite_Meal.dart';
import 'Screen/extension_widget/Setting.dart';
import 'StatelesssWidget/AboutUs.dart';
import 'Screen/HomePage.dart';
import 'Screen/splach_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProvider(create: (_) => MealProvider()),
          ChangeNotifierProvider(create: (_) => MealProviderRecommend()),
        ],
        child: Consumer<AuthProvider>(
            builder: (ctx, auth, _) {
              Future.delayed(
                  Duration.zero,
                      () {
                         return Provider.of<MealProvider>(ctx, listen: false).getData();
                      });
              Future.delayed(
                  Duration.zero,
                      () {
                    return Provider.of<MealProviderRecommend>(ctx, listen: false).getDataRecommend();
                  });
          print("Auth is ${auth.isAuth}");
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Theme.of(context).primaryColor,
            ),
            home: auth.isAuth
                 ?   HomePage()
                 : FutureBuilder(
                     future: auth.tryAutoLog(),
                    builder: (ctx, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          color: primaryColor,
                            height: double.infinity,
                            width: double.infinity,
                        );
                      } else {
                        return SplachScreen();
                      }
                    },
                  ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/LoginScreen': (context) => LoginScreen(),
              '/Registers': (context) => Registers(),
              '/HomePage': (context) => HomePage(),
              '/SplachScreen': (context) => SplachScreen(),
              '/AboutUs': (context) => AboutUs(),
              '/FavoriteMeal': (context) => FavoriteMeal(),
              '/SeeAllToDayGrid': (context) => SeeAllToDayGrid(),
              '/Setting': (context) => Setting(),
            },
          );
        }));
  }
}
