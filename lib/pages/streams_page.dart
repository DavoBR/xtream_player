import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/models/stream_category.dart';
import 'package:xtream_player/providers/categories_provider.dart';
import 'package:xtream_player/providers/filter_provider.dart';

import '../models/enums.dart';
import '../models/live.dart';
import '../models/movie.dart';
import '../models/serie.dart';
import '../providers/streams_provider.dart';
import '../widgets/movie_dialog.dart';
import '../widgets/search_view.dart';
import '../widgets/stream_card.dart';

class StreamsPage extends StatelessWidget {
  const StreamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SearchView(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StreamTypeDropDown(),
              _CategoryDropDown(),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _PageContent(),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreamTypeDropDown extends ConsumerWidget {
  const _StreamTypeDropDown();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownMenu(
      label: const Text('Type'),
      dropdownMenuEntries: StreamType.values.map((streamType) {
        return DropdownMenuEntry(
          value: streamType,
          label: streamType.name,
        );
      }).toList(),
      onSelected: (streamType) {
        ref.read(streamTypeProvider.notifier).state = streamType;
      },
    );
  }
}

class _CategoryDropDown extends ConsumerWidget {
  const _CategoryDropDown();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamType = ref.watch(streamTypeProvider);
    final categoriesAsync = ref.watch(categoriesProvider(streamType));
    final categories = categoriesAsync.hasValue ? categoriesAsync.value! : [];
    return DropdownMenu<StreamCategory>(
      label: const Text('Category'),
      width: 300,
      enabled: categories.isNotEmpty,
      dropdownMenuEntries: categories.map((category) {
        return DropdownMenuEntry<StreamCategory>(
          value: category,
          label: category.categoryName,
        );
      }).toList(),
      onSelected: (selected) {
        if (streamType == null) {
          return;
        }
        ref.read(streamCategoryProvider(streamType).notifier).state = selected;
      },
    );
  }
}

class _PageContent extends ConsumerWidget {
  const _PageContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(streamsProvider).when(
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('No elements'));
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 250,
            childAspectRatio: 1.0,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: items.length,
          itemBuilder: (context, i) => _ItemContent(items[i]),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _ItemContent extends StatelessWidget {
  const _ItemContent(this.item);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
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
          name: live.name ?? 'Unknown',
          onTap: () {
            context.push('/player/${streamType.name}/${live.streamId}');
          },
        );
      case StreamType.movie:
        final movie = Movie.fromJson(item);
        return StreamCard(
          streamType: streamType,
          streamId: movie.streamId!,
          imageUrl: movie.streamIcon,
          name: movie.name ?? 'Unknown',
          onInfoTap: () => showDialog(
            context: context,
            builder: (_) => MovieDialog(movie),
          ),
          onTap: () {
            context.push('/player/${streamType.name}/${movie.streamId}');
          },
        );
      case StreamType.series:
        final serie = Serie.fromJson(item);
        return StreamCard(
          streamType: streamType,
          streamId: serie.seriesId,
          imageUrl: serie.cover,
          name: serie.name ?? 'Unknown',
          onTap: () {
            context.push('/series/${serie.seriesId}');
          },
        );
    }
  }
}
