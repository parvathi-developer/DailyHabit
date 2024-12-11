import 'package:habit_app/model/habit_model.dart';

abstract class HabitState {}

class HabitLoading extends HabitState {}

class HabitLoaded extends HabitState {
  List<HabitModel> habitModels;

  HabitLoaded({required this.habitModels});
}

class HabitError extends HabitState {
  String errorMsg;
  HabitError({required this.errorMsg});
}
