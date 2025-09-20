import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/ui/screens/forgot_password_verify_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/login_screen.dart';
import 'package:flutter_application_task_management_app/ui/widgets/screen_background.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(hintText: 'First name'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(hintText: 'Last name'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(hintText: 'Phone number'),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {},
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                    const SizedBox(height: 36),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgotPasswordButton,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey),
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

  void _onTapLogInButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordVerifyScreen()));
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
