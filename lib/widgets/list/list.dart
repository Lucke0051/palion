import 'package:flutter/material.dart';
import 'package:palion/utilities/colors.dart';
import 'package:palion/widgets/list/abstract_section.dart';

class PalionList extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final List<AbstractSection>? sections;
  final Color? backgroundColor;
  final Color? lightBackgroundColor;
  final Color? darkBackgroundColor;
  final EdgeInsetsGeometry? contentPadding;

  const PalionList({
    Key? key,
    this.sections,
    this.backgroundColor,
    this.physics,
    this.shrinkWrap = false,
    this.lightBackgroundColor,
    this.darkBackgroundColor,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        color: Theme.of(context).brightness == Brightness.light
            ? backgroundColor ?? lightBackgroundColor ?? PalionColors.from(context).background
            : backgroundColor ?? darkBackgroundColor ?? Colors.black,
        child: ListView.builder(
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: contentPadding,
          itemCount: sections!.length,
          itemBuilder: (context, index) {
            final AbstractSection current = sections![index];
            AbstractSection? futureOne;
            if (index + 1 != sections!.length) {
              futureOne = sections![index + 1];
            }

            if (futureOne != null && futureOne.title != null) {
              current.showBottomDivider = false;
              return current;
            } else {
              current.showBottomDivider = true;
              return current;
            }
          },
        ),
      ),
    );
  }
}
