import 'package:flutter/material.dart';
import 'package:habit_app/model/habit_model.dart';

class HabitTile extends StatelessWidget {
  final HabitModel habit;
  final VoidCallback onToggle;
  final void Function(HabitModel habit)
      onEdit; // Update this to take the HabitModel

  final void Function(HabitModel habit) onDelete;
  const HabitTile(
      {Key? key,
      required this.habit,
      required this.onToggle,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      tileColor: Colors.teal.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        habit.name!,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        habit.description!,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: habit.isCompleted,
            onChanged: (_) => onToggle(),
          ),
          IconButton(
            onPressed: () {
              onEdit(habit); // Pass the current habit to the callback
            },
            icon: const Icon(Icons.edit),
            style: Theme.of(context).iconButtonTheme.style,
          ),
          IconButton(
            onPressed: () {
              onDelete(habit);
            },
            icon: const Icon(Icons.delete),
            style: Theme.of(context).iconButtonTheme.style,
          )
        ],
      ),
    );
  }
}
