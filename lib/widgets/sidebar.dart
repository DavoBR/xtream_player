import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            iconSize: 48.0,
            onPressed: () => context.go('/home'),
          ),
          IconButton(
            icon: const Icon(Icons.tv),
            iconSize: 48.0,
            onPressed: () => context.go('/streams'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 48.0,
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }
}
