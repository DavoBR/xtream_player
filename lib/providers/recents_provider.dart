import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/models/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentsNotifier extends FamilyAsyncNotifier<List<int>, StreamType> {
  final _prefs = SharedPreferences.getInstance();

  List<int> get values => state.valueOrNull ?? [];

  @override
  FutureOr<List<int>> build(StreamType arg) async {
    final prefs = await _prefs;
    final list = (prefs.getStringList('recents-${arg.name}') ?? [])
        .map(int.parse)
        .toList();

    return list;
  }

  void _saveState() async {
    final prefs = await _prefs;

    prefs.setStringList(
        'recents-${arg.name}', values.map((e) => e.toString()).toList());
  }

  void add(int idToAdd) {
    if (values.contains(idToAdd)) return;

    state = AsyncValue.data([idToAdd, ...values.take(9)]);

    _saveState();
  }
}

final recentsProvider =
    AsyncNotifierProvider.family<RecentsNotifier, List<int>, StreamType>(
        RecentsNotifier.new);
