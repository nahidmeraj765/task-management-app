import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/data/models/task_status_count_model.dart';
import 'package:flutter_application_task_management_app/data/services/api_caller.dart';
import 'package:flutter_application_task_management_app/data/utils/urls.dart';
import 'package:flutter_application_task_management_app/ui/widgets/list_card.dart';
import 'package:flutter_application_task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:flutter_application_task_management_app/ui/widgets/task_counted_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
  }

  Future<void> _getAllTaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.taskStatusCountUrl,
    );
    _getTaskStatusCountInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }

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
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountedByStatusCard(title: _taskStatusCountList[index].status, count: _taskStatusCountList[index].count);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8);
                  },
                ),
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
