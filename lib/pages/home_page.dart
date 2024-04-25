import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/extensions/settings_extensions.dart';
import 'package:xtream_player/providers/settings_provider.dart';

import '../models/enums.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/settings'),
        child: const Icon(Icons.settings),
      ),
      body: Consumer(builder: (context, ref, child) {
        return ref.watch(settingsProvider).when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          data: (settings) {
            if (settings.isEmpty) {
              return _MissingSettings();
            } else {
              return _Options();
            }
          },
          error: (Object error, StackTrace stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
        );
      }),
    );
  }
}

class _MissingSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No se ha configurado una cuenta'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/settings'),
            child: const Text('Configurar'),
          ),
        ],
      ),
    );
  }
}

class _Options extends StatelessWidget {
  final List<(StreamType, IconData, String)> _options = [
    (StreamType.live, Icons.live_tv, 'Live'),
    (StreamType.movie, Icons.movie, 'Movies'),
    (StreamType.series, Icons.tv, 'Series')
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Xtream Player',
            style: TextStyle(fontSize: 32.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._options.map((opt) {
              final (streamType, icon, label) = opt;
              return _Card(streamType: streamType, icon: icon, label: label);
            }),
          ],
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.streamType,
    required this.icon,
    required this.label,
  });

  final StreamType streamType;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () => context.go('/${streamType.name}'),
        child: Column(children: [
          Icon(icon, size: 200),
          Text(label),
        ]),
      ),
    );
  }
}
