
// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // ------ ติดต่อกับ supabase โปรเจคของเรา ------
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://znwbkzhwyzjdgggtehsw.supabase.co',
    publishableKey: 'sb_publishable_ep_cRPlW2QQPKtCzcb0LPQ_nuUUovGg',
  );
  //-------------------------------------------
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