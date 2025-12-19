import 'package:flutter/material.dart';
import '../core/pagination/pagination_manager.dart';
import '../core/physics/ultra_smooth_scroll_physics.dart';
import 'sliver_loading_footer.dart';

class SliverAdvancedSmoothList extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Future<void> Function(int page) onLoadMore;
  final Future<void> Function()? onRefresh;

  const SliverAdvancedSmoothList({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.onLoadMore,
    this.onRefresh,
  });

  @override
  State<SliverAdvancedSmoothList> createState() =>
      _SliverAdvancedSmoothListState();
}

class _SliverAdvancedSmoothListState extends State<SliverAdvancedSmoothList> {
  final ScrollController _controller = ScrollController();
  final PaginationManager _pagination = PaginationManager();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleScroll);
  }

  void _handleScroll() async {
    if (!_controller.hasClients ||
        _pagination.isLoading ||
        !_pagination.hasMore) return;

    final position = _controller.position;
    final threshold = position.maxScrollExtent - 200;

    if (position.pixels >= threshold) {
      _pagination.isLoading = true;
      await widget.onLoadMore(_pagination.page);
      _pagination.nextPage();
      _pagination.isLoading = false;
    }
  }

  Future<void> _handleRefresh() async {
    _pagination.reset();
    await widget.onLoadMore(1);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? _handleRefresh,
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: true,
        interactive: true,
        child: CustomScrollView(
          controller: _controller,
          physics: const UltraSmoothScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                widget.itemBuilder,
                childCount: widget.itemCount,
              ),
            ),
            if (_pagination.hasMore) const SliverLoadingFooter(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
