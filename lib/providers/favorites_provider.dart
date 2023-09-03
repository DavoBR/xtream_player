import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums.dart';

class FavoritesNotifier extends FamilyAsyncNotifier<List<int>, StreamType> {
  final _prefs = SharedPreferences.getInstance();

  List<int> get values => state.valueOrNull ?? [];

  @override
  FutureOr<List<int>> build(StreamType arg) async {
    final prefs = await _prefs;

    return (prefs.getStringList('favorites-${arg.name}') ?? [])
        .map(int.parse)
        .toList();
  }

  void _saveState() async {
    final prefs = await _prefs;

    prefs.setStringList(
      'favorites-${arg.name}',
      values.map((e) => e.toString()).toList(),
    );
  }

  void add(int idToAdd) {
    state = AsyncValue.data([idToAdd, ...values]);
    _saveState();
  }

  void remove(int idToRemove) {
    state = AsyncValue.data(values.where((id) => id != idToRemove).toList());
    _saveState();
  }
}

final favoritesProvider =
    AsyncNotifierProvider.family<FavoritesNotifier, List<int>, StreamType>(
        FavoritesNotifier.new);
