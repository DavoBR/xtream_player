import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/server_info.dart';
import '../models/user_info.dart';
import '../models/user_server_info.dart';
import 'player_api_provider.dart';

final userServerInfoProvider = FutureProvider<UserServerInfo>((ref) async {
  final api = await ref.watch(playerApiProvider.future);
  final response = await api.get('');
  return UserServerInfo.fromJson(response.data);
});

final userInfoProvider = FutureProvider<UserInfo>((ref) {
  return ref.watch(userServerInfoProvider.selectAsync((data) => data.userInfo));
});

final serverInfoProvider = FutureProvider<ServerInfo>((ref) {
  return ref
      .watch(userServerInfoProvider.selectAsync((data) => data.serverInfo));
});
