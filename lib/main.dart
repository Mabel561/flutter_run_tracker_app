import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//--------------------------------------------------------------------
void main() async {
  //----- โค้ดติดต่อกับ Supabase โปรเจ็กต์ที่เราจะทำงานด้วย -----
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://znwbkzhwyzjdgggtehsw.supabase.co',
    publishableKey: 'sb_publishable_ep_cRPlW2QQPKtCzcb0LPQ_nuUUovGg',
  );
  //----------------------------------------------------

  runApp(
    FlutterRunTrackerApp(),
  );
}

//--------------------------------------------------------------------
class FlutterRunTrackerApp extends StatefulWidget {
  const FlutterRunTrackerApp({super.key});

  @override
  State<FlutterRunTrackerApp> createState() => _FlutterRunTrackerAppState();
}

class _FlutterRunTrackerAppState extends State<FlutterRunTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        textTheme: TextTheme.of(context).apply(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontFamilyFallback: GoogleFonts.kanit().fontFamilyFallback,
        ),
      ),
    );
  }
}