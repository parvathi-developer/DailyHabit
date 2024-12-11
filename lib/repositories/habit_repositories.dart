import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_app/model/habit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HabitRepositories {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<HabitModel>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final habits = prefs.getString('habits');

    if (habits != null) {
      final List<dynamic> habitsList = json.decode(habits);
      return habitsList.map((e) => HabitModel.fromJson(e)).toList();
    }

    return [];
  }

  Future<void> saveHabits(List<HabitModel> habist) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(habist.map((e) => e.toJson()).toList());
    await prefs.setString('habits', encoded);
  }

  Future<void> addHabit(String userId, HabitModel habitModel) async {
    try {
      await _firestore
          .collection('habits')
          .doc(userId)
          .collection('userhabits')
          .add(habitModel.toJson());
    } catch (e) {
      throw Exception("Error addig habit");
    }
  }

  Future<List<HabitModel>> fetchHabits(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('habits')
          .doc(userId)
          .collection('userhabits')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return HabitModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception("Error Fetching Habits");
    }
  }

  Stream<List<HabitModel>> habitStream(String userId) {
    return _firestore
        .collection('habits')
        .doc(userId)
        .collection('userhabits')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return HabitModel.fromJson(data);
      }).toList();
    });
  }

  getUserIdFromSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> updateHabit(String userId, HabitModel habit) async {
    try {
      if (habit.id != null) {
        await _firestore
            .collection('habits')
            .doc(userId)
            .collection('userhabits')
            .doc(habit.id)
            .update(habit.toJson());
      } else {
        throw Exception("Habit Id is required");
      }
    } catch (e) {
      throw Exception("Error Updating :$e");
    }
  }

  Future<void> deleteHabit(String userId, String habitId) async {
    try {
      await _firestore
          .collection('habits')
          .doc(userId)
          .collection('userhabits')
          .doc(habitId)
          .delete();
    } catch (e) {
      throw Exception("Error Deleting:$e");
    }
  }
}
