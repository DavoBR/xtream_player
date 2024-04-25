import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/models/enums.dart';
import 'package:xtream_player/providers/favorites_provider.dart';
import 'package:xtream_player/providers/recents_provider.dart';
import 'package:xtream_player/providers/serie_provider.dart';
import 'package:xtream_player/providers/stream_info_provider.dart';
import 'package:xtream_player/widgets/stream_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _SectionGroup(
                title: 'Recents',
                itemsProviderFamily: recentsProvider,
              ),
              _SectionGroup(
                title: 'Favorites',
                itemsProviderFamily: favoritesProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionGroup extends StatelessWidget {
  const _SectionGroup({
    required this.title,
    required this.itemsProviderFamily,
  });

  final String title;
  final AsyncNotifierProviderFamily<FamilyAsyncNotifier<List<int>, StreamType>,
      List<int>, StreamType> itemsProviderFamily;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        Column(
          children: StreamType.values.map((streamType) {
            return _SectionGroupItem(
              streamType: streamType,
              idsProvider: itemsProviderFamily(streamType),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SectionGroupItem extends ConsumerWidget {
  const _SectionGroupItem({
    required this.streamType,
    required this.idsProvider,
  });

  final StreamType streamType;
  final AsyncNotifierFamilyProvider<FamilyAsyncNotifier<List<int>, StreamType>,
      List<int>, StreamType> idsProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idsAsync = ref.watch(idsProvider);
    return idsAsync.when(
      data: (ids) {
        if (ids.isEmpty) {
          return const SizedBox();
        }
        return Column(
          children: [
            Text(
              streamType.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            _Section(
              streamType: streamType,
              ids: ids,
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.streamType,
    required this.ids,
  });

  final StreamType streamType;
  final List<int> ids;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ids
          .map((id) => _SectionItem(streamType: streamType, id: id))
          .toList(),
    );
  }
}

class _SectionItem extends StatelessWidget {
  const _SectionItem({required this.streamType, required this.id});

  final StreamType streamType;
  final int id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 250,
      child: Builder(builder: (context) {
        switch (streamType) {
          case StreamType.series:
            return _SerieItem(id);
          case StreamType.movie:
            return _MovieItem(id);
          case StreamType.live:
            return _ChannelItem(id);
          default:
            return const SizedBox();
        }
      }),
    );
  }
}

class _SerieItem extends ConsumerWidget {
  const _SerieItem(this.id);

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serieAsync = ref.watch(serieProvider(id));
    return serieAsync.when(
      data: (serie) {
        return StreamCard(
          streamType: StreamType.series,
          streamId: id,
          imageUrl: serie.info.cover,
          name: serie.info.name,
          onTap: () => context.push('/series/$id'),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}

class _MovieItem extends ConsumerWidget {
  const _MovieItem(this.id);

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(streamInfoProvider(id));
    return movieAsync.when(
      data: (movie) {
        return StreamCard(
          streamType: StreamType.movie,
          streamId: id,
          imageUrl: movie.info?.coverBig,
          name: movie.movieData?.name ?? 'Unknown',
          onTap: () => context.push('/player/${StreamType.movie.name}/$id'),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}

class _ChannelItem extends ConsumerWidget {
  const _ChannelItem(this.id);

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelAsync = ref.watch(streamInfoProvider(id));
    return channelAsync.when(
      data: (channel) {
        return StreamCard(
          streamType: StreamType.series,
          streamId: id,
          imageUrl: channel.info?.coverBig,
          name: channel.movieData?.name ?? 'Unknown',
          onTap: () => context.push('/player/${StreamType.live.name}/$id'),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
