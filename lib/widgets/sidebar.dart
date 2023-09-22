import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xtream_player/models/enums.dart';
import 'package:xtream_player/providers/categories_provider.dart';

import '../models/stream_category.dart';
import '../providers/category_provider.dart';
import '../providers/scope_provider.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar(this._streamType, {super.key});

  final StreamType _streamType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider(_streamType));
    final scope = ref.watch(scopeProvider(_streamType));
    final selectedCategory = ref.watch(categoryProvider(_streamType));

    return Drawer(
      child: ListView(children: [
        ListTile(
          leading: const Icon(Icons.live_tv),
          title: const Text('Live'),
          selected: _streamType == StreamType.live,
          onTap: () => goToStreams(context, StreamType.live),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          selected: _streamType == StreamType.movie,
          onTap: () => goToStreams(context, StreamType.movie),
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('Series'),
          selected: _streamType == StreamType.series,
          onTap: () => goToStreams(context, StreamType.series),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            context.push('/settings');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.stream),
          title: const Text('All'),
          selected: scope == StreamScope.all,
          onTap: () => changeScope(context, ref, StreamScope.all),
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favorites'),
          selected: scope == StreamScope.favorites,
          onTap: () => changeScope(context, ref, StreamScope.favorites),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Recents'),
          selected: scope == StreamScope.recents,
          onTap: () => changeScope(context, ref, StreamScope.recents),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.category),
          title: Text('Categories'),
        ),
        ListTile(
          title: const Text('       All'),
          onTap: () => changeCategory(context, ref, null),
        ),
        ...categoriesAsync.maybeWhen<List<ListTile>>(
          orElse: () => [],
          data: (categories) {
            return categories.map((category) {
              return ListTile(
                title: Text('       ${category.categoryName}'),
                selected: selectedCategory == category,
                onTap: () => changeCategory(context, ref, category),
              );
            }).toList();
          },
        )
      ]),
    );
  }

  void goToStreams(BuildContext context, StreamType streamType) {
    Navigator.pop(context);
    context.go('/${streamType.name}');
  }

  void changeScope(BuildContext context, WidgetRef ref, StreamScope scope) {
    Navigator.pop(context);
    ref.read(scopeProvider(_streamType).notifier).state = scope;
  }

  void changeCategory(
    BuildContext context,
    WidgetRef ref,
    StreamCategory? category,
  ) {
    Navigator.pop(context);
    ref.read(categoryProvider(_streamType).notifier).state = category;
  }
}
