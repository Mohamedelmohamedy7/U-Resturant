import 'package:flutter/material.dart';
import 'package:food_app/model/http_exception.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  DateTime? _expireTime;
  String? _userid;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }
  bool loading=false;
  String? get token {
    if (_expireTime != null &&
        _expireTime!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    } else {
      return null;
    }
  }

  String get userid {
    return _userid!;
  }

  Future<void> _authinticate(
      String email, String password, String urlsegment) async {
    try {
      final res = await http.post(
          Uri.parse(
              "https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key="
              "AIzaSyAW1AvCYzuNgiTOz64cx6eOYrfWiXl19jM"),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = json.decode(res.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      } else {
        _token = responseData["idToken"];
        _userid = responseData["localId"];
        _expireTime = DateTime.now().add(Duration(seconds: int.parse(responseData["expiresIn"])));
      }
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        'userId': _userid,
        'expiresIn': _expireTime!.toIso8601String(),
      });
      prefs.setString("userData", userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authinticate(email, password, "signUp");
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    return _authinticate(email, password, "signInWithPassword");
  }

  Future<bool> tryAutoLog() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) return false;
    final Map<String, dynamic> extractedData =
        json.decode(prefs.getString("userData")!) as Map<String, dynamic>;
    final expire = DateTime.parse(extractedData["expiresIn"] as dynamic);
    if (expire.isBefore(DateTime.now())) return false;
    _token = extractedData["token"] as dynamic;
    _expireTime = expire;
    _userid = extractedData["userId"] as dynamic;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userid = null;
    _expireTime = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    int timerTo_Exprey;
    timerTo_Exprey = _expireTime!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timerTo_Exprey), logout);
  }
}
