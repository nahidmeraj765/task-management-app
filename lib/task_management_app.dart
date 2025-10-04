import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/ui/screens/login_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/main_navbar_holder_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/signup_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/splash_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/update_profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 234, 240, 237),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .copyWith(
              titleLarge: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
      ),
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name : (_) => SplashScreen(),
        LoginScreen.name : (_) => LoginScreen(),
        SignUpScreen.name : (_) => SignUpScreen(),
        MainNavbarHolderScreen.name : (_) => MainNavbarHolderScreen(),
        UpdateProfileScreen.name : (_) => UpdateProfileScreen(),
      },
    );
  }
}

