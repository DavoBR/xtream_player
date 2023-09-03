import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamsView extends ConsumerWidget {
  const StreamsView({
    super.key,
    required this.itemsProvider,
    required this.itemBuilder,
  });

  final FutureProvider<List<Map<String, dynamic>>> itemsProvider;
  final Widget Function(BuildContext context, Map<String, dynamic> item)
      itemBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(itemsProvider).when(
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
          itemBuilder: (context, i) => itemBuilder(context, items[i]),
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
