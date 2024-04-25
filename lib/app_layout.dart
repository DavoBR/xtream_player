import 'package:flutter/material.dart';
import 'package:xtream_player/widgets/sidebar.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(child: child ?? const Placeholder()),
        ],
      ),
    );
  }
}
