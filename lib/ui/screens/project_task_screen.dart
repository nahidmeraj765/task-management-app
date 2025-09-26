import 'package:flutter/material.dart';

class ProjectTaskScreen extends StatefulWidget {
  const ProjectTaskScreen({super.key});

  @override
  State<ProjectTaskScreen> createState() => _ProjectTaskScreenState();
}

class _ProjectTaskScreenState extends State<ProjectTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16,),
            SizedBox(
              height: 90,
              child: ListView.separated(
                itemCount: 4,
                primary: false,scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TaskCountedByStatusCard(title: "New", count: 2);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 4);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        ),
    );
  }
}

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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text('$count', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
