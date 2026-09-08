import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/app_colors.dart';

class PaginatedListView<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final bool isLoadingMore;
  final bool hasNextPage;
  final EdgeInsets padding;
  final double spacing;

  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.isLoadingMore,
    required this.hasNextPage,
    this.padding = const EdgeInsets.all(16),
    this.spacing = 12,
  });

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    // Fetch before reaching the bottom so the next page is ready on arrival.
    final nearBottom = position.pixels >= position.maxScrollExtent - 300;

    if (nearBottom && widget.hasNextPage && !widget.isLoadingMore) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final showFooter = widget.isLoadingMore;
    final itemCount = widget.items.length + (showFooter ? 1 : 0);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: widget.onRefresh,
      child: ListView.separated(
        controller: _scrollController,
        padding: widget.padding,
        // Keeps pull-to-refresh working when the list is short.
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => SizedBox(height: widget.spacing),
        itemBuilder: (context, index) {
          if (index >= widget.items.length) return const _LoadingFooter();
          return widget.itemBuilder(context, widget.items[index], index);
        },
      ),
    );
  }
}

class _LoadingFooter extends StatelessWidget {
  const _LoadingFooter();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}