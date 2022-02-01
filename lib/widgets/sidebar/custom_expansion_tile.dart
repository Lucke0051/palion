import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/utilities/colors.dart';
import 'package:palion/widgets/list/list_category_item.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key? key,
    this.leading,
    required this.title,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.selected,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
  })  : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          "CrossAxisAlignment.baseline is not supported since the expanded children are aligned in a column, not a row. Try to use another constant.",
        ),
        super(key: key);

  final Widget? leading;
  final String title;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Widget? trailing;
  final bool? selected;
  final bool initiallyExpanded;
  final bool maintainState;
  final Alignment? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;

  @override
  State<StatefulWidget> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
  static const _expansionDuration = Duration(milliseconds: 200);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _expansionDuration, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null) widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: PalionListCategoryItem(
              tileColor: Colors.transparent,
              active: _isExpanded,
              onTap: _handleTap,
              label: widget.title,
              trailing: widget.trailing ??
                  RotationTransition(
                    turns: _iconTurns,
                    child: Icon(
                      CupertinoIcons.chevron_down,
                      color: PalionTheme.of(context).active,
                    ),
                  ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: widget.expandedAlignment ?? Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Column(
          crossAxisAlignment: widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
