import 'dart:async';
import 'package:cnii_sentinel_flutter/screens/dashboard_screen.dart';
import 'package:cnii_sentinel_flutter/widgets/ripple_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cnii_sentinel_flutter/main.dart'; // Import to access DashboardScreen

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

    // 2. The Timer: Navigate to Dashboard after 4 seconds
    Timer(const Duration(seconds: 4), () {
      // Use pushReplacement so the user can't go "back" to the splash screen
      Navigator.of(context).pushReplacement(_createRoute());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // A Custom "Fade" Route Transition for a smooth effect
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark Background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- THE ANIMATED SVG ---
            const RippleLoader(
      size: 150,
      color: Color(0xFF00FF41), // Matrix Green
    ),
            
            const SizedBox(height: 50),
            
            // --- LOADING INDICATORS ---
            const Text(
              "INITIALIZING SENTINEL...",
              style: TextStyle(
                color: Color(0xFF00FF41),
                fontFamily: 'Courier', 
                letterSpacing: 3.0,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Minimalist Progress Bar
            SizedBox(
              width: 160,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[900],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00FF41)),
                minHeight: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}