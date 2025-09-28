import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/ui/widgets/list_card.dart';
import 'package:flutter_application_task_management_app/ui/widgets/task_counted_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.separated(
                itemCount: 4,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TaskCountedByStatusCard(title: "New", count: 2);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 8);
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListCard(text: 'New', color: Colors.blue);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}