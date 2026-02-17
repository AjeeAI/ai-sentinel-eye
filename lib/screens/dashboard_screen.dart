import 'package:cnii_sentinel_flutter/models/risk_model.dart';
import 'package:cnii_sentinel_flutter/services/sentinel_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SentinelService _service = SentinelService();
  List<InfrastructureRisk> _risks = [];
  bool _isLoading = true;
  
  // Controller for OpenStreetMap
  final MapController _mapController = MapController();
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final risks = await _service.fetchRisks();
    setState(() => _risks = risks);
    _generateMarkers();
    setState(() => _isLoading = false);
  }

  void _generateMarkers() {
    _markers.clear();
    for (var risk in _risks) {
      // UPDATED: Use real coordinates from the API (populated by Gemini or Fallback)
      LatLng pos = LatLng(risk.latitude, risk.longitude);

      _markers.add(
        Marker(
          point: pos,
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () {
              // Zoom in when clicking the map marker directly
              _mapController.move(pos, 14.0);
            },
            child: Icon(
              Icons.location_on,
              size: 40,
              color: risk.riskLevel.toLowerCase() == 'high' ? Colors.redAccent : 
                     risk.riskLevel.toLowerCase() == 'medium' ? Colors.orangeAccent : Colors.greenAccent,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CNII SENTINEL // ACTIVE"),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF00FF41)),
            onPressed: _loadData,
          )
        ],
      ),
      body: Stack(
        children: [
          // 1. The OpenStreetMap Layer
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              // Default view of Nigeria
              initialCenter: LatLng(9.0820, 8.6753), 
              initialZoom: 6.0,
            ),
            children: [
              // The "Dark Matter" Tile Layer (Cyberpunk Style)
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                userAgentPackageName: 'com.cnii.sentinel',
              ),
              // The Markers Layer
              MarkerLayer(markers: _markers),
            ],
          ),

          // 2. The Intelligence Feed
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 40, height: 5,
                      decoration: BoxDecoration(color: Colors.grey[700], borderRadius: BorderRadius.circular(10)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("THREAT INTELLIGENCE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
                          Text("${_risks.length} ACTIVE RISKS", style: const TextStyle(color: Color(0xFF00FF41), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _isLoading 
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFF00FF41)))
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: _risks.length,
                            itemBuilder: (context, index) {
                              final risk = _risks[index];
                              return _buildRiskCard(risk);
                            },
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(InfrastructureRisk risk) {
    Color riskColor = risk.riskLevel.toLowerCase() == 'high' ? Colors.redAccent : 
                      risk.riskLevel.toLowerCase() == 'medium' ? Colors.orangeAccent : Colors.greenAccent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border(left: BorderSide(color: riskColor, width: 4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: riskColor, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(risk.location, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: riskColor.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
              child: Text(risk.riskLevel.toUpperCase(), style: TextStyle(color: riskColor, fontSize: 10, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(risk.threatType, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            Text("ACTION: ${risk.recommendedAction}", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          ],
        ),
        onTap: () {
          // UPDATED: Move map to the exact coordinate from the backend
          LatLng pos = LatLng(risk.latitude, risk.longitude);
          _mapController.move(pos, 14.0);
        },
      ),
    );
  }
}