import 'server_info.dart';
import 'user_info.dart';

class UserServerInfo {
  final UserInfo userInfo;
  final ServerInfo serverInfo;

  UserServerInfo({
    required this.userInfo,
    required this.serverInfo,
  });

  factory UserServerInfo.fromJson(Map<String, dynamic> json) => UserServerInfo(
        userInfo: UserInfo.fromJson(json["user_info"]),
        serverInfo: ServerInfo.fromJson(json["server_info"]),
      );

  Map<String, dynamic> toJson() => {
        "user_info": userInfo.toJson(),
        "server_info": serverInfo.toJson(),
      };
}
