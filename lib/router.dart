import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/player_page.dart';
import 'pages/serie_page.dart';
import 'pages/settings_page.dart';
import 'pages/streams_page.dart';
import 'app_layout.dart';
import 'models/enums.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) => '/home',
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/streams',
          builder: (context, state) => const StreamsPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/series/:serieId',
      builder: (context, state) => SeriePage(
        int.parse(state.pathParameters["serieId"]!),
      ),
    ),
    GoRoute(
      path: '/player/:streamType/:streamId',
      builder: (context, state) => PlayerPage(
        streamType: StreamType.values.byName(
          state.pathParameters['streamType']!,
        ),
        streamId: int.parse(state.pathParameters["streamId"]!),
      ),
    ),
  ],
);
