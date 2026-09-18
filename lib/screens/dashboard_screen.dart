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
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final risks = await _service.fetchRisks();
    setState(() {
      _risks = risks;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Desktop / Wide Screen Layout (Side Panel + Map)
          if (constraints.maxWidth > 800) {
            return _buildDesktopLayout();
          }
          // Mobile / Narrow Screen Layout (Map + Bottom Sheet only, zero clutter)
          return _buildMobileLayout();
        },
      ),
    );
  }

  // --- RESPONSIVE LAYOUTS ---

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left Side Panel (KPIs + Threat Log)
        Container(
          width: 400,
          color: const Color(0xFF161616),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildKPISection(),
              ),
              const Divider(color: Colors.white12, height: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Text("THREAT LOG", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 2.0, fontSize: 16)),
                    const SizedBox(width: 12),
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFFFF453A), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text("${_risks.length} ACTIVE", style: const TextStyle(color: Colors.white54, fontSize: 10)),
                  ],
                ),
              ),
              Expanded(child: _buildThreatList()),
            ],
          ),
        ),
        // Right Side (Map)
        Expanded(child: _buildMapLayer()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Stack(
      children: [
        // Full screen map unobstructed on mobile
        _buildMapLayer(),

        // Clean Draggable Sheet for Threats
        Align(
          alignment: Alignment.bottomCenter,
          child: DraggableScrollableSheet(
            initialChildSize: 0.40,
            minChildSize: 0.15,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15, spreadRadius: 5)],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40, height: 4,
                      decoration: BoxDecoration(color: Colors.grey[700], borderRadius: BorderRadius.circular(10)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          const Text("THREAT LOG", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 2.0, fontSize: 16)),
                          const SizedBox(width: 12),
                          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFFFF453A), shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          Text("${_risks.length} ACTIVE", style: const TextStyle(color: Colors.white54, fontSize: 10)),
                        ],
                      ),
                    ),
                    Expanded(child: _buildThreatList(scrollController: scrollController)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- CORE COMPONENTS ---

  Widget _buildMapLayer() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(9.0820, 8.6753),
        initialZoom: 6.0,
      ),
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            -1, 0, 0, 0, 255,
             0,-1, 0, 0, 255,
             0, 0,-1, 0, 255,
             0, 0, 0, 1, 0,
          ]),
          child: TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.cnii.sentinel',
          ),
        ),
        MarkerLayer(markers: _buildMarkers()),
      ],
    );
  }

  Widget _buildKPISection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildKPICard("ACTIVE RISKS", _risks.length.toString(), Colors.white, Icons.warning_amber_rounded, const Color(0xFF2A2A2A))),
            const SizedBox(width: 12),
            Expanded(child: _buildKPICard("HIGH SEVERITY", "1", const Color(0xFFFF9F0A), Icons.error_outline, const Color(0xFF2A2A2A))),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("SCRAPER STATUS", style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1.0)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text("Polling", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Courier')),
                      const SizedBox(width: 8),
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF00FF41), shape: BoxShape.circle)),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.radar, color: Colors.white24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThreatList({ScrollController? scrollController}) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF00FF41)));
    }
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 20, top: 8),
      itemCount: _risks.length,
      itemBuilder: (context, index) => _buildThreatCard(_risks[index]),
    );
  }

  Widget _buildKPICard(String title, String value, Color iconColor, IconData icon, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1.0)),
              Icon(icon, color: iconColor.withOpacity(0.5), size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: iconColor, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return _risks.map((risk) {
      Color riskColor = _getRiskColor(risk.riskLevel);
      return Marker(
        point: LatLng(risk.latitude, risk.longitude),
        width: 40, height: 40,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: riskColor.withOpacity(0.4), blurRadius: 10)],
          ),
          child: Icon(Icons.my_location, color: riskColor, size: 30),
        ),
      );
    }).toList();
  }

  Widget _buildThreatCard(InfrastructureRisk risk) {
    Color riskColor = _getRiskColor(risk.riskLevel);
    String badgeText = risk.riskLevel.toUpperCase() == 'HIGH' ? 'CRITICAL' : risk.riskLevel.toUpperCase();
    
    return InkWell(
      onTap: () {
        LatLng pos = LatLng(risk.latitude, risk.longitude);
        _mapController.move(pos, 14.0);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          border: Border(left: BorderSide(color: riskColor, width: 4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(risk.riskLevel.toUpperCase() == 'HIGH' ? Icons.engineering : Icons.construction, color: Colors.white70, size: 20),
                    const SizedBox(width: 8),
                    Text(risk.threatType, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Courier')),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: riskColor.withOpacity(0.15),
                    border: Border.all(color: riskColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(badgeText, style: TextStyle(color: riskColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(risk.location, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("COORDINATES", style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1.0)),
                    const SizedBox(height: 4),
                    Text("${risk.latitude.toStringAsFixed(4)}°, ${risk.longitude.toStringAsFixed(4)}°", style: const TextStyle(color: Colors.white54, fontSize: 11, fontFamily: 'Courier')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: riskColor.withOpacity(0.15),
                  foregroundColor: riskColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  side: BorderSide(color: riskColor.withOpacity(0.5)),
                ),
                icon: Icon(risk.riskLevel.toUpperCase() == 'HIGH' ? Icons.local_shipping : Icons.campaign, size: 16),
                label: Text(risk.riskLevel.toUpperCase() == 'HIGH' ? "DISPATCH TEAM" : "ALERT", style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 12)),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(String level) {
    switch (level.toUpperCase()) {
      case 'HIGH': return const Color(0xFFFF453A);
      case 'MEDIUM': return const Color(0xFFFF9F0A);
      default: return const Color(0xFF00FF41);
    }
  }
}