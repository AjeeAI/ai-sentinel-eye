import 'package:cnii_sentinel_flutter/models/risk_model.dart';
import 'package:cnii_sentinel_flutter/screens/dashboard_screen.dart';
import 'package:cnii_sentinel_flutter/screens/splash_screen.dart';
import 'package:cnii_sentinel_flutter/services/sentinel_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // NEW MAP PACKAGE
import 'package:latlong2/latlong.dart';      // NEW COORDINATES PACKAGE
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  checkPlatform();
  runApp(const CniiSentinelApp());
}

void checkPlatform() {
  if (kIsWeb) {
    print("⚠️ RUNNING ON FLUTTER WEB (OpenStreetMap Mode)");
    SentinelService.useMock = false; 
  }
}

class CniiSentinelApp extends StatelessWidget {
  const CniiSentinelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CNII Sentinel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF00FF41),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(ThemeData.dark().textTheme),
      ),
     home: const SentinelSplashScreen(),
    );
  }
}

