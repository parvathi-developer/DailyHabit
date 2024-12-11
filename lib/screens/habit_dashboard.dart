import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/habit/habit_bloc.dart';
import 'package:habit_app/bloc/habit/habit_event.dart';
import 'package:habit_app/bloc/habit/habit_state.dart';
import 'package:habit_app/model/habit_model.dart';
import 'package:habit_app/widgets/habit_tile.dart';
import 'package:habit_app/widgets/progressbar.dart';

class HabitDashboard extends StatefulWidget {
  const HabitDashboard({super.key});

  @override
  State<HabitDashboard> createState() => _HabitDashboardState();
}

class _HabitDashboardState extends State<HabitDashboard> {
  @override
  void initState() {
    super.initState();
    context.read<HabitBloc>().add(Loadhabit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<HabitBloc>().add(Logout(context: context));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Expanded(child:
            BlocBuilder<HabitBloc, HabitState>(builder: (context, state) {
          if (state is HabitLoading) {
            return const CircularProgressIndicator();
          } else if (state is HabitLoaded) {
            if (state.habitModels.length > 0) {
              final completed =
                  state.habitModels.where((habit) => habit.isCompleted!).length;

              final total = state.habitModels.length;
              final progress = total > 0 ? (completed / total) * 100 : 0;

              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: ProgressBar(progress: progress.toDouble())),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.habitModels.length,
                          itemBuilder: (context, index) {
                            final habit = state.habitModels[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: HabitTile(
                                habit: habit,
                                onToggle: () {
                                  context.read<HabitBloc>().add(
                                      ToggleHabitCompletion(habitModel: habit));
                                },
                                onEdit: (habit) {
                                  Navigator.pushNamed(
                                    context,
                                    '/add-habit',
                                    arguments: HabitModel(
                                      id: habit.id,
                                      name: habit.name,
                                      description: habit.description,
                                      isCompleted: habit.isCompleted,
                                    ),
                                  );
                                },
                                onDelete: (habit) {
                                  context
                                      .read<HabitBloc>()
                                      .add(DeleteHabit(habitModel: habit));
                                },
                              ),
                            );
                          }))
                ],
              );
            } else {
              return const Center(child: Text('No Habits Available'));
            }
          } else {
            return const Center(child: Text('Error loading habits'));
          }
        })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-habit'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
