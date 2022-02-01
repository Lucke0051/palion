import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:palion/widgets/sidebar/custom_expansion_tile.dart';

//TODO: https://developer.apple.com/design/human-interface-guidelines/ios/bars/sidebars/

class Sidebar extends StatefulWidget {
  final List<SidebarTab> tabs;
  final void Function(dynamic)? onTabChanged;
  final List<int>? activeTabIndices;

  // const Sidebar({
  //   Key key,
  //   @required this.tabs,
  //   this.onTabChanged,
  //   this.activeTabIndices,
  // }) : super(key: key);

  const Sidebar.fromJson({
    Key? key,
    required this.tabs,
    this.onTabChanged,
    this.activeTabIndices,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  static const double _maxSidebarWidth = 300;
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

  List<Object?> _getFirstTabIndex(List<SidebarTab> tabs, List<int>? indices) {
    List<int>? newIndices = indices;
    dynamic tabId;
    if (tabs.isNotEmpty) {
      final SidebarTab firstTab = tabs.first;
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
      color: Theme.of(context).canvasColor,
      width: _sidebarWidth,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Container(color: Theme.of(context).primaryColor),
          ),
          Expanded(
            child: Material(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) => SidebarItem(
                  widget.tabs[index],
                  widget.onTabChanged,
                  activeTabIndices,
                  setActiveTabIndices,
                  index: index,
                ),
                itemCount: widget.tabs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final SidebarTab? data;
  final void Function(dynamic)? onTabChanged;
  final List<int>? activeTabIndices;
  final void Function(List<int> newIndices) setActiveTabIndices;
  final int? index;
  final List<int>? indices;

  const SidebarItem(
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

  Widget _buildTiles(SidebarTab root) {
    final _indices = indices ?? [index!];
    if (root.children == null || root.children!.isEmpty) {
      return ListTile(
        selected: activeTabIndices != null && _indicesMatch(_indices, activeTabIndices!),
        contentPadding: EdgeInsets.only(left: 16.0 + 20.0 * (_indices.length - 1)),
        title: Text(root.title),
        onTap: () {
          setActiveTabIndices(_indices);
          if (onTabChanged != null) onTabChanged?.call(root.key);
        },
      );
    }

    final List<Widget> children = [];
    for (int i = 0; i < root.children!.length; i++) {
      final SidebarTab item = root.children![i];
      final itemIndices = [..._indices, i];
      children.add(
        SidebarItem(
          item,
          onTabChanged,
          activeTabIndices,
          setActiveTabIndices,
          indices: itemIndices,
        ),
      );
    }

    return CustomExpansionTile(
      tilePadding: EdgeInsets.only(
        left: 16.0 + 20.0 * (_indices.length - 1),
        right: 12.0,
      ),
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

class SidebarTab {
  final dynamic key;
  final String title;
  final List<SidebarTab>? children;

  SidebarTab({
    required this.key,
    required this.title,
    this.children,
  });
}
