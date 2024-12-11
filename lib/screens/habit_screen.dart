import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/habit/habit_bloc.dart';
import 'package:habit_app/bloc/habit/habit_event.dart';
import 'package:habit_app/bloc/habit/habit_state.dart';
import 'package:habit_app/widgets/habit_tile.dart';
import 'package:habit_app/widgets/progressbar.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Dashboard"),
      ),
      body: Center(
        child: Container(
          child: Expanded(child:
              BlocBuilder<HabitBloc, HabitState>(builder: (context, state) {
            if (state is HabitLoading) {
              return CircularProgressIndicator();
            } else if (state is HabitLoaded) {
              if (state.habitModels.length > 0) {
                final completed = state.habitModels
                    .where((habit) => habit.isCompleted!)
                    .length;

                final total = state.habitModels.length;
                final progress = total > 0 ? (completed / total) * 100 : 0;

                return Column(
                  children: [
                    ProgressBar(progress: progress.toDouble()),
                    Expanded(
                        child: ListView.builder(
                            itemCount: state.habitModels.length,
                            itemBuilder: (context, index) {
                              final habit = state.habitModels[index];
                              return HabitTile(
                                habit: habit,
                                onToggle: () {
                                  context.read<HabitBloc>().add(
                                      ToggleHabitCompletion(habitModel: habit));
                                },
                                onEdit: (habit) {},
                                onDelete: (habit) {},
                              );
                            }))
                  ],
                );
              } else {
                return const Text('No Habits Available');
              }
            } else {
              return const Text('Error loading habits');
            }
          })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-habit'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
