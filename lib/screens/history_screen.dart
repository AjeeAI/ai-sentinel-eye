import 'package:flutter/material.dart';
import 'package:cnii_sentinel_flutter/theme/app_colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "CNII Sentinel // Analytics",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),

          // Overview KPI Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ANALYTICS OVERVIEW", style: TextStyle(color: AppColors.textMuted, fontSize: 10, letterSpacing: 1.0)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _kpiColumn("TOTAL THREATS", "142", AppColors.critical),
                    _kpiColumn("RESOLUTION RATE", "89.4%", AppColors.primary),
                    _kpiColumn("ACTIVE ANOMALIES", "03", AppColors.warning),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Resolved Incidents Table Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Resolved Incidents Log",
                style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                icon: const Icon(Icons.download, size: 14, color: AppColors.textSecondary),
                label: const Text("EXPORT", style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Mock Data Table Rows
          _buildResolvedRow("2023-10-27", "Lagos Sector 7", "Perimeter Breach"),
          _buildResolvedRow("2023-10-26", "Abuja Core Hub", "Network Intrusion"),
          _buildResolvedRow("2023-10-25", "Ogun Substation", "Thermal Anomaly"),
        ],
      ),
    );
  }

  Widget _kpiColumn(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 9)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Courier')),
      ],
    );
  }

  Widget _buildResolvedRow(String date, String location, String threat) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(color: AppColors.textMuted, fontSize: 10, fontFamily: 'Courier')),
              const SizedBox(height: 4),
              Text(location, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          Text(threat, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text("RESOLVED", style: TextStyle(color: AppColors.textMuted, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}