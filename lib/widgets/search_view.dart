import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xtream_player/models/enums.dart';

import '../providers/filter_provider.dart';

class SearchView extends ConsumerWidget {
  const SearchView(this._streamType, {super.key});

  final StreamType _streamType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: ref.read(filterProvider(_streamType)),
          ),
        ),
        leading: const Icon(Icons.search),
        onChanged: (value) => _onChange(ref, value),
      ),
    );
  }

  void _onChange(WidgetRef ref, String value) {
    EasyDebounce.debounce(
      'search-$_streamType',
      const Duration(milliseconds: 500),
      () {
        ref.read(filterProvider(_streamType).notifier).state = value;
      },
    );
  }
}
