import 'dart:math' show min;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/palion.dart';
import 'package:palion/widgets/sidebar/custom_expansion_tile.dart';

//TODO: https://developer.apple.com/design/human-interface-guidelines/ios/bars/sidebars/

class PalionSidebar extends StatefulWidget {
  final Widget? header;
  final List<PalionSidebarTab> tabs;
  final void Function(dynamic)? onTabChanged;
  final List<int>? activeTabIndices;

  const PalionSidebar({
    Key? key,
    this.header,
    required this.tabs,
    this.onTabChanged,
    this.activeTabIndices,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PalionSidebarState();
}

class _PalionSidebarState extends State<PalionSidebar> with SingleTickerProviderStateMixin {
  static const double _maxSidebarWidth = 350;
  double _sidebarWidth = _maxSidebarWidth;
  List<int>? activeTabIndices;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (activeTabIndices == null) {
        final newActiveTabData = _getFirstTabIndex(widget.tabs, []);
        final List<int> newActiveTabIndices = newActiveTabData[0]! as List<int>;
        final String? tabId = newActiveTabData[1] as String?;
        if (newActiveTabIndices.isNotEmpty) {
          setActiveTabIndices(newActiveTabIndices);
          if (widget.onTabChanged != null) widget.onTabChanged?.call(tabId);
        }
      }
    });
  }

  List<Object?> _getFirstTabIndex(List<PalionSidebarTab> tabs, List<int>? indices) {
    List<int>? newIndices = indices;
    dynamic tabId;
    if (tabs.isNotEmpty) {
      final PalionSidebarTab firstTab = tabs.first;
      tabId = firstTab.key;
      newIndices!.add(0);

      if (firstTab.children != null && firstTab.children!.isNotEmpty) {
        final tabData = _getFirstTabIndex(firstTab.children!, newIndices);
        newIndices = tabData[0] as List<int>?;
        tabId = tabData[1] as String?;
      }
    }
    return [newIndices, tabId];
  }

  void setActiveTabIndices(List<int> newIndices) {
    setState(() {
      activeTabIndices = newIndices;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    _sidebarWidth = min(mediaQuery.size.width * 0.7, _maxSidebarWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PalionTheme.of(context).sidebarBackground,
      width: _sidebarWidth,
      child: CustomScrollView(
        slivers: [
          if (widget.header != null) widget.header!,
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => PalionSidebarItem(
                widget.tabs[index],
                widget.onTabChanged,
                activeTabIndices,
                setActiveTabIndices,
                index: index,
              ),
              childCount: widget.tabs.length,
            ),
          ),
        ],
      ),
    );
  }
}

class PalionSidebarItem extends StatelessWidget {
  final PalionSidebarTab? data;
  final void Function(dynamic)? onTabChanged;
  final List<int>? activeTabIndices;
  final void Function(List<int> newIndices) setActiveTabIndices;
  final int? index;
  final List<int>? indices;

  const PalionSidebarItem(
    this.data,
    this.onTabChanged,
    this.activeTabIndices,
    this.setActiveTabIndices, {
    this.index,
    this.indices,
    Key? key,
  })  : assert(
          (index == null && indices != null) || (index != null && indices == null),
          "Exactly one parameter out of [index, indices] has to be provided",
        ),
        super(key: key);

  bool _indicesMatch(List<int?> a, List<int> b) {
    for (int i = 0; i < min(a.length, b.length); i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Widget _buildTiles(PalionSidebarTab root) {
    final _indices = indices ?? [index!];
    if (root.children == null || root.children!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: PalionListItem(
          selected: activeTabIndices != null && _indicesMatch(_indices, activeTabIndices!),
          label: root.title,
          leading: root.icon,
          onTap: () {
            setActiveTabIndices(_indices);
            if (onTabChanged != null) onTabChanged?.call(root.key);
          },
        ),
      );
    }

    final List<Widget> children = [];
    for (int i = 0; i < root.children!.length; i++) {
      final PalionSidebarTab item = root.children![i];
      final itemIndices = [..._indices, i];
      children.add(
        PalionSidebarItem(
          item,
          onTabChanged,
          activeTabIndices,
          setActiveTabIndices,
          indices: itemIndices,
        ),
      );
    }

    return CustomExpansionTile(
      selected: activeTabIndices != null && _indicesMatch(_indices, activeTabIndices!),
      title: root.title,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(data!);
  }
}

class PalionSidebarTab {
  final dynamic key;
  final String title;
  final Widget? icon;
  final List<PalionSidebarTab>? children;

  PalionSidebarTab({
    required this.key,
    required this.title,
    this.icon,
    this.children,
  });
}
