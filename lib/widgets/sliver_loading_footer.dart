import 'package:flutter/material.dart';

class SliverLoadingFooter extends StatelessWidget {
  const SliverLoadingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
