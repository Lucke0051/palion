import 'package:flutter/widgets.dart';

abstract class AbstractSection extends StatelessWidget {
  bool showBottomDivider = false;
  final String? title;
  final Widget? titleWidget;
  final EdgeInsetsGeometry? titlePadding;

  AbstractSection({
    Key? key,
    this.title,
    this.titleWidget,
    this.titlePadding,
  }) : super(key: key);
}
