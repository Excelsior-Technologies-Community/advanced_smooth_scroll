import 'package:flutter/material.dart';
import '../widgets/sliver_advanced_smooth_list.dart';

class DemoSliverScreen extends StatefulWidget {
  const DemoSliverScreen({super.key});

  @override
  State<DemoSliverScreen> createState() => _DemoSliverScreenState();
}

class _DemoSliverScreenState extends State<DemoSliverScreen> {
  final List<int> items = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    loadMore(1);
  }

  Future<void> loadMore(int page) async {
    if (!hasMore) return;

    await Future.delayed(const Duration(seconds: 1));

    if (page > 10) {
      hasMore = false;
      return;
    }

    setState(() {
      items.addAll(List.generate(20, (i) => items.length + i));
    });
  }

  Future<void> refresh() async {
    setState(() {
      items.clear();
      hasMore = true;
    });
    await loadMore(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          const SliverAppBar(
            title: Text('Advanced Smooth Scrolling'),
            floating: true,
          ),
        ],
        body: SliverAdvancedSmoothList(
          itemCount: items.length,
          onLoadMore: loadMore,
          onRefresh: refresh,
          itemBuilder: (context, index) {
            return Material(
              child: ListTile(
                title: Column(
                  children: [
                    Text(
                      'Advanced Smooth Scrolling ${items[index]}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Divider()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
