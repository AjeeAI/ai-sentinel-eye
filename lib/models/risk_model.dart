class InfrastructureRisk {
  final String riskLevel;
  final String location;
  final String threatType;
  final String recommendedAction;
  final double latitude;
  final double longitude;

  InfrastructureRisk({
    required this.riskLevel,
    required this.location,
    required this.threatType,
    required this.recommendedAction,
    required this.latitude,
    required this.longitude,
  });

  factory InfrastructureRisk.fromJson(Map<String, dynamic> json) {
    return InfrastructureRisk(
      // Defaulting to "Unknown" prevents crashes if API sends nulls
      riskLevel: json['risk_level'] ?? 'Unknown',
      location: json['location_identified'] ?? 'Unknown Location',
      threatType: json['threat_type'] ?? 'General Threat',
      recommendedAction: json['recommended_action'] ?? 'Monitor area',
      // We expect these to be non-null thanks to our backend fallback
      latitude: (json['latitude'] as num?)?.toDouble() ?? 9.0820, 
      longitude: (json['longitude'] as num?)?.toDouble() ?? 8.6753,
    );
  }
}

class PatrolResponse {
  final String summary;
  final List<InfrastructureRisk> risks;

  PatrolResponse({required this.summary, required this.risks});

  factory PatrolResponse.fromJson(Map<String, dynamic> json) {
    var list = json['risks'] as List;
    List<InfrastructureRisk> riskList = list.map((i) => InfrastructureRisk.fromJson(i)).toList();
    return PatrolResponse(
      summary: json['summary'] ?? "No summary available",
      risks: riskList,
    );
  }
}