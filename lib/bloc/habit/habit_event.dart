import 'package:flutter/material.dart';
import 'package:habit_app/model/habit_model.dart';

abstract class HabitEvent {}

class Loadhabit extends HabitEvent {}

class AddHabit extends HabitEvent {
  final HabitModel habitModel;

  AddHabit({required this.habitModel});
}

class ToggleHabitCompletion extends HabitEvent {
  final HabitModel habitModel;
  ToggleHabitCompletion({required this.habitModel});
}

class UpdateHabit extends HabitEvent {
  final HabitModel habitModel;

  UpdateHabit({required this.habitModel});
}

class DeleteHabit extends HabitEvent {
  final HabitModel habitModel;
  DeleteHabit({required this.habitModel});
}

class Logout extends HabitEvent {
  final BuildContext context;
  Logout({required this.context});
}

class HabitErrorEvent extends HabitEvent {
  final String errorMsg;
  HabitErrorEvent({required this.errorMsg});
}
