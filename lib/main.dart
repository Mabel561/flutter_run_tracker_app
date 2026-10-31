import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RunTrackerApp());
}

class RunTrackerApp extends StatefulWidget {
  const RunTrackerApp({super.key});

  @override
  State<RunTrackerApp> createState() => _RunTrackerAppState();
}

class _RunTrackerAppState extends State<RunTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        fontFamily: GoogleFonts.kanit().fontFamily),
    );
  }
}