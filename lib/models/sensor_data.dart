class SensorData {
  final DateTime timestamp;
  final double temperature;
  final double humidity;
  final double airflow;
  final double pressure;
  final double vibrationRms;
  final double imuX;
  final double imuY;
  final double imuZ;

  SensorData({
    required this.timestamp,
    required this.temperature,
    required this.humidity,
    required this.airflow,
    required this.pressure,
    required this.vibrationRms,
    required this.imuX,
    required this.imuY,
    required this.imuZ,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'temperature': temperature,
      'humidity': humidity,
      'airflow': airflow,
      'pressure': pressure,
      'vibrationRms': vibrationRms,
      'imuX': imuX,
      'imuY': imuY,
      'imuZ': imuZ,
    };
  }

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      timestamp: DateTime.parse(map['timestamp'] as String),
      temperature: (map['temperature'] as num).toDouble(),
      humidity: (map['humidity'] as num).toDouble(),
      airflow: (map['airflow'] as num).toDouble(),
      pressure: (map['pressure'] as num).toDouble(),
      vibrationRms: (map['vibrationRms'] as num).toDouble(),
      imuX: (map['imuX'] as num).toDouble(),
      imuY: (map['imuY'] as num).toDouble(),
      imuZ: (map['imuZ'] as num).toDouble(),
    );
  }
}
