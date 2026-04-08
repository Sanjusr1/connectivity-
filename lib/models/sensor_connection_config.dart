enum SensorConnectionType { mock, wifi, usb }

class SensorConnectionConfig {
  const SensorConnectionConfig({
    required this.connectionType,
    this.wifiHost = '',
    this.wifiPort = 9000,
  });

  final SensorConnectionType connectionType;
  final String wifiHost;
  final int wifiPort;

  SensorConnectionConfig copyWith({
    SensorConnectionType? connectionType,
    String? wifiHost,
    int? wifiPort,
  }) {
    return SensorConnectionConfig(
      connectionType: connectionType ?? this.connectionType,
      wifiHost: wifiHost ?? this.wifiHost,
      wifiPort: wifiPort ?? this.wifiPort,
    );
  }

  String get connectionLabel {
    switch (connectionType) {
      case SensorConnectionType.mock:
        return 'Mock';
      case SensorConnectionType.wifi:
        return 'Wi-Fi';
      case SensorConnectionType.usb:
        return 'USB';
    }
  }
}
