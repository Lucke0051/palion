import 'package:flutter/material.dart';
import 'package:palion/utilities/colors.dart';
import 'package:palion/widgets/list/list_tile.dart';

class PalionListSection extends StatelessWidget {
  const PalionListSection(
    this.items, {
    this.header,
    this.headerPadding = const EdgeInsets.only(
      left: 15.0,
      right: 15.0,
      bottom: 6.0,
    ),
    this.footer,
    Key? key,
  }) : super(key: key);

  final List<Widget> items;

  final Widget? header;
  final EdgeInsetsGeometry headerPadding;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final List<Widget> columnChildren = [];
    if (header != null) {
      columnChildren.add(
        DefaultTextStyle(
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
            fontSize: 13.5,
            letterSpacing: -0.5,
          ),
          child: Padding(
            padding: headerPadding,
            child: header,
          ),
        ),
      );
    }

    final List<Widget> itemsWithDividers = [];
    for (int i = 0; i < items.length; i++) {
      if (i < items.length - 1) {
        var leftPadding = 0.0;
        if (items[i] is PalionListTile && (i < items.length - 1 && (items[i + 1] is PalionListTile))) {
          leftPadding = (items[i] as PalionListTile).leading == null ? 15.0 : 54.0;
        }

        itemsWithDividers.add(items[i]);
        itemsWithDividers.add(
          Divider(
            height: 0.3,
            color: Colors.grey.shade400,
            indent: leftPadding,
          ),
        );
      } else {
        itemsWithDividers.add(items[i]);
      }
    }

    final bool largeScreen = MediaQuery.of(context).size.width >= 768;

    columnChildren.add(
      largeScreen
          ? Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: PalionColors.from(context).tile,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: itemsWithDividers,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: PalionColors.from(context).tile,
                border: Border(
                  top: BorderSide(
                    color: PalionColors.from(context).border,
                    width: 0.3,
                  ),
                  bottom: BorderSide(
                    color: PalionColors.from(context).border,
                    width: 0.3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: itemsWithDividers,
              ),
            ),
    );

    if (footer != null) {
      columnChildren.add(
        DefaultTextStyle(
          style: TextStyle(
            color: PalionColors.from(context).groupSubtitle,
            fontSize: 13.0,
            letterSpacing: -0.08,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 7.5,
            ),
            child: footer,
          ),
        ),
      );
    }

    return Padding(
      padding: largeScreen
          ? EdgeInsets.only(top: header == null ? 35.0 : 22.0, left: 22, right: 22)
          : EdgeInsets.only(
              top: header == null ? 35.0 : 22.0,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}
