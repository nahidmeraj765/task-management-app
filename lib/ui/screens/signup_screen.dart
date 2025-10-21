import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/data/services/api_caller.dart';
import 'package:flutter_application_task_management_app/data/utils/urls.dart';
import 'package:flutter_application_task_management_app/ui/screens/forgot_password_verify_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/login_screen.dart';
import 'package:flutter_application_task_management_app/ui/widgets/screen_background.dart';
import 'package:flutter_application_task_management_app/ui/widgets/snack_bar_message.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 82),
                    Text(
                      'Join With Us',
                      style: GoogleFonts.notoSerif(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        String inputText = value ?? '';
                        if (EmailValidator.validate(inputText) == false) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'First name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Last name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneNumberController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Phone number'),
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        String input = value?.trim() ?? '';
                        if (input.isEmpty) {
                          return 'Enter your phone number';
                        }
                        if (!RegExp(r'^\d{11}$').hasMatch(input)) {
                          return 'Phone number must be exactly 11 digits';
                        }
                        if (!RegExp(
                          r'^(013|014|015|016|017|018|019)\d{8}$',
                        ).hasMatch(input)) {
                          return 'Enter a valid Bangladeshi phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        String input = value?.trim() ?? '';
                        if (input.isEmpty) {
                          return 'Enter your password';
                        }
                        if (input.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                    const SizedBox(height: 36),
                    Center(
                      child: Column(
                        children: [
                          Visibility(
                            visible: _signUpInProgress == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: TextButton(
                              onPressed: _onTapForgotPasswordButton,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                  text: 'Sign in',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapLogInButton,
                                ),
                              ],
                            ),
                          ),
                        ],
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

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      // register this user
      _signUp();
    }
  }

  void _onTapLogInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<void> _signUp() async {
    _signUpInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _phoneNumberController.text.trim(),
      "password": _passwordController.text.trim(),
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );
    _signUpInProgress = false;
    setState(() {
      
    });
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'Registration successful! Please login.');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordVerifyScreen()),
    );
  }

  void _clearTextFields() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneNumberController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
