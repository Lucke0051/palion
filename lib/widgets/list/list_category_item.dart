import 'package:flutter/cupertino.dart';
import 'package:palion/utilities/colors.dart';

typedef PressOperationCallback = void Function();

class PalionListCategoryItem extends StatefulWidget {
  const PalionListCategoryItem({
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
  State<StatefulWidget> createState() => PalionListCategoryItemState();
}

class PalionListCategoryItemState extends State<PalionListCategoryItem> {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconThemeData = IconThemeData(
      color: widget.enabled
          ? (widget.selected
              ? (widget.selectedContentColor ?? PalionColors.from(context).selectedTileContent)
              : (widget.contentColor ?? PalionColors.from(context).tileContent))
          : PalionColors.from(context).tileContentInactive,
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
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: widget.enabled
                  ? (widget.selected
                      ? (widget.selectedContentColor ?? PalionColors.from(context).selectedTileContent)
                      : (widget.contentColor ?? PalionColors.from(context).tileContent))
                  : PalionColors.from(context).tileContentInactive,
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

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if ((widget.onTap != null) && widget.enabled) {
          widget.onTap!.call();
        }
      },
      child: Container(
        padding: widget.contentPadding,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: calculateBackgroundColor(context),
        ),
        height: 40,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: rowChildren,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Container(
                height: 1,
                color: PalionColors.from(context).itemCategoryItemBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color calculateBackgroundColor(BuildContext context) =>
      widget.selected ? (widget.selectedTileColor ?? PalionColors.from(context).selectedTile) : (widget.tileColor ?? PalionColors.from(context).tile);
}
