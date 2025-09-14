import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/ui/screens/splash_screen.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}