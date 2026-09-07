import 'package:flutter/material.dart';

/// Builds each child only on first visit, then keeps it alive.
class LazyIndexedStack extends StatefulWidget {
  final int index;
  final List<WidgetBuilder> itemBuilders;

  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.itemBuilders,
  });

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<Widget?> _built =
      List<Widget?>.filled(widget.itemBuilders.length, null);

  @override
  void initState() {
    super.initState();
    _build(widget.index);
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    _build(widget.index);
  }

  void _build(int index) {
    _built[index] ??= widget.itemBuilders[index](context);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      children: List.generate(
        _built.length,
        // Unvisited tabs are zero-size placeholders until first opened.
        (i) => _built[i] ?? const SizedBox.shrink(),
      ),
    );
  }
}