import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCompleted = progress >= 100;
    final completionText = '${progress.toStringAsFixed(0)}%';
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: progress / 100),
        duration: const Duration(seconds: 1),
        builder: (context, animatedValue, child) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: animatedValue,
                    backgroundColor: Colors.grey[100],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted
                          ? Colors.green
                          : Color.fromARGB(255, 120, 157, 101),
                    ),
                    strokeWidth: 6,
                  ),
                ),
                Text(
                  completionText,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          );
        });
  }
}
