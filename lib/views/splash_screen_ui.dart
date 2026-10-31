import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/show_all_run_ui.dart';

class SplashScreenUi extends StatefulWidget {
  SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ShowAllRunUi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00134D),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/speed.png',
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'RUN TRACKER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 18),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(Color(0xFF42629A)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Column(
                children: [
                  Text(
                    '© 2026 RUN TRACKER',
                    style: TextStyle(
                      color: Color(0xFF42629A),
                      fontSize: 10,
                      letterSpacing: 0.6,
                    ),
                  ),
                  Text(
                    'Created by Niv Run SAU TEAM',
                    style: TextStyle(color: Color(0xFF42629A), fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
