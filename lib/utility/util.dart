import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static Future<void> saveUserId(String? userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId!);
  }

  static Future<void> saveUserLogged(bool? isLogged) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLogged!);
  }

  static Future<bool?> getUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn');
  }

  static Future<void> clearSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("Preference Clerared");
  }

  Future<void> firebaseLogout() async {
    try {
      FirebaseAuth.instance.signOut();
      print("Firebase auth signed out");
    } catch (e) {
      print("Error during sign out ${e.toString()}");
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await firebaseLogout();
      await clearSharedPreference();

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print("Error during logout : ${e.toString()}");
    }
  }
}
