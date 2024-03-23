import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ui_kit/ui/loading_indicator/loading_circular.dart';

export 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InfinitePaginationWidget<PageKeyType, ItemType> extends StatefulWidget {
  const InfinitePaginationWidget({
    super.key,
    required this.itemBuilder,
    required this.pagingController,
  });

  final Widget Function(BuildContext, ItemType, int) itemBuilder;
  final PagingController<PageKeyType, ItemType> pagingController;

  @override
  State<InfinitePaginationWidget<PageKeyType, ItemType>> createState() =>
      _InfinitePaginationWidgetState<PageKeyType, ItemType>();
}

class _InfinitePaginationWidgetState<PageKeyType, ItemType>
    extends State<InfinitePaginationWidget<PageKeyType, ItemType>> {
  @override
  Widget build(BuildContext context) {
    return PagedListView<PageKeyType, ItemType>(
      pagingController: widget.pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<ItemType>(
        itemBuilder: widget.itemBuilder,
        newPageProgressIndicatorBuilder: (context) => const LoadingCircular(),
        firstPageProgressIndicatorBuilder: (context) => const LoadingCircular(),
      ),
    );
  }
}
