import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums.dart';

typedef PlayerPositionNotifierArg = (StreamType, int);

class PlayerPositionNotifier
    extends FamilyAsyncNotifier<int, PlayerPositionNotifierArg> {
  final _prefs = SharedPreferences.getInstance();

  @override
  FutureOr<int> build(PlayerPositionNotifierArg arg) async {
    final (streamType, streamId) = arg;
    final prefs = await _prefs;
    final key = 'player-position-state-${streamType.name}-$streamId';

    return prefs.getInt(key) ?? 0;
  }

  void setSeconds(int seconds) async {
    final (streamType, streamId) = arg;
    final prefs = await _prefs;
    final key = 'player-position-state-${streamType.name}-$streamId';

    prefs.setInt(key, seconds);

    state = AsyncValue.data(seconds);
  }
}

final playerPositionProvider = AsyncNotifierProviderFamily<
    PlayerPositionNotifier,
    int,
    PlayerPositionNotifierArg>(PlayerPositionNotifier.new);
