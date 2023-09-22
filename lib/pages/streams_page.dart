import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/widgets/sidebar.dart';

import '../models/enums.dart';
import '../models/live.dart';
import '../models/movie.dart';
import '../models/serie.dart';
import '../providers/category_provider.dart';
import '../providers/scope_provider.dart';
import '../providers/streams_provider.dart';
import '../widgets/movie_dialog.dart';
import '../widgets/search_view.dart';
import '../widgets/serie_dialog.dart';
import '../widgets/stream_card.dart';
import '../widgets/streams_view.dart';

class StreamsPage extends StatelessWidget {
  const StreamsPage(this.streamType, {super.key});

  final StreamType streamType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(streamType.name.toUpperCase()),
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Column(
            children: [
              Consumer(builder: (context, ref, child) {
                final scope = ref.watch(scopeProvider(streamType));
                final category = ref.watch(categoryProvider(streamType));
                return Text([scope.name.toUpperCase(), category?.categoryName]
                    .where((s) => s != null)
                    .join(' - '));
              }),
            ],
          ),
        ),
      ),
      drawer: Sidebar(streamType),
      body: Column(
        children: [
          SearchView(streamType),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamsView(
                itemsProvider: streamsProvider(streamType),
                itemBuilder: _itemBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, Map<String, dynamic> item) {
    final streamType =
        StreamType.values.byName(item['stream_type']!.toString());

    switch (streamType) {
      case StreamType.live:
        final live = Live.fromJson(item);
        return StreamCard(
          streamType: streamType,
          streamId: live.streamId!,
          imageUrl: live.streamIcon,
          imageWidth: 250,
          imageHeight: 250,
          name: live.name!,
          onTap: () => context.go('/${streamType.name}/${live.streamId}'),
        );
      case StreamType.movie:
        final movie = Movie.fromJson(item);
        return StreamCard(
          streamType: streamType,
          streamId: movie.streamId!,
          imageUrl: movie.streamIcon,
          name: movie.name!,
          onInfoTap: () => showDialog(
            context: context,
            builder: (_) => MovieDialog(movie),
          ),
          onTap: () => context.go('/${streamType.name}/${movie.streamId}'),
        );
      case StreamType.series:
        final serie = Serie.fromJson(item);
        return StreamCard(
          streamType: streamType,
          streamId: serie.seriesId,
          imageUrl: serie.cover,
          name: serie.name!,
          onTap: () => showDialog(
            context: context,
            builder: (_) => SerieDialog(serie),
          ),
        );
    }
  }
}
