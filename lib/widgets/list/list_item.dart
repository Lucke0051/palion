import 'package:flutter/cupertino.dart';
import 'package:palion/utilities/colors.dart';

typedef PressOperationCallback = void Function();

class PalionListItem extends StatefulWidget {
  const PalionListItem({
    this.leading,
    required this.label,
    this.labelPaddingLeft,
    this.labelPaddingRight,
    this.trailing,
    this.enabled = true,
    this.onTap,
    this.tileColor,
    this.selectedTileColor,
    this.selected = false,
    this.contentColor,
    this.selectedContentColor,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    Key? key,
  }) : super(key: key);

  final Widget? leading;
  final String label;
  final double? labelPaddingLeft;
  final double? labelPaddingRight;
  final Widget? trailing;
  final bool enabled;
  final PressOperationCallback? onTap;
  final Color? tileColor;
  final Color? selectedTileColor;
  final Color? contentColor;
  final Color? selectedContentColor;
  final bool selected;
  final EdgeInsetsGeometry contentPadding;

  @override
  State<StatefulWidget> createState() => PalionListItemState();
}

class PalionListItemState extends State<PalionListItem> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconThemeData = IconThemeData(
      color: widget.enabled
          ? (widget.selected
              ? (widget.selectedContentColor ?? PalionTheme.of(context).selectedTileContent)
              : (widget.contentColor ?? PalionTheme.of(context).tileContent))
          : PalionTheme.of(context).tileContentInactive,
      size: 26,
    );

    final List<Widget> rowChildren = [];

    if (widget.leading != null) {
      rowChildren.add(
        IconTheme.merge(
          data: iconThemeData,
          child: widget.leading!,
        ),
      );
    }

    rowChildren.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: widget.labelPaddingLeft ?? (widget.leading != null ? 10 : 0),
            right: widget.labelPaddingRight ?? (widget.trailing != null ? 10 : 0),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: widget.enabled
                  ? (widget.selected
                      ? (widget.selectedContentColor ?? PalionTheme.of(context).selectedTileContent)
                      : (widget.contentColor ?? PalionTheme.of(context).tileContent))
                  : PalionTheme.of(context).tileContentInactive,
            ),
          ),
        ),
      ),
    );

    if (widget.trailing != null) {
      rowChildren.add(
        IconTheme.merge(
          data: iconThemeData,
          child: widget.trailing!,
        ),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if ((widget.onTap != null) && widget.enabled) {
            widget.onTap!.call();
          }
        },
        onTapDown: (_) => setState(() => isTapped = true),
        onTapUp: (_) => setState(() => isTapped = false),
        onTapCancel: () => setState(() => isTapped = false),
        child: Container(
          padding: widget.contentPadding,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(9)),
            color: calculateBackgroundColor(context),
          ),
          height: 44,
          child: Row(
            children: rowChildren,
          ),
        ),
      ),
    );
  }

  Color calculateBackgroundColor(BuildContext context) => widget.selected
      ? (isTapped
          ? Color.alphaBlend(PalionTheme.of(context).tapOverlay, widget.selectedTileColor ?? PalionTheme.of(context).selectedTile)
          : (widget.selectedTileColor ?? PalionTheme.of(context).selectedTile))
      : (widget.tileColor ?? PalionTheme.of(context).tile);
}
