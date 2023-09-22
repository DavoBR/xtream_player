import 'package:go_router/go_router.dart';
import 'package:xtream_player/pages/home_page.dart';
import 'package:xtream_player/pages/player_page.dart';
import 'package:xtream_player/pages/settings_page.dart';
import 'package:xtream_player/pages/streams_page.dart';

import 'models/enums.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: ':streamType',
        builder: (context, state) => StreamsPage(
          StreamType.values.byName(state.pathParameters['streamType']!),
        ),
        routes: [
          GoRoute(
            path: ':streamId',
            builder: (context, state) => PlayerPage(
              streamType: StreamType.values.byName(
                state.pathParameters['streamType']!,
              ),
              streamId: int.parse(state.pathParameters["streamId"]!),
            ),
          ),
        ],
      ),
    ],
  ),
]);
