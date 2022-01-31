import 'package:flutter/cupertino.dart';
import 'package:palion/widgets/list/list_item.dart';

enum _PalionListTileType { simple, switchTile }

abstract class AbstractTile extends StatelessWidget {
  const AbstractTile({Key? key}) : super(key: key);
}

class PalionListTile extends AbstractTile {
  final String? title;
  final Widget? titleWidget;
  final int? titleMaxLines;
  final String? subtitle;
  final Widget? subtitleWidget;
  final int? subtitleMaxLines;
  final Widget? leading;
  final Widget? trailing;
  final Icon? iosChevron;
  final EdgeInsetsGeometry? iosChevronPadding;
  final Function(BuildContext context)? onPressed;
  final Function(bool value)? onToggle;
  final bool? switchValue;
  final bool enabled;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Color? switchActiveColor;
  final _PalionListTileType _tileType;
  final TargetPlatform? platform;

  const PalionListTile({
    Key? key,
    this.title,
    this.titleWidget,
    this.titleMaxLines,
    this.subtitle,
    this.subtitleMaxLines,
    this.leading,
    this.trailing,
    this.subtitleWidget,
    this.iosChevron = const Icon(
      CupertinoIcons.forward,
      size: 21.0,
    ),
    this.iosChevronPadding = const EdgeInsetsDirectional.only(
      start: 2.25,
    ),
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.enabled = true,
    this.onPressed,
    this.switchActiveColor,
    this.platform,
  })  : _tileType = _PalionListTileType.simple,
        onToggle = null,
        switchValue = null,
        assert(titleMaxLines == null || titleMaxLines > 0),
        assert(subtitleMaxLines == null || subtitleMaxLines > 0),
        super(key: key);

  const PalionListTile.switchTile({
    Key? key,
    this.title,
    this.titleWidget,
    this.titleMaxLines,
    this.subtitle,
    this.subtitleMaxLines,
    this.leading,
    this.enabled = true,
    this.trailing,
    this.subtitleWidget,
    required this.onToggle,
    required this.switchValue,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.switchActiveColor,
    this.platform,
  })  : _tileType = _PalionListTileType.switchTile,
        onPressed = null,
        iosChevron = null,
        iosChevronPadding = null,
        assert(titleMaxLines == null || titleMaxLines > 0),
        assert(subtitleMaxLines == null || subtitleMaxLines > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return iosTile(context);
  }

  Widget iosTile(BuildContext context) {
    if (_tileType == _PalionListTileType.switchTile) {
      return PalionListItem(
        enabled: enabled,
        type: PalionListItemType.toggle,
        label: title ?? '',
        labelWidget: titleWidget,
        subtitleWidget: subtitleWidget,
        labelMaxLines: titleMaxLines,
        leading: leading,
        subtitle: subtitle,
        subtitleMaxLines: subtitleMaxLines,
        switchValue: switchValue,
        onToggle: onToggle,
        labelTextStyle: titleTextStyle,
        switchActiveColor: switchActiveColor,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
        trailing: trailing,
      );
    } else {
      return PalionListItem(
        enabled: enabled,
        type: PalionListItemType.modal,
        labelWidget: titleWidget,
        subtitleWidget: subtitleWidget,
        label: title ?? '',
        labelMaxLines: titleMaxLines,
        value: subtitle,
        valueWidget: subtitleWidget,
        trailing: trailing,
        iosChevron: iosChevron,
        iosChevronPadding: iosChevronPadding,
        leading: leading,
        onPress: onTapFunction(context) as void Function()?,
        labelTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
      );
    }
  }

  Function? onTapFunction(BuildContext context) => onPressed != null ? () => onPressed!.call(context) : null;
}

class CustomTile extends AbstractTile {
  final Widget child;

  const CustomTile({
    required this.child,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}
