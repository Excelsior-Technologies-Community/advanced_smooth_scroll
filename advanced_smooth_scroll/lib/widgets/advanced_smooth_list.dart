import 'package:flutter/material.dart';
import '../core/pagination/pagination_manager.dart';
import '../core/physics/ultra_smooth_scroll_physics.dart';
import 'loading_footer.dart';
import 'fast_scrollbar.dart';

class AdvancedSmoothList extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Future<void> Function(int page) onLoadMore;

  const AdvancedSmoothList({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.onLoadMore,
  });

  @override
  State<AdvancedSmoothList> createState() => _AdvancedSmoothListState();
}

class _AdvancedSmoothListState extends State<AdvancedSmoothList> {
  final ScrollController _controller = ScrollController();
  final PaginationManager _pagination = PaginationManager();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() async {
    if (!_controller.hasClients ||
        _pagination.isLoading ||
        !_pagination.hasMore) return;

    final threshold = _controller.position.maxScrollExtent - 200;

    if (_controller.position.pixels >= threshold) {
      _pagination.isLoading = true;
      await widget.onLoadMore(_pagination.page);
      _pagination.nextPage();
      _pagination.isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FastScrollbar(
      controller: _controller,
      child: ListView.builder(
        controller: _controller,
        physics: const UltraSmoothScrollPhysics(),
        itemCount: widget.itemCount + (_pagination.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.itemCount) {
            return const LoadingFooter();
          }
          return widget.itemBuilder(context, index);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
