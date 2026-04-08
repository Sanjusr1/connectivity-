class SensorData {
  final DateTime timestamp;
  final double temperature;
  final double humidity;
  final double airflow;
  final double pressure;
  final double vibrationRms;
  final double microphoneLevel;
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
    required this.microphoneLevel,
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
      'microphoneLevel': microphoneLevel,
      'imuX': imuX,
      'imuY': imuY,
      'imuZ': imuZ,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      timestamp: DateTime.parse(map['timestamp'] as String),
      temperature: (map['temperature'] as num).toDouble(),
      humidity: (map['humidity'] as num).toDouble(),
      airflow: (map['airflow'] as num).toDouble(),
      pressure: (map['pressure'] as num).toDouble(),
      vibrationRms: (map['vibrationRms'] as num).toDouble(),
      microphoneLevel: ((map['microphoneLevel'] ?? 0) as num).toDouble(),
      imuX: (map['imuX'] as num).toDouble(),
      imuY: (map['imuY'] as num).toDouble(),
      imuZ: (map['imuZ'] as num).toDouble(),
    );
  }

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData.fromMap(json);
  }

  factory SensorData.fromTransportMap(Map<String, dynamic> map) {
    double readDouble(List<String> keys, {double fallback = 0}) {
      for (final key in keys) {
        final value = map[key];
        if (value is num) {
          return value.toDouble();
        }
        if (value is String) {
          final parsed = double.tryParse(value);
          if (parsed != null) {
            return parsed;
          }
        }
      }
      return fallback;
    }

    DateTime readTimestamp() {
      final rawTimestamp = map['timestamp'] ?? map['ts'];
      if (rawTimestamp is String && rawTimestamp.isNotEmpty) {
        final parsed = DateTime.tryParse(rawTimestamp);
        if (parsed != null) {
          return parsed;
        }
      }
      if (rawTimestamp is num) {
        final epoch = rawTimestamp.toInt();
        return epoch > 9999999999
            ? DateTime.fromMillisecondsSinceEpoch(epoch)
            : DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
      }
      return DateTime.now();
    }

    return SensorData(
      timestamp: readTimestamp(),
      temperature: readDouble(['temperature', 'temp', 'temp_c']),
      humidity: readDouble(['humidity', 'humidity_percent', 'rh']),
      airflow: readDouble(['airflow', 'airflow_mps', 'flow']),
      pressure: readDouble(['pressure', 'pressure_pa']),
      vibrationRms: readDouble(['vibrationRms', 'vibration_rms', 'piezo_rms']),
      microphoneLevel: readDouble(
        ['microphoneLevel', 'microphone_level', 'mic_db', 'mic_level'],
      ),
      imuX: readDouble(['imuX', 'imu_x', 'accel_x', 'ax']),
      imuY: readDouble(['imuY', 'imu_y', 'accel_y', 'ay']),
      imuZ: readDouble(['imuZ', 'imu_z', 'accel_z', 'az']),
    );
  }
}
