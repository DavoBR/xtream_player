import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/widgets/settings_view.dart';

import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final settingsAsync = ref.watch(settingsProvider);
        return settingsAsync.when(
          data: (settings) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SettingsView(settings),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
        );
      }),
    );
  }
}
