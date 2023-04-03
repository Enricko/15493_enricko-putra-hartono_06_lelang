import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
class Pref{

  static Future<bool> userPref(String id,String name,String token, String level)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("id", id);
    pref.setString("name", name);
    pref.setString("token", token);
    pref.setString("level", level);
    return true;
  }
  static Future<bool> logoutPref()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    return true;
  }
}