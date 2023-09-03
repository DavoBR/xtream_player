import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:popover/popover.dart';

class SelectItemButton<T> extends StatelessWidget {
  const SelectItemButton({
    super.key,
    required this.icon,
    required this.items,
    required this.checkSelected,
    required this.buildLabel,
    required this.onSelect,
    required this.filter,
  });

  final Widget icon;
  final List<T> items;
  final bool Function(T item) filter;
  final bool Function(T item) checkSelected;
  final String Function(T item) buildLabel;
  final void Function(T item) onSelect;

  @override
  Widget build(BuildContext context) {
    return MaterialDesktopCustomButton(
      onPressed: () => _onPressed(context),
      icon: icon,
    );
  }

  void _onPressed(BuildContext context) async {
    final item = await showPopover<T>(
      context: context,
      width: 300,
      height: 200,
      backgroundColor: Colors.black45,
      bodyBuilder: _buildList,
    );

    if (item == null) return;

    onSelect(item);
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children:
          items.where(filter).map((item) => _buildItem(context, item)).toList(),
    );
  }

  Widget _buildItem(BuildContext context, T item) {
    return ListTile(
      onTap: () => Navigator.of(context).pop(item),
      selected: checkSelected(item),
      title: Text(
        buildLabel(item),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
