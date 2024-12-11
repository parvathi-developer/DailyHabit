import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/habit/habit_bloc.dart';
import 'package:habit_app/bloc/habit/habit_event.dart';
import 'package:habit_app/model/habit_model.dart';
import 'package:uuid/uuid.dart';

class AddEditHabitScreen extends StatelessWidget {
  final HabitModel? habit;
  late TextEditingController _nameController;
  late TextEditingController _descController;

  final Uuid _uuid = Uuid();

  AddEditHabitScreen(this.habit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pre-fill the controllers if editing
    if (habit != null) {
      _nameController = TextEditingController(text: habit!.name);
      _descController = TextEditingController(text: habit!.description);
    } else {
      _nameController = TextEditingController();
      _descController = TextEditingController();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(habit != null ? 'Edit Habit' : 'Add Habit'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Habit Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate inputs
                if (_nameController.text.isEmpty ||
                    _descController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                  return;
                }

                final newHabit = HabitModel(
                    id: habit?.id ?? _uuid.v4(), // Use existing ID if editing
                    name: _nameController.text,
                    description: _descController.text,
                    isCompleted: habit?.isCompleted ?? false);

                // Add or Update based on whether we are editing
                if (habit != null) {
                  context
                      .read<HabitBloc>()
                      .add(UpdateHabit(habitModel: newHabit));
                } else {
                  context.read<HabitBloc>().add(AddHabit(habitModel: newHabit));
                }

                Navigator.pop(context);
              },
              child: Text(
                habit != null ? 'Edit Habit' : 'Add Habit',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
