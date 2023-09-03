import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/settings.dart';

class SettingsNotifier extends AsyncNotifier<Settings> {
  final _prefs = SharedPreferences.getInstance();
  final _vault = const FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: 'xtream-player',
      publicKey: 'a6add88c-4a39-11ee-be56-0242ac120002',
    ),
  );

  @override
  FutureOr<Settings> build() async {
    final prefs = await _prefs;
    final serverUrl = prefs.getString('settings-server-url');
    final username = prefs.getString('settings-username');
    final password = await _vault.read(key: 'settings-password');

    return Settings(
      serverUrl: serverUrl ?? '',
      username: username ?? '',
      password: password ?? '',
    );
  }

  void updateSettings(Settings settings) async {
    final prefs = await _prefs;
    prefs.setString('settings-server-url', settings.serverUrl);
    prefs.setString('settings-username', settings.username);
    await _vault.write(key: 'settings-password', value: settings.password);
    state = AsyncValue.data(settings);
  }
}

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, Settings>(SettingsNotifier.new);
