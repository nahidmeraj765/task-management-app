import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/ui/controllers/auth_controll.dart';
import 'package:flutter_application_task_management_app/ui/screens/login_screen.dart';
import 'package:flutter_application_task_management_app/ui/screens/main_navbar_holder_screen.dart';
import 'package:flutter_application_task_management_app/ui/utils/asset_paths.dart';
import 'package:flutter_application_task_management_app/ui/widgets/screen_background.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 5));
    final bool isLoggedIn = await AuthController.isUserAlreadyLoggedIn();
    if (isLoggedIn) {
      await AuthController.getUserData();
      Navigator.pushReplacementNamed(context, MainNavbarHolderScreen.name);
    }
    else{
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetPaths.logoPng, height: 150),
              SizedBox(height: 16),
              Text(
                "TaskForce Infinity",
                style: GoogleFonts.josefinSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
