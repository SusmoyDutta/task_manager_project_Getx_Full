import 'package:flutter/material.dart';

class TaskCounterCard extends StatelessWidget {
  const TaskCounterCard({
    super.key, required this.amount, required this.title,
  });
  final int amount;
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$amount',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                 title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
    );
  }
}
