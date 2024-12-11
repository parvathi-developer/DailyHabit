import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:habit_app/bloc/habit/habit_event.dart';
import 'package:habit_app/bloc/habit/habit_state.dart';
import 'package:habit_app/model/habit_model.dart';
import 'package:habit_app/repositories/habit_repositories.dart';
import 'package:habit_app/utility/util.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitRepositories habitRepositories;
  StreamSubscription<List<HabitModel>>? _habitSubscription;
  HabitBloc({required this.habitRepositories}) : super(HabitLoading()) {
    on<Loadhabit>(_onLoadHabit);
    on<AddHabit>(_onAddHabit);
    on<ToggleHabitCompletion>(_onToggleHabitCompletion);
    on<UpdateHabit>(_onUpdateHabit);
    on<DeleteHabit>(_onDeleteHabit);
    on<Logout>(_onLogoutEvent);

    _startSubscription();
  }

  /// Load habits for the current user
  Future<void> _onLoadHabit(Loadhabit event, Emitter<HabitState> emit) async {
    try {
      emit(HabitLoading());
      String? userId = await habitRepositories.getUserIdFromSharedPreference();
      if (userId == null) {
        emit(HabitError(errorMsg: "User not logged in."));
        return;
      }

      final habits = await habitRepositories.fetchHabits(userId);
      emit(HabitLoaded(habitModels: habits));
    } catch (e) {
      emit(HabitError(errorMsg: "Failed to load habits: ${e.toString()}"));
    }
  }

  /// Add a new habit
  Future<void> _onAddHabit(AddHabit event, Emitter<HabitState> emit) async {
    try {
      String? userId = await habitRepositories.getUserIdFromSharedPreference();
      if (userId == null) {
        emit(HabitError(errorMsg: "User not logged in."));
        return;
      }

      await habitRepositories.addHabit(userId, event.habitModel);
      add(Loadhabit()); // Refresh the habit list after adding
    } catch (e) {
      emit(HabitError(errorMsg: "Failed to add habit: ${e.toString()}"));
    }
  }

  FutureOr<void> _onToggleHabitCompletion(
      ToggleHabitCompletion event, Emitter<HabitState> emit) async {
    try {
      String? userId = await habitRepositories.getUserIdFromSharedPreference();
      if (userId == null) {
        emit(HabitError(errorMsg: "User not logged in."));
        return;
      }
      final habit = event.habitModel;
      final updateHabits = habit.copyWith(isCompleted: !habit.isCompleted!);
      await habitRepositories.updateHabit(userId, updateHabits);
      add(Loadhabit());
    } catch (e) {
      emit(HabitError(errorMsg: e.toString()));
    }
  }

  FutureOr<void> _onUpdateHabit(
      UpdateHabit event, Emitter<HabitState> emit) async {
    try {
      String? userId = await habitRepositories.getUserIdFromSharedPreference();
      if (userId == null) {
        emit(HabitError(errorMsg: "User not logged in."));
        return;
      }
      final habit = event.habitModel;
      final updateHabit = habit.copyWith(
          isCompleted: habit.isCompleted,
          id: habit.id,
          title: habit.name,
          description: habit.description);

      await habitRepositories.updateHabit(userId, updateHabit);
      add(Loadhabit());
    } catch (e) {
      emit(HabitError(errorMsg: e.toString()));
    } // Refresh the habit list after adding
  }

  FutureOr<void> _onDeleteHabit(
      DeleteHabit event, Emitter<HabitState> emit) async {
    try {
      String? userId = await habitRepositories.getUserIdFromSharedPreference();
      if (userId == null) {
        emit(HabitError(errorMsg: "User not logged in."));
        return;
      }

      await habitRepositories.deleteHabit(userId, event.habitModel.id!);
      add(Loadhabit()); // Refresh the habit list after adding
    } catch (e) {
      emit(HabitError(errorMsg: e.toString()));
    }
  }

  FutureOr<void> _onLogoutEvent(Logout event, Emitter<HabitState> emit) async {
    try {
      await Util().logout(event.context);
      // emit(HabitLoading());
    } catch (e) {
      emit(HabitError(errorMsg: e.toString()));
    }
  }

  void _startSubscription() async {
    try {
      String? userId = await habitRepositories.getUserIdFromSharedPreference();
      if (userId == null) {
        add(HabitErrorEvent(errorMsg: "User not logged In"));
        return;
      }

      _habitSubscription =
          habitRepositories.habitStream(userId).listen((habitList) {
        add(Loadhabit()); // Dispatch an event when habits are loaded
      }, onError: (error) {
        add(HabitErrorEvent(
            errorMsg: "Failed to sync habit:${error.toString()}"));
      });
    } catch (e) {
      add(HabitErrorEvent(errorMsg: 'Failed to initialize'));
    }
  }

  @override
  Future<void> close() {
    _habitSubscription?.cancel();
    return super.close();
  }
}
