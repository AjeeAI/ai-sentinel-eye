import 'package:flutter/material.dart';
import 'package:cnii_sentinel_flutter/theme/app_colors.dart';

class AiCoreScreen extends StatelessWidget {
  const AiCoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Title matching mockup
            const Text(
              "CNII Sentinel // AI Core",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            
            // Conversation Timeline
            Expanded(
              child: ListView(
                children: [
                  // User Prompt Bubble
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Text(
                      "Analyze physical vulnerability for the Ikeja fiber node over the next 48 hours.",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontFamily: 'Courier',
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // AI Response Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.psychology, color: AppColors.primary, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              "ANALYSIS COMPLETE",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5),
                            children: [
                              TextSpan(text: "Risk Level: "),
                              TextSpan(
                                text: "Medium", 
                                style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ". Predictive Model indicates a "),
                              TextSpan(
                                text: "65% chance", 
                                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: " of unauthorized roadwork near the Ikeja node. Recommendation: Increase drone surveillance."),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "MODEL CONFIDENCE",
                                style: TextStyle(color: AppColors.textMuted, fontSize: 10, letterSpacing: 1.0),
                              ),
                              const Text(
                                "92%",
                                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Command Input Bar at the Bottom
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.code, color: AppColors.textMuted, size: 18),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "AWAITING COMMAND...",
                      style: TextStyle(color: AppColors.textMuted, fontFamily: 'Courier', fontSize: 12),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    onPressed: () {},
                    child: const Text("EXECUTE", style: TextStyle(color: AppColors.primary, fontSize: 11)),
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