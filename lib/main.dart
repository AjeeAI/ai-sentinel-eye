import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cnii_sentinel_flutter/screens/splash_screen.dart';
import 'package:cnii_sentinel_flutter/services/sentinel_service.dart';
import 'package:cnii_sentinel_flutter/theme/app_theme.dart';

void main() {
  checkPlatform();
  runApp(const CniiSentinelApp());
}

void checkPlatform() {
  if (kIsWeb) {
    debugPrint("⚠️ RUNNING ON FLUTTER WEB (OpenStreetMap Mode)");
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
      theme: AppTheme.darkTheme,
      home: const SentinelSplashScreen(),
    );
  }
}