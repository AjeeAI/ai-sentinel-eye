import 'package:flutter/material.dart';
import 'package:cnii_sentinel_flutter/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _fastApiPolling = true;
  bool _twitterData = false;
  bool _osmData = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "CNII Sentinel // Configuration",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Adjust core operational parameters and environmental scrapers.",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 24),

          // Section 1: Network Scrapers
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              // Use standard border with a thicker left side
              border: const Border(
                left: BorderSide(color: AppColors.primary, width: 4),
                top: BorderSide(color: Colors.white12, width: 1),
                right: BorderSide(color: Colors.white12, width: 1),
                bottom: BorderSide(color: Colors.white12, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("NETWORK SCRAPERS", style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ),
                const Divider(color: Colors.white12, height: 1),
                SwitchListTile(
                  title: const Text("Enable FastAPI Polling", style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                  subtitle: const Text("30s interval sync", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  value: _fastApiPolling,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _fastApiPolling = val),
                ),
                SwitchListTile(
                  title: const Text("Include Twitter Data", style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                  subtitle: const Text("Real-time social sentiment stream", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  value: _twitterData,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _twitterData = val),
                ),
                SwitchListTile(
                  title: const Text("Include OpenStreetMap Data", style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                  subtitle: const Text("Geospatial topology overlays", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  value: _osmData,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _osmData = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Section 2: Alert Thresholds
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              // Use standard border with a thicker left side
              border: const Border(
                left: BorderSide(color: AppColors.critical, width: 4),
                top: BorderSide(color: Colors.white12, width: 1),
                right: BorderSide(color: Colors.white12, width: 1),
                bottom: BorderSide(color: Colors.white12, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ALERT THRESHOLDS", style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                const SizedBox(height: 12),
                const Text(
                  "Push Notification Minimum Severity\nFilter incoming tactical alerts",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ["ALL", "LOW", "HIGH", "CRIT"].map((level) {
                    bool isSelected = level == "HIGH";
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.critical.withOpacity(0.2) : AppColors.background,
                        border: Border.all(color: isSelected ? AppColors.critical : Colors.white24),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: isSelected ? AppColors.critical : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {},
                  child: const Text("RESET DEFAULT", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {},
                  child: const Text("APPLY CONFIG", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}