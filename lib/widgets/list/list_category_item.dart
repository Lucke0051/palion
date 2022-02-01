import 'package:flutter/cupertino.dart';
import 'package:palion/utilities/colors.dart';

typedef PressOperationCallback = void Function();

class PalionListCategoryItem extends StatefulWidget {
  const PalionListCategoryItem({
    required this.label,
    this.labelPaddingRight,
    this.trailing,
    this.enabled = true,
    this.active = false,
    this.onTap,
    this.tileColor,
    this.contentColor,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    Key? key,
  }) : super(key: key);

  final String label;
  final double? labelPaddingRight;
  final Widget? trailing;
  final bool enabled;
  final bool active;
  final PressOperationCallback? onTap;
  final Color? tileColor;
  final Color? contentColor;
  final EdgeInsetsGeometry contentPadding;

  @override
  State<StatefulWidget> createState() => PalionListCategoryItemState();
}

class PalionListCategoryItemState extends State<PalionListCategoryItem> {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconThemeData = IconThemeData(
      color: widget.enabled ? widget.contentColor ?? PalionTheme.of(context).tileContent : PalionTheme.of(context).tileContentInactive,
    );

    final List<Widget> rowChildren = [];

    rowChildren.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            right: widget.labelPaddingRight ?? (widget.trailing != null ? 10 : 0),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: widget.enabled ? widget.contentColor ?? PalionTheme.of(context).tileContent : PalionTheme.of(context).tileContentInactive,
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
        child: Container(
          padding: widget.contentPadding,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: calculateBackgroundColor(context),
          ),
          height: 40,
          child: widget.active
              ? Row(
                  children: rowChildren,
                )
              : Column(
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
                        color: PalionTheme.of(context).itemCategoryItemBorder,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Color calculateBackgroundColor(BuildContext context) => widget.tileColor ?? PalionTheme.of(context).tile;
}
