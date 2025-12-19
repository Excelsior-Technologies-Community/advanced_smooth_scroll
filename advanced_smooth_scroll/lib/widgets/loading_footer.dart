import 'package:flutter/material.dart';

class LoadingFooter extends StatelessWidget {
  const LoadingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
