import 'package:flutter/material.dart';

class TaskCountedByStatusCard extends StatelessWidget {
  const TaskCountedByStatusCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Text('$count', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
