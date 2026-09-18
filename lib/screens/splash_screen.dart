import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cnii_sentinel_flutter/screens/main_layout.dart';
import 'package:cnii_sentinel_flutter/widgets/ripple_loader.dart';
import 'package:cnii_sentinel_flutter/theme/app_colors.dart';

class SentinelSplashScreen extends StatefulWidget {
  const SentinelSplashScreen({super.key});

  @override
  State<SentinelSplashScreen> createState() => _SentinelSplashScreenState();
}

class _SentinelSplashScreenState extends State<SentinelSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Initialize the "Breathing" Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Speed of the "breath"
    )..repeat(reverse: true); // Loops back and forth

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 2. The Timer: Navigate to MainLayout after 4 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(_createRoute());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // A Custom "Fade" Route Transition to the new MainLayout shell
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MainLayout(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Applied your unused _scaleAnimation to the RippleLoader
            ScaleTransition(
              scale: _scaleAnimation,
              child: const RippleLoader(
                size: 150,
                color: AppColors.primary,
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Applied your unused _fadeAnimation to the pulsing text
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "INITIALIZING SENTINEL...",
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Courier', 
                  letterSpacing: 3.0,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Minimalist Progress Bar
            SizedBox(
              width: 160,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.surface,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}