class ServerInfo {
  final bool xui;
  final String version;
  final int revision;
  final String url;
  final String port;
  final String httpsPort;
  final String serverProtocol;
  final String rtmpPort;
  final int timestampNow;
  final DateTime timeNow;
  final String timezone;

  ServerInfo({
    required this.xui,
    required this.version,
    required this.revision,
    required this.url,
    required this.port,
    required this.httpsPort,
    required this.serverProtocol,
    required this.rtmpPort,
    required this.timestampNow,
    required this.timeNow,
    required this.timezone,
  });

  factory ServerInfo.fromJson(Map<String, dynamic> json) => ServerInfo(
        xui: json["xui"],
        version: json["version"],
        revision: json["revision"],
        url: json["url"],
        port: json["port"],
        httpsPort: json["https_port"],
        serverProtocol: json["server_protocol"],
        rtmpPort: json["rtmp_port"],
        timestampNow: json["timestamp_now"],
        timeNow: DateTime.parse(json["time_now"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "xui": xui,
        "version": version,
        "revision": revision,
        "url": url,
        "port": port,
        "https_port": httpsPort,
        "server_protocol": serverProtocol,
        "rtmp_port": rtmpPort,
        "timestamp_now": timestampNow,
        "time_now": timeNow.toIso8601String(),
        "timezone": timezone,
      };
}
