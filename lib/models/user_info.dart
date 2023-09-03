class UserInfo {
  final String username;
  final String password;
  final String message;
  final int auth;
  final String status;
  final String expDate;
  final String isTrial;
  final String activeCons;
  final String createdAt;
  final String maxConnections;
  final List<String> allowedOutputFormats;

  UserInfo({
    required this.username,
    required this.password,
    required this.message,
    required this.auth,
    required this.status,
    required this.expDate,
    required this.isTrial,
    required this.activeCons,
    required this.createdAt,
    required this.maxConnections,
    required this.allowedOutputFormats,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        username: json["username"],
        password: json["password"],
        message: json["message"],
        auth: json["auth"],
        status: json["status"],
        expDate: json["exp_date"],
        isTrial: json["is_trial"],
        activeCons: json["active_cons"],
        createdAt: json["created_at"],
        maxConnections: json["max_connections"],
        allowedOutputFormats:
            List<String>.from(json["allowed_output_formats"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "message": message,
        "auth": auth,
        "status": status,
        "exp_date": expDate,
        "is_trial": isTrial,
        "active_cons": activeCons,
        "created_at": createdAt,
        "max_connections": maxConnections,
        "allowed_output_formats":
            List<dynamic>.from(allowedOutputFormats.map((x) => x)),
      };
}
