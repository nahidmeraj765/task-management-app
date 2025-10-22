import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/data/models/user_model.dart';
import 'package:flutter_application_task_management_app/data/services/api_caller.dart';
import 'package:flutter_application_task_management_app/data/utils/urls.dart';
import 'package:flutter_application_task_management_app/ui/controllers/auth_controll.dart';
import 'package:flutter_application_task_management_app/ui/screens/forgot_password_verify_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/main_navbar_holder_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/signup_screen.dart';
import 'package:flutter_application_task_management_app/ui/widgets/screen_background.dart';
import 'package:flutter_application_task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 82),
                    Text(
                      'Get Started With',
                      style: GoogleFonts.notoSerif(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Title'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(hintText: 'Description'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: _addNewTaskProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: FilledButton(
                        onPressed: () {},
                        child: Text('Add Task'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    if (_formKey.currentState!.validate()) {
      _onTapAddButton();
    }
  }

  Future<void> _signIn() async {
    _addNewTaskProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      'status': "New",
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.createTaskUrl,
      body: requestBody,
    );
    _addNewTaskProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New task has been added.');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _clearTextFields() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
