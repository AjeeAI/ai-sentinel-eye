import 'dart:convert';
import 'package:cnii_sentinel_flutter/models/risk_model.dart';
import 'package:http/http.dart' as http;

class SentinelService {
  // Set to FALSE to use your real Python backend
  static bool useMock = false; 
  
  // Use 10.0.2.2 for Android Emulator to reach your PC's localhost
  // Use 127.0.0.1 if testing on iOS Simulator or Web
  static const String baseUrl = 'https://cnii-sentinel-backend.onrender.com'; 

  Future<List<InfrastructureRisk>> fetchRisks() async {
    if (useMock) {
      // Simulate network delay for realism
      await Future.delayed(const Duration(seconds: 2));
      return _getMockRisks();
    }

    try {
      // UPDATED: Pointing to the new GET endpoint we created
      final response = await http.get(Uri.parse('$baseUrl/patrol/latest'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        
        // The backend returns a PatrolResponse object, so we extract the 'risks' list
        final List<dynamic> risksJson = jsonResponse['risks'];
        
        return risksJson.map((json) => InfrastructureRisk.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load risks: ${response.statusCode}');
      }
    } catch (e) {
      print("API Error: $e");
      // Fallback to mock data so the app keeps working if backend is down
      return _getMockRisks();
    }
  }

  List<InfrastructureRisk> _getMockRisks() {
    return [
      InfrastructureRisk(
        riskLevel: 'High',
        location: 'Lagos-Ibadan Expressway (KM 12)',
        threatType: 'Heavy Excavation / Bridge Repair',
        recommendedAction: 'Dispatch patrol team immediately. Halt excavation near Marker 12B.',
        latitude: 6.9530,
        longitude: 3.6157,
      ),
      InfrastructureRisk(
        riskLevel: 'Medium',
        location: 'Lekki-Epe Expressway',
        threatType: 'Road Grading',
        recommendedAction: 'Alert site engineer. Verify fiber depth.',
        latitude: 6.4698,
        longitude: 3.5852,
      ),
      InfrastructureRisk(
        riskLevel: 'Low',
        location: 'Akwa Ibom Kwa Ibo Route',
        threatType: 'Drainage Clearing',
        recommendedAction: 'Routine surveillance required.',
        latitude: 5.0377,
        longitude: 7.9128,
      ),
    ];
  }
}